-- Function: gpSelect_Object_ImportSettingsItems()

DROP FUNCTION IF EXISTS gpSelect_Object_ImportSettingsItems(TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Object_ImportSettingsItems(Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Object_ImportSettingsItems(
    IN inImportSettingsId Integer, 
    IN inSession          TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, ParamValue TVarChar, DefaultValue TVarChar,
               ImportSettingsId Integer,
               ImportTypeItemsId Integer,  
               ParamName TVarChar,
               ParamType TVarChar,
               ParamNumber Integer,
               UserParamName TVarChar,
               isErased boolean) AS
$BODY$
BEGIN

   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_ImportSettingsItems());

   RETURN QUERY 
    SELECT 
       Object_ImportSettingsItems_View.Id,
       Object_ImportSettingsItems_View.ValueData, 
       Object_ImportSettingsItems_View.DefaultValue, 
       Object_ImportSettings_View.Id AS ImportSettingsId, 
       Object_ImportTypeItems_View.Id,
       Object_ImportTypeItems_View.Name,
       Object_ImportTypeItems_View.ParamType,
       Object_ImportTypeItems_View.ParamNumber,
       Object_ImportTypeItems_View.UserParamName,
       Object_ImportSettingsItems_View.isErased

FROM Object_ImportSettings_View
   LEFT JOIN Object_ImportTypeItems_View ON Object_ImportTypeItems_View.ImportTypeId = Object_ImportSettings_View.ImportTypeId
   LEFT JOIN Object_ImportSettingsItems_View ON Object_ImportSettingsItems_View.ImportSettingsId = Object_ImportSettings_View.Id
                                            AND Object_ImportSettingsItems_View.ImportTypeItemsId = Object_ImportTypeItems_View.Id
WHERE ((0 = inImportSettingsId) OR (Object_ImportSettings_View.Id = inImportSettingsId));
  
END;
$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Object_ImportSettingsItems(Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.09.14                         *
 03.07.14         *

*/

-- ����
-- SELECT * FROM gpSelect_Object_ImportSettingsItems (0, '2')