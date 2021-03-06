-- Function: gpInsertUpdate_Movement_ProfitLossService()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_ProfitLossService (Integer, TVarChar, TDateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_ProfitLossService (Integer, TVarChar, TDateTime, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_ProfitLossService (Integer, TVarChar, TDateTime, TFloat, TFloat, TFloat, TVarChar, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_ProfitLossService(
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
    IN inSession                  TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_ProfitLossService());
     
     -- ��������� ��������� ������� - ��� ������������ ������ ��� ��������
     PERFORM lpComplete_Movement_Finance_CreateTemp();

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement_ProfitLossService (ioId                := ioId
                                                      , inInvNumber         := inInvNumber
                                                      , inOperDate          := inOperDate
                                                      , inAmountIn          := inAmountIn
                                                      , inAmountOut         := inAmountOut
                                                      , inBonusValue        := inBonusValue
                                                      , inComment           := inComment
                                                      , inContractId        := inContractId
                                                      , inContractMasterId  := inContractMasterId
                                                      , inContractChildId   := inContractChildId
                                                      , inInfoMoneyId       := inInfoMoneyId
                                                      , inJuridicalId       := inJuridicalId
                                                      , inPaidKindId        := inPaidKindId
                                                      , inUnitId            := inUnitId
                                                      , inContractConditionKindId := inContractConditionKindId
                                                      , inBonusKindId       := inBonusKindId
                                                      , inIsLoad            := inIsLoad
                                                      , inUserId            := vbUserId
                                                       );

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 18.02.15         * add ContractMaster, ContractChild
 12.11.14                                        * add lpComplete_Movement_Finance_CreateTemp
 12.09.14                                        * add PositionId and ServiceDateId and BusinessId_... and BranchId_...
 17.08.14                                        * add MovementDescId
 08.05.14                                        *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_ProfitLossService (ioId := 0 , inInvNumber := '-1' , inOperDate := '01.01.2013', inAmountIn:= 20 , inAmountOut := 0 , inComment := '' , inContractId :=1 ,      inInfoMoneyId := 0,     inJuridicalId:= 1,       inPaidKindId:= 1,   inUnitId:= 0,   inContractConditionKindId:=0,     inSession:= zfCalc_UserAdmin() :: Integer)
