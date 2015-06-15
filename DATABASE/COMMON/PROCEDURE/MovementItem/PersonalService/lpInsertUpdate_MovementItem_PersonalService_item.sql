-- Function: lpInsertUpdate_MovementItem_PersonalService_item()

DROP FUNCTION IF EXISTS lpInsertUpdate_MovementItem_PersonalService_item (Integer, Integer, Integer, Boolean, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_MovementItem_PersonalService_item(
 INOUT ioId                  Integer   , -- ���� ������� <������� ���������>
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inPersonalId          Integer   , -- ����������
    IN inisMain              Boolean   , -- �������� ����� ������
    IN inSummService         TFloat    , -- ����� ���������
    IN inSummCardRecalc      TFloat    , -- ����� �� �������� (��) ��� �������������
    IN inSummMinus           TFloat    , -- ����� ���������
    IN inSummAdd             TFloat    , -- ����� ������
    
    IN inSummSocialIn        TFloat    , -- ����� ��� ������� (�� ��������)
    IN inSummSocialAdd       TFloat    , -- ����� ��� ������� (���. ��������)
    IN inSummChild           TFloat    , -- ����� �������� (���������)
    
    IN inComment             TVarChar  , -- 
    IN inInfoMoneyId         Integer   , -- ������ ����������
    IN inUnitId              Integer   , -- �������������
    IN inPositionId          Integer   , -- ���������
    IN inMemberId            Integer   , -- ��� ���� (���� ��������� ��������)
    IN inPersonalServiceListId   Integer   , -- ��������� ����������
    IN inUserId              Integer     -- ������������
)
RETURNS Integer AS
$BODY$
BEGIN
     -- ���������
     SELECT tmp.ioId
            INTO ioId
     FROM lpInsertUpdate_MovementItem_PersonalService (ioId                 := ioId
                                                     , inMovementId         := inMovementId
                                                     , inPersonalId         := inPersonalId
                                                     , inIsMain             := inIsMain
                                                     , inSummService        := inSummService
                                                     , inSummCardRecalc     := inSummCardRecalc
                                                     , inSummMinus          := inSummMinus
                                                     , inSummAdd            := inSummAdd
                                                     , inSummSocialIn       := inSummSocialIn
                                                     , inSummSocialAdd      := inSummSocialAdd
                                                     , inSummChild          := inSummChild
                                                     , inComment            := inComment
                                                     , inInfoMoneyId        := inInfoMoneyId
                                                     , inUnitId             := inUnitId
                                                     , inPositionId         := inPositionId
                                                     , inMemberId           := inMemberId
                                                     , inPersonalServiceListId  := inPersonalServiceListId
                                                     , inUserId             := inUserId
                                                      ) AS tmp;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 22.05.15                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_MovementItem_PersonalService_item (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')