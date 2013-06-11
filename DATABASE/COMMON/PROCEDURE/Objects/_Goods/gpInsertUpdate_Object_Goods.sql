-- Function: gpInsertUpdate_Object_Goods()

-- DROP FUNCTION gpInsertUpdate_Object_Goods();

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Goods(
 INOUT ioId	                 Integer   ,   	-- ���� ������� <�����>
    IN inCode                Integer   ,    -- ��� ������� <�����>
    IN inName                TVarChar  ,    -- �������� ������� <�����>
    IN inGoodsGroupId        Integer   ,    -- ������ �� ������ �������
    IN inMeasureId           Integer   ,    -- ������ �� ������� ���������
    IN inWeight              TFloat    ,    -- ���
    IN inInfoMoneyId         Integer   ,    -- �������������� ���������
    IN inSession             TVarChar       -- ������� ������������
)
RETURNS integer AS
$BODY$
   DECLARE UserId Integer;
   DECLARE Code_max Integer;   
 
BEGIN

   --   PERFORM lpCheckRight(inSession, zc_Enum_Process_GoodsGroup());

   -- !!! �������� ������������ �����
   -- !!! PERFORM lpCheckUnique_Object_ValueData(ioId, zc_Object_Goods(), inName);
   UserId := inSession;

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT MAX (ObjectCode) + 1 INTO Code_max FROM Object WHERE Object.DescId = zc_Object_Goods();
   ELSE
       Code_max := inCode;
   END IF; 

   -- �������� ���� ������������ ��� �������� <������������ ������>
   PERFORM lpCheckUnique_Object_ValueData (ioId, zc_Object_Goods(), inName);
   -- �������� ���� ������������ ��� �������� <��� ������>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_Goods(), Code_max);

   -- ��������� ������
   ioId := lpInsertUpdate_Object(ioId, zc_Object_Goods(), Code_max, inName);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_GoodsGroup(), ioId, inGoodsGroupId);
   -- ��������� ������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_Measure(), ioId, inMeasureId);
   -- ��������� �������������� ���������
   PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Goods_InfoMoney(), ioId, inInfoMoneyId);
   -- ��������� ���
   PERFORM lpInsertUpdate_ObjectFloat(zc_ObjectFloat_Goods_Weight(), ioId, inWeight);

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$
  LANGUAGE plpgsql VOLATILE                                                                         
  COST 100;
ALTER FUNCTION gpInsertUpdate_Object_Goods(Integer, Integer, TVarChar, Integer, Integer, TFloat, Integer, tvarchar)
  OWNER TO postgres;

  
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 11.06.13          *
 11.05.13                                        * rem lpCheckUnique_Object_ValueData

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Goods
