-- Function: gpInsertUpdate_Object_Goods()

DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, Integer, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, Integer, TFloat, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, Integer, TFloat, Boolean, Boolean, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, Integer, TFloat, TFloat, Boolean, Boolean, TFloat, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Object_Goods (Integer, TVarChar, TVarChar, Integer, Integer, Integer, TFloat, Integer, TFloat, TFloat, Boolean, Boolean, TFloat, Integer, TVarChar, TVarChar);

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
    IN inPrice               TFloat    ,    -- ���� ����������
    IN inIsClose             Boolean   ,    -- ��� ������
    IN inTOP                 Boolean   ,    -- ��� - �������
    IN inPercentMarkup	     TFloat    ,    -- % �������
    IN inMorionCode          Integer   ,    -- ��� �������
    IN inBarCode             TVarChar  ,    -- �����-��� �������������
    IN inSession             TVarChar       -- ������� ������������
)
RETURNS Integer
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbObjectId Integer;
   DECLARE vbCode Integer;
   DECLARE vbMainGoodsId Integer;
   DECLARE vbMorionGoodsId Integer;
   DECLARE vbBarCodeGoodsId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight(inSession, zc_Enum_Process_...());
     vbUserId:= lpGetUserBySession (inSession);

     -- ������������ <�������� ����>
     vbObjectId := lpGet_DefaultValue('zc_Object_Retail', vbUserId);

     -- �������� <inName>
     IF TRIM (COALESCE (inName, '')) = '' THEN
        RAISE EXCEPTION '������.�������� <��������> ������ ���� �����������.';
     END IF;

     -- �������� <�������� ����> - !!!������ ��� Insert!!!
     IF COALESCE (vbObjectId, 0) <= 0 AND COALESCE (ioId, 0) = 0 THEN
        RAISE EXCEPTION '� ������������ "%" �� ����������� �������� ����', lfGet_Object_ValueData (vbUserId);
     END IF;

     -- �������� <������� ���������>
     IF COALESCE (inMeasureId, 0) = 0 THEN
        RAISE EXCEPTION '������� ��������� ������ ���� ����������';
     END IF;

     -- �������� <��� ���>
     IF COALESCE (inNDSKindId, 0) = 0 THEN
        RAISE EXCEPTION '��� ��� ������ ���� ���������';
     END IF; 

     -- <���>
     IF COALESCE (ioId, 0) = 0
     THEN
          -- �������� ��� ����������� �� ��� ������ ����� � ����� �����
          IF EXISTS (SELECT 1
                     FROM ObjectLink
                          INNER JOIN Object ON Object.Id = ObjectLink.ObjectId AND Object.DescId = zc_Object_Goods() AND Object.ObjectCode = inCode :: Integer
                     WHERE ObjectLink.ChildObjectId = vbObjectId
                       AND ObjectLink.DescId = zc_ObjectLink_Goods_Object()
                    )
          THEN
              -- ����� ������
              vbCode:= lfGet_ObjectCode_byRetail (vbObjectId, 0, zc_Object_Goods());
          ELSE
              -- ��� inCode ��� �����
              vbCode:= lfGet_ObjectCode_byRetail (vbObjectId, inCode :: Integer, zc_Object_Goods());
          END IF;
     ELSE
         -- !!!��� �� ��������!!!
         vbCode:= COALESCE ((SELECT ObjectCode FROM Object WHERE Id = ioId), inCode :: Integer);
     END IF;
    
   
     -- ��������� <����� �������� ����>
     /*ioId:= lpInsertUpdate_Object_Goods_Retail (ioId            := ioId
                                              , inCode          := CASE WHEN ioId <> 0 THEN inCode ELSE vbCode :: TVarChar END
                                              , inName          := inName
                                              , inGoodsGroupId  := inGoodsGroupId
                                              , inMeasureId     := inMeasureId
                                              , inNDSKindId     := inNDSKindId
                                              , inMinimumLot    := inMinimumLot
                                              , inReferCode     := inReferCode
                                              , inReferPrice    := inReferPrice
                                              , inPrice         := inPrice
                                              , inIsClose       := inIsClose
                                              , inTOP           := inTOP
                                              , inPercentMarkup	:= inPercentMarkup
                                              , inObjectId      := vbObjectId
                                              , inUserId        := vbUserId
                                               );*/


     -- !!!��������!!! - ��� �������� �������������!!! �� "�����" Retail.Id (� �� ������ vbObjectId)
     PERFORM lpInsertUpdate_Object_Goods_Retail (ioId            := COALESCE (tmpGoods.GoodsId, ioId)
                                               , inCode          := CASE WHEN ioId <> 0 THEN inCode ELSE vbCode :: TVarChar END
                                               , inName          := inName
                                               , inGoodsGroupId  := inGoodsGroupId
                                               , inMeasureId     := inMeasureId
                                               , inNDSKindId     := inNDSKindId
                                               , inMinimumLot    := inMinimumLot
                                               , inReferCode     := inReferCode
                                               , inReferPrice    := inReferPrice
                                               , inPrice         := inPrice
                                               , inIsClose       := inIsClose
                                               , inTOP           := inTOP
                                               , inPercentMarkup := inPercentMarkup
                                               , inObjectId      := Object_Retail.Id
                                               , inUserId        := vbUserId
                                                )
     FROM Object AS Object_Retail
          LEFT JOIN (SELECT DISTINCT
                            COALESCE (ObjectLink_LinkGoods_Goods_find.ChildObjectId, Object_Goods.Id) AS GoodsId
                          , ObjectLink_Goods_Object.ChildObjectId                                     AS RetailId
                     FROM Object AS Object_Goods
                          LEFT JOIN ObjectLink AS ObjectLink_LinkGoods_Goods
                                               ON ObjectLink_LinkGoods_Goods.ChildObjectId = Object_Goods.Id
                                              AND ObjectLink_LinkGoods_Goods.DescId = zc_ObjectLink_LinkGoods_Goods()
                          LEFT JOIN ObjectLink AS ObjectLink_LinkGoods_GoodsMain
                                               ON ObjectLink_LinkGoods_GoodsMain.ObjectId = ObjectLink_LinkGoods_Goods.ObjectId
                                              AND ObjectLink_LinkGoods_GoodsMain.DescId = zc_ObjectLink_LinkGoods_GoodsMain()

                          LEFT JOIN ObjectLink AS ObjectLink_LinkGoods_GoodsMain_find
                                               ON ObjectLink_LinkGoods_GoodsMain_find.ChildObjectId = ObjectLink_LinkGoods_GoodsMain.ChildObjectId
                                              AND ObjectLink_LinkGoods_GoodsMain_find.DescId = zc_ObjectLink_LinkGoods_GoodsMain()
                          LEFT JOIN ObjectLink AS ObjectLink_LinkGoods_Goods_find
                                               ON ObjectLink_LinkGoods_Goods_find.ObjectId = ObjectLink_LinkGoods_GoodsMain_find.ObjectId
                                              AND ObjectLink_LinkGoods_Goods_find.DescId = zc_ObjectLink_LinkGoods_Goods()

                          LEFT JOIN ObjectLink AS ObjectLink_Goods_Object
                                               ON ObjectLink_Goods_Object.ObjectId = COALESCE (ObjectLink_LinkGoods_Goods_find.ChildObjectId, Object_Goods.Id)
                                              AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object()
                     WHERE Object_Goods.Id = ioId
                    ) AS tmpGoods ON tmpGoods.RetailId = Object_Retail.Id AND tmpGoods.GoodsId > 0
     WHERE Object_Retail.DescId = zc_Object_Retail();

     IF COALESCE (ioId, 0) = 0
     THEN
       -- � ������ ������� ����� ������ ���� ��������� �� ������
       SELECT Object.Id
       INTO ioId
       FROM ObjectLink
            JOIN Object ON Object.Id = ObjectLink.ObjectId 
                       AND Object.DescId = zc_Object_Goods() 
                       AND Object.ObjectCode = vbCode
       WHERE ObjectLink.ChildObjectId = vbObjectId
         AND ObjectLink.DescId = zc_ObjectLink_Goods_Object();
     END IF; 

     -- ����� ���� ���������� !!!��������!!! ���� �������� ���� ���� ��� ����� ����� !!!�� �� �������� ��������������!!!

     -- !!!����� �� ���� - vbCode!!!
     vbMainGoodsId:= (SELECT Object_Goods_Main_View.Id FROM Object_Goods_Main_View  WHERE Object_Goods_Main_View.GoodsCode = vbCode);

     -- ����������/��������� ������ � ����� �����������
     vbMainGoodsId := lpInsertUpdate_Object_Goods (vbMainGoodsId, inCode, inName, inGoodsGroupId, inMeasureId, inNDSKindId, NULL, vbUserId, 0, '');

     -- ��������� �������� - ����� ������� ���� � �����
     PERFORM gpInsertUpdate_Object_LinkGoods_Load (inGoodsMainCode    := inCode
                                                 , inGoodsCode        := inCode
                                                 , inRetailId         := Object_Retail.Id
                                                 , inSession          := inSession
                                                  )
     FROM Object AS Object_Retail
     WHERE Object_Retail.DescId = zc_Object_Retail();


     IF COALESCE (inMorionCode, 0) > 0 
     THEN
          -- ������������� ����� � ����� �������

          SELECT Id INTO vbMorionGoodsId
          FROM Object_Goods_View 
          WHERE ObjectId = zc_Enum_GlobalConst_Marion() 
            AND GoodsCodeInt = inMorionCode;

          IF COALESCE (vbMorionGoodsId, 0) = 0 
          THEN
                -- ������� ����� ����, ������� ��� ���
               vbMorionGoodsId:= lpInsertUpdate_Object (0, zc_Object_Goods(), inMorionCode, inName);
               PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_Object(), vbMorionGoodsId, zc_Enum_GlobalConst_Marion());
          END IF;       
                
          IF NOT EXISTS (SELECT 1 FROM Object_LinkGoods_View 
                         WHERE ObjectId = zc_Enum_GlobalConst_Marion() 
                           AND GoodsId = vbMorionGoodsId 
                           AND GoodsMainId = vbMainGoodsId) 
          THEN
               PERFORM gpInsertUpdate_Object_LinkGoods (0, vbMainGoodsId, vbMorionGoodsId, inSession);
          END IF;     
     END IF;          

     IF COALESCE (inBarCode, '') <> '' 
     THEN
          -- ������������� ����� �� �����-�����
     
          SELECT Id INTO vbBarCodeGoodsId
          FROM Object_Goods_View 
          WHERE ObjectId = zc_Enum_GlobalConst_BarCode() 
            AND GoodsName = inBarCode;

          IF COALESCE (vbBarCodeGoodsId, 0) = 0 
          THEN
               -- ������� ����� ����, ������� ��� ���
               vbBarCodeGoodsId:= lpInsertUpdate_Object(0, zc_Object_Goods(), 0, inBarCode);
               PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_Goods_Object(), vbBarCodeGoodsId, zc_Enum_GlobalConst_BarCode());
          END IF;       

          IF NOT EXISTS (SELECT 1 FROM Object_LinkGoods_View 
                         WHERE ObjectId = zc_Enum_GlobalConst_BarCode() 
                           AND GoodsId = vbBarCodeGoodsId 
                           AND GoodsMainId = vbMainGoodsId) 
          THEN
               PERFORM gpInsertUpdate_Object_LinkGoods(0, vbMainGoodsId, vbBarCodeGoodsId, inSession);
          END IF;     
      END IF;          
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
  
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.  �������� �.�.
 19.05.17                                                       * MorionCode, BarCode
 25.03.16                                        *
 10.06.15                        *
 23.03.15                        *
 16.02.15                        *
 26.11.14                        *
 13.11.14                        *
 26.06.14                        *
 24.06.14         *
 19.06.13                        * 

*/

-- ����
-- SELECT * FROM gpInsertUpdate_Object_Goods
