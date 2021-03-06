-- Function: gpSelect_Object_Goods()
 
DROP FUNCTION IF EXISTS gpSelect_Object_Goods_Juridical(Integer, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Object_Goods_Juridical(Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_Goods_Juridical(
    IN inObjectId    INTEGER , 
    IN inIsErased    Boolean ,
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, CommonCode Integer
             , GoodsMainId Integer, GoodsMainCode Integer, GoodsMainName TVarChar
             , GoodsId Integer, GoodsCodeInt Integer, GoodsCode TVarChar, GoodsName TVarChar
             , CodeUKTZED TVarChar
             , MakerName TVarChar
             , ConditionsKeepId Integer, ConditionsKeepName TVarChar
             , AreaId Integer, AreaName TVarChar
             , MinimumLot TFloat
             , IsUpload Boolean, IsPromo Boolean, isSpecCondition Boolean, isUploadBadm Boolean, isUploadTeva Boolean
             , UpdateName TVarChar
             , UpdateDate TDateTime
             , isErased boolean

) AS
$BODY$
BEGIN

--   PERFORM lpCheckRight(inSession, zc_Enum_Process_User());


      RETURN QUERY 
      SELECT 
           ObjectLink_LinkGoods_GoodsMain.ObjectId AS Id
         , COALESCE(Object_LinkGoods_View.GoodsCode, Object_LinkGoods_View.GoodsCodeInt::TVarChar) ::Integer AS CommonCode
         , MainGoods.Id                            AS GoodsMainId
         , MainGoods.ObjectCode                    AS GoodsMainCode
         , MainGoods.ValueData                     AS GoodsMainName
         , Object_Goods.Id                         AS GoodsId 
         , Object_Goods.ObjectCode                 AS GoodsCodeInt
         , ObjectString.ValueData                  AS GoodsCode
         , Object_Goods.ValueData                  AS GoodsName
         , ObjectString_Goods_UKTZED.ValueData     AS CodeUKTZED
         , ObjectString_Goods_Maker.ValueData      AS MakerName

         , Object_ConditionsKeep.Id                AS ConditionsKeepId
         , Object_ConditionsKeep.ValueData         AS ConditionsKeepName

         , Object_Area.Id                          AS AreaId
         , Object_Area.ValueData                   AS AreaName

         , ObjectFloat_Goods_MinimumLot.ValueData  AS MinimumLot
         , COALESCE(ObjectBoolean_Goods_IsUpload.ValueData,FALSE) AS IsUpload
         , COALESCE(ObjectBoolean_Goods_IsPromo.ValueData,FALSE)  AS IsPromo
         , COALESCE(ObjectBoolean_Goods_SpecCondition.ValueData,FALSE)  AS IsSpecCondition
         , COALESCE(ObjectBoolean_Goods_UploadBadm.ValueData,FALSE)     AS IsUploadBadm
         , COALESCE(ObjectBoolean_Goods_UploadTeva.ValueData,FALSE)     AS IsUploadTeva

         , COALESCE(Object_Update.ValueData, '')                ::TVarChar  AS UpdateName
         , COALESCE(ObjectDate_Protocol_Update.ValueData, Null) ::TDateTime AS UpdateDate

         , Object_Goods.isErased                   AS isErased 
      FROM ObjectLink AS ObjectLink_Goods_Object

          INNER JOIN Object AS Object_Goods 
                            ON Object_Goods.Id = ObjectLink_Goods_Object.ObjectId 
                           AND (Object_Goods.isErased = inIsErased OR inIsErased = True)

          LEFT JOIN ObjectString ON ObjectString.ObjectId = ObjectLink_Goods_Object.ObjectId
                                AND ObjectString.DescId = zc_ObjectString_Goods_Code()
          LEFT JOIN ObjectString AS ObjectString_Goods_Maker
                                 ON ObjectString_Goods_Maker.ObjectId = ObjectLink_Goods_Object.ObjectId
                                AND ObjectString_Goods_Maker.DescId = zc_ObjectString_Goods_Maker()

          LEFT JOIN ObjectString AS ObjectString_Goods_UKTZED
                                 ON ObjectString_Goods_UKTZED.ObjectId = ObjectLink_Goods_Object.ObjectId
                                AND ObjectString_Goods_UKTZED.DescId = zc_ObjectString_Goods_UKTZED()

          LEFT JOIN ObjectFloat AS ObjectFloat_Goods_MinimumLot
                                ON ObjectFloat_Goods_MinimumLot.ObjectId = ObjectLink_Goods_Object.ObjectId
                               AND ObjectFloat_Goods_MinimumLot.DescId = zc_ObjectFloat_Goods_MinimumLot()   

          LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_IsUpload
                                  ON ObjectBoolean_Goods_IsUpload.ObjectId = ObjectLink_Goods_Object.ObjectId
                                 AND ObjectBoolean_Goods_IsUpload.DescId = zc_ObjectBoolean_Goods_IsUpload()
          LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_IsPromo
                                  ON ObjectBoolean_Goods_IsPromo.ObjectId = ObjectLink_Goods_Object.ObjectId
                                 AND ObjectBoolean_Goods_IsPromo.DescId = zc_ObjectBoolean_Goods_Promo()
          LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_SpecCondition
                                  ON ObjectBoolean_Goods_SpecCondition.ObjectId = ObjectLink_Goods_Object.ObjectId
                                 AND ObjectBoolean_Goods_SpecCondition.DescId = zc_ObjectBoolean_Goods_SpecCondition()
          LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_UploadBadm
                                  ON ObjectBoolean_Goods_UploadBadm.ObjectId = ObjectLink_Goods_Object.ObjectId
                                 AND ObjectBoolean_Goods_UploadBadm.DescId = zc_ObjectBoolean_Goods_UploadBadm()
          LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_UploadTeva
                                  ON ObjectBoolean_Goods_UploadTeva.ObjectId = ObjectLink_Goods_Object.ObjectId
                                 AND ObjectBoolean_Goods_UploadTeva.DescId = zc_ObjectBoolean_Goods_UploadTeva()

          LEFT JOIN ObjectLink AS ObjectLink_Goods_ConditionsKeep 
                               ON ObjectLink_Goods_ConditionsKeep.ObjectId = ObjectLink_Goods_Object.ObjectId
                              AND ObjectLink_Goods_ConditionsKeep.DescId = zc_ObjectLink_Goods_ConditionsKeep()
          LEFT JOIN Object AS Object_ConditionsKeep ON Object_ConditionsKeep.Id = ObjectLink_Goods_ConditionsKeep.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_Area 
                               ON ObjectLink_Goods_Area.ObjectId = ObjectLink_Goods_Object.ObjectId
                              AND ObjectLink_Goods_Area.DescId = zc_ObjectLink_Goods_Area()
          LEFT JOIN Object AS Object_Area ON Object_Area.Id = ObjectLink_Goods_Area.ChildObjectId
          
          LEFT JOIN ObjectLink AS ObjectLink_LinkGoods_Goods
                               ON ObjectLink_LinkGoods_Goods.DescId = zc_ObjectLink_LinkGoods_Goods()
                              AND ObjectLink_LinkGoods_Goods.ChildObjectId = Object_Goods.Id

          LEFT JOIN ObjectLink AS ObjectLink_LinkGoods_GoodsMain 
                               ON ObjectLink_LinkGoods_GoodsMain.ObjectId = ObjectLink_LinkGoods_Goods.ObjectId 
                              AND ObjectLink_LinkGoods_GoodsMain.DescId = zc_ObjectLink_LinkGoods_GoodsMain()
     
          LEFT JOIN Object AS MainGoods ON MainGoods.Id = ObjectLink_LinkGoods_GoodsMain.ChildObjectId

          LEFT JOIN ObjectDate AS ObjectDate_Protocol_Update
                               ON ObjectDate_Protocol_Update.ObjectId = Object_Goods.Id
                              AND ObjectDate_Protocol_Update.DescId = zc_ObjectDate_Protocol_Update()
          LEFT JOIN ObjectLink AS ObjectLink_Update
                             ON ObjectLink_Update.ObjectId = Object_Goods.Id
                            AND ObjectLink_Update.DescId = zc_ObjectLink_Protocol_Update()
          LEFT JOIN Object AS Object_Update ON Object_Update.Id = ObjectLink_Update.ChildObjectId 
                         
          LEFT JOIN Object_LinkGoods_View ON Object_LinkGoods_View.GoodsmainId = ObjectLink_LinkGoods_Goodsmain.ChildObjectId
                                         AND Object_LinkGoods_View.ObjectId = zc_Enum_GlobalConst_Marion()

      WHERE ObjectLink_Goods_Object.ChildObjectId = inObjectId
     AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object();
                         
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
--ALTER FUNCTION gpSelect_Object_Goods_Juridical(Integer, TVarChar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.  �������� �.�.
 11.12.17         * Goods_UKTZED
 21.10.17         * add Area
 30.03.17                                                      * isUploadTeva
 07.01.17         * add ConditionsKeep
 15.09.16         * 
 10.02.16         * ���� �� �����
                    + �����
 11.11.14                         *
 22.10.14                         *
 24.06.14         *
 20.06.13                         *

*/

-- ����
 --select * from gpSelect_Object_Goods_Juridical(inObjectId := 59614 , inIsErased := 'False' ,  inSession := '3');