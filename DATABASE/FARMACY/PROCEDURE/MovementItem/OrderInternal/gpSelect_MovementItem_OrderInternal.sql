-- Function: gpSelect_MovementItem_OrderInternal()

DROP FUNCTION IF EXISTS gpSelect_MovementItem_OrderInternal (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MovementItem_OrderInternal(
    IN inMovementId  Integer      , -- ���� ���������
    IN inShowAll     Boolean      , --
    IN inIsErased    Boolean      , --
    IN inSession     TVarChar       -- ������ ������������
)

RETURNS SETOF refcursor 

AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbObjectId Integer;
  DECLARE Cursor1 refcursor;
  DECLARE Cursor2 refcursor;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_MovementItem_OrderInternal());
     vbUserId := inSession;
   vbObjectId := lpGet_DefaultValue('zc_Object_Retail', vbUserId);

     PERFORM lpCreateTempTable_OrderInternal(inMovementId, vbObjectId, 0, vbUserId);


     OPEN Cursor1 FOR
       SELECT
             tmpMI.Id                   AS Id
           , COALESCE(tmpMI.GoodsId, tmpGoods.GoodsId)     AS GoodsId
           , COALESCE(tmpMI.GoodsCode, tmpGoods.GoodsCode) AS GoodsCode
           , COALESCE(tmpMI.GoodsName, tmpGoods.GoodsName) AS GoodsName
           , tmpMI.Amount               AS Amount
           , tmpMI.Price * tmpMI.Amount AS Summ
           , FALSE                      AS isErased
           , tmpMI.Price
           , tmpMI.PartnerGoodsCode 
           , tmpMI.PartnerGoodsName
           , tmpMI.JuridicalName 
           , tmpMI.ContractName 
           , tmpMI.SuperFinalPrice 
           , COALESCE(tmpMI.isCalculated, FALSE) AS isCalculated

       FROM (SELECT Object_Goods.Id                              AS GoodsId
                  , Object_Goods.GoodsCodeInt                    AS GoodsCode
                  , Object_Goods.GoodsName                       AS GoodsName
             FROM Object_Goods_View AS Object_Goods
             WHERE Object_Goods.ObjectId = vbObjectId AND Object_Goods.isErased = FALSE
                   AND inShowAll = true       
            ) AS tmpGoods

            FULL JOIN (SELECT MovementItem.Id
                            , MovementItem.ObjectId              AS GoodsId
                            , MovementItem.Amount                AS Amount
                            , MIFloat_Summ.ValueData             AS Summ
                            , Object_Goods.GoodsCodeInt          AS GoodsCode
                            , Object_Goods.GoodsName             AS GoodsName
                            , MIBoolean_Calculated.ValueData     AS isCalculated
                            , COALESCE(PriceList.Price, MinPrice.Price) AS Price
                            , COALESCE(PriceList.GoodsCode, MinPrice.GoodsCode)         AS PartnerGoodsCode 
                            , COALESCE(PriceList.GoodsName, MinPrice.GoodsName)         AS PartnerGoodsName
                            , COALESCE(PriceList.JuridicalName, MinPrice.JuridicalName) AS JuridicalName
                            , COALESCE(PriceList.ContractName, MinPrice.ContractName)   AS ContractName
                            , COALESCE(PriceList.SuperFinalPrice, MinPrice.SuperFinalPrice) AS SuperFinalPrice

                       FROM (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE) AS tmpIsErased
                            JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                             AND MovementItem.DescId     = zc_MI_Master()
                                             AND MovementItem.isErased   = tmpIsErased.isErased
                       
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Juridical 
                                                        ON MILinkObject_Juridical.DescId = zc_MILinkObject_Juridical()
                                                       AND MILinkObject_Juridical.MovementItemId = MovementItem.id  
                                                       
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract 
                                                        ON MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
                                                       AND MILinkObject_Contract.MovementItemId = MovementItem.id  

                       LEFT JOIN MovementItemLinkObject AS MILinkObject_Goods 
                                                        ON MILinkObject_Goods.DescId = zc_MILinkObject_Goods()
                                                       AND MILinkObject_Goods.MovementItemId = MovementItem.id  

                       LEFT JOIN MovementItemBoolean AS MIBoolean_Calculated 
                                                     ON MIBoolean_Calculated.DescId = zc_MIBoolean_Calculated()
                                                    AND MIBoolean_Calculated.MovementItemId = MovementItem.id  

                       LEFT JOIN _tmpMI AS PriceList ON COALESCE(PriceList.ContractId, 0) = COALESCE(MILinkObject_Contract.ObjectId, 0)
                                                    AND PriceList.JuridicalId = MILinkObject_Juridical.ObjectId
                                                    AND PriceList.GoodsId = MILinkObject_Goods.ObjectId
                                                    AND PriceList.MovementItemId = MovementItem.id 

                       LEFT JOIN (SELECT * FROM 
                                      (SELECT *, MIN(Id) OVER(PARTITION BY MovementItemId) AS MinId FROM
                                           (SELECT *
                                                , MIN(SuperFinalPrice) OVER(PARTITION BY MovementItemId) AS MinSuperFinalPrice
                                            FROM _tmpMI) AS DDD
                                       WHERE DDD.SuperFinalPrice = DDD.MinSuperFinalPrice) AS DDD
                                  WHERE Id = MinId) AS MinPrice
                              ON MinPrice.MovementItemId = MovementItem.Id
                                             
                       JOIN Object_Goods_View AS Object_Goods 
                                              ON Object_Goods.Id = MovementItem.ObjectId 
                  LEFT JOIN MovementItemFloat AS MIFloat_Summ
                                              ON MIFloat_Summ.MovementItemId = MovementItem.Id
                                             AND MIFloat_Summ.DescId = zc_MIFloat_Summ()
                      ) AS tmpMI ON tmpMI.GoodsId     = tmpGoods.GoodsId;
        RETURN NEXT Cursor1;
     

     OPEN Cursor2 FOR
      SELECT * FROM _tmpMI;

   RETURN NEXT Cursor2;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MovementItem_OrderInternal (Integer, Boolean, Boolean, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 22.10.14                         *
 13.10.14                         *
 15.07.14                                                       *
 15.07.14                                                       *
 03.07.14                                                       *

*/

-- ����
-- SELECT * FROM gpSelect_MovementItem_OrderInternal (inMovementId:= 25173, inShowAll:= TRUE, inIsErased:= FALSE, inSession:= '9818')
-- SELECT * FROM gpSelect_MovementItem_OrderInternal (inMovementId:= 25173, inShowAll:= FALSE, inIsErased:= FALSE, inSession:= '2')
