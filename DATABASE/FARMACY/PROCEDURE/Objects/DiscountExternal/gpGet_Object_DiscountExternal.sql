-- Function: gpGet_Object_DiscountExternal()

DROP FUNCTION IF EXISTS gpGet_Object_DiscountExternal (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_DiscountExternal(
    IN inId          Integer,       -- ���� ������� <����������>
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , URL     TVarChar
             , Service TVarChar
             , Port    TVarChar
              )
AS
$BODY$
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight(inSession, zc_Enum_Process_DiscountExternal());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY
       SELECT
             CAST (0 AS Integer)    AS Id
           , lfGet_ObjectCode(0, zc_Object_DiscountExternal()) AS Code
           , CAST ('' AS TVarChar)  AS Name
          
           , CAST ('' AS TVarChar)  AS URL
           , CAST ('' AS TVarChar)  AS Service
           , CAST ('' AS TVarChar)  AS Port
         ;
   ELSE
       RETURN QUERY
       SELECT
             Object_DiscountExternal.Id         AS Id
           , Object_DiscountExternal.ObjectCode AS Code
           , Object_DiscountExternal.ValueData  AS Name

           , ObjectString_URL.ValueData       AS URL
           , ObjectString_Service.ValueData   AS Service
           , ObjectString_Port.ValueData      AS Port

       FROM Object AS Object_DiscountExternal
            LEFT JOIN ObjectString AS ObjectString_URL
                                   ON ObjectString_URL.ObjectId = Object_DiscountExternal.Id 
                                  AND ObjectString_URL.DescId = zc_ObjectString_DiscountExternal_URL()
            LEFT JOIN ObjectString AS ObjectString_Service
                                   ON ObjectString_Service.ObjectId = Object_DiscountExternal.Id 
                                  AND ObjectString_Service.DescId = zc_ObjectString_DiscountExternal_Service()
            LEFT JOIN ObjectString AS ObjectString_Port
                                   ON ObjectString_Port.ObjectId = Object_DiscountExternal.Id 
                                  AND ObjectString_Port.DescId = zc_ObjectString_DiscountExternal_Port()
       WHERE Object_DiscountExternal.Id = inId;
   END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_DiscountExternal (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 20.07.16         * 
*/

-- ����
-- SELECT * FROM gpGet_Object_DiscountExternal (2488964, zfCalc_UserAdmin())
