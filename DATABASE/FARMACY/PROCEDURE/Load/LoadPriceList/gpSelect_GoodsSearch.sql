-- Function: gpSelect_Movement_PriceList()

DROP FUNCTION IF EXISTS gpSelect_GoodsSearch (TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_GoodsSearch (TVarChar, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_GoodsSearch (TVarChar, TVarChar, TVarChar, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_GoodsSearch (Integer, TVarChar, TVarChar, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_GoodsSearch(
    IN inAreaId         Integer     -- ������
  , IN inGoodsSearch    TVarChar    -- ����� �������
  , IN inProducerSearch TVarChar    -- ����� �������������
  , IN inCodeSearch     TVarChar    -- ����� ������� �� ����
  , IN inSession        TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer, CommonCode Integer, BarCode TVarChar, 
               GoodsCode TVarChar, GoodsName TVarChar, GoodsNDS TVarChar, 
               GoodsId Integer, Code Integer, Name TVarChar, 
               Price TFloat, PriceWithNDS TFloat, ProducerName TVarChar, 
               JuridicalName TVarChar,
               ContractName TVarChar,
               AreaName TVarChar,
               ExpirationDate TDateTime, 
               MinimumLot TFloat, NDS TFloat, LinkGoodsId Integer, 
               MarginPercent TFloat, NewPrice TFloat)

AS
$BODY$
  DECLARE vbUserId     Integer;
  DECLARE vbObjectId   Integer;
  DECLARE vbUnitId     Integer;
  DECLARE vbUnitIdStr  TVarChar;
  DECLARE vbAreaId     Integer;
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_PriceList());
     vbUserId := inSession;
     vbObjectId := COALESCE (lpGet_DefaultValue ('zc_Object_Retail', vbUserId), '0');
     vbUnitIdStr := COALESCE (lpGet_DefaultValue ('zc_Object_Unit', vbUserId), '0');
     IF vbUnitIdStr <> '' THEN 
        vbUnitId := vbUnitIdStr;
     ELSE
     	vbUnitId := 0;
     END IF;	   

     -- ��������� ������ ������������
     vbAreaId:= (SELECT outAreaId FROM gpGet_Area_byUser(inSession));
     
     IF (COALESCE (vbAreaId, 0) <> 0) AND (vbAreaId <> inAreaId)
     THEN
         RAISE EXCEPTION '�� ���������� ���� ������� �� ��������� �������';
     END IF;
      
     RETURN QUERY
     WITH DD AS (SELECT DISTINCT Object_MarginCategoryItem_View.MarginPercent
                               , Object_MarginCategoryItem_View.MinPrice
                               , Object_MarginCategoryItem_View.MarginCategoryId
                 FROM Object_MarginCategoryItem_View
                      INNER JOIN Object AS Object_MarginCategoryItem ON Object_MarginCategoryItem.Id = Object_MarginCategoryItem_View.Id
                                                                    AND Object_MarginCategoryItem.isErased = FALSE
                )
        , MarginCondition AS (SELECT DD.MarginCategoryId, DD.MarginPercent, DD.MinPrice
                                   , COALESCE ((SELECT MIN (FF.minprice) FROM DD AS FF WHERE FF.MinPrice > DD.MinPrice AND FF.MarginCategoryId = DD.MarginCategoryId)
                                             , 1000000) AS MaxPrice 
                              FROM DD)
                              
          -- ������ ���� + ���
        , GoodsPrice AS
             (SELECT ObjectLink_Price_Goods.ChildObjectId AS GoodsId, COALESCE (ObjectBoolean_Top.ValueData, FALSE) AS isTOP, COALESCE (ObjectFloat_PercentMarkup.ValueData, 0) AS PercentMarkup
              FROM ObjectLink AS ObjectLink_Price_Unit
                   INNER JOIN ObjectLink AS ObjectLink_Price_Goods
                                         ON ObjectLink_Price_Goods.ObjectId = ObjectLink_Price_Unit.ObjectId
                                        AND ObjectLink_Price_Goods.DescId   = zc_ObjectLink_Price_Goods()
                   LEFT JOIN ObjectBoolean AS ObjectBoolean_Top
                                           ON ObjectBoolean_Top.ObjectId  = ObjectLink_Price_Unit.ObjectId
                                          AND ObjectBoolean_Top.DescId    = zc_ObjectBoolean_Price_Top()
                   LEFT JOIN ObjectFloat AS ObjectFloat_PercentMarkup
                                         ON ObjectFloat_PercentMarkup.ObjectId = ObjectLink_Price_Unit.ObjectId
                                        AND ObjectFloat_PercentMarkup.DescId = zc_ObjectFloat_Price_PercentMarkup()
              WHERE ObjectLink_Price_Unit.ChildObjectId = vbUnitId
                AND ObjectLink_Price_Unit.DescId        = zc_ObjectLink_Price_Goods()
                AND (ObjectBoolean_Top.ValueData = TRUE OR ObjectFloat_PercentMarkup.ValueData <> 0)
             )
   SELECT
         LoadPriceListItem.Id                AS Id,
         LoadPriceListItem.CommonCode        AS CommonCode,
         LoadPriceListItem.BarCode           AS BarCode,
         LoadPriceListItem.GoodsCode         AS GoodsCode,
         LoadPriceListItem.GoodsName         AS GoodsName,
         LoadPriceListItem.GoodsNDS          AS GoodsNDS,
         LoadPriceListItem.GoodsId           AS GoodsId,
         Object_Goods.GoodsCode              AS Code,
         Object_Goods.GoodsName              AS Name,
         LoadPriceListItem.Price             AS Price,
         (LoadPriceListItem.Price * (100 + Object_Goods.NDS)/100)::TFloat AS PriceWithNDS, 
         LoadPriceListItem.ProducerName, 
         Object_Juridical.ValueData          AS JuridicalName,
         Object_Contract.ValueData           AS ContractName,
         Object_Area.ValueData               AS AreaName,
         LoadPriceListItem.ExpirationDate    AS ExpirationDate,
         PartnerGoods.MinimumLot             AS MinimumLot,
         Object_Goods.NDS                    AS NDS,
         LinkGoods.Id                        AS LinkGoodsId
       , CASE WHEN COALESCE (NULLIF (GoodsPrice.isTOP, FALSE), ObjectGoodsView.isTop) = TRUE
                   THEN COALESCE (NULLIF (GoodsPrice.PercentMarkup, 0), COALESCE (ObjectGoodsView.PercentMarkup, 0)) -- - COALESCE(ObjectFloat_Juridical_Percent.valuedata, 0)
              ELSE COALESCE (MarginCondition.MarginPercent, 0) + COALESCE (ObjectFloat_Juridical_Percent.valuedata, 0)
         END                       :: TFloat AS MarginPercent
         --(MarginCondition.MarginPercent + COALESCE(ObjectFloat_Juridical_Percent.valuedata, 0))::TFloat,
       , zfCalc_SalePrice((LoadPriceListItem.Price * (100 + Object_Goods.NDS)/100),                         -- ���� � ���
                           CASE WHEN COALESCE (ObjectFloat_Contract_Percent.ValueData, 0) <> 0 
                                    THEN MarginCondition.MarginPercent + COALESCE (ObjectFloat_Contract_Percent.valuedata, 0)
                                ELSE MarginCondition.MarginPercent + COALESCE (ObjectFloat_Juridical_Percent.valuedata, 0)
                           END,                                                                             -- % ������� � ���������
                           COALESCE (NULLIF (GoodsPrice.isTOP, FALSE), ObjectGoodsView.isTop),              -- ��� �������
                           COALESCE (NULLIF (GoodsPrice.PercentMarkup, 0), ObjectGoodsView.PercentMarkup),  -- % ������� � ������
                           0.0, --ObjectFloat_Juridical_Percent.valuedata,                                  -- % ������������� � �� ���� ��� ����
                           ObjectGoodsView.Price                                                            -- ���� � ������ (�������������)
                         )         :: TFloat AS NewPrice

       FROM LoadPriceListItem 

            INNER JOIN LoadPriceList ON LoadPriceList.Id = LoadPriceListItem.LoadPriceListId
            LEFT JOIN (SELECT DISTINCT JuridicalId, ContractId, isPriceClose
                         FROM lpSelect_Object_JuridicalSettingsRetail (vbObjectId)) AS JuridicalSettings
                    ON JuridicalSettings.JuridicalId = LoadPriceList.JuridicalId 
                   AND JuridicalSettings.ContractId = LoadPriceList.ContractId 

            LEFT JOIN ObjectFloat AS ObjectFloat_Juridical_Percent
                                  ON ObjectFloat_Juridical_Percent.ObjectId = LoadPriceList.JuridicalId
                                 AND ObjectFloat_Juridical_Percent.DescId = zc_ObjectFloat_Juridical_Percent()

            LEFT JOIN ObjectFloat AS ObjectFloat_Contract_Percent
                                  ON ObjectFloat_Contract_Percent.ObjectId = LoadPriceList.ContractId
                                 AND ObjectFloat_Contract_Percent.DescId = zc_ObjectFloat_Contract_Percent()

            LEFT JOIN Object_MarginCategoryLink_View AS Object_MarginCategoryLink  
                                                     ON (Object_MarginCategoryLink.UnitId = vbUnitId)    
                                                    AND Object_MarginCategoryLink.JuridicalId = LoadPriceList.JuridicalId

            LEFT JOIN Object_Goods_Main_View AS Object_Goods ON Object_Goods.Id = LoadPriceListItem.GoodsId
            LEFT JOIN MarginCondition ON MarginCondition.MarginCategoryId = Object_MarginCategoryLink.MarginCategoryId
                                     AND (LoadPriceListItem.Price * (100 + Object_Goods.NDS)/100)::TFloat 
                                     BETWEEN MarginCondition.MinPrice AND MarginCondition.MaxPrice
                                     
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = LoadPriceList.JuridicalId
            LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = LoadPriceList.ContractId
            LEFT JOIN Object AS Object_Area ON Object_Area.Id = LoadPriceList.AreaId
            
            LEFT JOIN Object_Goods_View AS PartnerGoods ON PartnerGoods.ObjectId  = LoadPriceList.JuridicalId 
                                                       AND PartnerGoods.GoodsCode = LoadPriceListItem.GoodsCode
            LEFT JOIN Object_LinkGoods_View AS LinkGoods ON LinkGoods.GoodsMainId = Object_Goods.Id 
                                                        AND LinkGoods.GoodsId     = PartnerGoods.Id
            LEFT JOIN Object_LinkGoods_View AS LinkGoodsObject ON LinkGoodsObject.GoodsMainId = Object_Goods.Id 
                                                              AND LinkGoodsObject.ObjectId    = vbObjectId
            LEFT JOIN Object_Goods_View AS ObjectGoodsView ON ObjectGoodsView.Id = LinkGoodsObject.GoodsId

            LEFT JOIN GoodsPrice ON GoodsPrice.GoodsId = LinkGoodsObject.GoodsId

      WHERE 
        upper(LoadPriceListItem.GoodsName) LIKE UPPER ('%' || inGoodsSearch || '%') 
        AND
        upper(LoadPriceListItem.ProducerName) LIKE UPPER ('%' || inProducerSearch || '%')
        AND 
        upper (CAST (COALESCE (Object_Goods.GoodsCode, 0) AS TVarChar)) LIKE UPPER ('%' || inCodeSearch || '%')
        AND
        (
            inGoodsSearch <> ''
            or
            inProducerSearch <> ''
            or
            inCodeSearch <> ''
        )
        AND COALESCE(JuridicalSettings.isPriceClose, FALSE) <> TRUE
        AND (COALESCE (LoadPriceList.AreaId, 0) = inAreaId OR COALESCE(inAreaId, 0) = 0); 

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 21.10.17         *
 13.10.17         *
 13.06.16         *
 18.08.15                                                                        * inProducerSearch
 27.04.15                        *
 02.04.15                        *
 29.10.14                        *
*/

-- ����
-- SELECT * FROM gpSelect_GoodsSearch (inGoodsSearch := '����' , inProducerSearch := '���' , inCodeSearch := '1534' ,  inSession := '3');
