-- Function: gpUpdateMI_OrderInternal_Amount()

DROP FUNCTION IF EXISTS gpUpdateMI_OrderInternal_Amount (Integer, Integer, TFloat, TFloat, TFloat, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdateMI_OrderInternal_Amount(
    IN inId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inAmount              TFloat    , -- ����������
    IN inAmountSecond        TFloat    , -- ���������� �������
    IN inAmountNext          TFloat    , -- ����������
    IN inAmountNextSecond    TFloat    , -- ���������� �������
   OUT outAmountAllTotal     TFloat    , -- 
   OUT outAmountTotal        TFloat    , -- 
   OUT outAmountNextTotal    TFloat    , -- 
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_OrderInternal());

     -- ��������
     IF COALESCE (inId, 0) = 0
     THEN
         RAISE EXCEPTION '������.������� �� ������.';
     END IF;

     -- ��������� <������� ���������>
     PERFORM lpInsertUpdate_MovementItem (MovementItem.Id, MovementItem.DescId, MovementItem.ObjectId, MovementItem.MovementId, inAmount, NULL)
     FROM MovementItem
     WHERE MovementItem.Id = inId;

     -- ��������� �������� <���������� �������>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountSecond(), inId, inAmountSecond);


     -- ��������� �������� <���������� ����� �� ����>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountNext(), inId, inAmountNext);
     -- ��������� �������� <���������� �������>
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_AmountNextSecond(), inId, inAmountNextSecond);
     
     -- ����������� �������� ����� �� ���������
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);

     -- ��������� �������� !!!����� ���������!!!
     PERFORM lpInsert_MovementItemProtocol (inId, vbUserId, FALSE);

     -- ��������� �������� �����
     outAmountTotal    := inAmount + inAmountSecond;
     outAmountNextTotal:= inAmountNext + inAmountNextSecond;
     outAmountAllTotal := outAmountTotal + outAmountNextTotal;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 16.11.17         *
*/

-- ����
-- SELECT * FROM gpUpdateMI_OrderInternal_Amount (inId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')
