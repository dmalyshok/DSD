-- Function: gpReport_GoodsMI_ProductionUnionMD ()

DROP FUNCTION IF EXISTS gpReport_GoodsMI_ProductionUnionMD (TDateTime, TDateTime,  Boolean, Boolean, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpReport_GoodsMI_ProductionUnionMD (TDateTime, TDateTime,  Boolean, Boolean, Boolean, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_GoodsMI_ProductionUnionMD (
    IN inStartDate          TDateTime ,
    IN inEndDate            TDateTime ,
    IN inGroupMovement      Boolean   ,
    IN inGroupPartion       Boolean   ,
    IN inGroupInfoMoney     Boolean   ,
    IN inGoodsGroupId       Integer   ,
    IN inGoodsId            Integer   ,
    IN inChildGoodsGroupId  Integer   ,
    IN inChildGoodsId       Integer   ,
    IN inFromId             Integer   ,    -- �� ����
    IN inToId               Integer   ,    -- ����
    IN inSession            TVarChar       -- ������ ������������
)
RETURNS SETOF refcursor
/*
RETURNS TABLE (InvNumber TVarChar, OperDate TDateTime
             , PartionGoods  TVarChar, GoodsGroupName TVarChar, GoodsCode Integer, GoodsName TVarChar
             , Amount TFloat, HeadCount TFloat, Summ TFloat
             , ChildPartionGoods TVarChar, ChildGoodsGroupName TVarChar, ChildGoodsCode Integer,  ChildGoodsName TVarChar
             , ChildAmount TFloat, ChildSumm TFloat
             , ChildPrice TFloat
             )
*/
AS
$BODY$
    DECLARE vbDescId Integer;
    DECLARE Cursor1 refcursor;
    DECLARE Cursor2 refcursor;
BEGIN

    -- ����������� �� ������
    CREATE TEMP TABLE _tmpGoods (GoodsId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpChildGoods (ChildGoodsId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpFromGroup (FromId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpToGroup (ToId  Integer) ON COMMIT DROP;

    IF inGoodsGroupId <> 0
    THEN
        INSERT INTO _tmpGoods (GoodsId)
          SELECT GoodsId FROM  lfSelect_Object_Goods_byGoodsGroup (inGoodsGroupId) AS lfObject_Goods_byGoodsGroup;
    ELSE IF inGoodsId <> 0
         THEN
             INSERT INTO _tmpGoods (GoodsId)
              SELECT inGoodsId;
         ELSE
             INSERT INTO _tmpGoods (GoodsId)
               SELECT Object.Id FROM Object WHERE DescId = zc_Object_Goods();
         END IF;
    END IF;

    IF inChildGoodsGroupId <> 0
    THEN
        INSERT INTO _tmpChildGoods (ChildGoodsId)
          SELECT GoodsId FROM  lfSelect_Object_Goods_byGoodsGroup (inChildGoodsGroupId) AS lfObject_Goods_byGoodsGroup;
    ELSE IF inChildGoodsId <> 0
         THEN
             INSERT INTO _tmpChildGoods (ChildGoodsId)
              SELECT inChildGoodsId;
         ELSE
             INSERT INTO _tmpChildGoods (ChildGoodsId)
               SELECT Object.Id FROM Object WHERE DescId = zc_Object_Goods();
         END IF;
    END IF;


    -- ����������� �� �� ����
    IF inFromId <> 0
    THEN
        INSERT INTO _tmpFromGroup (FromId)
           SELECT UnitId FROM lfSelect_Object_Unit_byGroup (inFromId) AS lfSelect_Object_Unit_byGroup;
    ELSE
         INSERT INTO _tmpFromGroup (FromId)
          SELECT Id FROM Object_Unit_View;  --SELECT Id FROM Object WHERE DescId = zc_Object_Unit();
    END IF;

    -- ����������� �� ����
    IF inToId <> 0
    THEN
        INSERT INTO _tmpToGroup (ToId)
           SELECT UnitId FROM lfSelect_Object_Unit_byGroup (inToId) AS lfSelect_Object_Unit_byGroup;
    ELSE
        INSERT INTO _tmpToGroup (ToId)
          SELECT Id FROM Object_Unit_View ;   --SELECT Id FROM Object WHERE DescId = zc_Object_Unit();
    END IF;


    -- ���������
--    RETURN QUERY
     OPEN Cursor1 FOR

    -- ������������ �� ���� ���������  , �� �� ���� / ����
      WITH tmpMovement AS
                        (SELECT Movement.Id        AS MovementId
                              , Movement.InvNumber AS InvNumber
                              , Movement.OperDate  AS OperDate
                              , MovementLinkObject_From.ObjectId AS UnitId
                         FROM Movement
                         LEFT JOIN MovementLinkObject AS MovementLinkObject_From
				                                      ON MovementLinkObject_From.MovementId = Movement.Id
						                             AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
			             JOIN _tmpFromGroup ON _tmpFromGroup.FromId = MovementLinkObject_From.ObjectId
                         LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                      ON MovementLinkObject_To.MovementId = Movement.Id
                                                     AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                         JOIN _tmpToGroup on _tmpToGroup.ToId = MovementLinkObject_To.ObjectId

                         WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate
                           AND Movement.DescId  = zc_Movement_ProductionUnion()
                         GROUP BY Movement.Id
                                , Movement.InvNumber
                                , Movement.OperDate
                                , MovementLinkObject_From.ObjectId
                         )

  , tmpMI_Container AS (SELECT tmpMovement.MovementId                           AS MovementId
                             , tmpMovement.InvNumber                            AS InvNumber
                             , tmpMovement.OperDate                             AS OperDate
                             , MovementItem.ObjectId                            AS GoodsId
                             , (MIContainer.Amount)                             AS Amount
                             , MIFloat_HeadCount.ValueData                      AS HeadCount
                             , MovementItem.DescId                              AS MovementItemDescId
                             , MIContainer.DescId                               AS MIContainerDescId
                             , Container.ObjectId                               AS ContainerObjectId
                             , MovementItem.Id                                  AS MovementItemId
                             , MovementItem.ParentId                            AS MovementItemParentId
                             , COALESCE (CLO_PartionGoods.ObjectId, 0)          AS PartionGoodsId

                             , COALESCE (CLO_InfoMoneyDetail.ObjectId, 0)       AS InfoMoneyDetailId
                             , COALESCE (MILinkObject_Receipt.ObjectId, 0)      AS ReceiptId
                             , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)    AS GoodsKindId
                             , COALESCE (tmpMovement.UnitId,0)                  AS UnitId

                        FROM tmpMovement
                        JOIN MovementItemContainer AS MIContainer
                                                   ON MIContainer.MovementId = tmpMovement.MovementId
                        JOIN Container ON Container.Id = MIContainer.ContainerId
                        JOIN MovementItem ON MovementItem.Id = MIContainer.MovementItemId

	                    LEFT JOIN MovementItemFloat AS MIFloat_HeadCount
                                                        ON MIFloat_HeadCount.MovementItemId = MovementItem.Id
                                                       AND MIContainer.DescId =  zc_MIContainer_Count()
                                                       AND MIFloat_HeadCount.DescId = zc_MIFloat_Count()

                        LEFT JOIN MovementItemLinkObject AS MILinkObject_Receipt
                                                         ON MILinkObject_Receipt.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_Receipt.DescId = zc_MILinkObject_Receipt()

                        LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                         ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()

                        LEFT JOIN ContainerLinkObject AS CLO_PartionGoods
                                                      ON CLO_PartionGoods.ContainerId = Container.Id
                                                     AND CLO_PartionGoods.DescId = zc_ContainerLinkObject_PartionGoods()

                        LEFT JOIN ContainerLinkObject AS CLO_InfoMoneyDetail
                                                      ON CLO_InfoMoneyDetail.ContainerId = Container.Id
                                                     AND CLO_InfoMoneyDetail.DescId = zc_ContainerLinkObject_InfoMoneyDetail()
                           )


     , tmpMI_Count AS (SELECT tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.GoodsId
                             , 0                                        AS Summ
                             , SUM (tmpMI_Container.Amount)             AS Amount
                             , tmpMI_Container.HeadCount
--                             , tmpMI_Container.MovementItemDescId  as DescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId

                        FROM tmpMI_Container

                        WHERE tmpMI_Container.MIContainerDescId = zc_MIContainer_Count() AND tmpMI_Container.MovementItemDescId = zc_MI_Master()
                        GROUP BY tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.GoodsId
                             , tmpMI_Container.HeadCount
--                             , tmpMI_Container.MovementItemDescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId
                        )

        , tmpMI_sum AS (SELECT tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.GoodsId
                             , SUM (tmpMI_Container.Amount)             AS Summ
                             , 0                                        AS Amount
                             , tmpMI_Container.HeadCount
--                             , tmpMI_Container.MovementItemDescId as DescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId

                        FROM tmpMI_Container
                          -- JOIN (SELECT AccountID FROM Object_Account_View WHERE AccountGroupId = zc_Enum_AccountGroup_20000()
                          --       ) AS tmpAccount on tmpAccount.AccountID = tmpMI_Container.ContainerObjectId
                        WHERE tmpMI_Container.MIContainerDescId = zc_MIContainer_Summ() AND tmpMI_Container.MovementItemDescId = zc_MI_Master()
                        GROUP BY tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.GoodsId
                             , tmpMI_Container.HeadCount
--                             , tmpMI_Container.MovementItemDescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId
                           )


      SELECT CAST (tmpOperationGroup.InvNumber AS TVarChar)     AS InvNumber
           , CAST (tmpOperationGroup.OperDate AS TDateTime)     AS OperDate
           , tmpOperationGroup.PartionGoodsId                   AS PartionGoodsId
           , CAST (Object_PartionGoods.ValueData AS TVarChar)   AS PartionGoods
           , Object_GoodsGroup.ValueData                        AS GoodsGroupName
           , COALESCE (Object_Goods.Id,0)                       AS GoodsId
           , Object_Goods.ObjectCode                            AS GoodsCode
           , Object_Goods.ValueData                             AS GoodsName
           , tmpOperationGroup.Amount :: TFloat                 AS Amount
           , tmpOperationGroup.HeadCount :: TFloat              AS HeadCount
           , tmpOperationGroup.Summ :: TFloat                   AS Summ

           , COALESCE (tmpOperationGroup.MovementItemId,0)      AS MovementItemId
           , COALESCE (Object_InfoMoneyDetail.Id,0)             AS InfoMoneyDetailId
           , Object_InfoMoneyDetail.ValueData                   AS InfoMoneyDetailName
           , COALESCE (Object_Receipt.Id,0)                     AS ReceiptId
           , Object_Receipt.ValueData                           AS ReceiptName
           , COALESCE (Object_GoodsKind.Id,0)                   AS GoodsKindId
           , Object_GoodsKind.ValueData                         AS GoodsKindName
           , COALESCE (Object_Unit.Id,0)                        AS UnitId
           , Object_Unit.ValueData                              AS UnitName

      FROM (
            SELECT CASE WHEN inGroupMovement = True THEN tmpMI.InvNumber ELSE '' END                        AS InvNumber
                 , CASE WHEN inGroupMovement = True THEN tmpMI.OperDate ELSE CAST (Null AS TDateTime) END   AS OperDate
                 , CASE WHEN inGroupMovement = True THEN tmpMI.MovementItemId ELSE 0 END                    AS MovementItemId
                 , CASE WHEN inGroupPartion = True  THEN tmpMI.PartionGoodsId ELSE 0 END                    AS PartionGoodsId
                 , tmpMI.GoodsId                                                                            AS GoodsId
--                 , tmpMI.InfoMoneyDetailId                                                                  AS InfoMoneyDetailId
                 , CASE WHEN inGroupInfoMoney = True  THEN tmpMI.InfoMoneyDetailId ELSE 0 END               AS InfoMoneyDetailId
                 , tmpMI.ReceiptId                                                                          AS ReceiptId
                 , tmpMI.GoodsKindId                                                                        AS GoodsKindId
                 , tmpMI.UnitId                                                                             AS UnitId

                 , ABS (SUM(tmpMI.Summ))                                                                    AS Summ
                 , ABS (SUM(tmpMI.Amount))                                                                  AS Amount
                 , ABS (SUM(tmpMI.HeadCount))                                                               AS HeadCount

            FROM (SELECT  tmpMIMaster_Sum.InvNumber
                        , tmpMIMaster_Sum.OperDate
                        , tmpMIMaster_Sum.PartionGoodsId
                        , tmpMIMaster_Sum.GoodsId
                        , tmpMIMaster_Sum.Summ
                        , tmpMIMaster_Sum.Amount
                        , tmpMIMaster_Sum.HeadCount
                        , tmpMIMaster_Sum.MovementItemId --AS MasterId
                        , tmpMIMaster_Sum.InfoMoneyDetailId
                        , tmpMIMaster_Sum.ReceiptId
                        , tmpMIMaster_Sum.GoodsKindId
                        , tmpMIMaster_Sum.UnitId
                  FROM tmpMI_sum AS tmpMIMaster_Sum
                  JOIN _tmpGoods ON _tmpGoods.GoodsId = tmpMIMaster_Sum.GoodsId
                  UNION
                  SELECT  tmpMIMaster.InvNumber
                        , tmpMIMaster.OperDate
                        , tmpMIMaster.PartionGoodsId
                        , tmpMIMaster.GoodsId as GoodsId
                        , tmpMIMaster.Summ
                        , tmpMIMaster.Amount
                        , tmpMIMaster.HeadCount
                        , tmpMIMaster.MovementItemId --AS MasterId
                        , tmpMIMaster.InfoMoneyDetailId
                        , tmpMIMaster.ReceiptId
                        , tmpMIMaster.GoodsKindId
                        , tmpMIMaster.UnitId

                  FROM tmpMI_Count AS tmpMIMaster
                  JOIN _tmpGoods ON _tmpGoods.GoodsId = tmpMIMaster.GoodsId

                ) AS tmpMI
	    GROUP BY   CASE WHEN inGroupMovement = True THEN tmpMI.InvNumber ELSE '' END
                 , CASE WHEN inGroupMovement = True THEN tmpMI.OperDate ELSE CAST (Null AS TDateTime) END
                 , CASE WHEN inGroupMovement = True THEN tmpMI.MovementItemId ELSE 0 END
                 , CASE WHEN inGroupPartion = True  THEN tmpMI.PartionGoodsId ELSE 0 END
                 , tmpMI.GoodsId
--                 , tmpMI.InfoMoneyDetailId
                 , CASE WHEN inGroupInfoMoney = True  THEN tmpMI.InfoMoneyDetailId ELSE 0 END
                 , tmpMI.ReceiptId
                 , tmpMI.GoodsKindId
                 , tmpMI.UnitId

            ) AS tmpOperationGroup

             LEFT JOIN Object AS Object_Goods on Object_Goods.Id = tmpOperationGroup.GoodsId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                                  ON ObjectLink_Goods_GoodsGroup.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
             LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId
             LEFT JOIN Object AS Object_PartionGoods
                              ON Object_PartionGoods.Id = tmpOperationGroup.PartionGoodsId
                             AND inGroupPartion = True

             LEFT JOIN Object AS Object_InfoMoneyDetail ON Object_InfoMoneyDetail.Id = tmpOperationGroup.InfoMoneyDetailId
             LEFT JOIN Object AS Object_Receipt ON Object_Receipt.Id = tmpOperationGroup.ReceiptId
             LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpOperationGroup.GoodsKindId
             LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmpOperationGroup.UnitId


       ORDER BY
               tmpOperationGroup.InvNumber
             , tmpOperationGroup.OperDate
             , Object_PartionGoods.ValueData
             , Object_GoodsGroup.ValueData
             , Object_Goods.ObjectCode
             , Object_Goods.ValueData

       ;
     RETURN NEXT Cursor1;

    -- ��������� 2

     OPEN Cursor2 FOR

    -- ������������ �� ���� ���������  , �� �� ���� / ����
      WITH tmpMovement AS
                        (SELECT Movement.Id        AS MovementId
                              , Movement.InvNumber AS InvNumber
                              , Movement.OperDate  AS OperDate
                              , MovementLinkObject_From.ObjectId AS UnitId
                         FROM Movement
                         LEFT JOIN MovementLinkObject AS MovementLinkObject_From
				                                      ON MovementLinkObject_From.MovementId = Movement.Id
						                             AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
			             JOIN _tmpFromGroup ON _tmpFromGroup.FromId = MovementLinkObject_From.ObjectId
                         LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                      ON MovementLinkObject_To.MovementId = Movement.Id
                                                     AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                         JOIN _tmpToGroup on _tmpToGroup.ToId = MovementLinkObject_To.ObjectId

                         WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate
                           AND Movement.DescId  = zc_Movement_ProductionUnion()
                         GROUP BY Movement.Id
                                , Movement.InvNumber
                                , Movement.OperDate
                                , MovementLinkObject_From.ObjectId
                         )

  , tmpMI_Container AS (SELECT tmpMovement.MovementId                           AS MovementId
                             , tmpMovement.InvNumber                            AS InvNumber
                             , tmpMovement.OperDate                             AS OperDate
                             , MovementItem.ObjectId                            AS GoodsId
                             , (MIContainer.Amount)                             AS Amount
                             , MIFloat_HeadCount.ValueData                      AS HeadCount
                             , MovementItem.DescId                              AS MovementItemDescId
                             , MIContainer.DescId                               AS MIContainerDescId
                             , Container.ObjectId                               AS ContainerObjectId
                             , MovementItem.Id                                  AS MovementItemId
                             , MovementItem.ParentId                            AS MovementItemParentId
                             , COALESCE (CLO_PartionGoods.ObjectId, 0)          AS PartionGoodsId

                             , COALESCE (CLO_InfoMoneyDetail.ObjectId, 0)       AS InfoMoneyDetailId
                             , COALESCE (MILinkObject_Receipt.ObjectId, 0)      AS ReceiptId
                             , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)    AS GoodsKindId
                             , COALESCE (tmpMovement.UnitId,0)                  AS UnitId

                        FROM tmpMovement
                        JOIN MovementItemContainer AS MIContainer
                                                   ON MIContainer.MovementId = tmpMovement.MovementId
                        JOIN Container ON Container.Id = MIContainer.ContainerId
                        JOIN MovementItem ON MovementItem.Id = MIContainer.MovementItemId

	                    LEFT JOIN MovementItemFloat AS MIFloat_HeadCount
                                                        ON MIFloat_HeadCount.MovementItemId = MovementItem.Id
                                                       AND MIContainer.DescId =  zc_MIContainer_Count()
                                                       AND MIFloat_HeadCount.DescId = zc_MIFloat_Count()

                        LEFT JOIN MovementItemLinkObject AS MILinkObject_Receipt
                                                         ON MILinkObject_Receipt.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_Receipt.DescId = zc_MILinkObject_Receipt()

                        LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                         ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()

                        LEFT JOIN ContainerLinkObject AS CLO_PartionGoods
                                                      ON CLO_PartionGoods.ContainerId = Container.Id
                                                     AND CLO_PartionGoods.DescId = zc_ContainerLinkObject_PartionGoods()

                        LEFT JOIN ContainerLinkObject AS CLO_InfoMoneyDetail
                                                      ON CLO_InfoMoneyDetail.ContainerId = Container.Id
                                                     AND CLO_InfoMoneyDetail.DescId = zc_ContainerLinkObject_InfoMoneyDetail()
                           )

     , tmpMI_Count AS (SELECT tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.GoodsId
                             , 0                                    AS Summ
                             , SUM (tmpMI_Container.Amount)         AS Amount
                             , tmpMI_Container.HeadCount
                             , tmpMI_Container.MovementItemDescId   AS DescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId

                        FROM tmpMI_Container

                        WHERE tmpMI_Container.MIContainerDescId = zc_MIContainer_Count()
                        GROUP BY tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.GoodsId
                             , tmpMI_Container.HeadCount
                             , tmpMI_Container.MovementItemDescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId
                        )

        , tmpMI_sum AS (SELECT tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.GoodsId
                             , SUM (tmpMI_Container.Amount)         AS Summ
                             , 0                                    AS Amount
                             , tmpMI_Container.HeadCount
                             , tmpMI_Container.MovementItemDescId   AS DescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId

                        FROM tmpMI_Container
                          -- JOIN (SELECT AccountID FROM Object_Account_View WHERE AccountGroupId = zc_Enum_AccountGroup_20000()
                          --       ) AS tmpAccount on tmpAccount.AccountID = tmpMI_Container.ContainerObjectId
                        WHERE tmpMI_Container.MIContainerDescId = zc_MIContainer_Summ()
                        GROUP BY tmpMI_Container.MovementId
                             , tmpMI_Container.InvNumber
                             , tmpMI_Container.OperDate
                             , tmpMI_Container.GoodsId
                             , tmpMI_Container.HeadCount
                             , tmpMI_Container.MovementItemDescId
                             , tmpMI_Container.MovementItemId
                             , tmpMI_Container.MovementItemParentId
                             , tmpMI_Container.PartionGoodsId
                             , tmpMI_Container.InfoMoneyDetailId
                             , tmpMI_Container.ReceiptId
                             , tmpMI_Container.GoodsKindId
                             , tmpMI_Container.UnitId
                           )


      SELECT --tmpOperationGroup.MasterId                             AS MasterId

             CAST (Object_PartionGoodsChild.ValueData AS TVarChar)  AS ChildPartionGoods
           , Object_GoodsGroupChild.ValueData                       AS ChildGoodsGroupName
           , Object_GoodsChild.ObjectCode                           AS ChildGoodsCode
           , Object_GoodsChild.ValueData                            AS ChildGoodsName
           , tmpOperationGroup.ChildAmount  :: TFloat               AS ChildAmount
           , tmpOperationGroup.ChildSumm :: TFloat                  AS ChildSumm

           , COALESCE (tmpOperationGroup.PartionGoodsId,0)                       AS PartionGoodsId
           , COALESCE (tmpOperationGroup.MovementItemId,0)                       AS MovementItemId
           , COALESCE (tmpOperationGroup.GoodsId,0)                              AS GoodsId
           , COALESCE (tmpOperationGroup.InfoMoneyDetailId,0)                    AS InfoMoneyDetailId
           , COALESCE (tmpOperationGroup.ReceiptId,0)                            AS ReceiptId
           , COALESCE (tmpOperationGroup.GoodsKindId,0)                          AS GoodsKindId
           , COALESCE (tmpOperationGroup.UnitId,0)                               AS UnitId

           , Object_InfoMoneyDetailChild.Id                         AS InfoMoneyDetailChildId
           , Object_InfoMoneyDetailChild.ValueData                  AS InfoMoneyDetailChildName
           , Object_GoodsKindChild.Id                               AS GoodsKindChildId
           , Object_GoodsKindChild.ValueData                        AS GoodsKindChildName

           , CASE WHEN tmpOperationGroup.ChildAmount <> 0 THEN COALESCE ((tmpOperationGroup.ChildSumm / tmpOperationGroup.ChildAmount) ,0) ELSE 0 END  :: TFloat  AS ChildPrice

      FROM (
            SELECT
/*
                   CASE WHEN inGroupMovement = TRUE THEN tmpMI.MasterId
                        WHEN inGroupPartion  = TRUE THEN tmpMI.PartionGoodsId
                   ELSE tmpMI.GoodsId END       AS MasterId
*/


                   CASE WHEN inGroupMovement = True THEN tmpMI.MovementItemId ELSE 0 END                    AS MovementItemId
                 , CASE WHEN inGroupPartion = True  THEN tmpMI.PartionGoodsId ELSE 0 END                    AS PartionGoodsId
                 , tmpMI.GoodsId                                                                            AS GoodsId
                 , CASE WHEN inGroupInfoMoney = True  THEN tmpMI.InfoMoneyDetailId ELSE 0 END               AS InfoMoneyDetailId
--                 , tmpMI.InfoMoneyDetailId                                                                  AS InfoMoneyDetailId
                 , tmpMI.ReceiptId                                                                          AS ReceiptId
                 , tmpMI.GoodsKindId                                                                        AS GoodsKindId
                 , tmpMI.UnitId                                                                             AS UnitId


                 , tmpMI.ChildGoodsId                                                                       AS ChildGoodsId
                 , tmpMI.ChildGoodsKindId                                                                   AS ChildGoodsKindId
                 , tmpMI.ChildInfoMoneyDetailId                                                             AS ChildInfoMoneyDetailId
                 , CASE WHEN inGroupPartion = True THEN tmpMI.ChildPartionGoodsId ELSE 0 END                AS ChildPartionGoodsId




                 , ABS (SUM(tmpMI.ChildSumm))   AS ChildSumm
                 , ABS (SUM(tmpMI.ChildAmount)) AS ChildAmount

            FROM (SELECT  tmpMIChild_Sum.MovementItemParentId       AS MovementItemId --Parent
                        , tmpMIMaster_Sum.GoodsId                   AS GoodsId
                        , tmpMIMaster_Sum.PartionGoodsId            AS PartionGoodsId
                        , tmpMIChild_Sum.PartionGoodsId             AS ChildPartionGoodsId
                        , tmpMIChild_Sum.GoodsId                    AS ChildGoodsId
                        , tmpMIChild_Sum.Summ                       AS ChildSumm
                        , tmpMIChild_Sum.Amount                     AS ChildAmount

                        , tmpMIChild_Sum.InfoMoneyDetailId          AS ChildInfoMoneyDetailId
                        , tmpMIChild_Sum.GoodsKindId                AS ChildGoodsKindId

--                        , tmpMIMaster_Sum.InfoMoneyDetailId         AS InfoMoneyDetailId
                        , tmpMIChild_Sum.InfoMoneyDetailId          AS InfoMoneyDetailId
                        , tmpMIMaster_Sum.ReceiptId                 AS ReceiptId
                        , tmpMIMaster_Sum.GoodsKindId               AS GoodsKindId
                        , tmpMIMaster_Sum.UnitId                    AS UnitId

                  FROM tmpMI_sum AS tmpMIMaster_Sum
                       JOIN tmpMI_sum AS tmpMIChild_Sum ON tmpMIChild_Sum.MovementItemParentId = tmpMIMaster_Sum.MovementItemId
/*
                                                       AND tmpMIChild_Sum.ReceiptId = tmpMIMaster_Sum.ReceiptId
                                                       AND tmpMIChild_Sum.GoodsKindId = tmpMIMaster_Sum.GoodsKindId
                                                       AND tmpMIChild_Sum.UnitId = tmpMIMaster_Sum.UnitId
                                                       AND tmpMIChild_Sum.InfoMoneyDetailId = tmpMIMaster_Sum.InfoMoneyDetailId
*/
                                                       AND tmpMIChild_Sum.DescId = zc_MI_Child()
                       JOIN _tmpGoods ON _tmpGoods.GoodsId = tmpMIMaster_Sum.GoodsId
                       JOIN _tmpChildGoods ON _tmpChildGoods.ChildGoodsId = tmpMIChild_Sum.GoodsId
		                      --
                  WHERE tmpMIMaster_Sum.DescId = zc_MI_Master()

                  UNION

                  SELECT  tmpMIChild.MovementItemParentId           AS MovementItemId --Parent
                        , tmpMIMaster.GoodsId                       AS GoodsId
                        , tmpMIMaster.PartionGoodsId                AS PartionGoodsId
                        , tmpMIChild.PartionGoodsId                 AS ChildPartionGoodsId
                        , tmpMIChild.GoodsId                        AS ChildGoodsId
                        , tmpMIChild.Summ                           AS ChildSumm
                        , tmpMIChild.Amount                         AS ChildAmount

                        , tmpMIChild.InfoMoneyDetailId              AS ChildInfoMoneyDetailId
                        , tmpMIChild.GoodsKindId                    AS ChildGoodsKindId

                        , tmpMIMaster.InfoMoneyDetailId             AS InfoMoneyDetailId
                        , tmpMIMaster.ReceiptId                     AS ReceiptId
                        , tmpMIMaster.GoodsKindId                   AS GoodsKindId
                        , tmpMIMaster.UnitId                        AS UnitId



                  FROM tmpMI_Count AS tmpMIMaster
                         LEFT JOIN tmpMI_Count AS tmpMIChild ON tmpMIChild.MovementItemParentId = tmpMIMaster.MovementItemId
/*
                                                            AND tmpMIChild.ReceiptId = tmpMIMaster.ReceiptId
                                                            AND tmpMIChild.GoodsKindId = tmpMIMaster.GoodsKindId
                                                            AND tmpMIChild.UnitId = tmpMIMaster.UnitId
                                                            AND tmpMIChild.InfoMoneyDetailId = tmpMIMaster.InfoMoneyDetailId
*/
                                                            AND tmpMIChild.DescId = zc_MI_Child()
                         JOIN _tmpGoods ON _tmpGoods.GoodsId = tmpMIMaster.GoodsId
                         JOIN _tmpChildGoods ON _tmpChildGoods.ChildGoodsId = tmpMIChild.GoodsId

                  WHERE tmpMIMaster.DescId = zc_MI_Master()
                    AND COALESCE (tmpMIChild.Amount, -1 ) <> 0

                 ) AS tmpMI

	           GROUP BY

                   CASE WHEN inGroupMovement = True THEN tmpMI.MovementItemId ELSE 0 END
                 , CASE WHEN inGroupPartion = True  THEN tmpMI.PartionGoodsId ELSE 0 END
                 , tmpMI.GoodsId
--                 , tmpMI.InfoMoneyDetailId
                 , CASE WHEN inGroupInfoMoney = True  THEN tmpMI.InfoMoneyDetailId ELSE 0 END
                 , tmpMI.ReceiptId
                 , tmpMI.GoodsKindId
                 , tmpMI.UnitId
                 , tmpMI.ChildGoodsId
                 , tmpMI.ChildGoodsKindId
                 , tmpMI.ChildInfoMoneyDetailId
                 , CASE WHEN inGroupPartion = True THEN tmpMI.ChildPartionGoodsId ELSE 0 END


            ) AS tmpOperationGroup


             LEFT JOIN Object AS Object_GoodsChild on Object_GoodsChild.Id = tmpOperationGroup.ChildGoodsId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupChild
                                  ON ObjectLink_Goods_GoodsGroupChild.ObjectId = Object_GoodsChild.Id
                                 AND ObjectLink_Goods_GoodsGroupChild.DescId = zc_ObjectLink_Goods_GoodsGroup()
             LEFT JOIN Object AS Object_GoodsGroupChild ON Object_GoodsGroupChild.Id = ObjectLink_Goods_GoodsGroupChild.ChildObjectId

             LEFT JOIN Object AS Object_PartionGoodsChild
                              ON Object_PartionGoodsChild.Id = tmpOperationGroup.ChildPartionGoodsId
                             AND inGroupPartion = True
/*
             LEFT JOIN Object AS Object_InfoMoneyDetail ON Object_InfoMoneyDetail.Id = tmpOperationGroup.InfoMoneyDetailId
             LEFT JOIN Object AS Object_Receipt ON Object_Receipt.Id = tmpOperationGroup.ReceiptId
             LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpOperationGroup.GoodsKindId
             LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmpOperationGroup.UnitId
*/
-- child
             LEFT JOIN Object AS Object_InfoMoneyDetailChild ON Object_InfoMoneyDetailChild.Id = tmpOperationGroup.ChildInfoMoneyDetailId
             LEFT JOIN Object AS Object_GoodsKindChild ON Object_GoodsKindChild.Id = tmpOperationGroup.ChildGoodsKindId



--       ORDER BY --tmpOperationGroup.MasterId,  Object_PartionGoodsChild.ValueData
       ;
     RETURN NEXT Cursor2;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
--ALTER FUNCTION gpReport_GoodsMI_ProductionUnionMD (TDateTime, TDateTime, Integer, Boolean, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 04.12.14                                                       *
 02.12.14                                                       *



*/

-- ����
/*
BEGIN;
 select * from gpReport_GoodsMI_ProductionUnionMD(inStartDate := ('03.06.2014')::TDateTime , inEndDate := ('03.06.2014')::TDateTime , inGroupMovement := 'True' , inGroupPartion := 'True' , inGroupInfoMoney := 'True', inGoodsGroupId := 0 , inGoodsId := 0 , inChildGoodsGroupId := 0 , inChildGoodsId :=0 , inFromId := 0 , inToId := 0 ,  inSession := '5');
COMMIT;
*/
