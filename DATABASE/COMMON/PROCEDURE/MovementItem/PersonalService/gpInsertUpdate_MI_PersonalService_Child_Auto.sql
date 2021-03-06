-- Function: gpInsertUpdate_MI_PersonalService_Child_Auto()

DROP FUNCTION IF EXISTS gpInsertUpdate_MI_PersonalService_Child_Auto (Integer, Integer, Integer, TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsertUpdate_MI_PersonalService_Child_Auto(
    IN inUnitId              Integer   , -- �������������
    IN inPersonalServiceListId Integer   , -- ��������� ����������
    IN inMemberId            Integer   , -- ���.����
    IN inStartDate           TDateTime , -- ����
    IN inEndDate             TDateTime , -- ����
    IN inPositionId          Integer   , -- ���������
    IN inPositionLevelId     Integer   , -- ������ ���������
    IN inStaffListId         Integer   , -- ������� ����������
    IN inModelServiceId      Integer   , -- ������ ����������
    IN inStaffListSummKindId Integer   , -- ���� ���� ��� �������� ����������
    IN inAmount              TFloat    , --
    IN inMemberCount         TFloat    , --
    IN inDayCount            TFloat    , --
    IN inWorkTimeHoursOne    TFloat    , --
    IN inWorkTimeHours       TFloat    , --
    IN inPrice               TFloat    , --
    -- IN inHoursPlan           TFloat    , --
    -- IN inHoursDay            TFloat    , --
    -- IN inPersonalCount       TFloat    , --
    IN inGrossOne            TFloat    , --
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbJuridicalId Integer;
   DECLARE vbPersonalId Integer;
   DECLARE vbMovementId Integer;
   DECLARE vbId_Master Integer;
   DECLARE vbId_Child Integer;
   DECLARE vbIsInsert Boolean;
   DECLARE vbIsMain Boolean;
   DECLARE vbIsAuto Boolean;

   DECLARE vbInfoMoneyId_def Integer;
   DECLARE ioId Integer;

   DECLARE vbHoursPlan TFloat;
   DECLARE vbHoursDay TFloat;
   DECLARE vbPersonalCount TFloat;
   DECLARE vbsummservice TFloat;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_PersonalService_Child());
     vbUserId:= lpGetUserBySession (inSession);


     -- ������� - ���� �� ������� ����� 0 � ������
     IF COALESCE (inAmount, 0) = 0
     THEN
         -- !!!�����!!!
         RETURN;
     END IF;


     -- ��������
     IF COALESCE (inPersonalServiceListId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ����������� �������� <��������� ����������>.';
     END IF;
     -- ��������
     IF COALESCE (inStaffListId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ����������� �������� <������� ����������>.';
     END IF;
     -- ��������
     IF COALESCE (inModelServiceId, 0) = 0 AND COALESCE (inStaffListSummKindId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ����������� �������� <������ ����������> ��� <���� ���� ��� �������� ����������>.';
     END IF;


     -- �����
     vbInfoMoneyId_def:= (SELECT Object_InfoMoney_View.InfoMoneyId FROM Object_InfoMoney_View WHERE Object_InfoMoney_View.InfoMoneyId = zc_Enum_InfoMoney_60101()); -- 60101 ���������� ����� + ���������� �����


     IF EXISTS (SELECT 1 FROM Object WHERE Object.DescId = zc_Object_Personal() AND Object.Id = inMemberId)
     THEN
         SELECT Object_Personal.Id                                      AS PersonalId
              , COALESCE (ObjectBoolean_Personal_Main.ValueData, FALSE) AS isMain
                INTO vbPersonalId, vbIsMain
         FROM Object AS Object_Personal
              LEFT JOIN ObjectBoolean AS ObjectBoolean_Personal_Main
                                      ON ObjectBoolean_Personal_Main.ObjectId = Object_Personal.Id
                                     AND ObjectBoolean_Personal_Main.DescId = zc_ObjectBoolean_Personal_Main()
         WHERE Object_Personal.DescId = zc_Object_Personal()
           AND Object_Personal.Id     =  inMemberId;
     ELSE
         -- ����� ���������� (���� - ���.���� + ��������� + �������������)
         WITH -- ������ ���� ����������
              tmp AS (SELECT ObjectLink_Personal_Member.ChildObjectId   AS MemberId
                           , Object_Personal.Id                         AS PersonalId
                           , ObjectLink_Personal_Unit.ChildObjectId     AS UnitId
                           , ObjectLink_Personal_Position.ChildObjectId AS PositionId
                      FROM ObjectLink AS ObjectLink_Personal_Member
                           LEFT JOIN Object AS Object_Personal ON Object_Personal.Id       = ObjectLink_Personal_Member.ObjectId
                                                              AND Object_Personal.isErased = FALSE
                           LEFT JOIN ObjectLink AS ObjectLink_Personal_Unit
                                                ON ObjectLink_Personal_Unit.ObjectId = Object_Personal.Id
                                               AND ObjectLink_Personal_Unit.DescId   = zc_ObjectLink_Personal_Unit()
                           LEFT JOIN ObjectLink AS ObjectLink_Personal_Position
                                                ON ObjectLink_Personal_Position.ObjectId = Object_Personal.Id
                                               AND ObjectLink_Personal_Position.DescId   = zc_ObjectLink_Personal_Position()
    
                      WHERE ObjectLink_Personal_Member.ChildObjectId   = inMemberId
                        AND ObjectLink_Personal_Member.DescId          = zc_ObjectLink_Personal_Member()
                     )
         -- �������� ������ ������
         SELECT COALESCE (tmp1.PersonalId, COALESCE (tmp2.PersonalId, tmp3.PersonalId)) AS PersonalId
              , COALESCE (ObjectBoolean_Personal_Main.ValueData, FALSE)                 AS isMain
                INTO vbPersonalId, vbIsMain
         FROM Object AS Object_Member
              -- ������ ��������� - �� ���� ����������
              LEFT JOIN tmp AS tmp1 ON tmp1.MemberId   = Object_Member.Id
                                   AND tmp1.UnitId     = inUnitId
                                   AND tmp1.PositionId = inPositionId
              -- ������ ��������� - �������������
              LEFT JOIN tmp AS tmp2 ON tmp2.MemberId   = Object_Member.Id
                                   AND tmp2.UnitId     = inUnitId
              -- ������ ��������� - ���������
              LEFT JOIN tmp AS tmp3 ON tmp3.MemberId   = Object_Member.Id
                                   AND tmp3.PositionId = inPositionId
              LEFT JOIN ObjectBoolean AS ObjectBoolean_Personal_Main
                                      ON ObjectBoolean_Personal_Main.ObjectId = COALESCE (tmp1.PersonalId, COALESCE (tmp2.PersonalId, tmp3.PersonalId))
                                     AND ObjectBoolean_Personal_Main.DescId = zc_ObjectBoolean_Personal_Main()
         WHERE Object_Member.DescId = zc_Object_Member()
           AND Object_Member.Id     =  inMemberId
         ORDER BY CASE WHEN ObjectBoolean_Personal_Main.ValueData = TRUE THEN 0 ELSE 1 END, COALESCE (tmp1.PersonalId, COALESCE (tmp2.PersonalId, tmp3.PersonalId))
         LIMIT 1
         ;
     END IF;


     -- ��������
     IF COALESCE (vbPersonalId, 0) = 0
     THEN
         RAISE EXCEPTION '������.�� ��������� <��� (���������)> � <%> + <%> + <%> ��� ����� = <%>.'
                       , lfGet_Object_ValueData (inMemberId)
                       , lfGet_Object_ValueData (inPositionId)
                       , lfGet_Object_ValueData (inUnitId)
                       , zfConvert_FloatToString (inAmount);
     END IF;


    -- ����� ��������� (���� - ����� ���������� + ���������) - ������ ����
    SELECT MovementDate_ServiceDate.MovementId
         , MLO_Juridical.ObjectId AS JuridicalId -- �� ������� ���������� ����������(��� �������)
           INTO vbMovementId, vbJuridicalId
    FROM MovementDate AS MovementDate_ServiceDate
        INNER JOIN Movement ON Movement.Id       = MovementDate_ServiceDate.MovementId
                           AND Movement.DescId   = zc_Movement_PersonalService()
                           AND Movement.StatusId <> zc_Enum_Status_Erased()
        INNER JOIN MovementLinkObject AS MLO_PersonalServiceList
                                      ON MLO_PersonalServiceList.MovementId = Movement.Id
                                     AND MLO_PersonalServiceList.DescId     = zc_MovementLinkObject_PersonalServiceList()
                                     AND MLO_PersonalServiceList.ObjectId   = inPersonalServiceListId
        LEFT JOIN MovementLinkObject AS MLO_Juridical
                                     ON MLO_Juridical.MovementId = Movement.Id
                                    AND MLO_Juridical.DescId     = zc_MovementLinkObject_Juridical()

        LEFT JOIN MovementBoolean AS MovementBoolean_isAuto
                                  ON MovementBoolean_isAuto.MovementId = Movement.Id
                                 AND MovementBoolean_isAuto.DescId = zc_MovementBoolean_isAuto()
    WHERE MovementDate_ServiceDate.ValueData = DATE_TRUNC ('MONTH', inEndDate)
      AND MovementDate_ServiceDate.DescId    = zc_MovementDate_ServiceDate()
    ORDER BY CASE WHEN MovementBoolean_isAuto.ValueData = TRUE THEN 0 ELSE 1 END, MovementDate_ServiceDate.MovementId
    LIMIT 1
   ;


      IF COALESCE (vbMovementId, 0) = 0
      THEN
          -- ��������� ����� <��������>
          vbMovementId := lpInsertUpdate_Movement_PersonalService (ioId                      := 0
                                                                 , inInvNumber               := CAST (NEXTVAL ('Movement_PersonalService_seq') AS TVarChar) --inInvNumber
                                                                 , inOperDate                := inEndDate
                                                                 , inServiceDate             := DATE_TRUNC ('MONTH', inEndDate) :: TDateTime
                                                                 , inComment                 := '' :: TVarChar
                                                                 , inPersonalServiceListId   := inPersonalServiceListId
                                                                 , inJuridicalId             := vbJuridicalId
                                                                 , inUserId                  := vbUserId
                                                                  );
          -- ��������� �������� <������ �������������>
          PERFORM lpInsertUpdate_MovementBoolean (zc_MovementBoolean_isAuto(), vbMovementId, TRUE);

      END IF;


      -- ����� zc_MI_Master (���� - �������� + ��������� + �������������)
      SELECT MovementItem.Id                              AS Id_Master
           , COALESCE (MIBoolean_isAuto.ValueData, FALSE) AS isAuto
             INTO vbId_Master, vbIsAuto
      FROM MovementItem
           INNER JOIN MovementItemLinkObject AS MILinkObject_Unit
                                             ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                            AND MILinkObject_Unit.DescId         = zc_MILinkObject_Unit()
                                            AND MILinkObject_Unit.ObjectId       = inUnitId
           INNER JOIN MovementItemLinkObject AS MILinkObject_Position
                                             ON MILinkObject_Position.MovementItemId = MovementItem.Id
                                            AND MILinkObject_Position.DescId         = zc_MILinkObject_Position()
                                            AND MILinkObject_Position.ObjectId       = inPositionId

           LEFT JOIN MovementItemBoolean AS MIBoolean_isAuto
                                         ON MIBoolean_isAuto.MovementItemId = MovementItem.Id
                                        AND MIBoolean_isAuto.DescId = zc_MIBoolean_isAuto()

      WHERE MovementItem.MovementId = vbMovementId
        AND MovementItem.ObjectId   = vbPersonalId
        AND MovementItem.DescId     = zc_MI_Master()
        AND MovementItem.isErased   = FALSE;


      IF COALESCE (vbId_Master,0) = 0
      THEN
         -- ��������� zc_MI_Master
         vbId_Master:= (SELECT tmp.ioId
                        FROM lpInsertUpdate_MovementItem_PersonalService (ioId                     := vbId_Master
                                                                        , inMovementId             := vbMovementId
                                                                        , inPersonalId             := vbPersonalId
                                                                        , inIsMain                 := vbIsMain
                                                                        , inSummService            := 0 -- !!!����� ������ �����!!!
                                                                        , inSummCardRecalc         := 0
                                                                        , inSummCardSecondRecalc   := 0
                                                                        , inSummCardSecondCash     := 0
                                                                        , inSummNalogRecalc        := 0
                                                                        , inSummNalogRetRecalc     := 0
                                                                        , inSummMinus              := 0
                                                                        , inSummAdd                := 0
                                                                        , inSummHoliday            := 0
                                                                        , inSummSocialIn           := 0
                                                                        , inSummSocialAdd          := 0
                                                                        , inSummChildRecalc        := 0
                                                                        , inSummMinusExtRecalc     := 0
                                                                        , inComment                := ''
                                                                        , inInfoMoneyId            := vbInfoMoneyId_def
                                                                        , inUnitId                 := inUnitId
                                                                        , inPositionId             := inPositionId
                                                                        , inMemberId               := NULL
                                                                        , inPersonalServiceListId  := inPersonalServiceListId
                                                                        , inUserId                 := vbUserId
                                                                         ) AS tmp);

         -- ��������� �������� <������ �������������>
         PERFORM lpInsertUpdate_MovementItemBoolean (zc_MIBoolean_isAuto(), vbId_Master, TRUE);

      END IF;

      -- ����� zc_MI_Child
      vbId_Child:= 0 ;/*(SELECT MovementItem.Id
                    FROM MovementItem
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_PositionLevel
                                                         ON MILinkObject_PositionLevel.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_PositionLevel.DescId = zc_MILinkObject_PositionLevel()
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_StaffList
                                                         ON MILinkObject_StaffList.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_StaffList.DescId = zc_MILinkObject_StaffList()
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_ModelService
                                                         ON MILinkObject_ModelService.MovementItemId = MovementItem.Id
                                                        AND MILinkObject_ModelService.DescId = zc_MILinkObject_ModelService()
                       LEFT JOIN MovementItemLinkObject AS MILinkObject_StaffListSummKind
                                                        ON MILinkObject_StaffListSummKind.MovementItemId = MovementItem.Id
                                                       AND MILinkObject_StaffListSummKind.DescId = zc_MILinkObject_StaffListSummKind()
                    WHERE MovementItem.MovementId = vbMovementId
                      AND MovementItem.DescId     = zc_MI_Child()
                      AND MovementItem.ParentId   = vbId_Master
                      AND MovementItem.isErased   = FALSE
                      AND MovementItem.ObjectId   = inMemberId
                      AND (MILinkObject_PositionLevel.ObjectId     = inPositionLevelId     OR inPositionLevelId = 0)
                      AND (MILinkObject_StaffList.ObjectId         = inStaffListId         OR inStaffListId = 0)
                      AND (MILinkObject_ModelService.ObjectId      = inModelServiceId      OR inModelServiceId = 0)
                      AND (MILinkObject_StaffListSummKind.ObjectId = inStaffListSummKindId OR inStaffListSummKindId=0)
                   );*/

     -- �������� ������ �� ���. ������� ����������
     SELECT ObjectFloat_HoursPlan.ValueData     AS HoursPlan
          , ObjectFloat_HoursDay.ValueData      AS HoursDay
          , ObjectFloat_PersonalCount.ValueData AS PersonalCount
            INTO vbHoursPlan, vbHoursDay, vbPersonalCount
     FROM Object AS Object_StaffList
          LEFT JOIN ObjectFloat AS ObjectFloat_HoursPlan
                                ON ObjectFloat_HoursPlan.ObjectId = Object_StaffList.Id
                               AND ObjectFloat_HoursPlan.DescId = zc_ObjectFloat_StaffList_HoursPlan()
          LEFT JOIN ObjectFloat AS ObjectFloat_HoursDay
                                ON ObjectFloat_HoursDay.ObjectId = Object_StaffList.Id
                               AND ObjectFloat_HoursDay.DescId = zc_ObjectFloat_StaffList_HoursDay()
          LEFT JOIN ObjectFloat AS ObjectFloat_PersonalCount
                                ON ObjectFloat_PersonalCount.ObjectId = Object_StaffList.Id
                               AND ObjectFloat_PersonalCount.DescId = zc_ObjectFloat_StaffList_PersonalCount()
     WHERE Object_StaffList.Id     = inStaffListId;


      -- ��������� zc_MI_Child
      PERFORM lpInsertUpdate_MI_PersonalService_Child( ioId                   := vbId_Child
                                                     , inMovementId           := vbMovementId
                                                     , inParentId             := vbId_Master
                                                     , inMemberId             := inMemberId
                                                     , inPositionLevelId      := inPositionLevelId
                                                     , inStaffListId          := inStaffListId
                                                     , inModelServiceId       := inModelServiceId
                                                     , inStaffListSummKindId  := inStaffListSummKindId

                                                     , inAmount               := COALESCE (inAmount, 0)
                                                     , inMemberCount          := COALESCE (inMemberCount, 0)
                                                     , inDayCount             := COALESCE (inDayCount, 0)
                                                     , inWorkTimeHoursOne     := COALESCE (inWorkTimeHoursOne, 0)
                                                     , inWorkTimeHours        := COALESCE (inWorkTimeHours, 0)
                                                     , inPrice                := COALESCE (inPrice, 0)
                                                     , inHoursPlan            := COALESCE (vbHoursPlan, 0)
                                                     , inHoursDay             := COALESCE (vbHoursDay, 0)
                                                     , inPersonalCount        := COALESCE (vbPersonalCount, 0)
                                                     , inGrossOne             := COALESCE (inGrossOne, 0)
                                                     , inUserId               := vbUserId
                                                     );

    IF COALESCE (vbIsAuto, TRUE) = TRUE
    THEN
       vbSummService := (SELECT SUM (MovementItem.Amount) AS Amount
                         FROM MovementItem
                         WHERE MovementItem.ParentId = vbId_Master
                           AND MovementItem.DescId   = zc_MI_Child()
                           AND MovementItem.isErased = FALSE
                        );

       -- ��������� ����� ������� = ����� �� �����
       PERFORM lpInsertUpdate_MovementItem_PersonalService (ioId                     := vbId_Master
                                                          , inMovementId             := vbMovementId
                                                          , inPersonalId             := MovementItem.ObjectId
                                                          , inIsMain                 := COALESCE (MIBoolean_Main.ValueData, FALSE)
                                                          , inSummService            := vbSummService
                                                          , inSummCardRecalc         := COALESCE (MIFloat_SummCardRecalc.ValueData, 0)
                                                          , inSummCardSecondRecalc   := COALESCE (MIFloat_SummCardSecondRecalc.ValueData, 0)
                                                          , inSummCardSecondCash     := COALESCE (MIFloat_SummCardSecondCash.ValueData, 0)
                                                          , inSummNalogRecalc        := COALESCE (MIFloat_SummNalogRecalc.ValueData, 0)
                                                          , inSummNalogRetRecalc     := COALESCE (MIFloat_SummNalogRetRecalc.ValueData, 0)
                                                          , inSummMinus              := COALESCE (MIFloat_SummMinus.ValueData, 0)
                                                          , inSummAdd                := COALESCE (MIFloat_SummAdd.ValueData, 0)
                                                          , inSummHoliday            := COALESCE (MIFloat_SummHoliday.ValueData, 0)
                                                          , inSummSocialIn           := COALESCE (MIFloat_SummSocialIn.ValueData, 0)
                                                          , inSummSocialAdd          := COALESCE (MIFloat_SummSocialAdd.ValueData, 0)
                                                          , inSummChildRecalc        := COALESCE (MIFloat_SummChildRecalc.ValueData, 0)
                                                          , inSummMinusExtRecalc     := COALESCE (MIFloat_SummMinusExtRecalc.ValueData, 0)
                                                          , inComment                := MIString_Comment.ValueData
                                                          , inInfoMoneyId            := MILinkObject_InfoMoney.ObjectId
                                                          , inUnitId                 := inUnitId
                                                          , inPositionId             := inPositionId
                                                          , inMemberId               := MILinkObject_Member.ObjectId
                                                          , inPersonalServiceListId  := NULL
                                                          , inUserId                 := vbUserId
                                                           )
       FROM MovementItem
            LEFT JOIN MovementItemString AS MIString_Comment
                                         ON MIString_Comment.MovementItemId = MovementItem.Id
                                        AND MIString_Comment.DescId = zc_MIString_Comment()
            LEFT JOIN MovementItemFloat AS MIFloat_SummCardRecalc
                                        ON MIFloat_SummCardRecalc.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummCardRecalc.DescId = zc_MIFloat_SummCardRecalc()
            LEFT JOIN MovementItemFloat AS MIFloat_SummCardSecondRecalc
                                        ON MIFloat_SummCardSecondRecalc.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummCardSecondRecalc.DescId = zc_MIFloat_SummCardSecondRecalc()
            LEFT JOIN MovementItemFloat AS MIFloat_SummCardSecondCash
                                        ON MIFloat_SummCardSecondCash.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummCardSecondCash.DescId = zc_MIFloat_SummCardSecondCash()
            LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRecalc
                                        ON MIFloat_SummNalogRecalc.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummNalogRecalc.DescId = zc_MIFloat_SummNalogRecalc()
            LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRetRecalc
                                        ON MIFloat_SummNalogRetRecalc.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummNalogRetRecalc.DescId = zc_MIFloat_SummNalogRetRecalc()
            LEFT JOIN MovementItemFloat AS MIFloat_SummMinus
                                        ON MIFloat_SummMinus.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummMinus.DescId = zc_MIFloat_SummMinus()
            LEFT JOIN MovementItemFloat AS MIFloat_SummAdd
                                        ON MIFloat_SummAdd.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummAdd.DescId = zc_MIFloat_SummAdd()
            LEFT JOIN MovementItemFloat AS MIFloat_SummHoliday
                                        ON MIFloat_SummHoliday.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummHoliday.DescId = zc_MIFloat_SummHoliday()
            LEFT JOIN MovementItemFloat AS MIFloat_SummSocialIn
                                        ON MIFloat_SummSocialIn.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummSocialIn.DescId = zc_MIFloat_SummSocialIn()
            LEFT JOIN MovementItemFloat AS MIFloat_SummSocialAdd
                                        ON MIFloat_SummSocialAdd.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummSocialAdd.DescId = zc_MIFloat_SummSocialAdd()
            LEFT JOIN MovementItemFloat AS MIFloat_SummChildRecalc
                                        ON MIFloat_SummChildRecalc.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummChildRecalc.DescId = zc_MIFloat_SummChildRecalc()
            LEFT JOIN MovementItemFloat AS MIFloat_SummMinusExtRecalc
                                        ON MIFloat_SummMinusExtRecalc.MovementItemId = MovementItem.Id
                                       AND MIFloat_SummMinusExtRecalc.DescId = zc_MIFloat_SummMinusExtRecalc()
            LEFT JOIN MovementItemBoolean AS MIBoolean_Main
                                          ON MIBoolean_Main.MovementItemId = MovementItem.Id
                                         AND MIBoolean_Main.DescId = zc_MIBoolean_Main()
            LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                             ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                            AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
            LEFT JOIN MovementItemLinkObject AS MILinkObject_Member
                                             ON MILinkObject_Member.MovementItemId = MovementItem.Id
                                            AND MILinkObject_Member.DescId         = zc_MILinkObject_Member()                                                           
            LEFT JOIN MovementItemLinkObject AS MILinkObject_PersonalServiceList
                                             ON MILinkObject_PersonalServiceList.MovementItemId = MovementItem.Id
                                            AND MILinkObject_PersonalServiceList.DescId         = zc_MILinkObject_PersonalServiceList() 
       WHERE MovementItem.Id       = vbId_Master
         AND MovementItem.DescId   = zc_MI_Master()
         AND MovementItem.isErased = FALSE;

    END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 05.01.18         *
 20.06.17         * add inSummCardSecondCash
 21.06.16         *
*/

-- ����
-- SELECT * FROM gpInsertUpdate_MI_PersonalService_Child_Auto(inFromId := 183292 , inToId := 183290 , inOperDate := ('01.06.2016')::TDateTime , inGoodsId := 3022 , inRemainsMCS_result := 0.8 , inPrice_from := 155.1 , inPrice_to := 155.1 ,  inSession := '3');
