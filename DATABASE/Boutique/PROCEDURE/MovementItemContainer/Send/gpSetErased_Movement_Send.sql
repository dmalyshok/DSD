-- Function: gpSetErased_Movement_Send (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpSetErased_Movement_Send (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSetErased_Movement_Send(
    IN inMovementId        Integer               , -- ���� ���������
    IN inSession           TVarChar                -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbUserId Integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    --vbUserId:= lpCheckRight(inSession, zc_Enum_Process_SetErased_Send());
    vbUserId:= lpGetUserBySession (inSession);

    -- ������� ������ �� ���� ��� � ��������
    PERFORM lpInsertUpdate_MovementLinkMovement (zc_MovementLinkMovement_Child(), MLM_Child.MovementId, Null)
    FROM MovementLinkMovement AS MLM_Child
    WHERE MLM_Child.descId = zc_MovementLinkMovement_Child()
      AND MLM_Child.MovementChildId = inMovementId;
    
    -- ������� ��������
    PERFORM lpSetErased_Movement (inMovementId := inMovementId
                                , inUserId     := vbUserId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.
 25.04.17         *
*/
