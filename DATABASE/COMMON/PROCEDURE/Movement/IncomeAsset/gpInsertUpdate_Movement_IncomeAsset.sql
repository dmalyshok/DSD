-- Function: gpInsertUpdate_Movement_IncomeAsset()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_IncomeAsset (Integer, TVarChar, TDateTime,TDateTime, TVarChar, Boolean, TFloat, TFloat, Integer, Integer, Integer, Integer, Integer, Integer, TVarChar, TVarChar);


CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_IncomeAsset(
 INOUT ioId                  Integer   , -- ���� ������� <��������>
    IN inInvNumber           TVarChar  , -- ����� ���������
    IN inOperDate            TDateTime , -- ���� ���������

    IN inOperDatePartner     TDateTime , -- ���� ��������� � �����������
    IN inInvNumberPartner    TVarChar  , -- ����� ��������� � �����������

    IN inPriceWithVAT        Boolean   , -- ���� � ��� (��/���)
    IN inVATPercent          TFloat    , -- % ���
    IN inChangePercent       TFloat    , -- (-)% ������ (+)% ������� 

    IN inFromId              Integer   , -- �� ���� (� ���������)
    IN inToId                Integer   , -- ���� (� ���������)
    IN inPaidKindId          Integer   , -- ���� ���� ������ 
    IN inContractId          Integer   , -- ��������
    IN inCurrencyDocumentId  Integer   , -- ������ (���������)
    IN inCurrencyPartnerId   Integer   , -- ������ (�����������)
   OUT outCurrencyValue      TFloat    , -- ���� ������
    IN inComment             TVarChar  , -- ����������
    IN inSession             TVarChar    -- ������ ������������
)                              
RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbAccessKeyId Integer;
   DECLARE vbIsInsert Boolean;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_IncomeAsset());
                                              
     -- ��������� <��������>
     SELECT tmp.ioId, tmp.outCurrencyValue
            INTO ioId, outCurrencyValue
     FROM lpInsertUpdate_Movement_IncomeAsset (ioId                := ioId
                                             , inInvNumber         := inInvNumber
                                             , inOperDate          := inOperDate
                                             , inOperDatePartner   := inOperDatePartner
                                             , inInvNumberPartner  := inInvNumberPartner
                                             , inPriceWithVAT      := inPriceWithVAT
                                             , inVATPercent        := inVATPercent
                                             , inChangePercent     := inChangePercent
                                             , inFromId            := inFromId
                                             , inToId              := inToId
                                             , inPaidKindId        := inPaidKindId
                                             , inContractId        := inContractId
                                             , inCurrencyDocumentId:= inCurrencyDocumentId
                                             , inCurrencyPartnerId := inCurrencyPartnerId
                                             , inComment           := inComment
                                             , inUserId            := vbUserId
                                              ) AS tmp;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 06.10.16         * parce
 25.07.16         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_Movement_IncomeAsset (ioId:= 0, inInvNumber:= '-1', inOperDate:= '01.01.2013', inOperDatePartner:= '01.01.2013', inInvNumberPartner:= 'xxx', inPriceWithVAT:= true, inVATPercent:= 20, inChangePercent:= 0, inFromId:= 1, inToId:= 2, inPaidKindId:= 1, inContractId:= 0, inCarId:= 0, inPersonalDriverId:= 0, inPersonalPackerId:= 0, inSession:= '2')
