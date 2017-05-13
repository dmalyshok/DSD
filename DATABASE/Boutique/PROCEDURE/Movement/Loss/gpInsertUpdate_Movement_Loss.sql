-- Function: gpInsertUpdate_Movement_Loss()

DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_Loss (Integer, TVarChar, TDateTime, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpInsertUpdate_Movement_Loss (Integer, TVarChar, TDateTime, Integer, Integer, Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_Movement_Loss(
 INOUT ioId                   Integer   , -- ���� ������� <��������>
 INOUT ioInvNumber            TVarChar  , -- ����� ���������
    IN inOperDate             TDateTime , -- ���� ���������
    IN inFromId               Integer   , -- �� ���� (� ���������)
    IN inToId                 Integer   , -- ���� (� ���������)
    IN inCurrencyDocumentId   Integer   , -- ������ (���������)
   OUT outCurrencyValue       TFloat    , -- ���� ������
   OUT outParValue            TFloat    , -- ������� ��� �������� � ������ �������
    IN inComment              TVarChar  , -- ����������
    IN inSession              TVarChar    -- ������ ������������
)                              
RETURNS RECORD
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbOperDate TDateTime;
   DECLARE vbIsInsert Boolean;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_Movement_Loss());
     
     IF COALESCE (ioId, 0) = 0 THEN
         ioInvNumber:= CAST (NEXTVAL ('movement_loss_seq') AS TVarChar);  
     END IF;

     -- ������ �� �����
     SELECT Movement.OperDate
    INTO vbOperDate
     FROM Movement 
     WHERE Movement.Id = ioId;

    IF inCurrencyDocumentId <> zc_Currency_Basis() THEN
        SELECT COALESCE (tmp.Amount,1), COALESCE (tmp.ParValue,0)
       INTO outCurrencyValue, outParValue
        FROM lfSelect_Movement_Currency_byDate (inOperDate:= vbOperDate, inCurrencyFromId:= zc_Currency_Basis(), inCurrencyToId:= inCurrencyDocumentId ) AS tmp;
    END IF;

     -- ��������� <��������>
     ioId := lpInsertUpdate_Movement_Loss (ioId                := ioId
                                         , inInvNumber         := ioInvNumber
                                         , inOperDate          := inOperDate
                                         , inFromId            := inFromId
                                         , inToId              := inToId
                                         , inCurrencyDocumentId:= inCurrencyDocumentId
                                         , inCurrencyValue     := outCurrencyValue
                                         , inParValue          := outParValue
                                         , inComment           := inComment
                                         , inUserId            := vbUserId
                                           );

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 08.05.17         *
 25.04.17         *
 */

-- ����
-- select * from gpInsertUpdate_Movement_Loss(ioId := 17 , ioInvNumber := '4' , inOperDate := ('01.01.2017')::TDateTime , inFromId := 311 , inToId := 311 , inCurrencyDocumentId := 353 , inComment := 'rfff' ,  inSession := '2');