-- Function: lpInsertUpdate_MI_ProductionUnion_Master()

DROP FUNCTION IF EXISTS lpInsertUpdate_MI_ProductionUnion_Master (Integer, Integer, Integer, TFloat, TVarChar, Integer, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_MI_ProductionUnion_Master (Integer, Integer, Integer, TFloat, TFloat, TVarChar, Integer, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_MI_ProductionUnion_Master (Integer, Integer, Integer, TFloat, TFloat, TDateTime, TVarChar, Integer, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_MI_ProductionUnion_Master (Integer, Integer, Integer, TFloat, TFloat, TFloat, TDateTime, TVarChar, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MI_ProductionUnion_Master(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inGoodsId             Integer   , -- ������
    IN inAmount              TFloat    , -- ����������
    IN inCount	             TFloat    , -- ���������� �������
    IN inCuterWeight	     TFloat    , -- ����������� ���(�������)
    IN inPartionGoodsDate    TDateTime , -- ������ ������
    IN inPartionGoods        TVarChar  , -- ������ ������
    IN inGoodsKindId         Integer   , -- ���� �������
    IN inUserId              Integer     -- ������������
)
RETURNS Integer
AS
$BODY$
  DECLARE vbIsInsert Boolean;
BEGIN
   -- ��������
   IF COALESCE (inGoodsId, 0) = 0
   THEN 
       RAISE EXCEPTION '������.�� ���������� �������� ��������� <�����>.';
   END IF;

   -- ������ ��������
   IF inPartionGoodsDate <= '01.01.1900' THEN inPartionGoodsDate:= NULL; END IF;


   -- ������������ ������� ��������/�������������
   vbIsInsert:= COALESCE (ioId, 0) = 0;

   -- ��������� <������� ���������>
   ioId := lpInsertUpdate_MovementItem (ioId, zc_MI_Master(), inGoodsId, inMovementId, inAmount, NULL);

   -- ��������� ����� � <���� �������>
   PERFORM lpInsertUpdate_MovementItemLinkObject(zc_MILinkObject_GoodsKind(), ioId, inGoodsKindId);

   -- ��������� �������� <���������� �������>
   PERFORM lpInsertUpdate_MovementItemFloat(zc_MIFloat_Count(), ioId, inCount);

   -- ��������� �������� <����������� ���(�������)>
   PERFORM lpInsertUpdate_MovementItemFloat(zc_MIFloat_CuterWeight(), ioId, inCuterWeight);
   
   -- ��������� �������� <������ ������> � Child
   IF vbIsInsert = FALSE
   THEN
       PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_PartionGoods(), MovementItem.Id, inPartionGoodsDate)
       FROM MovementItemDate
            INNER JOIN MovementItem ON MovementItem.ParentId = ioId
            INNER JOIN MovementItemDate AS MovementItemDate_find ON MovementItemDate_find.MovementItemId = MovementItem.Id
                                                                AND MovementItemDate_find.DescId = zc_MIDate_PartionGoods()
                                                                AND MovementItemDate_find.ValueData = MovementItemDate.ValueData
       WHERE MovementItemDate.MovementItemId = ioId
         AND MovementItemDate.DescId = zc_MIDate_PartionGoods();
   END IF;

   -- ��������� �������� <������ ������>
   PERFORM lpInsertUpdate_MovementItemDate (zc_MIDate_PartionGoods(), ioId, inPartionGoodsDate);
   -- ��������� �������� <������ ������>
   PERFORM lpInsertUpdate_MovementItemString(zc_MIString_PartionGoods(), ioId, inPartionGoods);

   -- ����������� �������� ����� �� ���������
   PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);

   -- ��������� ��������
   PERFORM lpInsert_MovementItemProtocol (ioId, inUserId, vbIsInsert);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 29.06.16         * add inCuterWeight
 21.03.15                                        * all
 19.12.14                                                       * add zc_MILinkObject_???GoodsKindComplete
 11.12.14         * �� gp
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MI_ProductionUnion_Master (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inPartionClose:= FALSE, inComment:= '', inCount:= 1, inRealWeight:= 1, inCuterCount:= 0, inReceiptId:= 0, inSession:= '2')
