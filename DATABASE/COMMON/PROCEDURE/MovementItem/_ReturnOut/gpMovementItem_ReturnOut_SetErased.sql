-- Function: gpMovementItem_ReturnOut_SetErased (Integer, Boolean, TVarChar)

DROP FUNCTION IF EXISTS gpMovementItem_ReturnOut_SetErased (Integer, Boolean, TVarChar);


CREATE OR REPLACE FUNCTION gpMovementItem_ReturnOut_SetErased(
    IN inMovementItemId      Integer              , -- ���� ������� <������� ���������>
   OUT outIsErased           Boolean              , -- ����� ��������
    IN inSession             TVarChar               -- ������� ������������
)
  RETURNS Boolean
AS
$BODY$
   DECLARE vbMovementId Integer;
   DECLARE vbStatusId Integer;
   DECLARE vbUserId Integer;
BEGIN
  vbUserId:= lpCheckRight(inSession, zc_Enum_Process_SetErased_MI_ReturnOut());

  -- ������������� ����� ��������
  outIsErased := TRUE;

  -- ����������� ������
  UPDATE MovementItem SET isErased = TRUE WHERE Id = inMovementItemId
         RETURNING MovementId INTO vbMovementId;

  -- �������� - ��������� ��������� �������� ������
  -- PERFORM lfCheck_Movement_Parent (inMovementId:= vbMovementId, inComment:= '���������');

  -- ���������� <������>
  vbStatusId := (SELECT StatusId FROM Movement WHERE Id = vbMovementId);
  -- �������� - �����������/��������� ��������� �������� ������
  IF vbStatusId <> zc_Enum_Status_UnComplete()
  THEN
      RAISE EXCEPTION '������.��������� ��������� � ������� <%> �� ��������.', lfGet_Object_ValueData (vbStatusId);
  END IF;

  -- ����������� �������� ����� �� ���������
  PERFORM lpInsertUpdate_MovementFloat_TotalSumm (vbMovementId);

  -- !!! �� ������� - ������ ���� ���������� ��������!!!
  -- outIsErased := FALSE;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpMovementItem_ReturnOut_SetErased (Integer, TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 10.02.14                                                          *
*/

-- ����
-- SELECT * FROM gpMovementItem_ReturnOut_SetErased (inMovementId:= 55, outIsErased = true, inSession:= '2')
