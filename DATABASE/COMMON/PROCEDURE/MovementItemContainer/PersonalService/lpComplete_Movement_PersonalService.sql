-- Function: lpComplete_Movement_PersonalService (Integer, Boolean)

DROP FUNCTION IF EXISTS lpComplete_Movement_PersonalService (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_PersonalService(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbMovementId_check      Integer;
   DECLARE vbServiceDate           TDateTime;
   DECLARE vbPersonalServiceListId Integer;
   DECLARE vbMovementItemId_err    Integer;
BEGIN
     -- ������� - �� ����������, ��� lpComplete_Movement_PersonalService_Recalc
     CREATE TEMP TABLE _tmpMovement_Recalc (MovementId Integer, StatusId Integer, PersonalServiceListId Integer, PaidKindId Integer, ServiceDate TDateTime) ON COMMIT DROP;
     -- ������� - �� ���������, ��� lpComplete_Movement_PersonalService_Recalc
     CREATE TEMP TABLE _tmpMI_Recalc (MovementId_from Integer, MovementItemId_from Integer, PersonalServiceListId_from Integer, MovementId_to Integer, MovementItemId_to Integer, PersonalServiceListId_to Integer, ServiceDate TDateTime, UnitId Integer, PersonalId Integer, PositionId Integer, InfoMoneyId Integer, SummCardRecalc TFloat, SummCardSecondRecalc TFloat, SummNalogRecalc TFloat, SummNalogRetRecalc TFloat, SummChildRecalc TFloat, SummMinusExtRecalc TFloat, isMovementComplete Boolean) ON COMMIT DROP;


     -- �����
     vbServiceDate:= (SELECT MovementDate.ValueData FROM MovementDate WHERE MovementDate.MovementId = inMovementId AND MovementDate.DescId = zc_MIDate_ServiceDate());
     -- �����
     vbPersonalServiceListId:= (SELECT MLO.ObjectId AS PersonalServiceListId FROM MovementLinkObject AS MLO WHERE MLO.MovementId = inMovementId AND MLO.DescId = zc_MovementLinkObject_PersonalServiceList());

     -- �������� - ������ ���� �� ������
     vbMovementId_check:= (SELECT MovementDate_ServiceDate.MovementId
                           FROM MovementDate AS MovementDate_ServiceDate
                                INNER JOIN Movement ON Movement.Id       = MovementDate_ServiceDate.MovementId
                                                   AND Movement.StatusId = zc_Enum_Status_Complete()
                                INNER JOIN MovementLinkObject AS MovementLinkObject_PersonalServiceList
                                                              ON MovementLinkObject_PersonalServiceList.MovementId = MovementDate_ServiceDate.MovementId
                                                             AND MovementLinkObject_PersonalServiceList.DescId     = zc_MovementLinkObject_PersonalServiceList()
                                                             AND MovementLinkObject_PersonalServiceList.ObjectId   = vbPersonalServiceListId
                           WHERE MovementDate_ServiceDate.ValueData = vbServiceDate
                            AND MovementDate_ServiceDate.DescId     = zc_MIDate_ServiceDate()
                            AND MovementDate_ServiceDate.MovementId <> inMovementId
                           LIMIT 1
                          );
     IF vbMovementId_check <> 0
     THEN
         RAISE EXCEPTION '������.������� ������ <��������� ����������> � <%> �� <%> ��� <%> �� <%>.������������ ���������. <%>'
                       , (SELECT Movement.InvNumber FROM Movement WHERE Movement.Id = vbMovementId_check)
                       , DATE ((SELECT Movement.OperDate FROM Movement WHERE Movement.Id = vbMovementId_check))
                       , lfGet_Object_ValueData ((SELECT MovementLinkObject.ObjectId FROM MovementLinkObject WHERE MovementLinkObject.MovementId = vbMovementId_check AND MovementLinkObject.DescId = zc_MovementLinkObject_PersonalServiceList()))
                       , zfCalc_MonthYearName ((SELECT MovementDate.ValueData FROM MovementDate WHERE MovementDate.MovementId = vbMovementId_check AND MovementDate.DescId = zc_MIDate_ServiceDate()))
                       , vbMovementId_check
                        ;
     END IF;


     -- �������� - �� ������ ���� ���������
     IF EXISTS (SELECT 1
                FROM ObjectLink AS OL_PaidKind
                WHERE OL_PaidKind.ObjectId      = vbPersonalServiceListId
                  AND OL_PaidKind.DescId        = zc_ObjectLink_PersonalServiceList_PaidKind()
                  AND OL_PaidKind.ChildObjectId = zc_Enum_PaidKind_FirstForm() -- !!!��� �� ��!!!
               )
     THEN
         -- ��� ��������� �� - ������ "�������" �����
         vbMovementItemId_err:= (SELECT MovementItem.Id
                                 FROM MovementItem
                                      LEFT JOIN ObjectDate AS ObjectDate_DateOut
                                                           ON ObjectDate_DateOut.ObjectId = MovementItem.ObjectId
                                                          AND ObjectDate_DateOut.DescId   = zc_ObjectDate_Personal_Out()
                                 WHERE MovementItem.MovementId = inMovementId
                                   AND MovementItem.DescId     = zc_MI_Master()
                                   AND MovementItem.isErased   = FALSE
                                   -- �.�. ������ ��� 1-�� ����� ����. ������
                                   AND COALESCE (ObjectDate_DateOut.ValueData, zc_DateEnd()) < DATE_TRUNC ('MONTH', vbServiceDate) + INTERVAL'1 MONTH'
                                 LIMIT 1
                                );
         IF vbMovementItemId_err > 0
         THEN RAISE EXCEPTION '������.��������� <%> <%> <%> ������ <%>. ���������� ��� ������� � ��������� �� <%>.'
                       , lfGet_Object_ValueData_sh ((SELECT MI.ObjectId FROM MovementItem AS MI WHERE MI.Id = vbMovementItemId_err))
                       , lfGet_Object_ValueData_sh ((SELECT MILO.ObjectId FROM MovementItemLinkObject AS MILO WHERE MILO.MovementItemId = vbMovementItemId_err AND MILO.DescId = zc_MILinkObject_Position()))
                       , lfGet_Object_ValueData_sh ((SELECT MILO.ObjectId FROM MovementItemLinkObject AS MILO WHERE MILO.MovementItemId = vbMovementItemId_err AND MILO.DescId = zc_MILinkObject_Unit()))
                       , zfConvert_DateToString ((SELECT ObjectDate_DateOut.ValueData FROM MovementItem AS MI LEFT JOIN ObjectDate AS ObjectDate_DateOut ON ObjectDate_DateOut.ObjectId = MI.ObjectId AND ObjectDate_DateOut.DescId   = zc_ObjectDate_Personal_Out() WHERE MI.Id = vbMovementItemId_err))
                       , zfCalc_MonthYearName (vbServiceDate)
                        ;
         END IF;

     ELSE 
         -- ��� ��������� - ������ "���������" �����
         vbMovementItemId_err:= (SELECT MovementItem.Id
                                 FROM MovementItem
                                      LEFT JOIN ObjectDate AS ObjectDate_DateOut
                                                           ON ObjectDate_DateOut.ObjectId = MovementItem.ObjectId
                                                          AND ObjectDate_DateOut.DescId   = zc_ObjectDate_Personal_Out()
                                 WHERE MovementItem.MovementId = inMovementId
                                   AND MovementItem.DescId     = zc_MI_Master()
                                   AND MovementItem.isErased   = FALSE
                                   -- �.�. ������ ��� 1-�� ����� ����. ������
                                   AND COALESCE (ObjectDate_DateOut.ValueData + INTERVAL'1 MONTH', zc_DateEnd()) < DATE_TRUNC ('MONTH', vbServiceDate) + INTERVAL'1 MONTH'
                                 LIMIT 1
                                );
         IF vbMovementItemId_err > 0
         THEN RAISE EXCEPTION '������.��������� <%> <%> <%> ������ <%>. ���������� ��� ������� � ��������� �� <%>.'
                       , lfGet_Object_ValueData_sh ((SELECT MI.ObjectId FROM MovementItem AS MI WHERE MI.Id = vbMovementItemId_err))
                       , lfGet_Object_ValueData_sh ((SELECT MILO.ObjectId FROM MovementItemLinkObject AS MILO WHERE MILO.MovementItemId = vbMovementItemId_err AND MILO.DescId = zc_MILinkObject_Position()))
                       , lfGet_Object_ValueData_sh ((SELECT MILO.ObjectId FROM MovementItemLinkObject AS MILO WHERE MILO.MovementItemId = vbMovementItemId_err AND MILO.DescId = zc_MILinkObject_Unit()))
                       , zfConvert_DateToString ((SELECT ObjectDate_DateOut.ValueData FROM MovementItem AS MI LEFT JOIN ObjectDate AS ObjectDate_DateOut ON ObjectDate_DateOut.ObjectId = MI.ObjectId AND ObjectDate_DateOut.DescId   = zc_ObjectDate_Personal_Out() WHERE MI.Id = vbMovementItemId_err))
                       , zfCalc_MonthYearName (vbServiceDate)
                        ;
         END IF;

     END IF;


     -- �������� ������ !!!���� ��� <����� ������� - ��������� � ���������� ��� �������������>!!!
     IF EXISTS (SELECT 1
                FROM MovementItem
                     LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRecalc
                                                  ON MIFloat_SummNalogRecalc.MovementItemId = MovementItem.Id
                                                 AND MIFloat_SummNalogRecalc.DescId         = zc_MIFloat_SummNalogRecalc()
                     /*LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRetRecalc
                                                  ON MIFloat_SummNalogRetRecalc.MovementItemId = MovementItem.Id
                                                 AND MIFloat_SummNalogRetRecalc.DescId         = zc_MIFloat_SummNalogRetRecalc()*/
                WHERE MovementItem.MovementId = inMovementId
                  AND MovementItem.DescId     = zc_MI_Master()
                  AND MovementItem.isErased   = FALSE
                  AND (MIFloat_SummNalogRecalc.ValueData <> 0 /*OR MIFloat_SummNalogRetRecalc.ValueData <> 0*/)
               )
     THEN
          PERFORM lpInsertUpdate_MovementItem (tmp.MovementItemId, zc_MI_Master(), tmp.PersonalId, inMovementId, tmp.Amount, tmp.ParentId)
                , lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Unit(),                tmp.MovementItemId, tmp.UnitId)
                , lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_Position(),            tmp.MovementItemId, tmp.PositionId)
                , lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_PersonalServiceList(), tmp.MovementItemId, tmp.PersonalServiceListId)
          FROM (WITH tmpMI AS (SELECT MovementItem.Id                          AS MovementItemId
                                    , MovementItem.ParentId                    AS ParentId
                                    , MovementItem.ObjectId                    AS PersonalId
                                    , ObjectLink_Personal_Member.ChildObjectId AS MemberId
                                    , MovementItem.Amount                      AS Amount
                               FROM MovementItem
                                    INNER JOIN ObjectLink AS ObjectLink_Personal_Member
                                                          ON ObjectLink_Personal_Member.ObjectId = MovementItem.ObjectId
                                                         AND ObjectLink_Personal_Member.DescId   = zc_ObjectLink_Personal_Member()
                               WHERE MovementItem.MovementId = inMovementId
                                 AND MovementItem.DescId     = zc_MI_Master()
                                 AND MovementItem.isErased   = FALSE
                              )
             , tmpPersonal AS (SELECT tmp.MemberId                                          AS MemberId
                                    , ObjectLink_Personal_Member.ObjectId                   AS PersonalId
                                    , ObjectLink_Personal_PersonalServiceList.ChildObjectId AS PersonalServiceListId
                                    , ObjectLink_Personal_Position.ChildObjectId            AS PositionId
                                    , ObjectLink_Personal_Unit.ChildObjectId                AS UnitId
                                    , ROW_NUMBER() OVER (PARTITION BY tmp.MemberId
                                                         -- ����������� ������������ ��������� ��� ������, �.�. �������� � Ord = 1
                                                         ORDER BY CASE WHEN COALESCE (ObjectDate_DateOut.ValueData, zc_DateEnd()) = zc_DateEnd() THEN 0 ELSE 1 END
                                                                , CASE WHEN ObjectLink_Personal_PersonalServiceList.ChildObjectId > 0 THEN 0 ELSE 1 END
                                                                , CASE WHEN ObjectBoolean_Official.ValueData = TRUE THEN 0 ELSE 1 END
                                                                , CASE WHEN ObjectBoolean_Main.ValueData = TRUE THEN 0 ELSE 1 END
                                                                , ObjectLink_Personal_Member.ObjectId
                                                        ) AS Ord
                               FROM (SELECT DISTINCT tmpMI.MemberId FROM tmpMI) AS tmp
                                               -- �������� ���� �����������
                                               INNER JOIN ObjectLink AS ObjectLink_Personal_Member
                                                                     ON ObjectLink_Personal_Member.ChildObjectId = tmp.MemberId
                                                                    AND ObjectLink_Personal_Member.DescId        = zc_ObjectLink_Personal_Member()
                                               INNER JOIN Object AS Object_Personal ON Object_Personal.Id = ObjectLink_Personal_Member.ObjectId
                                                                                   AND Object_Personal.isErased = FALSE
                                               LEFT JOIN ObjectDate AS ObjectDate_DateOut
                                                                    ON ObjectDate_DateOut.ObjectId = Object_Personal.Id
                                                                   AND ObjectDate_DateOut.DescId   = zc_ObjectDate_Personal_Out()
                                               LEFT JOIN ObjectLink AS ObjectLink_Personal_PersonalServiceList
                                                                    ON ObjectLink_Personal_PersonalServiceList.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                                   AND ObjectLink_Personal_PersonalServiceList.DescId = zc_ObjectLink_Personal_PersonalServiceList()
                                               LEFT JOIN ObjectBoolean AS ObjectBoolean_Official
                                                                       ON ObjectBoolean_Official.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                                      AND ObjectBoolean_Official.DescId   = zc_ObjectBoolean_Member_Official()
                                               LEFT JOIN ObjectBoolean AS ObjectBoolean_Main
                                                                       ON ObjectBoolean_Main.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                                      AND ObjectBoolean_Main.DescId   = zc_ObjectBoolean_Personal_Main()
                                               LEFT JOIN ObjectLink AS ObjectLink_Personal_Position
                                                                    ON ObjectLink_Personal_Position.ObjectId = Object_Personal.Id
                                                                   AND ObjectLink_Personal_Position.DescId   = zc_ObjectLink_Personal_Position()
                                               LEFT JOIN ObjectLink AS ObjectLink_Personal_Unit
                                                                    ON ObjectLink_Personal_Unit.ObjectId = Object_Personal.Id
                                                                   AND ObjectLink_Personal_Unit.DescId   = zc_ObjectLink_Personal_Unit()
                              )
                -- ���������
                SELECT tmpMI.MovementItemId
                     , tmpMI.ParentId
                     , tmpMI.Amount
                     , tmpPersonal.PersonalId
                     , tmpPersonal.PositionId
                     , tmpPersonal.UnitId
                     , tmpPersonal.PersonalServiceListId
                FROM tmpMI
                     INNER JOIN tmpPersonal ON tmpPersonal.MemberId = tmpMI.MemberId
                                           AND tmpPersonal.Ord      = 1
                     LEFT JOIN MovementItemLinkObject AS MILO_Unit
                                                      ON MILO_Unit.MovementItemId = tmpMI.MovementItemId
                                                     AND MILO_Unit.DescId         = zc_MILinkObject_Unit()
                     LEFT JOIN MovementItemLinkObject AS MILO_Position
                                                      ON MILO_Position.MovementItemId = tmpMI.MovementItemId
                                                     AND MILO_Position.DescId         = zc_MILinkObject_Position()
                     LEFT JOIN MovementItemLinkObject AS MILO_PersonalServiceList
                                                      ON MILO_PersonalServiceList.MovementItemId = tmpMI.MovementItemId
                                                     AND MILO_PersonalServiceList.DescId         = zc_MILinkObject_PersonalServiceList()
                WHERE tmpMI.PersonalId                  <> tmpPersonal.PersonalId
                   OR tmpPersonal.PositionId            <> COALESCE (MILO_Position.ObjectId, 0)
                   OR tmpPersonal.UnitId                <> COALESCE (MILO_Unit.ObjectId, 0)
                   OR tmpPersonal.PersonalServiceListId <> COALESCE (MILO_PersonalServiceList.ObjectId, 0)
               ) AS tmp;
     END IF;


     -- ������������� !!!���� ��� ��!!! - <�� �������� �� (����) - 1�> + <�� �������� �� (����) - 2�> + <������ - ��������� (����)> + <�������� - ��������� (����)> + <��������� ������. ��.�. (����)>
     IF EXISTS (SELECT ObjectLink_PersonalServiceList_PaidKind.ChildObjectId
                FROM MovementLinkObject AS MovementLinkObject_PersonalServiceList
                     INNER JOIN ObjectLink AS ObjectLink_PersonalServiceList_PaidKind
                                           ON ObjectLink_PersonalServiceList_PaidKind.ObjectId      = MovementLinkObject_PersonalServiceList.ObjectId
                                          AND ObjectLink_PersonalServiceList_PaidKind.DescId        = zc_ObjectLink_PersonalServiceList_PaidKind()
                                          AND ObjectLink_PersonalServiceList_PaidKind.ChildObjectId = zc_Enum_PaidKind_FirstForm() -- !!!��� �� ��!!!
                WHERE MovementLinkObject_PersonalServiceList.MovementId = inMovementId
                  AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()
               )
     THEN
          PERFORM lpComplete_Movement_PersonalService_Recalc (inMovementId := inMovementId
                                                            , inUserId     := inUserId);
     END IF;


     -- !!!�����������!!! �������� ������� ��������
     DELETE FROM _tmpMIContainer_insert;
     DELETE FROM _tmpMIReport_insert;
     -- !!!�����������!!! �������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     DELETE FROM _tmpItem;

     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , AnalyzerId, ObjectIntId_Analyzer
                         , IsActive, IsMaster
                          )
        -- 1.1. ���� ���������� �� ��, ��� ������� � �����������
        SELECT Movement.DescId
             , Movement.OperDate
             , COALESCE (Object_ObjectTo.Id, COALESCE (MovementItem.ObjectId, 0)) AS ObjectId
             , COALESCE (Object_ObjectTo.DescId, COALESCE (Object.DescId, 0))     AS ObjectDescId
             , -1 * MovementItem.Amount AS OperSumm
             , MovementItem.Id AS MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyGroupId, 0) AS InfoMoneyGroupId
               -- �������������� ����������
             , COALESCE (View_InfoMoney.InfoMoneyDestinationId, 0) AS InfoMoneyDestinationId
               -- �������������� ������ ����������
             , COALESCE (View_InfoMoney.InfoMoneyId, 0) AS InfoMoneyId

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , zc_Juridical_Basis() AS JuridicalId_Basis

             , COALESCE (ObjectLink_PersonalTo_Unit.ChildObjectId, COALESCE (MILinkObject_Unit.ObjectId, 0))          AS UnitId
             , COALESCE (ObjectLink_PersonalTo_Position.ChildObjectId, COALESCE (MILinkObject_Position.ObjectId, 0))  AS PositionId
             , COALESCE (MovementLinkObject_PersonalServiceList.ObjectId, 0) AS PersonalServiceListId

               -- ������ ������: ������ �� ������������� !!!� ����� � �/����� - ������ ����������!!!
             , COALESCE (ObjectLink_Unit_Branch.ChildObjectId, zc_Branch_Basis()) AS BranchId_Balance
               -- ������ ����: �� ������������ !!!� ����� � �/����� - ������ ����������!!!
             , 0 AS BranchId_ProfitLoss

               -- ����� ���������� - ����
             , CASE WHEN View_InfoMoney.InfoMoneyGroupId = zc_Enum_InfoMoneyGroup_60000() -- ���������� �����
                         THEN lpInsertFind_Object_ServiceDate (inOperDate:= MovementDate_ServiceDate.ValueData)
                    ELSE 0
               END AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , 0                     AS AnalyzerId           -- �� ����, �.�. ��� ������� ��
             , MovementItem.ObjectId AS ObjectIntId_Analyzer -- ����, �������� "��������"

             -- , CASE WHEN -1 * MovementItem.Amount >= 0 THEN TRUE ELSE FALSE END AS IsActive
             , TRUE AS IsActive -- ������ �����
             , TRUE AS IsMaster
        FROM Movement
             INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE

             LEFT JOIN MovementDate AS MovementDate_ServiceDate
                                    ON MovementDate_ServiceDate.MovementId = Movement.Id
                                   AND MovementDate_ServiceDate.DescId = zc_MIDate_ServiceDate()

             LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                              ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                              ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                             AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                              ON MILinkObject_Position.MovementItemId = MovementItem.Id
                                             AND MILinkObject_Position.DescId = zc_MILinkObject_Position()

             LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalServiceList
                                          ON MovementLinkObject_PersonalServiceList.MovementId = Movement.Id
                                         AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()

             -- ����� ��� ����
             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = MovementItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             -- ���� � ��� ���� ����������� - �� ���� "�����������" ������� � "������ � ��" ��� � "��������� �����"
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Personal()
             LEFT JOIN ObjectLink AS ObjectLink_PersonalTo_Unit ON ObjectLink_PersonalTo_Unit.ObjectId = ObjectLink_Member_ObjectTo.ChildObjectId
                                                               AND ObjectLink_PersonalTo_Unit.DescId = zc_ObjectLink_Personal_Unit()
             LEFT JOIN ObjectLink AS ObjectLink_PersonalTo_Position ON ObjectLink_PersonalTo_Position.ObjectId = ObjectLink_Member_ObjectTo.ChildObjectId
                                                                   AND ObjectLink_PersonalTo_Position.DescId = zc_ObjectLink_Personal_Position()

             LEFT JOIN Object ON Object.Id = MovementItem.ObjectId
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch ON ObjectLink_Unit_Branch.ObjectId = COALESCE (ObjectLink_PersonalTo_Unit.ChildObjectId, COALESCE (MILinkObject_Unit.ObjectId, 0))
                                                           AND ObjectLink_Unit_Branch.DescId   = zc_ObjectLink_Unit_Branch()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = MILinkObject_InfoMoney.ObjectId

             -- LEFT JOIN MovementItemFloat AS MIF_SummNalog ON MIF_SummNalog.MovementItemId = MovementItem.Id AND MIF_SummNalog.DescId = zc_MIFloat_SummNalog()
             -- LEFT JOIN MovementItemFloat AS MIF_SummPhone ON MIF_SummPhone.MovementItemId = MovementItem.Id AND MIF_SummPhone.DescId = zc_MIFloat_SummPhone()

        WHERE Movement.Id = inMovementId
          AND Movement.DescId = zc_Movement_PersonalService()
          AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
          -- AND (MovementItem.Amount <> 0 OR MIF_SummNalog.ValueData <> 0 OR MIF_SummPhone.ValueData <> 0)
       ;


     -- ��������
     IF EXISTS (SELECT _tmpItem.ObjectId FROM _tmpItem WHERE _tmpItem.ObjectId = 0)
     THEN
         RAISE EXCEPTION '� ��������� �� ��������� <���������>. ���������� ����������.';
     END IF;

     -- ��������
     IF EXISTS (SELECT _tmpItem.JuridicalId_Basis FROM _tmpItem WHERE _tmpItem.JuridicalId_Basis = 0)
     THEN
         RAISE EXCEPTION '� �� ����������� <������� �� ����.> ���������� ����������.';
     END IF;


     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, PersonalServiceListId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , AnalyzerId, ObjectIntId_Analyzer
                         , IsActive, IsMaster
                          )
        -- 1.2.1. ���� �� �� (����� ��������������� � ����������)
        WITH tmpMI_find AS (SELECT _tmpItem.*
                                 , MIF.DescId    AS DescId_find
                                 , MIF.ValueData AS OperSumm_find
                            FROM _tmpItem
                                 INNER JOIN MovementItemFloat AS MIF ON MIF.MovementItemId = _tmpItem.MovementItemId
                                                                    AND MIF.DescId IN (zc_MIFloat_SummChild()
                                                                                     , zc_MIFloat_SummMinusExt()
                                                                                      )
                            
                            WHERE MIF.ValueData <> 0
                           )
           ,  tmpMI_re AS (SELECT tmpMI_find.*, -1 * tmpMI_find.OperSumm_find AS OperSumm_re
                                , CASE WHEN tmpMI_find.DescId_find = zc_MIFloat_SummChild()    THEN zc_Enum_InfoMoney_60102() -- �� - ��������
                                       WHEN tmpMI_find.DescId_find = zc_MIFloat_SummMinusExt() THEN zc_Enum_InfoMoney_60104() -- �� - ��������� ������. ��.�.
                                  END AS InfoMoneyId_re
                           FROM tmpMI_find
                          UNION ALL
                           SELECT tmpMI_find.*, 1 * tmpMI_find.OperSumm_find AS OperSumm_re
                                , zc_Enum_InfoMoney_60101() AS InfoMoneyId_re -- �� - ��
                           FROM tmpMI_find
                          )
        -- ���������
        SELECT tmpMI_re.MovementDescId
             , tmpMI_re.OperDate
             , tmpMI_re.ObjectId
             , tmpMI_re.ObjectDescId
             , tmpMI_re.OperSumm_re AS OperSumm
             , tmpMI_re.MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , tmpMI_re.InfoMoneyGroupId
               -- �������������� ����������
             , tmpMI_re.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , tmpMI_re.InfoMoneyId_re

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , tmpMI_re.JuridicalId_Basis

             , tmpMI_re.UnitId
             , tmpMI_re.PositionId
             , tmpMI_re.PersonalServiceListId

               -- ������ ������: ������ �� ������������� !!!� ����� � �/����� - ������ ����������!!!
             , tmpMI_re.BranchId_Balance
               -- ������ ����: �� ������������ !!!� ����� � �/����� - ������ ����������!!!
             , tmpMI_re.BranchId_ProfitLoss

               -- ����� ���������� - ����
             , tmpMI_re.ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , tmpMI_re.AnalyzerId           -- �� ����, �.�. ��� ������� ��
             , tmpMI_re.ObjectIntId_Analyzer -- ����, �������� "��������"

             , TRUE  AS IsActive -- ������ �����
             , FALSE AS IsMaster
        FROM tmpMI_re

       UNION ALL
        -- 1.2.1. ���� �� �� (����� ��������������� � ����������)
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , 0 AS ObjectId
             , 0 AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

               -- ������ ����
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossGroupId, 0) AS ProfitLossGroupId
               -- ��������� ���� - �����������
             , COALESCE (lfObject_Unit_byProfitLossDirection.ProfitLossDirectionId, 0) AS ProfitLossDirectionId

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: ObjectLink_Unit_Business
             , COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId            -- ������������, ��� ��������� WhereObjectId_Analyzer
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: ������ �� �������������
             , _tmpItem.BranchId_Balance AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , 0 AS AnalyzerId               -- �� ����, �.�. ��� ����
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ����
             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = _tmpItem.UnitId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Contract ON ObjectLink_Unit_Contract.ObjectId = _tmpItem.UnitId
                                                             AND ObjectLink_Unit_Contract.DescId = zc_ObjectLink_Unit_Contract()
             LEFT JOIN lfSelect_Object_Unit_byProfitLossDirection() AS lfObject_Unit_byProfitLossDirection ON lfObject_Unit_byProfitLossDirection.UnitId = _tmpItem.UnitId

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Founder()

        WHERE ObjectLink_Unit_Contract.ChildObjectId IS NULL
          AND Object_ObjectTo.Id IS NULL
       UNION ALL
         -- 1.2.2. ��������������� ������ �� �� ���� - �� ��
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , COALESCE (ObjectLink_Contract_Juridical.ChildObjectId, 0) AS ObjectId
             , COALESCE (Object.DescId, 0) AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.���� ������ �� ��������
             , COALESCE (ObjectLink_Contract_JuridicalBasis.ChildObjectId, 0) AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: ������ "������� ������" (����� ��� ��� ������)
             , zc_Branch_Basis() AS BranchId_Balance
               -- ������ ����: ����� �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , ObjectLink_Unit_Contract.ChildObjectId     AS ContractId
             , ObjectLink_Contract_PaidKind.ChildObjectId AS PaidKindId

             , 0 AS AnalyzerId               -- �� ����, �.�. ��� ���������������
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ���������������

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             INNER JOIN ObjectLink AS ObjectLink_Unit_Contract ON ObjectLink_Unit_Contract.ObjectId = _tmpItem.UnitId
                                                              AND ObjectLink_Unit_Contract.DescId = zc_ObjectLink_Unit_Contract()
             LEFT JOIN ObjectLink AS ObjectLink_Contract_Juridical ON ObjectLink_Contract_Juridical.ObjectId = ObjectLink_Unit_Contract.ChildObjectId
                                                                  AND ObjectLink_Contract_Juridical.DescId = zc_ObjectLink_Contract_Juridical()
             LEFT JOIN ObjectLink AS ObjectLink_Contract_PaidKind ON ObjectLink_Contract_PaidKind.ObjectId = ObjectLink_Unit_Contract.ChildObjectId
                                                                 AND ObjectLink_Contract_PaidKind.DescId = zc_ObjectLink_Contract_PaidKind()
             LEFT JOIN ObjectLink AS ObjectLink_Contract_JuridicalBasis ON ObjectLink_Contract_JuridicalBasis.ObjectId = ObjectLink_Unit_Contract.ChildObjectId
                                                                       AND ObjectLink_Contract_JuridicalBasis.DescId = zc_ObjectLink_Contract_JuridicalBasis()
             LEFT JOIN Object ON Object.Id = ObjectLink_Contract_Juridical.ChildObjectId

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Founder()

        WHERE ObjectLink_Unit_Contract.ChildObjectId > 0
          AND Object_ObjectTo.Id IS NULL

       UNION ALL
         -- 1.2.3. ��������������� ������ �� ���������� - �� ��
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , Object_ObjectTo.Id     AS ObjectId
             , Object_ObjectTo.DescId AS ObjectDescId
             , -1 * _tmpItem.OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyGroupId
               -- �������������� ���������� - �� ������������
             , 0 AS InfoMoneyDestinationId
               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����
             , zc_Juridical_Basis() AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId
             , 0 AS PaidKindId

             , 0 AS AnalyzerId               -- �� ����, �.�. ��� ���������������
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ���������������

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster

        FROM _tmpItem
             INNER JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                                AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             INNER JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                                AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             INNER JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                 AND Object_ObjectTo.DescId = zc_Object_Founder()


       UNION ALL
        -- 1.3.1. ���� �� ������� - ��������� � �� (��� ����������) - !!!�����!!!
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , 0 AS ObjectId
             , 0 AS ObjectDescId
             , -1 * COALESCE (MIF.ValueData, 0) + 1 * COALESCE (MIF_ret.ValueData, 0) AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

               -- ������ ����
             , 0 AS ProfitLossGroupId     -- ���������� �����
               -- ��������� ���� - �����������
             , 0 AS ProfitLossDirectionId -- ���������� �����

               -- �������������� ������ ����������
             , View_InfoMoney.InfoMoneyGroupId
               -- �������������� ����������
             , View_InfoMoney.InfoMoneyDestinationId
               -- �������������� ������ ���������� - ��������� ������� �� �� - ����������
             , View_InfoMoney.InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: ObjectLink_Unit_Business
             , COALESCE (ObjectLink_Unit_Business.ChildObjectId, 0) AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId            -- ������������, ��� ��������� WhereObjectId_Analyzer
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: ������ �� �������������
             , _tmpItem.BranchId_Balance AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , 0 AS AnalyzerId -- �� ����, �.�. ��� ����
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ����

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster
        FROM _tmpItem
             LEFT JOIN MovementItemFloat AS MIF     ON MIF.MovementItemId     = _tmpItem.MovementItemId AND MIF.DescId     = zc_MIFloat_SummNalog()
             LEFT JOIN MovementItemFloat AS MIF_ret ON MIF_ret.MovementItemId = _tmpItem.MovementItemId AND MIF_ret.DescId = zc_MIFloat_SummNalogRet()
             LEFT JOIN ObjectLink AS ObjectLink_Unit_Business ON ObjectLink_Unit_Business.ObjectId = _tmpItem.UnitId
                                                             AND ObjectLink_Unit_Business.DescId = zc_ObjectLink_Unit_Business()
             LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = zc_Enum_InfoMoney_50101() -- ��������� ������� �� �� - ����������
        WHERE MIF.ValueData <> 0 OR MIF_ret.ValueData <> 0

       UNION
        -- 1.3.2.1. ���� ���������� �� �� - ��������� � ��
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , _tmpItem.ObjectId
             , _tmpItem.ObjectDescId
             , 1 * COALESCE (MIF.ValueData, 0) AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId
             , _tmpItem.PositionId
             , _tmpItem.PersonalServiceListId

               -- ������ ������: ������ �� ������������� !!!� ����� � �/����� - ������ ����������!!!
             , _tmpItem.BranchId_Balance
               -- ������ ����: �� ������������ !!!� ����� � �/����� - ������ ����������!!!
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: ����
             , _tmpItem.ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , zc_Enum_AnalyzerId_PersonalService_Nalog() AS AnalyzerId -- ����, �.�. ��� ��������� � ��
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ��������� � ��

             , _tmpItem.IsActive -- ������ �����
             , FALSE AS IsMaster
        FROM _tmpItem
             LEFT JOIN MovementItemFloat AS MIF     ON MIF.MovementItemId     = _tmpItem.MovementItemId AND MIF.DescId     = zc_MIFloat_SummNalog()

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Founder()
        WHERE MIF.ValueData <> 0 
          AND Object_ObjectTo.Id IS NULL

       UNION
        -- 1.3.2.2. ���� ���������� �� �� - ���������� � ��
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , _tmpItem.ObjectId
             , _tmpItem.ObjectDescId
             , -1 * COALESCE (MIF_ret.ValueData, 0) AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyGroupId
               -- �������������� ����������
             , _tmpItem.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , _tmpItem.InfoMoneyId

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId
             , _tmpItem.PositionId
             , _tmpItem.PersonalServiceListId

               -- ������ ������: ������ �� ������������� !!!� ����� � �/����� - ������ ����������!!!
             , _tmpItem.BranchId_Balance
               -- ������ ����: �� ������������ !!!� ����� � �/����� - ������ ����������!!!
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: ����
             , _tmpItem.ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , zc_Enum_AnalyzerId_PersonalService_NalogRet() AS AnalyzerId -- ����, �.�. ��� ���������� � ��
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ���������� � ��

             , _tmpItem.IsActive -- ������ �����
             , FALSE AS IsMaster
        FROM _tmpItem
             LEFT JOIN MovementItemFloat AS MIF_ret ON MIF_ret.MovementItemId = _tmpItem.MovementItemId AND MIF_ret.DescId = zc_MIFloat_SummNalogRet()

             LEFT JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             LEFT JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                               AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             LEFT JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                AND Object_ObjectTo.DescId = zc_Object_Founder()
        WHERE MIF_ret.ValueData <> 0
          AND Object_ObjectTo.Id IS NULL

       UNION ALL
         -- 1.3.3.1. ��������������� �� ������� �� ����������
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , Object_ObjectTo.Id     AS ObjectId
             , Object_ObjectTo.DescId AS ObjectDescId
             , 1 * COALESCE (MIF.ValueData, 0) AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyGroupId
               -- �������������� ���������� - �� ������������
             , 0 AS InfoMoneyDestinationId
               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����
             , zc_Juridical_Basis() AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId
             , 0 AS PaidKindId

             , zc_Enum_AnalyzerId_PersonalService_Nalog() AS AnalyzerId -- ����, �.�. ��� ��������������� - ������
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ��������� � ��

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster

        FROM _tmpItem
             LEFT JOIN MovementItemFloat AS MIF     ON MIF.MovementItemId     = _tmpItem.MovementItemId AND MIF.DescId     = zc_MIFloat_SummNalog()

             INNER JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                                AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             INNER JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                                AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             INNER JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                 AND Object_ObjectTo.DescId = zc_Object_Founder()
        WHERE MIF.ValueData <> 0
       UNION ALL
         -- 1.3.3.2. ��������������� �� ���������� ������� �� ����������
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , Object_ObjectTo.Id     AS ObjectId
             , Object_ObjectTo.DescId AS ObjectDescId
             , -1 * COALESCE (MIF_ret.ValueData, 0) AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                               -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId   -- ���������� �����

             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyGroupId
               -- �������������� ���������� - �� ������������
             , 0 AS InfoMoneyDestinationId
               -- �������������� ������ ���������� - �� ������������
             , 0 AS InfoMoneyId

               -- ������ ������: �� ������������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����
             , zc_Juridical_Basis() AS JuridicalId_Basis

             , 0 AS UnitId                -- �� ������������
             , 0 AS PositionId            -- �� ������������
             , 0 AS PersonalServiceListId -- �� ������������

               -- ������ ������: �� ������������
             , 0 AS BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: �� ������������
             , 0 AS ServiceDateId

             , 0 AS ContractId
             , 0 AS PaidKindId

             , zc_Enum_AnalyzerId_PersonalService_NalogRet() AS AnalyzerId -- ����, �.�. ��� ��������������� - ������
             , _tmpItem.ObjectIntId_Analyzer -- ����, �.�. ��� ��������� � ��

             , NOT _tmpItem.IsActive
             , NOT _tmpItem.IsMaster

        FROM _tmpItem
             LEFT JOIN MovementItemFloat AS MIF_ret ON MIF_ret.MovementItemId = _tmpItem.MovementItemId AND MIF_ret.DescId = zc_MIFloat_SummNalogRet()

             INNER JOIN ObjectLink AS ObjectLink_Personal_Member ON ObjectLink_Personal_Member.ObjectId = _tmpItem.ObjectId
                                                                AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()
             INNER JOIN ObjectLink AS ObjectLink_Member_ObjectTo ON ObjectLink_Member_ObjectTo.ObjectId = ObjectLink_Personal_Member.ChildObjectId
                                                                AND ObjectLink_Member_ObjectTo.DescId = zc_ObjectLink_Member_ObjectTo()
             INNER JOIN Object AS Object_ObjectTo ON Object_ObjectTo.Id     = ObjectLink_Member_ObjectTo.ChildObjectId
                                                 AND Object_ObjectTo.DescId = zc_Object_Founder()
        WHERE MIF_ret.ValueData <> 0
       ;

/*
     -- ��������� ������� - �������� ���������, �� ����� ���������� ��� ������������ �������� � ���������
     -- 2.1. ���� ���������� �� ���.����
     INSERT INTO _tmpItem (MovementDescId, OperDate, ObjectId, ObjectDescId, OperSumm
                         , MovementItemId, ContainerId
                         , AccountGroupId, AccountDirectionId, AccountId
                         , ProfitLossGroupId, ProfitLossDirectionId
                         , InfoMoneyGroupId, InfoMoneyDestinationId, InfoMoneyId
                         , BusinessId_Balance, BusinessId_ProfitLoss, JuridicalId_Basis
                         , UnitId, PositionId, BranchId_Balance, BranchId_ProfitLoss, ServiceDateId, ContractId, PaidKindId
                         , IsActive, IsMaster
                          )
        SELECT _tmpItem.MovementDescId
             , _tmpItem.OperDate
             , _tmpItem.ObjectId
             , _tmpItem.ObjectDescId
             , -1 * (COALESCE (MIFloat_SummSocialIn.ValueData, 0) + COALESCE (MIFloat_SummSocialAdd.ValueData, 0)) AS OperSumm
             , _tmpItem.MovementItemId

             , 0 AS ContainerId                                                     -- ���������� �����
             , 0 AS AccountGroupId, 0 AS AccountDirectionId, 0 AS AccountId         -- ���������� �����
             , 0 AS ProfitLossGroupId, 0 AS ProfitLossDirectionId                   -- �� ������������

               -- �������������� ������ ����������
             , View_InfoMoney.InfoMoneyGroupId
               -- �������������� ����������
             , View_InfoMoney.InfoMoneyDestinationId
               -- �������������� ������ ����������
             , View_InfoMoney.InfoMoneyId

               -- ������ ������: �� ����� ����� ����� ���������
             , 0 AS BusinessId_Balance
               -- ������ ����: �� ������������
             , 0 AS BusinessId_ProfitLoss

               -- ������� ��.����: �� ����� ����� ����� ���������
             , _tmpItem.JuridicalId_Basis

             , _tmpItem.UnitId
             , _tmpItem.PositionId

               -- ������ ������: ������ �� �������������
             , _tmpItem.BranchId_Balance
               -- ������ ����: �� ������������
             , 0 AS BranchId_ProfitLoss

               -- ����� ����������: ����
             , _tmpItem.ServiceDateId

             , 0 AS ContractId -- �� ������������
             , 0 AS PaidKindId -- �� ������������

             , FALSE AS IsActive
             , TRUE AS IsMaster
        FROM _tmpItem
              LEFT JOIN MovementItemFloat AS MIFloat_SummSocialIn
                                          ON MIFloat_SummSocialIn.MovementItemId = _tmpItem.MovementItemId
                                         AND MIFloat_SummSocialIn.DescId = zc_MIFloat_SummSocialIn()
              LEFT JOIN MovementItemFloat AS MIFloat_SummSocialAdd
                                          ON MIFloat_SummSocialAdd.MovementItemId = _tmpItem.MovementItemId
                                         AND MIFloat_SummSocialAdd.DescId = zc_MIFloat_SummSocialAdd()
              LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = zc_Enum_InfoMoney_60103() -- ���������� ����� + ��������
       ;
*/

     -- 5.1. ����� - ���������/��������� ��������
     PERFORM lpComplete_Movement_Finance (inMovementId := inMovementId
                                        , inUserId     := inUserId);

     -- 5.2. ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_PersonalService()
                                , inUserId     := inUserId
                                 );
     -- 6.1. ����� - ����������� ����� � ������� (���� ���� "������" �������) - �� ���� "�����" <������ - ��������� � ��> � <�������� - ���������> � <��������� ���������� ��.�.> 
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummToPay(), tmpMovement.MovementItemId, -1 * OperSumm
                                                                                                 + tmpMovement.SummSocialAdd
                                                                                                 - tmpMovement.SummTransport
                                                                                                 + tmpMovement.SummTransportAdd
                                                                                                 + tmpMovement.SummTransportAddLong
                                                                                                 + tmpMovement.SummTransportTaxi
                                                                                                 - tmpMovement.SummPhone

                                                                                                 - tmpMovement.SummNalog
                                                                                                 + tmpMovement.SummNalogRet
                                                                                                 - tmpMovement.SummChild
                                                                                                 - tmpMovement.SummMinusExt
                                              )
             -- ����� ��� (��������� �� ��������, ���� ����� ���� � ��������...)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransport()       , tmpMovement.MovementItemId, tmpMovement.SummTransport)
             -- ����� ��������������� (�������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransportAdd()    , tmpMovement.MovementItemId, tmpMovement.SummTransportAdd)
             -- ����� ������������ (�������, ���� ���������������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransportAddLong(), tmpMovement.MovementItemId, tmpMovement.SummTransportAddLong)
             -- ����� �� ����� (�������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummTransportTaxi()   , tmpMovement.MovementItemId, tmpMovement.SummTransportTaxi)
             -- ����� ���.����� (���������)
           , lpInsertUpdate_MovementItemFloat (zc_MIFloat_SummPhone()           , tmpMovement.MovementItemId, tmpMovement.SummPhone)
     FROM (WITH tmpMI AS (SELECT MovementItem.Id AS MovementItemId
                               , _tmpItem.ContainerId
                               , _tmpItem.ObjectId
                               , _tmpItem.ObjectIntId_Analyzer
                               , COALESCE (_tmpItem.OperSumm, 0) AS OperSumm
                               , COALESCE (MIFloat_SummSocialAdd.ValueData, 0) AS SummSocialAdd
                               , COALESCE (MIFloat_SummNalog.ValueData, 0)     AS SummNalog
                               , COALESCE (MIFloat_SummNalogRet.ValueData, 0)  AS SummNalogRet
                               , COALESCE (MIFloat_SummChild.ValueData, 0)     AS SummChild
                               , COALESCE (MIFloat_SummMinusExt.ValueData, 0)  AS SummMinusExt
                         FROM MovementItem
                              LEFT JOIN MovementItemFloat AS MIFloat_SummSocialAdd
                                                          ON MIFloat_SummSocialAdd.MovementItemId = MovementItem.Id
                                                         AND MIFloat_SummSocialAdd.DescId = zc_MIFloat_SummSocialAdd()
                              LEFT JOIN MovementItemFloat AS MIFloat_SummNalog
                                                          ON MIFloat_SummNalog.MovementItemId = MovementItem.Id
                                                         AND MIFloat_SummNalog.DescId = zc_MIFloat_SummNalog()
                              LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRet
                                                          ON MIFloat_SummNalogRet.MovementItemId = MovementItem.Id
                                                         AND MIFloat_SummNalogRet.DescId         = zc_MIFloat_SummNalogRet()
                              LEFT JOIN MovementItemFloat AS MIFloat_SummChild
                                                          ON MIFloat_SummChild.MovementItemId = MovementItem.Id
                                                         AND MIFloat_SummChild.DescId = zc_MIFloat_SummChild()
                              LEFT JOIN MovementItemFloat AS MIFloat_SummMinusExt
                                                          ON MIFloat_SummMinusExt.MovementItemId = MovementItem.Id
                                                         AND MIFloat_SummMinusExt.DescId = zc_MIFloat_SummMinusExt()
                              LEFT JOIN _tmpItem ON _tmpItem.MovementItemId = MovementItem.Id
                                                AND _tmpItem.IsMaster       = TRUE
                         WHERE MovementItem.MovementId = inMovementId
                           AND MovementItem.DescId     = zc_MI_Master()
                        )
   , tmpMIContainer AS (SELECT MIContainer.ContainerId
                             , SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Income()                      THEN  1 * MIContainer.Amount ELSE 0 END)  AS SummTransport
                             , SUM (CASE WHEN MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_Transport_Add()        THEN -1 * MIContainer.Amount ELSE 0 END)  AS SummTransportAdd
                             , SUM (CASE WHEN MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_Transport_AddLong()    THEN -1 * MIContainer.Amount ELSE 0 END)  AS SummTransportAddLong
                             , SUM (CASE WHEN MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_Transport_Taxi()       THEN -1 * MIContainer.Amount ELSE 0 END)  AS SummTransportTaxi
                             , SUM (CASE WHEN MIContainer.AnalyzerId     = zc_Enum_AnalyzerId_MobileBills_Personal() THEN  1 * MIContainer.Amount ELSE 0 END)  AS SummPhone
                        FROM MovementItemContainer AS MIContainer
                        WHERE MIContainer.ContainerId IN (SELECT ContainerId FROM _tmpItem)
                          AND MIContainer.OperDate >= DATE_TRUNC ('MONTH', (SELECT DISTINCT OperDate FROM _tmpItem ) - INTERVAL '3 MONTH')
                        GROUP BY MIContainer.ContainerId
                       )
           -- ���������
           SELECT tmpMI.MovementItemId
                , tmpMI.OperSumm
                , tmpMI.SummSocialAdd
                , tmpMI.SummNalog
                , tmpMI.SummNalogRet
                , tmpMI.SummChild
                , tmpMI.SummMinusExt
                , COALESCE (SUM (CASE WHEN tmpMI.ObjectId = tmpMI.ObjectIntId_Analyzer THEN tmpMIContainer.SummTransport        ELSE 0 END), 0) AS SummTransport
                , COALESCE (SUM (CASE WHEN tmpMI.ObjectId = tmpMI.ObjectIntId_Analyzer THEN tmpMIContainer.SummTransportAdd     ELSE 0 END), 0) AS SummTransportAdd
                , COALESCE (SUM (CASE WHEN tmpMI.ObjectId = tmpMI.ObjectIntId_Analyzer THEN tmpMIContainer.SummTransportAddLong ELSE 0 END), 0) AS SummTransportAddLong
                , COALESCE (SUM (CASE WHEN tmpMI.ObjectId = tmpMI.ObjectIntId_Analyzer THEN tmpMIContainer.SummTransportTaxi    ELSE 0 END), 0) AS SummTransportTaxi
                , COALESCE (SUM (CASE WHEN tmpMI.ObjectId = tmpMI.ObjectIntId_Analyzer THEN tmpMIContainer.SummPhone            ELSE 0 END), 0) AS SummPhone
           FROM tmpMI
                LEFT JOIN tmpMIContainer ON tmpMIContainer.ContainerId = tmpMI.ContainerId
           GROUP BY tmpMI.MovementItemId
                  , tmpMI.OperSumm
                  , tmpMI.SummSocialAdd
                  , tmpMI.SummNalog
                  , tmpMI.SummNalogRet
                  , tmpMI.SummChild
                  , tmpMI.SummMinusExt
          ) AS tmpMovement
           ;


     -- 6.2. ����� - ����������� �������� �����
     PERFORM lpInsertUpdate_MovementFloat_TotalSumm (inMovementId);


END;$BODY$
  LANGUAGE plpgsql VOLATILE;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 09.09.14                                        *
*/

-- ����
-- SELECT * FROM lpUnComplete_Movement (inMovementId:= 3581, inUserId:= zfCalc_UserAdmin() :: Integer)
-- SELECT * FROM gpComplete_Movement_PersonalService (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpSelect_MovementItemContainer_Movement (inMovementId:= 3581, inSession:= zfCalc_UserAdmin())
