-- Function: gpInsertUpdate_Object_Freight (Integer,Integer,TVarChar, TFloat,TVarChar)

-- DROP FUNCTION gpInsertUpdate_Object_Freight (Integer,Integer,TVarChar, TFloat,TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Freight(
 INOUT ioId              Integer   ,    -- ���� ������� <���� �������>
    IN inCode            Integer   ,    -- ��� ������� <���� �������>
    IN inName            TVarChar  ,    -- �������� ������� <���� �������>
    IN inSession         TVarChar       -- ������ ������������
)
 RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode_calc Integer;   

BEGIN
   
   -- �������� ���� ������������ �� ����� ���������
   -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Freight());
   vbUserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   vbCode_calc:=lfGet_ObjectCode (inCode, zc_Object_Freight()); 
   
   -- �������� ���� ������������ ��� �������� <������������>
   PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Freight(), inName);
   -- �������� ���� ������������ ��� �������� <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Freight(), vbCode_calc);
   
   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Freight(), vbCode_calc, inName);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;$BODY$ LANGUAGE plpgsql;
ALTER FUNCTION gpInsertUpdate_Object_Freight(Integer,Integer,TVarChar, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 24.09.13          * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Freight()
