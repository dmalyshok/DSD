-- Function: gpGet_Object_Member (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpGet_Object_Member (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_Member(
    IN inId          Integer,        -- ���������� ���� 
    IN inSession     TVarChar        -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , INN TVarChar, DriverCertificate TVarChar, Comment TVarChar
             , EMail TVarChar, Phone TVarChar, Address TVarChar
             , EMailSign Tblob, Photo Tblob
             , EducationId Integer, EducationCode Integer, EducationName TVarChar
             , isOfficial Boolean) AS
$BODY$
BEGIN

     -- �������� ���� ������������ �� ����� ���������
     -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Get_Object_Member());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)    AS Id
           , lfGet_ObjectCode(0, zc_Object_Member()) AS Code
           , CAST ('' as TVarChar)  AS NAME
           
           , CAST ('' as TVarChar)  AS INN
           , CAST ('' as TVarChar)  AS DriverCertificate
           , CAST ('' as TVarChar)  AS Comment

           , CAST ('' as TVarChar)  AS EMail
           , CAST ('' as TVarChar)  AS Phone
           , CAST ('' as TVarChar)  AS Address

           , CAST ('' as TBlob)     AS EMailSign
           , CAST ('' as TBlob)     AS Photo

           , CAST (0 as Integer)    AS EducationId
           , CAST (0 as Integer)    AS EducationCode
           , CAST ('' as TVarChar)  AS EducationName   
  
           , FALSE AS isOfficial;
   ELSE
       RETURN QUERY 
     SELECT 
           Object_Member.Id         AS Id
         , Object_Member.ObjectCode AS Code
         , Object_Member.ValueData  AS Name
         
         , ObjectString_INN.ValueData               AS INN
         , ObjectString_DriverCertificate.ValueData AS DriverCertificate
         , ObjectString_Comment.ValueData           AS Comment


         , ObjectString_EMail.ValueData             AS EMail
         , ObjectString_Phone.ValueData             AS Phone
         , ObjectString_Address.ValueData           AS Address

         , ObjectBlob_EMailSign.ValueData           AS EMailSign
         , ObjectBlob_Photo.ValueData               AS Photo
 
         , Object_Education.Id                      AS EducationId
         , Object_Education.ObjectCode              AS EducationCode
         , Object_Education.ValueData               AS EducationName

         , ObjectBoolean_Official.ValueData         AS isOfficial

     FROM Object AS Object_Member
          LEFT JOIN ObjectBoolean AS ObjectBoolean_Official
                                  ON ObjectBoolean_Official.ObjectId = Object_Member.Id
                                 AND ObjectBoolean_Official.DescId = zc_ObjectBoolean_Member_Official()
          LEFT JOIN ObjectString AS ObjectString_INN ON ObjectString_INN.ObjectId = Object_Member.Id 
                AND ObjectString_INN.DescId = zc_ObjectString_Member_INN()
 
          LEFT JOIN ObjectString AS ObjectString_DriverCertificate ON ObjectString_DriverCertificate.ObjectId = Object_Member.Id 
                AND ObjectString_DriverCertificate.DescId = zc_ObjectString_Member_DriverCertificate()

          LEFT JOIN ObjectString AS ObjectString_Comment ON ObjectString_Comment.ObjectId = Object_Member.Id 
                AND ObjectString_Comment.DescId = zc_ObjectString_Member_Comment()

          LEFT JOIN ObjectString AS ObjectString_EMail
                                 ON ObjectString_EMail.ObjectId = Object_Member.Id 
                                AND ObjectString_EMail.DescId = zc_ObjectString_Member_EMail()
          LEFT JOIN ObjectString AS ObjectString_Phone
                                 ON ObjectString_Phone.ObjectId = Object_Member.Id 
                                AND ObjectString_Phone.DescId = zc_ObjectString_Member_Phone()
          LEFT JOIN ObjectString AS ObjectString_Address
                                 ON ObjectString_Address.ObjectId = Object_Member.Id 
                                AND ObjectString_Address.DescId = zc_ObjectString_Member_Address()

         LEFT JOIN ObjectBlob AS ObjectBlob_EMailSign
                              ON ObjectBlob_EMailSign.ObjectId = Object_Member.Id
                             AND ObjectBlob_EMailSign.DescId = zc_ObjectBlob_Member_EMailSign()
         
         LEFT JOIN ObjectBlob AS ObjectBlob_Photo
                              ON ObjectBlob_Photo.ObjectId = Object_Member.Id
                             AND ObjectBlob_Photo.DescId = zc_ObjectBlob_Member_Photo()

         LEFT JOIN ObjectLink AS ObjectLink_Member_Education
                              ON ObjectLink_Member_Education.ObjectId = Object_Member.Id
                             AND ObjectLink_Member_Education.DescId = zc_ObjectLink_Member_Education()
         LEFT JOIN Object AS Object_Education ON Object_Education.Id = ObjectLink_Member_Education.ChildObjectId
    
     WHERE Object_Member.Id = inId;
     
   END IF;
   
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 25.01.11         * 
*/

-- ����
-- SELECT * FROM gpGet_Object_Member (1, '2')