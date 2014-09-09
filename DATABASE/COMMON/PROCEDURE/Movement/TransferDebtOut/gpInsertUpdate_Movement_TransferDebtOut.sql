-- Function: gpInsertUpdate_Movement_TransferDebtOut()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_TransferDebtOut (integer, TVarChar, TVarChar, TDateTime, Boolean, Boolean, TFloat, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_TransferDebtOut(
 INOUT ioId                  Integer   , -- ���� ������� <�������� ������� ����� (������)>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inInvNumberPartner    TVarChar  , -- ����� ��������� � �����������
    IN inOperDate            TDateTime , -- ���� ���������
    IN inChecked             Boolean   , -- ��������
    IN inPriceWithVAT        Boolean   , -- ���� � ��� (��/���)
    IN inVATPercent          TFloat    , -- % ���
    IN inChangePercent       TFloat    , -- (-)% ������ (+)% �������
    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
    IN inContractFromId      Integer   , -- ������� (�� ����)
    IN inContractToId        Integer   , -- ������� (����)
    IN inPaidKindFromId      Integer   , -- ���� ���� ������ (�� ����)
    IN inPaidKindToId        Integer   , -- ���� ���� ������ (����)
    IN inPartnerId           Integer   , -- ����������
    IN inDocumentTaxKindId_inf Integer  , -- ��� ������������ ���������� ���������
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS Integer AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbMovementId_Tax Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_TransferDebtOut());

     -- ������������ ��������� ��� ���������
     IF ioId <> 0
     THEN
         vbMovementId_Tax:= (SELECT MovementChildId FROM MovementLinkMovement WHERE MovementId = ioId AND DescId = zc_MovementLinkMovement_Master());
     END IF;

     -- ��������� <��������>
     ioId:= lpInsertUpdate_Movement_TransferDebtOut (ioId               := ioId
                                                   , inInvNumber        := inInvNumber
                                                   , inInvNumberPartner := inInvNumberPartner
                                                   , inOperDate         := inOperDate
                                                   , inChecked          := inChecked
                                                   , inPriceWithVAT     := inPriceWithVAT
                                                   , inVATPercent       := inVATPercent
                                                   , inChangePercent    := inChangePercent
                                                   , inFromId           := inFromId
                                                   , inToId             := inToId
                                                   , inPaidKindFromId   := inPaidKindFromId
                                                   , inPaidKindToId     := inPaidKindToId
                                                   , inContractFromId   := inContractFromId
                                                   , inContractToId     := inContractToId
                                                   , inPartnerId        := inPartnerId
                                                   , inUserId           := vbUserId
                                                    );

    -- � ���� ������ ���� ������������/������� ���������
    IF vbMovementId_Tax <> 0
    THEN
        IF inDocumentTaxKindId_inf <> 0
        THEN
             -- �������� <��� �����. ���.> �� ������ ����������
             IF NOT EXISTS (SELECT ObjectId FROM MovementLinkObject WHERE MovementId = vbMovementId_Tax AND DescId = zc_MovementLinkObject_DocumentTaxKind() AND ObjectId = inDocumentTaxKindId_inf)
             THEN
                 RAISE EXCEPTION '������.������ �������� <��� ���������� ���������>.';
             END IF;

             -- �������������� ���������
             IF EXISTS (SELECT Id FROM Movement WHERE Id = vbMovementId_Tax AND StatusId = zc_Enum_Status_Erased())
             THEN
                 PERFORM lpUnComplete_Movement (inMovementId := vbMovementId_Tax
                                              , inUserId     := vbUserId);
             END IF;
        ELSE
             -- �������� ���������
             PERFORM lpSetErased_Movement (inMovementId := vbMovementId_Tax
                                         , inUserId     := vbUserId);
        END IF;

    END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 03.09.14         * add inChecked
 20.06.14                                                       * add InvNumberPartner
 17.04.14                                        * add ������������/������� ���������
 07.05.14                                        * add inPartnerId
 03.05.14                                        * del inMasterId, ioPriceListId, outPriceListName
 24.04.14         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_TransferDebtOut (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inInvNumberPartner:= 'xxx', inPriceWithVAT:= true, inVATPercent:= 20, inChangePercent:= 0, inFromId:= 1, inToId:= 2, inCarId:= 0, inPaidKindId:= 1, inContractId:= 0, inPersonalDriverId:= 0, inRouteId:= 0, inRouteSortingId:= 0, inSession:= '2')
