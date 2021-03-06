-- Function: lpInsertUpdate_Object_MemberExternal (Integer, Integer, TVarChar, TVarChar)

DROP FUNCTION IF EXISTS lpInsertUpdate_Object_MemberExternal (Integer, Integer, TVarChar, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Object_MemberExternal(
 INOUT ioId	             Integer   ,    -- ���� ������� <���������� ����(���������)> 
    IN inCode                Integer   ,    -- ��� ������� 
    IN inName                TVarChar  ,    -- �������� �������
    IN inUserId              Integer        -- ������������
)
RETURNS Integer
AS
$BODY$
   DECLARE vbCode_calc Integer;
BEGIN
   -- �������� ����� ���
   IF ioId <> 0 AND COALESCE (inCode, 0) = 0 THEN inCode := (SELECT ObjectCode FROM Object WHERE Id = ioId); END IF;

   -- ���� ��� �� ����������, ���������� ��� ��� ��������� + 1
   vbCode_calc:= lfGet_ObjectCode (inCode, zc_Object_MemberExternal());
   
   -- �������� ������������ <������������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_MemberExternal(), TRIM (inName));
   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_MemberExternal(), vbCode_calc);

   -- ��������� <������>
   ioId := lpInsertUpdate_Object (ioId, zc_Object_MemberExternal(), vbCode_calc, TRIM (inName), inAccessKeyId:= NULL);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, inUserId);
   
END;$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 30.03.15                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_Object_MemberExternal()
