-- Function: lpUpdate_MI_ProductionUnion_CuterWeight()

DROP FUNCTION IF EXISTS lpUpdate_MI_ProductionUnion_CuterWeight  (Integer, TFloat, Integer);

CREATE OR REPLACE FUNCTION lpUpdate_MI_ProductionUnion_CuterWeight(
    IN inId                     Integer   , -- ���� ������� <������� ���������>
    IN inAmount                 TFloat    , -- ���������� 
    IN inUserId                 Integer     -- ������������
)                              
RETURNS Integer
AS
$BODY$
BEGIN
   -- ��������
   IF NOT EXISTS (SELECT 1 FROM MovementItem AS MI JOIN Movement ON Movement.Id = MI.MovementId AND Movement.DescId = zc_Movement_ProductionUnion() AND Movement.StatusId = zc_Enum_Status_Complete() WHERE MI.Id = inId AND MI.DescId = zc_MI_Master() AND MI.isErased = FALSE)
   THEN
       RAISE EXCEPTION '������. ������ ������������ <%> �� �������.', inId;
   END IF;

   -- ��������� �������� <������ ������>
   PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_CuterWeight(), inId, inAmount + COALESCE ((SELECT MIF.ValueData FROM MovementItemFloat AS MIF WHERE MIF.MovementItemId = inId AND MIF.DescId = zc_MIFloat_CuterWeight()), 0));

   -- ��������� ��������
   PERFORM lpInsert_MovementItemProtocol (inId, inUserId, FALSE);

   -- 
   RETURN inId;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 17.06.16                                        *
*/

-- ����
-- SELECT * FROM lpUpdate_MI_ProductionUnion_CuterWeight (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inPartionClose:= FALSE, inComment:= '', inCount:= 1, inRealWeight:= 1, inCuterCount:= 0, inReceiptId:= 0, inSession:= '2')
