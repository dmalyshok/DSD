-- Function: gpInsertUpdate_Object_Goods()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods(Integer, TVarChar, TVarChar, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods(Integer, TVarChar, TVarChar, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods(Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods(Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, Integer, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Object_Goods(
 INOUT ioId                  Integer   ,    -- ���� ������� <�����>
    IN inCode                TVarChar  ,    -- ��� ������� <�����>
    IN inName                TVarChar  ,    -- �������� ������� <�����>
    IN inGoodsGroupId        Integer   ,    -- ������ �������
    IN inMeasureId           Integer   ,    -- ������ �� ������� ���������
    IN inNDSKindId           Integer   ,    -- ���
    IN inMinimumLot          TFloat    ,    -- ��������� ��������
    IN inReferCode           Integer   ,    -- ��� ��� �������� �����������
    IN inReferPrice          TFloat    ,    -- ����������� ���� ��������

    IN inSession             TVarChar       -- ������� ������������
)
RETURNS integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUserName TVarChar;
   DECLARE vbObjectId Integer;
   DECLARE vbCode Integer;
   DECLARE vbMainGoodsId Integer;
BEGIN

   --   PERFORM lpCheckRight(inSession, zc_Enum_Process_GoodsGroup());
   vbUserId := lpGetUserBySession (inSession);
   vbObjectId := lpGet_DefaultValue('zc_Object_Retail', vbUserId);

   IF COALESCE(vbObjectId, 0) = 0 THEN
      SELECT ValueData INTO vbUserName FROM Object WHERE Id = vbUserId;
      RAISE EXCEPTION '� ������������ "%" �� ����������� �������� ����', vbUserName;
   END IF;

   -- !!! �������� ������������ <���>
   IF COALESCE(inMeasureId, 0) = 0 THEN
      RAISE EXCEPTION '������� ��������� ������ ���� ����������';
   END IF; 

   -- !!! �������� ������������ <���>
   IF COALESCE(inNDSKindId, 0) = 0 THEN
      RAISE EXCEPTION '��� ��� ������ ���� ���������';
   END IF; 

   vbCode := COALESCE((SELECT ObjectCode FROM Object WHERE Id = ioId), inCode::integer);
   
   ioId := lpInsertUpdate_Object_Goods(ioId, inCode, inName, inGoodsGroupId, inMeasureId, inNDSKindId, vbObjectId, vbUserId, 0, '');
   
   IF inMinimumLot = 0 THEN 
      inMinimumLot := NULL;
   END IF;   	

   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_MinimumLot(), ioId, inMinimumLot);
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_ReferCode(), ioId, inReferCode);
   PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_Goods_ReferPrice(), ioId, inReferPrice);

   -- ����� ���� ���������� �������� ���� �������� ���� ����

   -- ��������� ������ � ����� ����������

   SELECT Object_Goods_Main_View.Id INTO vbMainGoodsId
     FROM Object_Goods_Main_View 
    WHERE Object_Goods_Main_View.GoodsCode = vbCode; 

   --
   vbMainGoodsId := lpInsertUpdate_Object_Goods(vbMainGoodsId, inCode, inName, inGoodsGroupId, inMeasureId, inNDSKindId, NULL, vbUserId, 0, '');

   PERFORM gpInsertUpdate_Object_LinkGoods_Load(inCode, inCode, vbObjectId, inSession);

   -- ��������� ��������
   -- PERFORM lpInsert_ObjectProtocol (ioId, UserId);

END;$BODY$

LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpInsertUpdate_Object_Goods(Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, Integer, TFloat, TVarChar) OWNER TO postgres;

  
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.11.14                        *
 13.11.14                        *
 26.06.14                        *
 24.06.14         *
 19.06.13                        * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Goods
