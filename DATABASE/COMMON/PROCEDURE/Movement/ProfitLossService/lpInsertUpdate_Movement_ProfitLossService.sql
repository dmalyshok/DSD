-- Function: lpInsertUpdate_Movement_ProfitLossService()

DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_ProfitLossService (Integer, TVarChar, TDateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_ProfitLossService (Integer, TVarChar, TDateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_Movement_ProfitLossService (Integer, TVarChar, TDateTime, TFloat, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Movement_ProfitLossService(
 INOUT ioId                       Integer   , -- ���� ������� <��������>
    IN inInvNumber                TVarChar  , -- ����� ���������
    IN inOperDate                 TDateTime , -- ���� ���������
    IN inAmountIn                 TFloat    , -- ����� ��������
    IN inAmountOut                TFloat    , -- ����� ��������
    IN inBonusValue               TFloat    , -- % ������
    IN inComment                  TVarChar  , -- �����������
    IN inContractId               Integer   , -- �������
    IN inContractMasterId         Integer   , -- �������(�������)
    IN inContractChildId          Integer   , -- �������(����)
    IN inInfoMoneyId              Integer   , -- ������ ����������
    IN inJuridicalId              Integer   , -- ��. ����
    IN inPaidKindId               Integer   , -- ���� ���� ������
    IN inUnitId                   Integer   , -- �������������
    IN inContractConditionKindId  Integer   , -- ���� ������� ���������
    IN inBonusKindId              Integer   , -- ���� �������
    IN inIsLoad                   Boolean   , -- ����������� ������������� (�� ������)
    IN inUserId                   Integer     -- ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbAccessKeyId Integer;
   DECLARE vbMovementItemId Integer;
   DECLARE vbAmount TFloat;
   DECLARE vbBranchId Integer;
   DECLARE vbIsInsert Boolean;
BEGIN
     -- ���������� ���� �������
     vbAccessKeyId:= lpGetAccessKey (inUserId, zc_Enum_Process_InsertUpdate_Movement_ProfitLossService());

     -- ��������
     IF (COALESCE(inAmountIn, 0) = 0) AND (COALESCE(inAmountOut, 0) = 0) THEN
        RAISE EXCEPTION '������� �����.';
     END IF;

     -- ��������
     IF (COALESCE(inAmountIn, 0) <> 0) AND (COALESCE(inAmountOut, 0) <> 0) THEN
        RAISE EXCEPTION '������ ���� ������� ������ ���� �����: <�����> ��� <������>.';
     END IF;


     -- ����������� ��������
     IF ioId <> 0 THEN
        PERFORM lpUnComplete_Movement (inMovementId := ioId
                                     , inUserId     := inUserId);
     END IF;

     -- ������
     IF inAmountIn <> 0 THEN
        vbAmount := inAmountIn;
     ELSE
        vbAmount := -1 * inAmountOut;
     END IF;

     -- ���������� ������� ��������/�������������
     vbIsInsert:= COALESCE (ioId, 0) = 0;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement (ioId, zc_Movement_ProfitLossService(), inInvNumber, inOperDate, NULL, vbAccessKeyId);

     -- ���������� <������� ���������>
     SELECT MovementItem.Id INTO vbMovementItemId FROM MovementItem WHERE MovementItem.MovementId = ioId AND MovementItem.DescId = zc_MI_Master();

     -- ��������� <������� ���������>
     vbMovementItemId := lpInsertUpdate_MovementItem (vbMovementItemId, zc_MI_Master(), inJuridicalId, ioId, vbAmount, NULL);

     -- % ������ 
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_BonusValue(), vbMovementItemId, inBonusValue);
     -- �����������
     PERFORM lpInsertUpdate_MovementItemString (zc_MIString_Comment(), vbMovementItemId, inComment);

     -- ��������� ����� � <���� ���� ������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_PaidKind(), vbMovementItemId, inPaidKindId);
     -- ��������� ����� � <�������������� ������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_InfoMoney(), vbMovementItemId, inInfoMoneyId);
     -- ��������� ����� � <��������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Contract(), vbMovementItemId, inContractId);
     -- ��������� ����� � <�������� ������� >
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_ContractMaster(), vbMovementItemId, inContractMasterId);
     -- ��������� ����� � <�������� ����>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_ContractChild(), vbMovementItemId, inContractChildId);

     -- ��������� ����� � <��������������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(), vbMovementItemId, inUnitId);
     -- ��������� ����� � <���� ������� ���������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_ContractConditionKind(), vbMovementItemId, inContractConditionKindId);
     -- ��������� ����� � <���� �������>
     PERFORM lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_BonusKind(), vbMovementItemId, inBonusKindId);
     
     IF vbIsInsert = TRUE
     THEN
         -- ��������� �������� <����������� ������������� ��/���>
         PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_isLoad(), ioId, inIsLoad);
     END IF;

     -- ��������� ��������
     PERFORM lpInsert_MovementProtocol (ioId, inUserId, vbIsInsert);
     -- ��������� ��������
     PERFORM lpInsert_MovementItemProtocol (vbMovementItemId, inUserId, vbIsInsert);

     -- !!!�������� ��� �� �����, �� ��������!!!
     -- !!!�������������� �������!!!
     -- IF vbIsInsert = TRUE OR NOT EXISTS (SELECT MovementId FROM MovementItem WHERE MovementId = ioId AND DescId = zc_MI_Child() AND isErased = FALSE)
     /*IF EXISTS (SELECT UserId FROM ObjectLink_UserRole_View WHERE UserId = inUserId AND RoleId = zc_Enum_Role_Admin())
        OR EXISTS (SELECT MovementId FROM MovementItem WHERE MovementId = ioId AND DescId = zc_MI_Child() AND isErased = FALSE)
     THEN
         PERFORM lpInsertUpdate_MI_ProfitLossService_AmountPartner (inMovementId:= ioId
                                                                  , inAmount    := -1 * vbAmount
                                                                  , inUserId    := inUserId
                                                                   );
     END IF;*/

     -- 5.3. �������� ��������
     PERFORM lpComplete_Movement_Service (inMovementId := ioId
                                        , inUserId     := inUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 18.02.15         * add ContractMaster, ContractChild
 10.05.14                                        * add lpInsert_MovementItemProtocol
 08.05.14                                        * set lp
 05.04.14                                        * add !!!��� �����������!!! : _tmp1___ and _tmp2___
 25.03.14                                        * ������� - !!!��� �����������!!!
 06.03.14                                        * add lpComplete_Movement_Service
 19.02.14         * add BonusKind
 18.02.14                                                         *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_Movement_ProfitLossService (ioId := 0 , inInvNumber := '-1' , inOperDate := '01.01.2013', inAmountIn:= 20 , inAmountOut := 0 , inComment := '' , inContractId :=1 ,      inInfoMoneyId := 0,     inJuridicalId:= 1,       inPaidKindId:= 1,   inUnitId:= 0,   inContractConditionKindId:=0,     inUserId:= zfCalc_UserAdmin())
