-- Function: gpSelect_MI_ProductionUnion()

DROP FUNCTION IF EXISTS gpSelect_MI_ProductionUnion_Master (Integer, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_MI_ProductionUnion (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_ProductionUnion(
    IN inMovementId          Integer,
    IN inShowAll             Boolean,
    IN inisErased            Boolean      , --
    IN inSession             TVarChar       -- ������ ������������
)
RETURNS SETOF refcursor AS
$BODY$
  DECLARE Cursor1 refcursor;
  DECLARE Cursor2 refcursor;
BEGIN

   --PERFORM lpCheckRight(inSession, zc_Enum_Process_Select_MovementItem_ProductionUnion());
   IF inShowAll THEN
    OPEN Cursor1 FOR
       SELECT
              0                                     AS Id
--            , 0                                     AS LineNum
            , tmpGoods.GoodsId                      AS GoodsId
            , tmpGoods.GoodsCode                    AS GoodsCode
            , tmpGoods.GoodsName                    AS GoodsName
            , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
            , Object_Measure.ValueData              AS MeasureName
            , CAST (NULL AS TFloat)                 AS Amount

            , CAST (NULL AS Boolean)                AS PartionClose
            , CAST (NULL AS TDateTime)              AS PartionGoodsDate
            , CAST (NULL AS TVarchar)               AS PartionGoods

            , CAST (NULL AS TVarchar)               AS Comment
            , CAST (NULL AS TFloat)                 AS Count
            , CAST (NULL AS TFloat)                 AS RealWeight

            , CAST (NULL AS TFloat)                 AS CuterCount
            , CAST (NULL AS TFloat)                 AS CuterWeight

            , CAST (NULL AS Integer)                AS GoodsKindId
            , CAST (NULL AS Integer)                AS GoodsKindCode
            , CAST (NULL AS TVarchar)               AS GoodsKindName
            , CAST (NULL AS Integer)                AS GoodsKindId_Complete
            , CAST (NULL AS Integer)                AS GoodsKindCode_Complete
            , CAST (NULL AS TVarchar)               AS GoodsKindName_Complete

            , CAST (NULL AS Integer)                AS ReceiptId
            , CAST (NULL AS TVarchar)               AS ReceiptCode
            , CAST (NULL AS TVarchar)               AS ReceiptName

            , Object_InfoMoney_View.InfoMoneyCode
            , Object_InfoMoney_View.InfoMoneyGroupName
            , Object_InfoMoney_View.InfoMoneyDestinationName
            , Object_InfoMoney_View.InfoMoneyName
            , Object_InfoMoney_View.InfoMoneyName_all
            , FALSE                                  AS isAuto
            , FALSE                                  AS isErased

       FROM (SELECT Object_Goods.Id                          AS GoodsId
                  , Object_Goods.ObjectCode                  AS GoodsCode
                  , Object_Goods.ValueData                   AS GoodsName
                  , ObjectLink_Goods_InfoMoney.ChildObjectId AS InfoMoneyId
             FROM Object AS Object_Goods
                  LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                       ON ObjectLink_Goods_InfoMoney.ObjectId = Object_Goods.Id 
                                      AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
             WHERE Object_Goods.DescId = zc_Object_Goods()
            ) AS tmpGoods

            LEFT JOIN (SELECT MovementItem.ObjectId                         AS GoodsId
                       FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
                            JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                             AND MovementItem.DescId     = zc_MI_Master()
                                             AND MovementItem.isErased   = tmpIsErased.isErased
                      ) AS tmpMI ON tmpMI.GoodsId     = tmpGoods.GoodsId

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpGoods.GoodsId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = tmpGoods.GoodsId
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

            LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = tmpGoods.InfoMoneyId

       WHERE tmpMI.GoodsId IS NULL
      UNION ALL
       SELECT
             MovementItem.Id                    AS Id
--           , 0 AS LineNum
--           , CAST (row_number() OVER (ORDER BY MovementItem.Id) AS INTEGER) AS LineNum
            , Object_Goods.Id                   AS GoodsId
            , Object_Goods.ObjectCode           AS GoodsCode
            , Object_Goods.ValueData            AS GoodsName
            , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
            , Object_Measure.ValueData          AS MeasureName

            , MovementItem.Amount               AS Amount

            , MIBoolean_PartionClose.ValueData  AS PartionClose
            , MIDate_PartionGoods.ValueData     AS PartionGoodsDate
            , MIString_PartionGoods.ValueData   AS PartionGoods

            , MIString_Comment.ValueData        AS Comment
            , MIFloat_Count.ValueData           AS Count
            , MIFloat_RealWeight.ValueData      AS RealWeight
            , MIFloat_CuterCount.ValueData      AS CuterCount
            , MIFloat_CuterWeight.ValueData     AS CuterWeight

            , Object_GoodsKind.Id                 AS GoodsKindId
            , Object_GoodsKind.ObjectCode         AS GoodsKindCode
            , Object_GoodsKind.ValueData          AS GoodsKindName
            , Object_GoodsKindComplete.Id         AS GoodsKindId_Complete
            , Object_GoodsKindComplete.ObjectCode AS GoodsKindCode_Complete
            , Object_GoodsKindComplete.ValueData  AS GoodsKindName_Complete

            , Object_Receipt.Id                   AS ReceiptId
            , ObjectString_Receipt_Code.ValueData AS ReceiptCode
            , Object_Receipt.ValueData            AS ReceiptName

            , Object_InfoMoney_View.InfoMoneyCode
            , Object_InfoMoney_View.InfoMoneyGroupName
            , Object_InfoMoney_View.InfoMoneyDestinationName
            , Object_InfoMoney_View.InfoMoneyName
            , Object_InfoMoney_View.InfoMoneyName_all
            , COALESCE(MIBoolean_isAuto.ValueData, FALSE)  AS isAuto

            , MovementItem.isErased               AS isErased


       FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
            JOIN MovementItem ON MovementItem.MovementId = inMovementId
                             AND MovementItem.DescId     = zc_MI_Master()
                             AND MovementItem.isErased   = tmpIsErased.isErased
             LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Receipt
                                              ON MILinkObject_Receipt.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Receipt.DescId = zc_MILinkObject_Receipt()
             LEFT JOIN Object AS Object_Receipt ON Object_Receipt.Id = MILinkObject_Receipt.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                              ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
             LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILO_GoodsKindComplete
                                              ON MILO_GoodsKindComplete.MovementItemId = MovementItem.Id
                                             AND MILO_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
             LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = MILO_GoodsKindComplete.ObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                  ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
             LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

             LEFT JOIN MovementItemFloat AS MIFloat_Count
                                         ON MIFloat_Count.MovementItemId = MovementItem.Id
                                        AND MIFloat_Count.DescId = zc_MIFloat_Count()

             LEFT JOIN MovementItemFloat AS MIFloat_RealWeight
                                         ON MIFloat_RealWeight.MovementItemId = MovementItem.Id
                                        AND MIFloat_RealWeight.DescId = zc_MIFloat_RealWeight()

             LEFT JOIN MovementItemFloat AS MIFloat_CuterCount
                                         ON MIFloat_CuterCount.MovementItemId = MovementItem.Id
                                        AND MIFloat_CuterCount.DescId = zc_MIFloat_CuterCount()
             LEFT JOIN MovementItemFloat AS MIFloat_CuterWeight
                                         ON MIFloat_CuterWeight.MovementItemId = MovementItem.Id
                                        AND MIFloat_CuterWeight.DescId = zc_MIFloat_CuterWeight()

             LEFT JOIN MovementItemBoolean AS MIBoolean_PartionClose
                                           ON MIBoolean_PartionClose.MovementItemId = MovementItem.Id
                                          AND MIBoolean_PartionClose.DescId = zc_MIBoolean_PartionClose()

             LEFT JOIN MovementItemBoolean AS MIBoolean_isAuto
                                           ON MIBoolean_isAuto.MovementItemId = MovementItem.Id
                                          AND MIBoolean_isAuto.DescId = zc_MIBoolean_isAuto()

             LEFT JOIN MovementItemString AS MIString_Comment
                                          ON MIString_Comment.MovementItemId = MovementItem.Id
                                         AND MIString_Comment.DescId = zc_MIString_Comment()

             LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                        ON MIDate_PartionGoods.MovementItemId =  MovementItem.Id
                                       AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
             LEFT JOIN MovementItemString AS MIString_PartionGoods
                                          ON MIString_PartionGoods.MovementItemId = MovementItem.Id
                                         AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()

             LEFT JOIN ObjectString AS ObjectString_Receipt_Code
                                    ON ObjectString_Receipt_Code.ObjectId = Object_Receipt.Id
                                   AND ObjectString_Receipt_Code.DescId = zc_ObjectString_Receipt_Code()

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()
            LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                 ON ObjectLink_Goods_InfoMoney.ObjectId = Object_Goods.Id 
                                AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
            LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId
            ;

    RETURN NEXT Cursor1;

   ELSE

    OPEN Cursor1 FOR
       SELECT
             MovementItem.Id					AS Id
           , CAST (row_number() OVER (ORDER BY MovementItem.Id) AS INTEGER) AS  LineNum
            , Object_Goods.Id                   AS GoodsId
            , Object_Goods.ObjectCode           AS GoodsCode
            , Object_Goods.ValueData            AS GoodsName
            , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull

            , MovementItem.Amount               AS Amount

            , MIBoolean_PartionClose.ValueData  AS PartionClose
            , MIDate_PartionGoods.ValueData     AS PartionGoodsDate
            , MIString_PartionGoods.ValueData   AS PartionGoods

            , MIString_Comment.ValueData        AS Comment
            , MIFloat_Count.ValueData           AS Count
            , MIFloat_RealWeight.ValueData      AS RealWeight
            , MIFloat_CuterCount.ValueData      AS CuterCount
            , MIFloat_CuterWeight.ValueData     AS CuterWeight

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

            , Object_InfoMoney_View.InfoMoneyCode
            , Object_InfoMoney_View.InfoMoneyGroupName
            , Object_InfoMoney_View.InfoMoneyDestinationName
            , Object_InfoMoney_View.InfoMoneyName
            , Object_InfoMoney_View.InfoMoneyName_all
            , COALESCE(MIBoolean_isAuto.ValueData, FALSE)  AS isAuto

            , MovementItem.isErased               AS isErased

       FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
            JOIN MovementItem ON MovementItem.MovementId = inMovementId
                             AND MovementItem.DescId     = zc_MI_Master()
                             AND MovementItem.isErased   = tmpIsErased.isErased
             LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Receipt
                                              ON MILinkObject_Receipt.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Receipt.DescId = zc_MILinkObject_Receipt()
             LEFT JOIN Object AS Object_Receipt ON Object_Receipt.Id = MILinkObject_Receipt.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                              ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
             LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILO_GoodsKindComplete
                                              ON MILO_GoodsKindComplete.MovementItemId = MovementItem.Id
                                             AND MILO_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
             LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = MILO_GoodsKindComplete.ObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                  ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
             LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

             LEFT JOIN MovementItemFloat AS MIFloat_Count
                                         ON MIFloat_Count.MovementItemId = MovementItem.Id
                                        AND MIFloat_Count.DescId = zc_MIFloat_Count()

             LEFT JOIN MovementItemFloat AS MIFloat_RealWeight
                                         ON MIFloat_RealWeight.MovementItemId = MovementItem.Id
                                        AND MIFloat_RealWeight.DescId = zc_MIFloat_RealWeight()

             LEFT JOIN MovementItemFloat AS MIFloat_CuterCount
                                         ON MIFloat_CuterCount.MovementItemId = MovementItem.Id
                                        AND MIFloat_CuterCount.DescId = zc_MIFloat_CuterCount()
             LEFT JOIN MovementItemFloat AS MIFloat_CuterWeight
                                         ON MIFloat_CuterWeight.MovementItemId = MovementItem.Id
                                        AND MIFloat_CuterWeight.DescId = zc_MIFloat_CuterWeight()

             LEFT JOIN MovementItemBoolean AS MIBoolean_PartionClose
                                           ON MIBoolean_PartionClose.MovementItemId = MovementItem.Id
                                          AND MIBoolean_PartionClose.DescId = zc_MIBoolean_PartionClose()

             LEFT JOIN MovementItemBoolean AS MIBoolean_isAuto
                                           ON MIBoolean_isAuto.MovementItemId = MovementItem.Id
                                          AND MIBoolean_isAuto.DescId = zc_MIBoolean_isAuto()

             LEFT JOIN MovementItemString AS MIString_Comment
                                          ON MIString_Comment.MovementItemId = MovementItem.Id
                                         AND MIString_Comment.DescId = zc_MIString_Comment()

             LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                        ON MIDate_PartionGoods.MovementItemId =  MovementItem.Id
                                       AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
             LEFT JOIN MovementItemString AS MIString_PartionGoods
                                          ON MIString_PartionGoods.MovementItemId = MovementItem.Id
                                         AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
             LEFT JOIN ObjectString AS ObjectString_Receipt_Code
                                    ON ObjectString_Receipt_Code.ObjectId = Object_Receipt.Id
                                   AND ObjectString_Receipt_Code.DescId = zc_ObjectString_Receipt_Code()

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()
            LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                 ON ObjectLink_Goods_InfoMoney.ObjectId = Object_Goods.Id 
                                AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
            LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId
           ;

    RETURN NEXT Cursor1;
   END IF;

    OPEN Cursor2 FOR

       SELECT
              MovementItem.Id					AS Id
            , CAST (row_number() OVER (ORDER BY MovementItem.Id) AS INTEGER) AS  LineNum
            , Object_Goods.Id                   AS GoodsId
            , Object_Goods.ObjectCode           AS GoodsCode
            , Object_Goods.ValueData            AS GoodsName
            , ObjectString_Goods_GoodsGroupFull.ValueData AS GoodsGroupNameFull
  
            , MovementItem.Amount               AS Amount
            , MovementItem.ParentId             AS ParentId

            , MIFloat_AmountReceipt.ValueData   AS AmountReceipt

            , MIFloat_CuterCount.ValueData * MIFloat_AmountReceipt.ValueData AS AmountCalc

            , MIDate_PartionGoods.ValueData     AS PartionGoodsDate
            , MIString_PartionGoods.ValueData   AS PartionGoods

            , MIString_Comment.ValueData        AS Comment

            , Object_GoodsKind.Id               AS GoodsKindId
            , Object_GoodsKind.ObjectCode       AS GoodsKindCode
            , Object_GoodsKind.ValueData        AS GoodsKindName
            , Object_Measure.ValueData          AS MeasureName

            , Object_GoodsKindComplete.Id         AS GoodsKindCompleteId
            , Object_GoodsKindComplete.ObjectCode AS GoodsKindCompleteCode
            , Object_GoodsKindComplete.ValueData  AS GoodsKindCompleteName

            , MIFloat_Count.ValueData           AS Count_onCount

            , Object_Receipt.Id                 AS ReceiptId
            , Object_Receipt.ObjectCode         AS ReceiptCode
            , Object_Receipt.ValueData          AS ReceiptName

            , zfCalc_ReceiptChild_GroupNumber (inGoodsId                := Object_Goods.Id
                                             , inGoodsKindId            := Object_GoodsKind.Id
                                             , inInfoMoneyDestinationId := Object_InfoMoney_View.InfoMoneyDestinationId
                                             , inInfoMoneyId            := Object_InfoMoney_View.InfoMoneyId
                                             , inIsWeightMain           := MIBoolean_WeightMain.ValueData
                                             , inIsTaxExit              := MIBoolean_TaxExit.ValueData
                                              ) AS GroupNumber

            , COALESCE(MIBoolean_isAuto.ValueData, False)  AS isAuto
            , MovementItem.isErased             AS isErased

       FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
            JOIN MovementItem ON MovementItem.MovementId = inMovementId
                             AND MovementItem.DescId     = zc_MI_Child()
                             AND MovementItem.isErased   = tmpIsErased.isErased
             LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId

             LEFT JOIN MovementItemBoolean AS MIBoolean_isAuto
                                           ON MIBoolean_isAuto.MovementItemId = MovementItem.Id
                                          AND MIBoolean_isAuto.DescId = zc_MIBoolean_isAuto()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Receipt
                                              ON MILinkObject_Receipt.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Receipt.DescId = zc_MILinkObject_Receipt()
             LEFT JOIN Object AS Object_Receipt ON Object_Receipt.Id = MILinkObject_Receipt.ObjectId

             LEFT JOIN MovementItemBoolean AS MIBoolean_TaxExit
                                           ON MIBoolean_TaxExit.MovementItemId =  MovementItem.Id
                                          AND MIBoolean_TaxExit.DescId = zc_MIBoolean_TaxExit()
             LEFT JOIN MovementItemBoolean AS MIBoolean_WeightMain
                                           ON MIBoolean_WeightMain.MovementItemId =  MovementItem.Id
                                          AND MIBoolean_WeightMain.DescId = zc_MIBoolean_WeightMain()

             LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                        ON MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                                       AND MIDate_PartionGoods.MovementItemId =  MovementItem.Id

             LEFT JOIN MovementItemString AS MIString_PartionGoods
                                          ON MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                                         AND MIString_PartionGoods.MovementItemId =  MovementItem.Id

             LEFT JOIN MovementItemFloat AS MIFloat_AmountReceipt
                                         ON MIFloat_AmountReceipt.MovementItemId = MovementItem.Id
                                        AND MIFloat_AmountReceipt.DescId = zc_MIFloat_AmountReceipt()

             LEFT JOIN MovementItemFloat AS MIFloat_CuterCount
                                         ON MIFloat_CuterCount.MovementItemId = MovementItem.ParentId
                                        AND MIFloat_CuterCount.DescId = zc_MIFloat_CuterCount()

             LEFT JOIN MovementItemFloat AS MIFloat_Count
                                         ON MIFloat_Count.MovementItemId = MovementItem.Id
                                        AND MIFloat_Count.DescId = zc_MIFloat_Count()

             LEFT JOIN MovementItemString AS MIString_Comment
                                          ON MIString_Comment.MovementItemId = MovementItem.Id
                                         AND MIString_Comment.DescId = zc_MIString_Comment()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                              ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                             AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
             LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId

             LEFT JOIN MovementItemLinkObject AS MILO_GoodsKindComplete
                                              ON MILO_GoodsKindComplete.MovementItemId = MovementItem.Id
                                             AND MILO_GoodsKindComplete.DescId = zc_MILinkObject_GoodsKindComplete()
             LEFT JOIN Object AS Object_GoodsKindComplete ON Object_GoodsKindComplete.Id = MILO_GoodsKindComplete.ObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                  ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
             LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                  ON ObjectLink_Goods_InfoMoney.ObjectId = Object_Goods.Id
                                 AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
             LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

       ORDER BY MovementItem.Id
            ;
    RETURN NEXT Cursor2;

END;
$BODY$
LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MI_ProductionUnion (Integer, Boolean, Boolean, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 31.03.15         * add GoodsGroupNameFull
 19.12.14                                                       * add zc_MILinkObject_GoodsKindComplete
 02.06.14                                                       *
 27.05.14                                                       * ������� ���
 16.07.13         *

*/

-- ����
-- SELECT * FROM gpSelect_MI_ProductionUnion (inMovementId:= 1, inShowAll:= TRUE, inisErased:= FALSE, inSession:= '2')
