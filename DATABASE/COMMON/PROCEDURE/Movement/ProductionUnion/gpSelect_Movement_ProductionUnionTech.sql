-- Function: gpSelect_Movement_ProductionUnionTech()

-- DROP FUNCTION IF EXISTS gpSelect_Movement_ProductionUnionTech (TDateTime, TDateTime, Integer, Integer, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Movement_ProductionUnionTech (TDateTime, TDateTime, Integer, Integer, Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_ProductionUnionTech(
    IN inStartDate         TDateTime,
    IN inEndDate           TDateTime,
    IN inFromId            Integer,
    IN inToId              Integer,
    IN inJuridicalBasisId  Integer ,
    IN inIsErased          Boolean      , --
    IN inSession           TVarChar       -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
  DECLARE vbUserId Integer;

  DECLARE vbFromId_group Integer;
  DECLARE vbIsOrder Boolean;

  DECLARE Cursor1 refcursor;
  DECLARE Cursor2 refcursor;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Select_Movement_ProductionUnionTech());
     vbUserId:= lpGetUserBySession (inSession);


     -- ������������
     vbFromId_group:= (SELECT ObjectLink_Parent.ChildObjectId FROM ObjectLink AS ObjectLink_Parent WHERE ObjectLink_Parent.ObjectId = inFromId AND ObjectLink_Parent.DescId = zc_ObjectLink_Unit_Parent());
     -- 
     CREATE TEMP TABLE _tmpListMaster (MovementId Integer, StatusId Integer, InvNumber TVarChar, OperDate TDateTime, DocumentKindId integer,MovementItemId Integer, MovementItemId_order Integer, GoodsId Integer, GoodsKindId Integer, GoodsKindId_Complete Integer, ReceiptId Integer, Amount_Order TFloat, CuterCount_Order TFloat, Amount TFloat, CuterCount TFloat, isPartionDate Boolean, isOrderSecond Boolean) ON COMMIT DROP;

     -- ������������ - ��� �������+���-��
     vbIsOrder:= (inFromId = inToId) AND EXISTS (SELECT lfSelect.UnitId FROM lfSelect_Object_Unit_byGroup (8446) AS lfSelect WHERE lfSelect.UnitId = inFromId);


     WITH tmpMI_order2 AS (SELECT (Movement.OperDate :: Date + COALESCE (MIFloat_StartProductionInDays.ValueData, 0) :: Integer) :: TDateTime AS OperDate
                               , MAX (MovementItem.Id)                                          AS MovementItemId
                               , COALESCE (MILO_Goods.ObjectId, MovementItem.ObjectId)          AS GoodsId
                               , ObjectLink_Receipt_GoodsKind.ChildObjectId                     AS GoodsKindId
                               , COALESCE (ObjectLink_Receipt_GoodsKindComplete.ChildObjectId, zc_GoodsKind_Basis()) AS GoodsKindId_Complete
                               , COALESCE (MILO_ReceiptBasis.ObjectId, 0)                       AS ReceiptId
                               -- , MLO_To.ObjectId                                                AS ToId
                               , OrderType_Unit.ChildObjectId                                   AS ToId
                               , SUM (CASE WHEN (Movement.OperDate :: Date + COALESCE (MIFloat_StartProductionInDays.ValueData, 0) :: Integer) :: TDateTime
                                                BETWEEN inStartDate AND inEndDate
                                                THEN MovementItem.Amount + COALESCE (MIFloat_AmountSecond.ValueData, 0)
                                           ELSE 0
                                      END) AS Amount
                               , SUM (CASE WHEN (Movement.OperDate :: Date + COALESCE (MIFloat_StartProductionInDays.ValueData, 0) :: Integer) :: TDateTime
                                                BETWEEN inStartDate AND inEndDate
                                                THEN COALESCE (MIFloat_AmountSecond.ValueData, 0)
                                           ELSE 0
                                      END) AS AmountSecond
                               , SUM (CASE WHEN (Movement.OperDate :: Date + COALESCE (MIFloat_StartProductionInDays.ValueData, 0) :: Integer) :: TDateTime
                                                BETWEEN inStartDate AND inEndDate
                                                THEN COALESCE (MIFloat_CuterCount.ValueData, 0) + COALESCE (MIFloat_CuterCountSecond.ValueData, 0)
                                           ELSE 0
                                      END) AS CuterCount
                          FROM (SELECT (inStartDate - INTERVAL '5 DAY') AS StartDate, (inEndDate + INTERVAL '5 DAY') AS EndDate WHERE vbIsOrder = TRUE) AS tmpDate
                               INNER JOIN Movement ON Movement.OperDate BETWEEN tmpDate.StartDate AND tmpDate.EndDate
                                                  AND Movement.DescId = zc_Movement_OrderInternal()
                                                  AND Movement.StatusId <> zc_Enum_Status_Erased()
                               INNER JOIN MovementLinkObject AS MLO_To
                                                             ON MLO_To.MovementId = Movement.Id
                                                            AND MLO_To.DescId = zc_MovementLinkObject_To()
                                                            AND MLO_To.ObjectId IN (inFromId, vbFromId_group)

                               INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                      AND MovementItem.isErased = FALSE
                                                      AND MovementItem.DescId     = zc_MI_Master()

                               LEFT JOIN MovementItemFloat AS MIFloat_StartProductionInDays
                                                           ON MIFloat_StartProductionInDays.MovementItemId = MovementItem.Id 
                                                          AND MIFloat_StartProductionInDays.DescId = zc_MIFloat_StartProductionInDays()
                               LEFT JOIN MovementItemFloat AS MIFloat_AmountSecond
                                                           ON MIFloat_AmountSecond.MovementItemId = MovementItem.Id
                                                          AND MIFloat_AmountSecond.DescId = zc_MIFloat_AmountSecond()
                               LEFT JOIN MovementItemFloat AS MIFloat_CuterCount
                                                           ON MIFloat_CuterCount.MovementItemId = MovementItem.Id
                                                          AND MIFloat_CuterCount.DescId = zc_MIFloat_CuterCount()
                               LEFT JOIN MovementItemFloat AS MIFloat_CuterCountSecond
                                                           ON MIFloat_CuterCountSecond.MovementItemId = MovementItem.Id
                                                          AND MIFloat_CuterCountSecond.DescId = zc_MIFloat_CuterCountSecond()
                               LEFT JOIN MovementItemLinkObject AS MILO_Goods
                                                                ON MILO_Goods.MovementItemId = MovementItem.Id
                                                               AND MILO_Goods.DescId = zc_MILinkObject_Goods()
                               LEFT JOIN MovementItemLinkObject AS MILO_ReceiptBasis
                                                                ON MILO_ReceiptBasis.MovementItemId = MovementItem.Id
                                                               AND MILO_ReceiptBasis.DescId = zc_MILinkObject_ReceiptBasis()
                               LEFT JOIN MovementLinkObject AS MLO_DocumentKind
                                                            ON MLO_DocumentKind.MovementId = Movement.Id
                                                           AND MLO_DocumentKind.DescId = zc_MovementLinkObject_DocumentKind()

                               LEFT JOIN ObjectLink AS ObjectLink_Receipt_GoodsKind
                                                    ON ObjectLink_Receipt_GoodsKind.ObjectId = MILO_ReceiptBasis.ObjectId
                                                   AND ObjectLink_Receipt_GoodsKind.DescId = zc_ObjectLink_Receipt_GoodsKind()
                               LEFT JOIN ObjectLink AS ObjectLink_Receipt_GoodsKindComplete
                                                    ON ObjectLink_Receipt_GoodsKindComplete.ObjectId = MILO_ReceiptBasis.ObjectId
                                                   AND ObjectLink_Receipt_GoodsKindComplete.DescId = zc_ObjectLink_Receipt_GoodsKindComplete()

                               LEFT JOIN ObjectLink AS ObjectLink_OrderType_Goods
                                                    ON ObjectLink_OrderType_Goods.ChildObjectId = COALESCE (MILO_Goods.ObjectId, MovementItem.ObjectId)
                                                   AND ObjectLink_OrderType_Goods.DescId = zc_ObjectLink_OrderType_Goods()
                               LEFT JOIN ObjectLink AS OrderType_Unit
                                                    ON OrderType_Unit.ObjectId = ObjectLink_OrderType_Goods.ObjectId
                                                   AND OrderType_Unit.DescId = zc_ObjectLink_OrderType_Unit()

                          -- WHERE MLO_To.ObjectId IN (inFromId, vbFromId_group)
                            -- AND OrderType_Unit.ChildObjectId = inFromId
                          GROUP BY Movement.OperDate
                                 , COALESCE (MILO_Goods.ObjectId, MovementItem.ObjectId)
                                 , ObjectLink_Receipt_GoodsKind.ChildObjectId
                                 , COALESCE (ObjectLink_Receipt_GoodsKindComplete.ChildObjectId, zc_GoodsKind_Basis())
                                 , MILO_ReceiptBasis.ObjectId
                                 -- , MLO_To.ObjectId
                                 , OrderType_Unit.ChildObjectId
                                 , MIFloat_StartProductionInDays.ValueData
                          HAVING SUM (CASE WHEN (Movement.OperDate :: Date + COALESCE (MIFloat_StartProductionInDays.ValueData, 0) :: Integer) :: TDateTime
                                                BETWEEN inStartDate AND inEndDate
                                                THEN MovementItem.Amount + COALESCE (MIFloat_AmountSecond.ValueData, 0)
                                           ELSE 0
                                      END) <> 0
                              OR SUM (CASE WHEN (Movement.OperDate :: Date + COALESCE (MIFloat_StartProductionInDays.ValueData, 0) :: Integer) :: TDateTime
                                                BETWEEN inStartDate AND inEndDate
                                                THEN COALESCE (MIFloat_CuterCount.ValueData, 0) + COALESCE (MIFloat_CuterCountSecond.ValueData, 0)
                                           ELSE 0
                                      END) <> 0
                         )
   , tmpMI_production AS (SELECT Movement.Id                                                    AS MovementId
                               , Movement.StatusId                                              AS StatusId
                               , Movement.InvNumber                                             AS InvNumber
                               , Movement.OperDate                                              AS OperDate
                               , MovementItem.ObjectId                                          AS GoodsId
                               , MILO_GoodsKind.ObjectId                                        AS GoodsKindId
                               , MILO_GoodsKindComplete.ObjectId                                AS GoodsKindId_Complete
                               , MILO_Receipt.ObjectId                                          AS ReceiptId
                               , MLO_From.ObjectId                                              AS FromId
                               , MLO_DocumentKind.ObjectId                                      AS DocumentKindId
                               , MovementItem.Id                                                AS MovementItemId
                               , MovementItem.Amount                                            AS Amount
                               , COALESCE (MIFloat_CuterCount.ValueData, 0)                     AS CuterCount
                               , COALESCE ((ObjectBoolean_UnitFrom_PartionDate.ValueData = TRUE AND ObjectBoolean_UnitTo_PartionDate.ValueData = TRUE), FALSE) AS isPartionDate
                          FROM Movement
                               INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                      AND MovementItem.isErased   = FALSE
                                                      AND MovementItem.DescId     = zc_MI_Master()
                               LEFT JOIN MovementItemFloat AS MIFloat_CuterCount
                                                           ON MIFloat_CuterCount.MovementItemId = MovementItem.Id
                                                          AND MIFloat_CuterCount.DescId = zc_MIFloat_CuterCount()
                               LEFT JOIN MovementItemLinkObject AS MILO_GoodsKind
                                                                ON MILO_GoodsKind.MovementItemId = MovementItem.Id
                                                               AND MILO_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                               LEFT JOIN MovementItemLinkObject AS MILO_GoodsKindComplete
                                                                ON MILO_GoodsKindComplete.MovementItemId = MovementItem.Id
                                                               AND MILO_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
                               LEFT JOIN MovementItemLinkObject AS MILO_Receipt
                                                                ON MILO_Receipt.MovementItemId = MovementItem.Id
                                                               AND MILO_Receipt.DescId = zc_MILinkObject_Receipt()
                               LEFT JOIN MovementLinkObject AS MLO_From
                                                            ON MLO_From.MovementId = Movement.Id
                                                           AND MLO_From.DescId = zc_MovementLinkObject_From()
                               LEFT JOIN MovementLinkObject AS MLO_To
                                                            ON MLO_To.MovementId = Movement.Id
                                                           AND MLO_To.DescId = zc_MovementLinkObject_To()
                               LEFT JOIN MovementLinkObject AS MLO_DocumentKind
                                                            ON MLO_DocumentKind.MovementId = Movement.Id
                                                           AND MLO_DocumentKind.DescId = zc_MovementLinkObject_DocumentKind()
         
                               LEFT JOIN ObjectBoolean AS ObjectBoolean_UnitFrom_PartionDate
                                                       ON ObjectBoolean_UnitFrom_PartionDate.ObjectId = MLO_From.ObjectId
                                                      AND ObjectBoolean_UnitFrom_PartionDate.DescId = zc_ObjectBoolean_Unit_PartionDate()
                               LEFT JOIN ObjectBoolean AS ObjectBoolean_UnitTo_PartionDate
                                                       ON ObjectBoolean_UnitTo_PartionDate.ObjectId = MLO_To.ObjectId
                                                      AND ObjectBoolean_UnitTo_PartionDate.DescId = zc_ObjectBoolean_Unit_PartionDate()

                            WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate
                              AND Movement.DescId = zc_Movement_ProductionUnion()
                              AND MLO_From.ObjectId = inFromId
                              AND MLO_To.ObjectId = inToId
                           )
      , tmpMI_order22 AS (SELECT tmpMI_order2.OperDate
                               , tmpMI_order2.MovementItemId AS MovementItemId_order
                               , tmpMI_order2.GoodsId
                               , tmpMI_order2.GoodsKindId
                               , tmpMI_order2.GoodsKindId_Complete
                               , tmpMI_order2.ReceiptId
                               , tmpMI_order2.ToId
                               , tmpMI_order2.Amount
                               , CASE WHEN tmpMI_order2.AmountSecond <> 0 THEN TRUE ELSE FALSE END AS isOrderSecond
                               , tmpMI_order2.CuterCount
                          FROM tmpMI_order2
                          WHERE tmpMI_order2.ToId = inFromId
                         )
        , tmpMI_order_find AS (SELECT tmpMI_order22.MovementItemId_order    AS MovementItemId_order
                                    , MAX (tmpMI_production.MovementItemId) AS MovementItemId
                               FROM tmpMI_production
                                    INNER JOIN tmpMI_order22 ON tmpMI_order22.GoodsId = tmpMI_production.GoodsId
                                                           AND tmpMI_order22.GoodsKindId = tmpMI_production.GoodsKindId
                                                           AND tmpMI_order22.GoodsKindId_Complete = tmpMI_production.GoodsKindId_Complete
                                                           AND tmpMI_order22.ReceiptId = tmpMI_production.ReceiptId
                                                           AND tmpMI_order22.OperDate = tmpMI_production.OperDate
                                                           AND tmpMI_order22.ToId = tmpMI_production.FromId
                               WHERE tmpMI_production.StatusId <> zc_Enum_Status_Erased()
                               GROUP BY tmpMI_order22.MovementItemId_order
                              )
       , tmpMI_order AS (SELECT tmpMI_order22.OperDate
                              , tmpMI_order22.MovementItemId_order
                              , tmpMI_order22.GoodsId
                              , tmpMI_order22.GoodsKindId
                              , tmpMI_order22.GoodsKindId_Complete
                              , tmpMI_order22.ReceiptId
                              , tmpMI_order22.ToId
                              , tmpMI_order22.Amount
                              , tmpMI_order22.CuterCount
                              , tmpMI_order22.isOrderSecond
                              , COALESCE (tmpMI_order_find.MovementItemId, 0) AS MovementItemId_find
                         FROM tmpMI_order22
                              LEFT JOIN tmpMI_order_find ON tmpMI_order_find.MovementItemId_order = tmpMI_order22.MovementItemId_order
                         )

    -- !!!!!!!!!!!!!!!!!!!!!!!
    INSERT INTO _tmpListMaster (MovementId, StatusId, InvNumber, OperDate, DocumentKindId, MovementItemId, MovementItemId_order, GoodsId, GoodsKindId, GoodsKindId_Complete, ReceiptId, Amount_Order, CuterCount_Order, Amount, CuterCount, isPartionDate, isOrderSecond)
       SELECT COALESCE (tmpMI_production.MovementId, 0)                                          AS MovementId
            , COALESCE (tmpMI_production.StatusId, 0)                                            AS StatusId
            , COALESCE (tmpMI_production.InvNumber, '')                                          AS InvNumber
            , COALESCE (tmpMI_production.OperDate, tmpMI_order.OperDate)                         AS OperDate
            , COALESCE (tmpMI_production.DocumentKindId, 0)                                      AS DocumentKindId
            , COALESCE (tmpMI_production.MovementItemId, tmpMI_order.MovementItemId_order)       AS MovementItemId
            , tmpMI_order.MovementItemId_order                                                   AS MovementItemId_order
            , COALESCE (tmpMI_production.GoodsId, tmpMI_order.GoodsId)                           AS GoodsId
            , COALESCE (tmpMI_production.GoodsKindId, tmpMI_order.GoodsKindId)                   AS GoodsKindId
            , COALESCE (tmpMI_production.GoodsKindId_Complete, tmpMI_order.GoodsKindId_Complete) AS GoodsKindId_Complete
            , COALESCE (tmpMI_production.ReceiptId, tmpMI_order.ReceiptId)                       AS ReceiptId
            , COALESCE (tmpMI_order.Amount, 0)                 AS Amount_Order
            , COALESCE (tmpMI_order.CuterCount, 0)             AS CuterCount_Order
            , COALESCE (tmpMI_production.Amount, 0)            AS Amount
            , COALESCE (tmpMI_production.CuterCount, 0)        AS CuterCount
            , COALESCE (tmpMI_production.isPartionDate, FALSE) AS isPartionDate
            , COALESCE (tmpMI_order.isOrderSecond, FALSE)      AS isOrderSecond

       FROM tmpMI_production
            FULL JOIN tmpMI_order ON tmpMI_order.MovementItemId_find = tmpMI_production.MovementItemId
                                 /*AND tmpMI_order.GoodsId = tmpMI_production.GoodsId
                                 AND tmpMI_order.GoodsKindId = tmpMI_production.GoodsKindId
                                 AND tmpMI_order.GoodsKindId_Complete = tmpMI_production.GoodsKindId_Complete
                                 AND tmpMI_order.ReceiptId = tmpMI_production.ReceiptId
                                 AND tmpMI_order.OperDate = tmpMI_production.OperDate
                                 AND tmpMI_order.ToId = tmpMI_production.FromId*/
                                 -- AND (tmpMI_order.CuterCount <> 0 OR tmpMI_order.Amount <> 0)
                                ;

    -- !!!!!!!!!!!!!!!!!!!!!!!
    ANALYZE _tmpListMaster;


    OPEN Cursor1 FOR
    -- ��� ����������� - � ����. 1
    -- CREATE TEMP TABLE _tmpRes1_ProductionUnionTech ON COMMIT DROP AS
      WITH tmpStatus AS (SELECT 0                           AS StatusId
                   UNION SELECT zc_Enum_Status_Complete()   AS StatusId
                   UNION SELECT zc_Enum_Status_UnComplete() AS StatusId
                   UNION SELECT zc_Enum_Status_Erased()     AS StatusId WHERE inIsErased = TRUE
                       )

       SELECT
              CASE WHEN _tmpListMaster.MovementId <> 0 THEN row_number() OVER (ORDER BY CASE WHEN _tmpListMaster.MovementId <> 0 THEN _tmpListMaster.MovementItemId ELSE NULL END) ELSE 0 END :: Integer AS LineNum
            , _tmpListMaster.MovementId
            , _tmpListMaster.MovementItemId
            , _tmpListMaster.MovementItemId_order
            , _tmpListMaster.InvNumber
            , _tmpListMaster.OperDate
            , _tmpListMaster.DocumentKindId
            , Object_DocumentKind.ValueData     AS DocumentKindName

            , Object_Goods.Id                   AS GoodsId
            , Object_Goods.ObjectCode           AS GoodsCode
            , Object_Goods.ValueData            AS GoodsName

            , _tmpListMaster.Amount
            , _tmpListMaster.CuterCount
            , COALESCE (ObjectFloat_Receipt_Value.ValueData, 0) * _tmpListMaster.CuterCount AS  Amount_calc

            , COALESCE (MIBoolean_PartionClose.ValueData, FALSE) AS isPartionClose

            , MIString_Comment.ValueData        AS Comment
            , MIFloat_Count.ValueData           AS Count
            , MIFloat_RealWeight.ValueData      AS RealWeight
            , MIFloat_CuterWeight.ValueData     AS CuterWeight 

            , _tmpListMaster.Amount_order
            , _tmpListMaster.CuterCount_order

            , Object_GoodsKind.Id               AS GoodsKindId
            , Object_GoodsKind.ObjectCode       AS GoodsKindCode
            , Object_GoodsKind.ValueData        AS GoodsKindName
            , Object_Measure.ValueData          AS MeasureName

            , Object_GoodsKindComplete.Id         AS GoodsKindId_Complete
            , Object_GoodsKindComplete.ObjectCode AS GoodsKindCode_Complete
            , Object_GoodsKindComplete.ValueData  AS GoodsKindName_Complete

            , Object_Receipt.Id                   AS ReceiptId
            , ObjectString_Receipt_Code.ValueData AS ReceiptCode
            , Object_Receipt.ValueData            AS ReceiptName
            , ObjectString_Receipt_Comment.ValueData AS Comment_receipt
            , ObjectBoolean_Receipt_Main.ValueData   AS isMain


            , ObjectFloat_TermProduction.ValueData AS TermProduction
            , CASE WHEN _tmpListMaster.isPartionDate = TRUE THEN TO_CHAR (_tmpListMaster.OperDate, 'DD.MM.YYYY') ELSE '*' || TO_CHAR (MIDate_PartionGoods.ValueData, 'DD.MM.YYYY')  END :: TVarChar AS PartionGoodsDate
            , (CASE WHEN _tmpListMaster.isPartionDate = TRUE THEN _tmpListMaster.OperDate ELSE MIDate_PartionGoods.ValueData END
             + (COALESCE (ObjectFloat_TermProduction.ValueData, 0) :: TVarChar || ' DAY') :: INTERVAL) :: TDateTime AS PartionGoodsDateClose


            , CASE WHEN _tmpListMaster.MovementItemId > 0 AND _tmpListMaster.MovementItemId <> _tmpListMaster.MovementItemId_order THEN COALESCE (MIBoolean_OrderSecond.ValueData, FALSE) ELSE _tmpListMaster.isOrderSecond END :: Boolean AS isOrderSecond

            , Object_Status.ObjectCode            AS StatusCode
            , Object_Status.ValueData             AS StatusName

            , Object_Insert.ValueData             AS InsertName
            , Object_Update.ValueData             AS UpdateName
            , MIDate_Insert.ValueData             AS InsertDate
            , MIDate_Update.ValueData             AS UpdateDate

            , FALSE                               AS isErased

       FROM _tmpListMaster
             INNER JOIN tmpStatus ON tmpStatus.StatusId = _tmpListMaster.StatusId

             LEFT JOIN MovementItemBoolean AS MIBoolean_OrderSecond
                                           ON MIBoolean_OrderSecond.MovementItemId = _tmpListMaster.MovementItemId
                                          AND MIBoolean_OrderSecond.DescId = zc_MIBoolean_OrderSecond()

             LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                        ON MIDate_PartionGoods.MovementItemId = _tmpListMaster.MovementItemId
                                       AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                                       AND _tmpListMaster.isPartionDate = FALSE
             LEFT JOIN ObjectLink AS ObjectLink_OrderType_Goods
                                  ON ObjectLink_OrderType_Goods.ChildObjectId = _tmpListMaster.GoodsId
                                 AND ObjectLink_OrderType_Goods.DescId = zc_ObjectLink_OrderType_Goods()
             LEFT JOIN ObjectFloat AS ObjectFloat_TermProduction
                                   ON ObjectFloat_TermProduction.ObjectId = ObjectLink_OrderType_Goods.ObjectId
                                  AND ObjectFloat_TermProduction.DescId = zc_ObjectFloat_OrderType_TermProduction() 

             LEFT JOIN MovementItemFloat AS MIFloat_Count
                                         ON MIFloat_Count.MovementItemId = _tmpListMaster.MovementItemId
                                        AND MIFloat_Count.DescId = zc_MIFloat_Count()
                                        AND _tmpListMaster.MovementId <> 0
             LEFT JOIN MovementItemFloat AS MIFloat_RealWeight
                                         ON MIFloat_RealWeight.MovementItemId = _tmpListMaster.MovementItemId
                                        AND MIFloat_RealWeight.DescId = zc_MIFloat_RealWeight()
                                        AND _tmpListMaster.MovementId <> 0
             LEFT JOIN MovementItemFloat AS MIFloat_CuterWeight
                                         ON MIFloat_CuterWeight.MovementItemId = _tmpListMaster.MovementItemId
                                        AND MIFloat_CuterWeight.DescId = zc_MIFloat_CuterWeight()
                                        AND _tmpListMaster.MovementId <> 0

             LEFT JOIN MovementItemBoolean AS MIBoolean_PartionClose
                                           ON MIBoolean_PartionClose.MovementItemId = _tmpListMaster.MovementItemId
                                          AND MIBoolean_PartionClose.DescId = zc_MIBoolean_PartionClose()
                                          AND _tmpListMaster.MovementId <> 0
             LEFT JOIN MovementItemString AS MIString_Comment
                                          ON MIString_Comment.MovementItemId = _tmpListMaster.MovementItemId
                                         AND MIString_Comment.DescId = zc_MIString_Comment()
                                         AND _tmpListMaster.MovementId <> 0

             LEFT JOIN MovementItemDate AS MIDate_Insert
                                        ON MIDate_Insert.MovementItemId = _tmpListMaster.MovementItemId
                                       AND MIDate_Insert.DescId = zc_MIDate_Insert()
             LEFT JOIN MovementItemDate AS MIDate_Update
                                        ON MIDate_Update.MovementItemId = _tmpListMaster.MovementItemId
                                       AND MIDate_Update.DescId = zc_MIDate_Update()

             LEFT JOIN MovementItemLinkObject AS MILO_Insert
                                              ON MILO_Insert.MovementItemId = _tmpListMaster.MovementItemId
                                             AND MILO_Insert.DescId = zc_MILinkObject_Insert()
             LEFT JOIN Object AS Object_Insert ON Object_Insert.Id = MILO_Insert.ObjectId
             LEFT JOIN MovementItemLinkObject AS MILO_Update
                                              ON MILO_Update.MovementItemId = _tmpListMaster.MovementItemId
                                             AND MILO_Update.DescId = zc_MILinkObject_Update()
             LEFT JOIN Object AS Object_Update ON Object_Update.Id = MILO_Update.ObjectId

             LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = _tmpListMaster.GoodsId
             LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = _tmpListMaster.GoodsKindId
             LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = _tmpListMaster.GoodsKindId_Complete
             LEFT JOIN Object AS Object_Receipt ON Object_Receipt.Id = _tmpListMaster.ReceiptId
             LEFT JOIN Object AS Object_Status ON Object_Status.Id = _tmpListMaster.StatusId
             LEFT JOIN Object AS Object_DocumentKind ON Object_DocumentKind.Id = _tmpListMaster.DocumentKindId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                  ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()

             LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

             LEFT JOIN ObjectString AS ObjectString_Receipt_Code
                                    ON ObjectString_Receipt_Code.ObjectId = Object_Receipt.Id
                                   AND ObjectString_Receipt_Code.DescId = zc_ObjectString_Receipt_Code()
             LEFT JOIN ObjectString AS ObjectString_Receipt_Comment
                                    ON ObjectString_Receipt_Comment.ObjectId = Object_Receipt.Id
                                   AND ObjectString_Receipt_Comment.DescId = zc_ObjectString_Receipt_Comment()
             LEFT JOIN ObjectBoolean AS ObjectBoolean_Receipt_Main
                                     ON ObjectBoolean_Receipt_Main.ObjectId = Object_Receipt.Id
                                    AND ObjectBoolean_Receipt_Main.DescId = zc_ObjectBoolean_Receipt_Main()
             LEFT JOIN ObjectFloat AS ObjectFloat_Receipt_Value
                                   ON ObjectFloat_Receipt_Value.ObjectId = Object_Receipt.Id
                                  AND ObjectFloat_Receipt_Value.DescId = zc_ObjectFloat_Receipt_Value()

           ;
    RETURN NEXT Cursor1;


    -- !!!�����������!!!
    CREATE TEMP TABLE _tmpMI_Child_two (MovementItemId Integer, MovementItemId_Child Integer, GoodsId Integer, Amount TFloat, isErased Boolean) ON COMMIT DROP;
    -- 
    INSERT INTO _tmpMI_Child_two (MovementItemId, MovementItemId_Child, GoodsId, Amount, isErased)
       SELECT _tmpListMaster.MovementItemId AS MovementItemId
            , MovementItem.Id               AS MovementItemId_Child
            , MovementItem.ObjectId         AS GoodsId
            , MovementItem.Amount           AS Amount
            , MovementItem.isErased         AS isErased
       FROM _tmpListMaster
            INNER JOIN MovementItem ON MovementItem.ParentId = _tmpListMaster.MovementItemId
                                   AND MovementItem.MovementId = _tmpListMaster.MovementId
                                   AND MovementItem.DescId   = zc_MI_Child()
            INNER JOIN (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased ON tmpIsErased.isErased = MovementItem.isErased
       WHERE _tmpListMaster.MovementId <> 0;

    -- !!!!!!!!!!!!!!!!!!!!!!!
    ANALYZE _tmpMI_Child_two;


     OPEN Cursor2 FOR
     -- ��� ����������� - � ����. - 2
     -- CREATE TEMP TABLE _tmpRes2_ProductionUnionTech ON COMMIT DROP AS
     WITH tmpMI_Child AS (SELECT tmpMI_Child_two.MovementItemId
                               , tmpMI_Child_two.MovementItemId_Child
                               , tmpMI_Child_two.GoodsId
                               , COALESCE (MILO_GoodsKind.ObjectId, 0)      AS GoodsKindId
                               , tmpMI_Child_two.Amount
                               , tmpMI_Child_two.isErased
                          FROM _tmpMI_Child_two AS tmpMI_Child_two
                               LEFT JOIN MovementItemLinkObject AS MILO_GoodsKind
                                                                ON MILO_GoodsKind.MovementItemId = tmpMI_Child_two.MovementItemId_Child
                                                               AND MILO_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                               
                         )
    , tmpReceiptChild AS (SELECT _tmpListMaster.MovementItemId                                  AS MovementItemId
                               , COALESCE (ObjectLink_ReceiptChild_Goods.ChildObjectId, 0)      AS GoodsId
                               , COALESCE (ObjectLink_ReceiptChild_GoodsKind.ChildObjectId, 0)  AS GoodsKindId
                               , ObjectFloat_Value.ValueData                                    AS Value
                               , ObjectFloat_Value_master.ValueData                             AS Value_master
                               , COALESCE (ObjectBoolean_TaxExit.ValueData, FALSE)              AS isTaxExit
                               , COALESCE (ObjectBoolean_WeightMain.ValueData, FALSE)           AS isWeightMain
                               , CASE WHEN _tmpListMaster.MovementId <> 0 THEN _tmpListMaster.Amount     ELSE _tmpListMaster.Amount_order     END AS Amount_calc
                               , CASE WHEN _tmpListMaster.MovementId <> 0 THEN _tmpListMaster.CuterCount ELSE _tmpListMaster.CuterCount_order END AS CuterCount_calc
                               , _tmpListMaster.GoodsKindId AS GoodsKindId_master
                          FROM _tmpListMaster
                               INNER JOIN ObjectLink AS ObjectLink_ReceiptChild_Receipt
                                                     ON ObjectLink_ReceiptChild_Receipt.ChildObjectId = _tmpListMaster.ReceiptId
                                                    AND ObjectLink_ReceiptChild_Receipt.DescId = zc_ObjectLink_ReceiptChild_Receipt()
                               INNER JOIN Object AS Object_ReceiptChild ON Object_ReceiptChild.Id = ObjectLink_ReceiptChild_Receipt.ObjectId
                                                                       AND Object_ReceiptChild.isErased = FALSE
                               LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_Goods
                                                    ON ObjectLink_ReceiptChild_Goods.ObjectId = Object_ReceiptChild.Id
                                                   AND ObjectLink_ReceiptChild_Goods.DescId = zc_ObjectLink_ReceiptChild_Goods()
                               LEFT JOIN ObjectLink AS ObjectLink_ReceiptChild_GoodsKind
                                                   ON ObjectLink_ReceiptChild_GoodsKind.ObjectId = Object_ReceiptChild.Id
                                                  AND ObjectLink_ReceiptChild_GoodsKind.DescId = zc_ObjectLink_ReceiptChild_GoodsKind()
                               INNER JOIN ObjectFloat AS ObjectFloat_Value_master
                                                      ON ObjectFloat_Value_master.ObjectId = _tmpListMaster.ReceiptId
                                                     AND ObjectFloat_Value_master.DescId = zc_ObjectFloat_Receipt_Value()
                                                     AND ObjectFloat_Value_master.ValueData <> 0
                               INNER JOIN ObjectFloat AS ObjectFloat_Value
                                                      ON ObjectFloat_Value.ObjectId = Object_ReceiptChild.Id
                                                     AND ObjectFloat_Value.DescId = zc_ObjectFloat_ReceiptChild_Value()
                                                     -- AND ObjectFloat_Value.ValueData <> 0

                               LEFT JOIN ObjectBoolean AS ObjectBoolean_WeightMain
                                                       ON ObjectBoolean_WeightMain.ObjectId = Object_ReceiptChild.Id 
                                                      AND ObjectBoolean_WeightMain.DescId = zc_ObjectBoolean_ReceiptChild_WeightMain()
                               LEFT JOIN ObjectBoolean AS ObjectBoolean_TaxExit
                                                       ON ObjectBoolean_TaxExit.ObjectId = Object_ReceiptChild.Id 
                                                      AND ObjectBoolean_TaxExit.DescId = zc_ObjectBoolean_ReceiptChild_TaxExit()
                         )
 , tmpMI_ReceiptChild AS (SELECT MAX (COALESCE (tmpMI_Child.MovementItemId_Child, 0)) AS MovementItemId_Child
                               , tmpReceiptChild.MovementItemId
                               , tmpReceiptChild.GoodsId
                               , tmpReceiptChild.GoodsKindId
                               , tmpReceiptChild.Value
                               , tmpReceiptChild.Value_master
                               , tmpReceiptChild.isTaxExit
                               , tmpReceiptChild.isWeightMain
                               , tmpReceiptChild.Amount_calc
                               , tmpReceiptChild.CuterCount_calc
                               , tmpReceiptChild.GoodsKindId_master
                          FROM tmpReceiptChild
                               LEFT JOIN tmpMI_Child ON tmpMI_Child.MovementItemId = tmpReceiptChild.MovementItemId
                                                    AND tmpMI_Child.GoodsId = tmpReceiptChild.GoodsId
                                                    AND tmpMI_Child.GoodsKindId = tmpReceiptChild.GoodsKindId
                                                    
                                                    AND tmpMI_Child.isErased = FALSE
                          GROUP BY tmpReceiptChild.MovementItemId
                                 , tmpReceiptChild.GoodsId
                                 , tmpReceiptChild.GoodsKindId
                                 , tmpReceiptChild.Value
                                 , tmpReceiptChild.Value_master
                                 , tmpReceiptChild.isTaxExit
                                 , tmpReceiptChild.isWeightMain
                                 , tmpReceiptChild.Amount_calc
                                 , tmpReceiptChild.CuterCount_calc
                                 , tmpReceiptChild.GoodsKindId_master
                         )
       SELECT Object_Goods.Id                   AS GoodsId
            , Object_Goods.ObjectCode           AS GoodsCode
            , Object_Goods.ValueData            AS GoodsName

            , COALESCE (tmpMI_Child.MovementItemId, tmpMI_ReceiptChild.MovementItemId) AS ParentId
            , tmpMI_Child.MovementItemId_Child AS MovementItemId
            , tmpMI_Child.Amount

            , COALESCE (MIFloat_AmountReceipt.ValueData, CASE WHEN tmpMI_ReceiptChild.GoodsKindId_master = zc_GoodsKind_WorkProgress() THEN tmpMI_ReceiptChild.Value ELSE 0 END) AS AmountReceipt

            , CASE WHEN tmpMI_ReceiptChild.GoodsKindId_master = zc_GoodsKind_WorkProgress()
                        THEN CASE WHEN tmpMI_ReceiptChild.isTaxExit = FALSE
                                       THEN tmpMI_ReceiptChild.CuterCount_calc * tmpMI_ReceiptChild.Value
                                  WHEN tmpMI_ReceiptChild.Value_master <> 0
                                       THEN tmpMI_ReceiptChild.Amount_calc * tmpMI_ReceiptChild.Value / tmpMI_ReceiptChild.Value_master
                                  ELSE 0
                             END
                   WHEN tmpMI_ReceiptChild.Value_master <> 0
                        THEN tmpMI_ReceiptChild.Amount_calc * tmpMI_ReceiptChild.Value / tmpMI_ReceiptChild.Value_master 
                   ELSE 0
              END AS AmountCalc

            , CASE WHEN TRUE = zfCalc_ReceiptChild_isWeightTotal (inGoodsId                := tmpMI_Child.GoodsId
                                                                , inGoodsKindId            := tmpMI_Child.GoodsKindId
                                                                , inInfoMoneyDestinationId := Object_InfoMoney_View.InfoMoneyDestinationId
                                                                , inInfoMoneyId            := Object_InfoMoney_View.InfoMoneyId
                                                                , inIsWeightMain           := CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_WeightMain.ValueData, FALSE) ELSE COALESCE (tmpMI_ReceiptChild.isWeightMain, FALSE) END
                                                                , inIsTaxExit              := CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_TaxExit.ValueData, FALSE)    ELSE COALESCE (tmpMI_ReceiptChild.isTaxExit, FALSE)    END
                                                                 )
                        THEN tmpMI_Child.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END
                    ELSE 0
              END :: TFloat AS AmountWeight
            , CASE WHEN TRUE = zfCalc_ReceiptChild_isWeightTotal (inGoodsId                := tmpMI_Child.GoodsId
                                                                , inGoodsKindId            := tmpMI_Child.GoodsKindId
                                                                , inInfoMoneyDestinationId := Object_InfoMoney_View.InfoMoneyDestinationId
                                                                , inInfoMoneyId            := Object_InfoMoney_View.InfoMoneyId
                                                                , inIsWeightMain           := CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_WeightMain.ValueData, FALSE) ELSE COALESCE (tmpMI_ReceiptChild.isWeightMain, FALSE) END
                                                                , inIsTaxExit              := CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_TaxExit.ValueData, FALSE)    ELSE COALESCE (tmpMI_ReceiptChild.isTaxExit, FALSE)    END
                                                                 )
                        THEN CASE WHEN tmpMI_ReceiptChild.GoodsKindId_master = zc_GoodsKind_WorkProgress()
                                       THEN CASE WHEN tmpMI_ReceiptChild.isTaxExit = FALSE
                                                      THEN tmpMI_ReceiptChild.CuterCount_calc * tmpMI_ReceiptChild.Value
                                                 WHEN tmpMI_ReceiptChild.Value_master <> 0
                                                      THEN tmpMI_ReceiptChild.Amount_calc * tmpMI_ReceiptChild.Value / tmpMI_ReceiptChild.Value_master
                                                 ELSE 0
                                            END
                                  WHEN tmpMI_ReceiptChild.Value_master <> 0
                                       THEN tmpMI_ReceiptChild.Amount_calc * tmpMI_ReceiptChild.Value / tmpMI_ReceiptChild.Value_master 
                                  ELSE 0
                             END
                           * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END
                   ELSE 0
              END :: TFloat AS AmountCalcWeight
            , CASE WHEN TRUE = zfCalc_ReceiptChild_isWeightTotal (inGoodsId                := tmpMI_Child.GoodsId
                                                                , inGoodsKindId            := tmpMI_Child.GoodsKindId
                                                                , inInfoMoneyDestinationId := Object_InfoMoney_View.InfoMoneyDestinationId
                                                                , inInfoMoneyId            := Object_InfoMoney_View.InfoMoneyId
                                                                , inIsWeightMain           := CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_WeightMain.ValueData, FALSE) ELSE COALESCE (tmpMI_ReceiptChild.isWeightMain, FALSE) END
                                                                , inIsTaxExit              := CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_TaxExit.ValueData, FALSE)    ELSE COALESCE (tmpMI_ReceiptChild.isTaxExit, FALSE)    END
                                                                 )
                        THEN COALESCE (MIFloat_AmountReceipt.ValueData, CASE WHEN tmpMI_ReceiptChild.GoodsKindId_master = zc_GoodsKind_WorkProgress() THEN tmpMI_ReceiptChild.Value ELSE 0 END)
                           * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END
                   ELSE 0
              END :: TFloat AS AmountReceiptWeight

            , MIDate_PartionGoods.ValueData     AS PartionGoodsDate
            , MIString_PartionGoods.ValueData   AS PartionGoods
            , MIString_Comment.ValueData        AS Comment

            , CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_WeightMain.ValueData, FALSE) ELSE COALESCE (tmpMI_ReceiptChild.isWeightMain, FALSE) END :: Boolean  AS isWeightMain
            , CASE WHEN tmpMI_Child.MovementItemId <> 0 THEN COALESCE (MIBoolean_TaxExit.ValueData, FALSE)    ELSE COALESCE (tmpMI_ReceiptChild.isTaxExit, FALSE)    END :: Boolean  AS isTaxExit

            , Object_GoodsKind.Id               AS GoodsKindId
            , Object_GoodsKind.ObjectCode       AS GoodsKindCode
            , Object_GoodsKind.ValueData        AS GoodsKindName

            , Object_GoodsKindComplete.Id               AS GoodsKindCompleteId
            , Object_GoodsKindComplete.ObjectCode       AS GoodsKindCompleteCode
            , Object_GoodsKindComplete.ValueData        AS GoodsKindCompleteName

            , Object_Measure.ValueData          AS MeasureName

            , zfCalc_ReceiptChild_GroupNumber (inGoodsId                := Object_Goods.Id
                                             , inGoodsKindId            := Object_GoodsKind.Id
                                             , inInfoMoneyDestinationId := Object_InfoMoney_View.InfoMoneyDestinationId
                                             , inInfoMoneyId            := Object_InfoMoney_View.InfoMoneyId
                                             , inIsWeightMain           := COALESCE (MIBoolean_WeightMain.ValueData, tmpMI_ReceiptChild.isWeightMain)
                                             , inIsTaxExit              := COALESCE (MIBoolean_WeightMain.ValueData, tmpMI_ReceiptChild.isWeightMain)
                                              ) AS GroupNumber

            , CASE 
              zfCalc_ReceiptChild_GroupNumber (inGoodsId                := Object_Goods.Id
                                             , inGoodsKindId            := Object_GoodsKind.Id
                                             , inInfoMoneyDestinationId := Object_InfoMoney_View.InfoMoneyDestinationId
                                             , inInfoMoneyId            := Object_InfoMoney_View.InfoMoneyId
                                             , inIsWeightMain           := COALESCE (MIBoolean_WeightMain.ValueData, tmpMI_ReceiptChild.isWeightMain)
                                             , inIsTaxExit              := COALESCE (MIBoolean_WeightMain.ValueData, tmpMI_ReceiptChild.isWeightMain)
                                              )
                   WHEN 6 THEN 15993821 -- _colorRecord_GoodsPropertyId_Ice           - inGoodsId = zc_Goods_WorkIce()
                   WHEN 1 THEN 14614528 -- _colorRecord_KindPackage_MaterialBasis     - inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100() -- �������� ����� + ������ �����
                   WHEN 2 THEN 14614528 -- _colorRecord_KindPackage_MaterialBasis     - inInfoMoneyId = zc_Enum_InfoMoney_10105() -- �������� ����� + ������ ����� + ������ ������ �����
                   WHEN 3 THEN 14614528 -- _colorRecord_KindPackage_PF                - inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_21300() -- ������������� + ������������� ������������
                   WHEN 4 THEN 14614528 -- _colorRecord_KindPackage_PF                - inInfoMoneyDestinationId inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_30300() -- ������ + �����������
                   WHEN 5 THEN 32896    -- _colorRecord_KindPackage_Composition_K_MB  -  zc_Enum_InfoMoney_10201() -- �������� ����� + ������ ����� + ������
                   WHEN 7 THEN 35980    -- _colorRecord_KindPackage_Composition_K     - zc_Enum_InfoMoney_10201() -- �������� ����� + ������ ����� + ������
                   WHEN 8 THEN 10965163 -- _colorRecord_KindPackage_Composition_Y     - inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10200() -- �������� ����� + ������ ����� (�������� �������� + �������� + ������ �����)
                   ELSE 0 -- clBlack
             END :: Integer AS Color_calc

            , Object_Insert.ValueData             AS InsertName
            , Object_Update.ValueData             AS UpdateName
            , MIDate_Insert.ValueData             AS InsertDate
            , MIDate_Update.ValueData             AS UpdateDate

            , tmpMI_Child.isErased

       FROM tmpMI_Child
            FULL JOIN tmpMI_ReceiptChild ON tmpMI_ReceiptChild.MovementItemId_Child = tmpMI_Child.MovementItemId_Child

            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = COALESCE (tmpMI_ReceiptChild.GoodsId, tmpMI_Child.GoodsId)
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = COALESCE (tmpMI_ReceiptChild.GoodsKindId, tmpMI_Child.GoodsKindId)

            LEFT JOIN MovementItemLinkObject AS MILO_GoodsKindComplete
                                            ON MILO_GoodsKindComplete.MovementItemId = tmpMI_Child.MovementItemId_Child
                                           AND MILO_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
            LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = MILO_GoodsKindComplete.ObjectId

            LEFT JOIN MovementItemBoolean AS MIBoolean_TaxExit
                                          ON MIBoolean_TaxExit.MovementItemId =  tmpMI_Child.MovementItemId_Child
                                         AND MIBoolean_TaxExit.DescId = zc_MIBoolean_TaxExit()
            LEFT JOIN MovementItemBoolean AS MIBoolean_WeightMain
                                          ON MIBoolean_WeightMain.MovementItemId =  tmpMI_Child.MovementItemId_Child
                                         AND MIBoolean_WeightMain.DescId = zc_MIBoolean_WeightMain()

            LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                       ON MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                                      AND MIDate_PartionGoods.MovementItemId = tmpMI_Child.MovementItemId_Child

            LEFT JOIN MovementItemString AS MIString_PartionGoods
                                         ON MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                                        AND MIString_PartionGoods.MovementItemId = tmpMI_Child.MovementItemId_Child

            LEFT JOIN MovementItemFloat AS MIFloat_AmountReceipt
                                        ON MIFloat_AmountReceipt.MovementItemId = tmpMI_Child.MovementItemId_Child
                                       AND MIFloat_AmountReceipt.DescId = zc_MIFloat_AmountReceipt()

            LEFT JOIN MovementItemString AS MIString_Comment
                                         ON MIString_Comment.MovementItemId = tmpMI_Child.MovementItemId_Child
                                        AND MIString_Comment.DescId = zc_MIString_Comment()

             LEFT JOIN MovementItemDate AS MIDate_Insert
                                        ON MIDate_Insert.MovementItemId = tmpMI_Child.MovementItemId_Child
                                       AND MIDate_Insert.DescId = zc_MIDate_Insert()
             LEFT JOIN MovementItemDate AS MIDate_Update
                                        ON MIDate_Update.MovementItemId = tmpMI_Child.MovementItemId_Child
                                       AND MIDate_Update.DescId = zc_MIDate_Update()

             LEFT JOIN MovementItemLinkObject AS MILO_Insert
                                              ON MILO_Insert.MovementItemId = tmpMI_Child.MovementItemId_Child
                                             AND MILO_Insert.DescId = zc_MILinkObject_Insert()
             LEFT JOIN Object AS Object_Insert ON Object_Insert.Id = MILO_Insert.ObjectId
             LEFT JOIN MovementItemLinkObject AS MILO_Update
                                              ON MILO_Update.MovementItemId = tmpMI_Child.MovementItemId_Child
                                             AND MILO_Update.DescId = zc_MILinkObject_Update()
             LEFT JOIN Object AS Object_Update ON Object_Update.Id = MILO_Update.ObjectId

            LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                  ON ObjectFloat_Weight.ObjectId = Object_Goods.Id
                                 AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                 ON ObjectLink_Goods_InfoMoney.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
            LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

      ;
    RETURN NEXT Cursor2;
    

    -- ��� ���������� - 1
    -- OPEN Cursor1 FOR SELECT * FROM _tmpRes1_ProductionUnionTech;
    -- RETURN NEXT Cursor1;
    
    -- ��� ���������� - 1
    -- OPEN Cursor2 FOR SELECT * FROM _tmpRes1_ProductionUnionTech;
    -- RETURN NEXT Cursor2;


END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����

               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 05.10.16         * add inJuridicalBasisId
 13.06.16         *
 07.11.15         * GoodsKindComplete
 15.03.15                                        * all
 19.12.14                                                        *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_ProductionUnionTech (inStartDate:= '01.02.2018', inEndDate:= '01.02.2018', inFromId:= 8447, inToId:= 8447, inJuridicalBasisId:= 9399, inIsErased:= FALSE, inSession:= zfCalc_UserAdmin());
