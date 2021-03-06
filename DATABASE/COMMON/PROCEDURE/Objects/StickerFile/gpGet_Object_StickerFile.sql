-- Function: gpGet_Object_StickerFile (Integer,TVarChar)

DROP FUNCTION IF EXISTS gpGet_Object_StickerFile (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Object_StickerFile(
    IN inId          Integer,       -- ���� ������� <����������>
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, Code Integer, Name TVarChar
             , LanguageId Integer, LanguageName TVarChar
             , TradeMarkId Integer, TradeMarkName TVarChar
             , JuridicalId Integer, JuridicalName TVarChar
             , Comment TVarChar
             , Width1 TFloat, Width2 TFloat, Width3 TFloat, Width4 TFloat, Width5 TFloat
             , Width6 TFloat, Width7 TFloat, Width8 TFloat, Width9 TFloat, Width10 TFloat
             , isDefault Boolean
             ) AS
$BODY$
BEGIN

  -- �������� ���� ������������ �� ����� ���������
  -- PERFORM lpCheckRight(inSession, zc_Enum_Process_Get_Object_StickerFile());

   IF COALESCE (inId, 0) = 0
   THEN
       RETURN QUERY 
       SELECT
             CAST (0 as Integer)       AS Id
           , lfGet_ObjectCode(0, zc_Object_StickerFile()) AS Code
           , CAST ('' as TVarChar)     AS NAME
           
           , CAST (0 as Integer)       AS LanguageId
           , CAST ('' as TVarChar)     AS LanguageName
 
           , CAST (0 as Integer)       AS TradeMarkId
           , CAST ('' as TVarChar)     AS TradeMarkName

           , CAST (0 as Integer)       AS JuridicalId
           , CAST ('' as TVarChar)     AS JuridicalName
           
           , CAST ('' as TVarChar)     AS Comment

           , CAST (0 as TFloat)        AS Width1
           , CAST (0 as TFloat)        AS Width2
           , CAST (0 as TFloat)        AS Width3
           , CAST (0 as TFloat)        AS Width4
           , CAST (0 as TFloat)        AS Width5
           , CAST (0 as TFloat)        AS Width6
           , CAST (0 as TFloat)        AS Width7
           , CAST (0 as TFloat)        AS Width8
           , CAST (0 as TFloat)        AS Width9
           , CAST (0 as TFloat)        AS Width10
           
           , CAST (False AS Boolean)   AS isDefault
           ;
   ELSE
       RETURN QUERY
       SELECT 
             Object_StickerFile.Id          AS Id
           , Object_StickerFile.ObjectCode  AS Code
           , Object_StickerFile.ValueData   AS Name

           , Object_Language.Id             AS LanguageId
           , Object_Language.ValueData      AS LanguageName
 
           , Object_TradeMark.Id            AS TradeMarkId
           , Object_TradeMark.ValueData     AS TradeMarkName

           , Object_Juridical.Id            AS JuridicalId
           , Object_Juridical.ValueData     AS JuridicalName
           
           , ObjectString_Comment.ValueData AS Comment

           , ObjectFloat_Width1.ValueData      AS Width1
           , ObjectFloat_Width2.ValueData      AS Width2
           , ObjectFloat_Width3.ValueData      AS Width3
           , ObjectFloat_Width4.ValueData      AS Width4
           , ObjectFloat_Width5.ValueData      AS Width5
           , ObjectFloat_Width6.ValueData      AS Width6
           , ObjectFloat_Width7.ValueData      AS Width7
           , ObjectFloat_Width8.ValueData      AS Width8
           , ObjectFloat_Width9.ValueData      AS Width9
           , ObjectFloat_Width10.ValueData     AS Width10
           
           , ObjectBoolean_Default.ValueData AS isDefault
           
       FROM Object AS Object_StickerFile
            LEFT JOIN ObjectString AS ObjectString_Comment
                                   ON ObjectString_Comment.ObjectId = Object_StickerFile.Id
                                  AND ObjectString_Comment.DescId = zc_ObjectString_StickerFile_Comment()

            LEFT JOIN ObjectBoolean AS ObjectBoolean_Default
                                    ON ObjectBoolean_Default.ObjectId = Object_StickerFile.Id
                                   AND ObjectBoolean_Default.DescId = zc_ObjectBoolean_StickerFile_Default()
                                                              
            LEFT JOIN ObjectLink AS ObjectLink_StickerFile_Language
                                 ON ObjectLink_StickerFile_Language.ObjectId = Object_StickerFile.Id
                                AND ObjectLink_StickerFile_Language.DescId = zc_ObjectLink_StickerFile_Language()
            LEFT JOIN Object AS Object_Language ON Object_Language.Id = ObjectLink_StickerFile_Language.ChildObjectId

            LEFT JOIN ObjectLink AS ObjectLink_StickerFile_TradeMark
                                 ON ObjectLink_StickerFile_TradeMark.ObjectId = Object_StickerFile.Id
                                AND ObjectLink_StickerFile_TradeMark.DescId = zc_ObjectLink_StickerFile_TradeMark()
            LEFT JOIN Object AS Object_TradeMark ON Object_TradeMark.Id = ObjectLink_StickerFile_TradeMark.ChildObjectId

            LEFT JOIN ObjectLink AS ObjectLink_StickerFile_Juridical
                                 ON ObjectLink_StickerFile_Juridical.ObjectId = Object_StickerFile.Id
                                AND ObjectLink_StickerFile_Juridical.DescId = zc_ObjectLink_StickerFile_Juridical()
            LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = ObjectLink_StickerFile_Juridical.ChildObjectId

            LEFT JOIN ObjectFloat AS ObjectFloat_Width1
                                  ON ObjectFloat_Width1.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width1.DescId = zc_ObjectFloat_StickerFile_Width1()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width2
                                  ON ObjectFloat_Width2.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width2.DescId = zc_ObjectFloat_StickerFile_Width2()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width3
                                  ON ObjectFloat_Width3.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width3.DescId = zc_ObjectFloat_StickerFile_Width3()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width4
                                  ON ObjectFloat_Width4.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width4.DescId = zc_ObjectFloat_StickerFile_Width4()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width5
                                  ON ObjectFloat_Width5.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width5.DescId = zc_ObjectFloat_StickerFile_Width5()

            LEFT JOIN ObjectFloat AS ObjectFloat_Width6
                                  ON ObjectFloat_Width6.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width6.DescId = zc_ObjectFloat_StickerFile_Width6()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width7
                                  ON ObjectFloat_Width7.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width7.DescId = zc_ObjectFloat_StickerFile_Width7()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width8
                                  ON ObjectFloat_Width8.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width8.DescId = zc_ObjectFloat_StickerFile_Width8()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width9
                                  ON ObjectFloat_Width9.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width9.DescId = zc_ObjectFloat_StickerFile_Width9()
 
            LEFT JOIN ObjectFloat AS ObjectFloat_Width10
                                  ON ObjectFloat_Width10.ObjectId = Object_StickerFile.Id 
                                 AND ObjectFloat_Width10.DescId = zc_ObjectFloat_StickerFile_Width10()                                  
       WHERE Object_StickerFile.Id = inId;
      
   END IF;
  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 19.12.17         *
 23.10.17         *
*/

-- ����
-- SELECT * FROM gpGet_Object_StickerFile (2, '')
