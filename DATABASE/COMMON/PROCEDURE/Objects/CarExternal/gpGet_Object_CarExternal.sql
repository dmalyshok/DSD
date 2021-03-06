-- Function: gpGet_Object_CarExternal (Integer,TVarChar)

DROP FUNCTION IF EXISTS gpGet_Object_CarExternal (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_CarExternal(
    IN inId          Integer,       -- ���� ������� <����������>
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar 
             , RegistrationCertificate TVarChar, Comment TVarChar
             , CarModelId Integer, CarModelCode Integer, CarModelName TVarChar
             , JuridicalId Integer, JuridicalCode Integer, JuridicalName TVarChar
             , isErased boolean
             ) AS
$BODY$
BEGIN

  -- �������� ���� ������������ �� ����� ���������
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Get_Object_CarExternal());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)    AS Id
           , lfGet_ObjectCode (0, zc_Object_CarExternal())  AS Code
           , CAST ('' as TVarChar)  AS NAME
           
           , CAST ('' as TVarChar)  AS RegistrationCertificate
           , CAST ('' as TVarChar)  AS Comment

           , CAST (0 as Integer)    AS CarModelId
           , CAST (0 as Integer)    AS CarModelCode
           , CAST ('' as TVarChar)  AS CarModelName
          
           , CAST (0 as Integer)    AS JuridicalId
           , CAST (0 as Integer)    AS JuridicalCode
           , CAST ('' as TVarChar)  AS JuridicalName

           , CAST (NULL AS Boolean) AS isErased
;
   ELSE
       RETURN QUERY 
       SELECT 
             Object_CarExternal.Id          AS Id
           , Object_CarExternal.ObjectCode  AS Code
           , Object_CarExternal.ValueData   AS Name
           
           , RegistrationCertificate.ValueData  AS RegistrationCertificate
           , ObjectString_Comment.ValueData     AS Comment
           
           , Object_CarModel.Id         AS CarModelId
           , Object_CarModel.ObjectCode AS CarModelCode
           , Object_CarModel.ValueData  AS CarModelName
         
           , Object_Juridical.Id          AS JuridicalId
           , Object_Juridical.ObjectCode  AS JuridicalCode
           , Object_Juridical.ValueData   AS JuridicalName           
           
           , Object_CarExternal.isErased AS isErased
           
       FROM Object AS Object_CarExternal
       
            LEFT JOIN ObjectString AS RegistrationCertificate 
                                   ON RegistrationCertificate.ObjectId = Object_CarExternal.Id 
                                  AND RegistrationCertificate.DescId = zc_ObjectString_CarExternal_RegistrationCertificate()
            LEFT JOIN ObjectString AS ObjectString_Comment
                                   ON ObjectString_Comment.ObjectId = Object_CarExternal.Id
                                  AND ObjectString_Comment.DescId = zc_ObjectString_CarExternal_Comment()
                                                             
            LEFT JOIN ObjectLink AS CarExternal_CarModel 
                                 ON CarExternal_CarModel.ObjectId = Object_CarExternal.Id
                                AND CarExternal_CarModel.DescId = zc_ObjectLink_CarExternal_CarModel()
            LEFT JOIN Object AS Object_CarModel ON Object_CarModel.Id = CarExternal_CarModel.ChildObjectId
            
            LEFT JOIN ObjectLink AS ObjectLink_CarExternal_Juridical 
                                 ON ObjectLink_CarExternal_Juridical.ObjectId = Object_CarExternal.Id
                                AND ObjectLink_CarExternal_Juridical.DescId = zc_ObjectLink_CarExternal_Juridical()
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_CarExternal_Juridical.ChildObjectId            

       WHERE Object_CarExternal.Id = inId;
      
   END IF;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Object_CarExternal (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 17.03.16         *
*/

-- ����
-- SELECT * FROM gpGet_Object_CarExternal (2, '')
