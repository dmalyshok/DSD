-- Function: gpSelect_Scale_MI()

DROP FUNCTION IF EXISTS gpSelect_Scale_MI (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Scale_MI(
    IN inMovementId  Integer      , -- ���� ���������
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (MovementItemId Integer, GoodsCode Integer, GoodsName TVarChar, MeasureName TVarChar
             , Amount TFloat, AmountWeight TFloat, AmountPartner TFloat, AmountPartnerWeight TFloat
             , RealWeight TFloat, RealWeightWeight TFloat, CountTare TFloat, WeightTare TFloat, WeightTareTotal TFloat
             , Count TFloat, HeadCount TFloat, BoxCount TFloat
             , BoxNumber TFloat, LevelNumber TFloat
             , ChangePercentAmount TFloat
             , Price TFloat, CountForPrice TFloat
             , PartionGoods TVarChar, PartionGoodsDate TDateTime
             , GoodsKindName TVarChar
             , BoxId Integer, BoxName TVarChar
             , PriceListName  TVarChar
             , InsertDate TDateTime, UpdateDate TDateTime
             , isBarCode   Boolean
             , isPromo     Boolean
             , Color_calc  Integer
             , TaxDoc      TFloat
             , TaxDoc_calc TFloat
             , AmountDoc   TFloat
             , AmountStart TFloat
             , AmountEnd   TFloat
             , Ord         Integer
             , isErased    Boolean
              )
AS
$BODY$
    DECLARE vbGoodsPropertyId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Scale_MI());

     -- ������������
     vbGoodsPropertyId:= zfCalc_GoodsPropertyId ((SELECT MLO.ObjectId FROM MovementLinkObject AS MLO WHERE MLO.MovementId = inMovementId AND MLO.DescId = zc_MovementLinkObject_Contract())
                                               , (SELECT OL_Juridical.ChildObjectId FROM MovementLinkObject AS MLO LEFT JOIN ObjectLink AS OL_Juridical ON OL_Juridical.ObjectId = MLO.ObjectId AND OL_Juridical.DescId = zc_ObjectLink_Partner_Juridical() WHERE MLO.MovementId = inMovementId AND MLO.DescId = zc_MovementLinkObject_To())
                                               , (SELECT MLO.ObjectId FROM MovementLinkObject AS MLO WHERE MLO.MovementId = inMovementId AND MLO.DescId = zc_MovementLinkObject_To())
                                                );

     RETURN QUERY 
       WITH -- MovementItem
            tmpMI AS (SELECT MovementItem.Id AS MovementItemId
                           , MovementItem.ObjectId AS GoodsId
                           , MovementItem.Amount
                           , COALESCE (MIFloat_AmountPartner.ValueData, 0) AS AmountPartner
         
                           , COALESCE (MIFloat_RealWeight.ValueData, 0)          AS RealWeight
                           , COALESCE (MIFloat_CountTare.ValueData, 0)           AS CountTare
                           , COALESCE (MIFloat_WeightTare.ValueData, 0)          AS WeightTare
         
                           , COALESCE (MIFloat_CountPack.ValueData, 0)           AS CountPack
                           , COALESCE (MIFloat_HeadCount.ValueData, 0)           AS HeadCount
                           , COALESCE (MIFloat_BoxCount.ValueData, 0)            AS BoxCount
         
                           , COALESCE (MIFloat_BoxNumber.ValueData, 0)   AS BoxNumber
                           , COALESCE (MIFloat_LevelNumber.ValueData, 0) AS LevelNumber
         
                           , COALESCE (MIFloat_ChangePercentAmount.ValueData, 0) AS ChangePercentAmount
         
                           , COALESCE (MIFloat_Price.ValueData, 0) 		  AS Price
                           , COALESCE (MIFloat_CountForPrice.ValueData, 0) 	  AS CountForPrice
                    
                           , MIString_PartionGoods.ValueData   AS PartionGoods
                           , MIDate_PartionGoods.ValueData     AS PartionGoodsDate
         
                           , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                           , COALESCE (MILinkObject_Box.ObjectId, 0)       AS BoxId
                           , COALESCE (MILinkObject_PriceList.ObjectId, 0) AS PriceListId
                    
                           , MIDate_Insert.ValueData AS InsertDate
                           , MIDate_Update.ValueData AS UpdateDate
         
                           , MIFloat_PromoMovement.ValueData AS MovementId_Promo
         
                           , MIBoolean_BarCode.ValueData AS isBarCode
         
                           , MovementItem.isErased
         
                      FROM MovementItem
                           LEFT JOIN MovementItemDate AS MIDate_Insert
                                                      ON MIDate_Insert.MovementItemId = MovementItem.Id
                                                     AND MIDate_Insert.DescId = zc_MIDate_Insert()
                           LEFT JOIN MovementItemDate AS MIDate_Update
                                                      ON MIDate_Update.MovementItemId = MovementItem.Id
                                                     AND MIDate_Update.DescId = zc_MIDate_Update()
         
                           LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                                      ON MIDate_PartionGoods.MovementItemId = MovementItem.Id
                                                     AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                           LEFT JOIN MovementItemString AS MIString_PartionGoods
                                                        ON MIString_PartionGoods.MovementItemId = MovementItem.Id
                                                       AND MIString_PartionGoods.DescId = zc_MIString_PartionGoods()
                                                                          
                           LEFT JOIN MovementItemFloat AS MIFloat_ChangePercentAmount
                                                       ON MIFloat_ChangePercentAmount.MovementItemId = MovementItem.Id
                                                      AND MIFloat_ChangePercentAmount.DescId = zc_MIFloat_ChangePercentAmount()
         
                           LEFT JOIN MovementItemFloat AS MIFloat_RealWeight
                                                       ON MIFloat_RealWeight.MovementItemId = MovementItem.Id
                                                      AND MIFloat_RealWeight.DescId = zc_MIFloat_RealWeight()
                           LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                       ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                                      AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                           LEFT JOIN MovementItemFloat AS MIFloat_CountTare
                                                       ON MIFloat_CountTare.MovementItemId = MovementItem.Id
                                                      AND MIFloat_CountTare.DescId = zc_MIFloat_CountTare()
                           LEFT JOIN MovementItemFloat AS MIFloat_WeightTare
                                                       ON MIFloat_WeightTare.MovementItemId = MovementItem.Id
                                                      AND MIFloat_WeightTare.DescId = zc_MIFloat_WeightTare()
                           LEFT JOIN MovementItemFloat AS MIFloat_CountPack
                                                       ON MIFloat_CountPack.MovementItemId = MovementItem.Id
                                                      AND MIFloat_CountPack.DescId = zc_MIFloat_CountPack()
                           LEFT JOIN MovementItemFloat AS MIFloat_HeadCount
                                                       ON MIFloat_HeadCount.MovementItemId = MovementItem.Id
                                                      AND MIFloat_HeadCount.DescId = zc_MIFloat_HeadCount()
         
                           LEFT JOIN MovementItemFloat AS MIFloat_BoxCount
                                                       ON MIFloat_BoxCount.MovementItemId = MovementItem.Id
                                                      AND MIFloat_BoxCount.DescId = zc_MIFloat_BoxCount()
                           LEFT JOIN MovementItemFloat AS MIFloat_BoxNumber
                                                       ON MIFloat_BoxNumber.MovementItemId = MovementItem.Id
                                                      AND MIFloat_BoxNumber.DescId = zc_MIFloat_BoxNumber()
                           LEFT JOIN MovementItemFloat AS MIFloat_LevelNumber
                                                       ON MIFloat_LevelNumber.MovementItemId = MovementItem.Id
                                                      AND MIFloat_LevelNumber.DescId = zc_MIFloat_LevelNumber()
         
                           LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                       ON MIFloat_Price.MovementItemId = MovementItem.Id
                                                      AND MIFloat_Price.DescId = zc_MIFloat_Price()
                           LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                                       ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                                      AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
         
                           LEFT JOIN MovementItemFloat AS MIFloat_PromoMovement
                                                       ON MIFloat_PromoMovement.MovementItemId = MovementItem.Id
                                                      AND MIFloat_PromoMovement.DescId = zc_MIFloat_PromoMovementId()
         
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                            ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
         
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_Box
                                                            ON MILinkObject_Box.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_Box.DescId = zc_MILinkObject_Box()
         
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_PriceList
                                                            ON MILinkObject_PriceList.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_PriceList.DescId = zc_MILinkObject_PriceList()
         
                           LEFT JOIN MovementItemBoolean AS MIBoolean_BarCode
                                                         ON MIBoolean_BarCode.MovementItemId =  MovementItem.Id
                                                        AND MIBoolean_BarCode.DescId = zc_MIBoolean_BarCode()
         
                      WHERE MovementItem.MovementId = inMovementId
                        AND MovementItem.DescId     = zc_MI_Master()
                     )
     -- ���������� ��������
   , tmpAmountDoc AS (SELECT DISTINCT
                             ObjectLink_GoodsPropertyValue_Goods.ChildObjectId                     AS GoodsId
                           , COALESCE (ObjectLink_GoodsPropertyValue_GoodsKind.ChildObjectId, 0)   AS GoodsKindId
                           , ObjectFloat_AmountDoc.ValueData * (1 - tmpGoodsProperty.TaxDoc / 100) AS AmountStart
                           , ObjectFloat_AmountDoc.ValueData * (1 + tmpGoodsProperty.TaxDoc / 100) AS AmountEnd
                           , ObjectFloat_AmountDoc.ValueData                                       AS AmountDoc
                           , tmpGoodsProperty.TaxDoc                                               AS TaxDoc
                      FROM (SELECT OFl.ObjectId AS GoodsPropertyId, OFl.ValueData AS TaxDoc FROM ObjectFloat AS OFl WHERE OFl.ObjectId = vbGoodsPropertyId AND OFl.DescId = zc_ObjectFloat_GoodsProperty_TaxDoc() AND OFl.ValueData > 0
                           ) AS tmpGoodsProperty
                           INNER JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_GoodsProperty
                                                 ON ObjectLink_GoodsPropertyValue_GoodsProperty.ChildObjectId = tmpGoodsProperty.GoodsPropertyId
                                                AND ObjectLink_GoodsPropertyValue_GoodsProperty.DescId        = zc_ObjectLink_GoodsPropertyValue_GoodsProperty()
                           LEFT JOIN ObjectFloat AS ObjectFloat_AmountDoc
                                                 ON ObjectFloat_AmountDoc.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                                AND ObjectFloat_AmountDoc.DescId   = zc_ObjectFloat_GoodsPropertyValue_AmountDoc()
                           LEFT JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_Goods
                                                ON ObjectLink_GoodsPropertyValue_Goods.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                               AND ObjectLink_GoodsPropertyValue_Goods.DescId   = zc_ObjectLink_GoodsPropertyValue_Goods()
                           LEFT JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_GoodsKind
                                                ON ObjectLink_GoodsPropertyValue_GoodsKind.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                               AND ObjectLink_GoodsPropertyValue_GoodsKind.DescId   = zc_ObjectLink_GoodsPropertyValue_GoodsKind()
                           INNER JOIN tmpMI ON tmpMI.GoodsId     = ObjectLink_GoodsPropertyValue_Goods.ChildObjectId
                                           AND tmpMI.GoodsKindId = ObjectLink_GoodsPropertyValue_GoodsKind.ChildObjectId
                                           AND tmpMI.isBarCode   = TRUE
                      WHERE ObjectFloat_AmountDoc.ValueData > 0
                     )
       -- ���������
       SELECT
             tmpMI.MovementItemId
           , Object_Goods.ObjectCode          AS GoodsCode
           , Object_Goods.ValueData           AS GoodsName
           , Object_Measure.ValueData         AS MeasureName

           , tmpMI.Amount :: TFloat           AS Amount
           , (tmpMI.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) :: TFloat AS AmountWeight

           , tmpMI.AmountPartner :: TFloat    AS AmountPartner
           , (tmpMI.AmountPartner * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) :: TFloat AS AmountPartnerWeight

           , tmpMI.RealWeight  :: TFloat      AS RealWeight
           , (tmpMI.RealWeight * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) :: TFloat AS RealWeightWeight
           , tmpMI.CountTare   :: TFloat      AS CountTare
           , tmpMI.WeightTare  :: TFloat      AS WeightTare
           , (tmpMI.WeightTare * tmpMI.CountTare) :: TFloat AS WeightTareTotal

           , tmpMI.CountPack   :: TFloat AS Count
           , tmpMI.HeadCount   :: TFloat AS HeadCount
           , tmpMI.BoxCount    :: TFloat AS BoxCount

           , tmpMI.BoxNumber   :: TFloat AS BoxNumber
           , tmpMI.LevelNumber :: TFloat AS LevelNumber

           , tmpMI.ChangePercentAmount :: TFloat AS ChangePercentAmount

           , tmpMI.Price         :: TFloat AS Price
           , tmpMI.CountForPrice :: TFloat AS CountForPrice
           
           , tmpMI.PartionGoods :: TVarChar       AS PartionGoods
           , tmpMI.PartionGoodsDate :: TDateTime  AS PartionGoodsDate

           , Object_GoodsKind.ValueData      AS GoodsKindName
           , Object_Box.Id                   AS BoxId
           , Object_Box.ValueData            AS BoxName
           , Object_PriceList.ValueData      AS PriceListName
           
           , tmpMI.InsertDate :: TDateTime AS InsertDate
           , tmpMI.UpdateDate :: TDateTime AS UpdateDate

           , COALESCE (tmpMI.isBarCode, FALSE) :: Boolean AS isBarCode
           , CASE WHEN tmpMI.MovementId_Promo > 0 THEN TRUE ELSE FALSE END :: Boolean AS isPromo

           , CASE WHEN tmpAmountDoc.AmountStart > 0 AND tmpMI.isErased = FALSE AND NOT (tmpMI.AmountPartner BETWEEN tmpAmountDoc.AmountStart AND tmpAmountDoc.AmountEnd)
                       THEN 16711680 -- clBlue
                  ELSE 0 -- clBlack
             END :: Integer AS Color_calc
           , tmpAmountDoc.TaxDoc :: TFloat AS TaxDoc
           , CASE WHEN tmpAmountDoc.AmountDoc > 0 AND tmpMI.isErased = FALSE
                       THEN 100 * tmpMI.AmountPartner / tmpAmountDoc.AmountDoc - 100
                  ELSE 0
             END :: TFloat AS TaxDoc_calc
           , tmpAmountDoc.AmountDoc   :: TFloat AS AmountDoc
           , tmpAmountDoc.AmountStart :: TFloat AS AmountStart
           , tmpAmountDoc.AmountEnd   :: TFloat AS AmountEnd

           , ROW_NUMBER() OVER (ORDER BY tmpMI.MovementItemId ASC) :: Integer AS Ord
           , tmpMI.isErased

       FROM tmpMI
            LEFT JOIN tmpAmountDoc ON tmpAmountDoc.GoodsId     = tmpMI.GoodsId
                                  AND tmpAmountDoc.GoodsKindId = tmpMI.GoodsKindId
            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMI.GoodsId
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpMI.GoodsKindId
            LEFT JOIN Object AS Object_Box ON Object_Box.Id = tmpMI.BoxId
            LEFT JOIN Object AS Object_PriceList ON Object_PriceList.Id = tmpMI.PriceListId
            LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                  ON ObjectFloat_Weight.ObjectId = tmpMI.GoodsId
                                 AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpMI.GoodsId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

       ORDER BY tmpMI.MovementItemId DESC
     ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Scale_MI (Integer, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 28.01.15                                        *
*/

-- ����
-- SELECT * FROM gpSelect_Scale_MI (inMovementId:= 25173, inSession:= '2')
