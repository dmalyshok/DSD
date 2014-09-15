-- Function: gpInsertUpdate_Object_GoodsGroup()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_GoodsGroup (Integer, Integer, TVarChar, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_GoodsGroup(
 INOUT ioId                  Integer   ,    -- ���� ������� <������ �������>
    IN inCode                Integer   ,    -- ��� ������� <������ �������>
    IN inName                TVarChar  ,    -- �������� ������� <������ �������>
    IN inParentId            Integer   ,    -- ������ �� ������ �������
    IN inGroupStatId         Integer   ,    -- ������ �� ������ ������� (����������)
    IN inTradeMarkId         Integer   ,    -- ������ �� �������� �����
    IN inGoodsTagId          Integer   ,    -- ������ �� ������� ������
    IN inSession             TVarChar       -- ������ ������������
)
  RETURNS integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbCode Integer; 
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   vbUserId := lpCheckRight(inSession, zc_Enum_Process_InsertUpdate_Object_GoodsGroup());

   -- ���� ��� �� ����������, ���������� ��� ��� ���������+1
   IF COALESCE (inCode, 0) = 0
   THEN 
       SELECT COALESCE (MAX (ObjectCode), 0) + 1 INTO vbCode FROM Object WHERE Object.DescId = zc_Object_GoodsGroup();
   ELSE
       vbCode := inCode;
   END IF; 
   

   -- !!! �������� ������������ <������������>
   -- !!! PERFORM lpCheckUnique_Object_ValueData (ioId, zc_Object_GoodsGroup(), inName);
   -- �������� ������������ <���>
   PERFORM lpCheckUnique_Object_ObjectCode (ioId, zc_Object_GoodsGroup(), vbCode);

   -- �������� ���� � ������
   PERFORM lpCheck_Object_CycleLink (ioId, zc_ObjectLink_GoodsGroup_Parent(), inParentId);
   

   -- ��������� <������>
   ioId := lpInsertUpdate_Object(ioId, zc_Object_GoodsGroup(), inCode, inName);
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_GoodsGroup_Parent(), ioId, inParentId);

   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_GoodsGroup_GoodsGroupStat(), ioId, inGroupStatId);

   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_GoodsGroup_TradeMark(), ioId, inTradeMarkId);
  
   -- ��������� ����� � <>
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_GoodsGroup_GoodsTag(), ioId, inGoodsTagId);

   -- �������� �������� <������ �������� ������> � ���� ������� ���� ������
   PERFORM lpInsertUpdate_ObjectString (zc_ObjectString_Goods_GroupNameFull(), ObjectLink.ObjectId, lfGet_Object_TreeNameFull (ObjectLink.ChildObjectId, zc_ObjectLink_GoodsGroup_Parent()))
   FROM ObjectLink
   WHERE DescId = zc_ObjectLink_Goods_GoodsGroup()
     AND ChildObjectId IN -- !!! ���������� �� ��� ������ ���� !!!!
                     (SELECT ioId
                     UNION ALL
                      SELECT ObjectLink.ObjectId
                      FROM ObjectLink
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child1.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child2.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child3.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child4.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child4 ON ObjectLink_Child4.ChildObjectId = ObjectLink_Child3.ObjectId
                                                               AND ObjectLink_Child4.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child5.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child4 ON ObjectLink_Child4.ChildObjectId = ObjectLink_Child3.ObjectId
                                                               AND ObjectLink_Child4.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child5 ON ObjectLink_Child5.ChildObjectId = ObjectLink_Child4.ObjectId
                                                               AND ObjectLink_Child5.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     )
  ;


   -- �������� �������� <������ ����������> � ���� ������� ���� ������
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_GoodsGroupStat(), ObjectLink.ObjectId, inGroupStatId)
   FROM ObjectLink
   WHERE DescId = zc_ObjectLink_Goods_GoodsGroup()
     AND ChildObjectId IN -- !!! ���������� �� ��� ������ ���� !!!!
                     (SELECT ioId
                     UNION ALL
                      SELECT ObjectLink.ObjectId
                      FROM ObjectLink
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child1.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child2.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child3.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child4.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child4 ON ObjectLink_Child4.ChildObjectId = ObjectLink_Child3.ObjectId
                                                               AND ObjectLink_Child4.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child5.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child4 ON ObjectLink_Child4.ChildObjectId = ObjectLink_Child3.ObjectId
                                                               AND ObjectLink_Child4.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child5 ON ObjectLink_Child5.ChildObjectId = ObjectLink_Child4.ObjectId
                                                               AND ObjectLink_Child5.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     )
  ;

   -- �������� �������� <�������� �����> � ���� ������� ���� ������
   PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_TradeMark(), ObjectLink.ObjectId, inTradeMarkId)
   FROM ObjectLink
   WHERE DescId = zc_ObjectLink_Goods_GoodsGroup()
     AND ChildObjectId IN -- !!! ���������� �� ��� ������ ���� !!!!
                     (SELECT ioId
                     UNION ALL
                      SELECT ObjectLink.ObjectId
                      FROM ObjectLink
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child1.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child2.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child3.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child4.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child4 ON ObjectLink_Child4.ChildObjectId = ObjectLink_Child3.ObjectId
                                                               AND ObjectLink_Child4.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     UNION ALL
                      SELECT ObjectLink_Child5.ObjectId
                      FROM ObjectLink
                           JOIN ObjectLink AS ObjectLink_Child1 ON ObjectLink_Child1.ChildObjectId = ObjectLink.ObjectId
                                                               AND ObjectLink_Child1.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child2 ON ObjectLink_Child2.ChildObjectId = ObjectLink_Child1.ObjectId
                                                               AND ObjectLink_Child2.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child3 ON ObjectLink_Child3.ChildObjectId = ObjectLink_Child2.ObjectId
                                                               AND ObjectLink_Child3.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child4 ON ObjectLink_Child4.ChildObjectId = ObjectLink_Child3.ObjectId
                                                               AND ObjectLink_Child4.DescId = zc_ObjectLink_GoodsGroup_Parent()
                           JOIN ObjectLink AS ObjectLink_Child5 ON ObjectLink_Child5.ChildObjectId = ObjectLink_Child4.ObjectId
                                                               AND ObjectLink_Child5.DescId = zc_ObjectLink_GoodsGroup_Parent()
                      WHERE ObjectLink.DescId = zc_ObjectLink_GoodsGroup_Parent()
                        AND ObjectLink.ChildObjectId = ioId
                     )
  ;

   -- ��������� ��������
   PERFORM lpInsert_ObjectProtocol (ioId, vbUserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_GoodsGroup (Integer, Integer, TVarChar, Integer, Integer, Integer, tvarchar) OWNER TO postgres;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 15.09.14         * add GoodsTag
 11.09.14         * add TradeMark
 04.09.14         * add �������� <������ ����������> ����������
 13.01.14                                        * zc_ObjectString_Goods_GroupNameFull
 11.05.13                                        * rem lpCheckUnique_Object_ValueData
 12.06.13         *
 16.06.13                                        * �������
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_GoodsGroup()
