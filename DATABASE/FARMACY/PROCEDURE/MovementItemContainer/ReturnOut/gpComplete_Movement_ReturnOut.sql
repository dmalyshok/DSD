-- Function: gpComplete_Movement_ReturnOut()

DROP FUNCTION IF EXISTS gpComplete_Movement_ReturnOut (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_ReturnOut(
    IN inMovementId        Integer              , -- ���� ���������
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
  DECLARE vbJuridicalId Integer;
  DECLARE vbUnit Integer;
  DECLARE vbOperDate  TDateTime;
  DECLARE vbChangeIncomePaymentId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
--     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Complete_ReturnOut());
     vbUserId:= inSession;
     -- ��������� ����� ����������� �� ������������� �������, ��� � ��.
     PERFORM lpCheckComplete_Movement_ReturnOut (inMovementId);
     
      -- ����������� �������� �����
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);

     -- ���������� ��������
     PERFORM lpComplete_Movement_ReturnOut(inMovementId, -- ���� ���������
                                           vbUserId);    -- ������������                          

     UPDATE Movement SET StatusId = zc_Enum_Status_Complete() WHERE Id = inMovementId AND StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased());

    --���� � ��������� ����������� ���� �������� ���������� - �� ������� �������� �� ��������� ����� 
    IF EXISTS(SELECT 1 FROM Movement_ReturnOut_View WHERE Id = inMovementId AND OperDatePartner is not null)
    THEN

    --������� �������� �� ��������� ����� �� ��������
        SELECT 
            lpInsertUpdate_Movement_ChangeIncomePayment(
                ioId := COALESCE(ChangeIncomePayment.Id,0), -- ���� ������� <�������� ��������� ����� �� ��������>
                inInvNumber := COALESCE(ChangeIncomePayment.InvNumber, NEXTVAL('movement_ChangeIncomePayment_seq')::TVarChar), -- ����� ���������
                inOperDate := ReturnOut.OperDatePartner, -- ���� ���������
                inTotalSumm := ReturnOut.TotalSumm, -- ����� ��������� �����
                inFromId := ReturnOut.ToId, -- �� ���� (� ���������)
                inJuridicalId := ReturnOut.JuridicalId, -- ��� ������ ������
                inChangeIncomePaymentKindId := zc_Enum_ChangeIncomePaymentKind_ReturnOut(), -- ���� ��������� ����� �����
                inComment := NULL::TVarChar, -- �����������
                inUserId := vbUserId)
        INTO
            vbChangeIncomePaymentId
        FROM
            Movement_ReturnOut_View AS ReturnOut
            LEFT OUTER JOIN MovementLinkMovement AS NLN_ChangeIncomePayment
                                                 ON NLN_ChangeIncomePayment.MovementId = ReturnOut.ID
                                                AND NLN_ChangeIncomePayment.DescId = zc_MovementLinkMovement_ChangeIncomePayment()
            LEFT OUTER JOIN Movement AS ChangeIncomePayment
                                     ON ChangeIncomePayment.Id = NLN_ChangeIncomePayment.MovementChildId
        WHERE
            ReturnOut.Id = inMovementId;
        --��������� ����� ����������, ��� ���� ������
        PERFORM lpInsertUpdate_MovementString(zc_MovementString_InvNumberPartner(),vbChangeIncomePaymentId,(SELECT InvNumberPartner FROM Movement_ReturnOut_View WHERE Id = inMovementId));
        
        --������� ������� � �������� �� ��������� ����� �� ��������
        PERFORM lpInsertUpdate_MovementLinkMovement(zc_MovementLinkMovement_ChangeIncomePayment(),inMovementId,vbChangeIncomePaymentId);
        --������� �������� �� ��������� ����� �� ��������
        PERFORM lpComplete_Movement_ChangeIncomePayment(vbChangeIncomePaymentId,vbUserId);
    END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 05.02.15                         * 

*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 579, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_ReturnOut (inMovementId:= 579, inIsLastComplete:= FALSE, inSession:= '2')
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 579, inSession:= '2')
