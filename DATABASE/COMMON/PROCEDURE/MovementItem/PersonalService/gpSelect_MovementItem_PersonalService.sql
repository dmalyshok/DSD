-- Function: gpSelect_MovementItem_PersonalService()

DROP FUNCTION IF EXISTS gpSelect_MovementItem_PersonalService (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MovementItem_PersonalService(
    IN inMovementId  Integer      , -- ���� ���������
    IN inShowAll     Boolean      , --
    IN inIsErased    Boolean      , --
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS TABLE (Id Integer, PersonalId Integer, PersonalCode Integer, PersonalName TVarChar
             , INN TVarChar, Card TVarChar, CardSecond TVarChar, isMain Boolean, isOfficial Boolean
             , PersonalCode_to Integer, PersonalName_to TVarChar
             , UnitId Integer, UnitCode Integer, UnitName TVarChar
             , PositionId Integer, PositionName TVarChar
             , InfoMoneyId Integer, InfoMoneyCode Integer, InfoMoneyName TVarChar, InfoMoneyName_all TVarChar
             , MemberId Integer, MemberName TVarChar
             , PersonalServiceListId Integer, PersonalServiceListName TVarChar
             , Amount TFloat, AmountToPay TFloat, AmountCash TFloat, SummService TFloat
             , SummCard TFloat, SummCardRecalc TFloat, SummCardSecond TFloat, SummCardSecondRecalc TFloat, SummCardSecondCash TFloat
             , SummNalog TFloat, SummNalogRecalc TFloat
             , SummNalogRet TFloat, SummNalogRetRecalc TFloat
             , SummMinus TFloat, SummAdd TFloat
             , SummHoliday TFloat, SummSocialIn TFloat, SummSocialAdd TFloat
             , SummChild TFloat, SummChildRecalc TFloat, SummMinusExt TFloat, SummMinusExtRecalc TFloat
             , SummTransport TFloat, SummTransportAdd TFloat, SummTransportAddLong TFloat, SummTransportTaxi TFloat, SummPhone TFloat
             , TotalSummChild TFloat, SummDiff TFloat
             , Comment TVarChar
             , isErased Boolean
             , isAuto Boolean
              )
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbInfoMoneyId_def Integer;
   DECLARE vbInfoMoneyName TVarChar;
   DECLARE vbInfoMoneyName_all TVarChar;
   DECLARE vbIsSummCardRecalc Boolean;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_Select_MI_PersonalService());
     vbUserId:= lpGetUserBySession (inSession);


     -- ������������ ������
     vbInfoMoneyId_def:= (SELECT Object_InfoMoney_View.InfoMoneyId FROM Object_InfoMoney_View WHERE Object_InfoMoney_View.InfoMoneyId = zc_Enum_InfoMoney_60101()); -- 60101 ���������� ����� + ���������� �����
     -- ������������
     vbIsSummCardRecalc:= COALESCE (inMovementId, 0) = 0
                       OR EXISTS (SELECT ObjectLink_PersonalServiceList_PaidKind.ChildObjectId
                                  FROM MovementLinkObject AS MovementLinkObject_PersonalServiceList
                                       INNER JOIN ObjectLink AS ObjectLink_PersonalServiceList_PaidKind
                                                             ON ObjectLink_PersonalServiceList_PaidKind.ObjectId = MovementLinkObject_PersonalServiceList.ObjectId
                                                            AND ObjectLink_PersonalServiceList_PaidKind.DescId = zc_ObjectLink_PersonalServiceList_PaidKind()
                                                            AND ObjectLink_PersonalServiceList_PaidKind.ChildObjectId = zc_Enum_PaidKind_FirstForm()
                                  WHERE MovementLinkObject_PersonalServiceList.MovementId = inMovementId
                                    AND MovementLinkObject_PersonalServiceList.DescId = zc_MovementLinkObject_PersonalServiceList()
                                 );

     -- ���������
     RETURN QUERY
       WITH tmpIsErased AS (SELECT FALSE AS isErased UNION ALL SELECT inIsErased AS isErased WHERE inIsErased = TRUE)
          , tmpMIContainer_all AS (SELECT MIContainer.MovementItemId
                                        , CLO_Unit.ObjectId     AS UnitId
                                        , CLO_Position.ObjectId AS PositionId
                                        , CLO_Personal.ObjectId AS PersonalId
                                        , (CASE WHEN MIContainer.AnalyzerId = zc_Enum_AnalyzerId_PersonalService_Nalog() THEN MIContainer.Amount ELSE 0 END) AS SummNalog
                                        , ROW_NUMBER() OVER (PARTITION BY MIContainer.MovementItemId ORDER BY ABS (MIContainer.Amount) DESC) AS Ord
                                   FROM MovementItemContainer AS MIContainer
                                        LEFT JOIN ContainerLinkObject AS CLO_Unit
                                                                      ON CLO_Unit.ContainerId = MIContainer.ContainerId
                                                                     AND CLO_Unit.DescId = zc_ContainerLinkObject_Unit()
                                        LEFT JOIN ContainerLinkObject AS CLO_Position
                                                                      ON CLO_Position.ContainerId = MIContainer.ContainerId
                                                                     AND CLO_Position.DescId = zc_ContainerLinkObject_Position()
                                        LEFT JOIN ContainerLinkObject AS CLO_Personal
                                                                      ON CLO_Personal.ContainerId = MIContainer.ContainerId
                                                                     AND CLO_Personal.DescId = zc_ContainerLinkObject_Personal()
                                   WHERE MIContainer.MovementId = inMovementId
                                     AND MIContainer.DescId     = zc_MIContainer_Summ()
                                     AND MIContainer.AnalyzerId IN (zc_Enum_AnalyzerId_PersonalService_Nalog())
                                  )
          , tmpMI AS (SELECT MovementItem.Id                          AS MovementItemId
                           , MovementItem.Amount
                           , MovementItem.ObjectId                    AS PersonalId
                           , MILinkObject_Unit.ObjectId               AS UnitId
                           , MILinkObject_Position.ObjectId           AS PositionId
                           , MILinkObject_InfoMoney.ObjectId          AS InfoMoneyId
                           , MILinkObject_Member.ObjectId             AS MemberId
                           , ObjectLink_Personal_Member.ChildObjectId AS MemberId_Personal
                           , MILinkObject_PersonalServiceList.ObjectId AS PersonalServiceListId
                           , MovementItem.isErased
                      FROM tmpIsErased
                           INNER JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                                  AND MovementItem.DescId = zc_MI_Master()
                                                  AND MovementItem.isErased = tmpIsErased.isErased
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_InfoMoney
                                                            ON MILinkObject_InfoMoney.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_InfoMoney.DescId = zc_MILinkObject_InfoMoney()
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_Unit
                                                            ON MILinkObject_Unit.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_Unit.DescId = zc_MILinkObject_Unit()
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_Position
                                                            ON MILinkObject_Position.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_Position.DescId = zc_MILinkObject_Position()
                           LEFT JOIN MovementItemLinkObject AS MILinkObject_Member
                                                            ON MILinkObject_Member.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_Member.DescId = zc_MILinkObject_Member()
                           LEFT JOIN ObjectLink AS ObjectLink_Personal_Member
                                                ON ObjectLink_Personal_Member.ObjectId = MovementItem.ObjectId
                                               AND ObjectLink_Personal_Member.DescId = zc_ObjectLink_Personal_Member()

                           LEFT JOIN MovementItemLinkObject AS MILinkObject_PersonalServiceList
                                                            ON MILinkObject_PersonalServiceList.MovementItemId = MovementItem.Id
                                                           AND MILinkObject_PersonalServiceList.DescId = zc_MILinkObject_PersonalServiceList()
                     )
          , tmpMIChild AS (SELECT  MovementItem.ParentId    AS ParentId
                                 , SUM(MovementItem.Amount) AS Amount
                           FROM tmpIsErased
                              INNER JOIN MovementItem ON MovementItem.MovementId = inMovementId
                                                     AND MovementItem.DescId = zc_MI_Child()
                                                     AND MovementItem.isErased = tmpIsErased.isErased
                           GROUP BY MovementItem.ParentId
                       )

          , tmpUserAll AS (SELECT DISTINCT UserId FROM ObjectLink_UserRole_View WHERE RoleId IN (zc_Enum_Role_Admin()/*, 293449*/) AND UserId = vbUserId/* AND UserId <> 9464*/) -- ���������-���� (����������) AND <> ����� �.�.
          , tmpPersonal AS (SELECT 0 AS MovementItemId
                                 , 0 AS Amount
                                 , View_Personal.PersonalId
                                 , View_Personal.UnitId
                                 , View_Personal.PositionId
                                 , vbInfoMoneyId_def         AS InfoMoneyId
                                 , View_Personal.MemberId    AS MemberId_Personal
                                 , 0     AS MemberId
                                 , ObjectLink_Personal_PersonalServiceList.ChildObjectId AS PersonalServiceListId -- !!!����� ��� ���� �.�. ���� ����������� �� ��!!!
                                 , FALSE AS isErased
                            FROM (SELECT UnitId_PersonalService FROM Object_RoleAccessKeyGuide_View WHERE UnitId_PersonalService <> 0 AND UserId = vbUserId AND inShowAll = TRUE
                                 UNION
                                  -- ����� ����� ����
                                  SELECT Object.Id AS UnitId_PersonalService FROM tmpUserAll INNER JOIN Object ON Object.DescId = zc_Object_Unit() AND inShowAll = TRUE
                                 ) AS View_RoleAccessKeyGuide
                                 INNER JOIN Object_Personal_View AS View_Personal ON View_Personal.UnitId = View_RoleAccessKeyGuide.UnitId_PersonalService
                                                                                 -- AND View_Personal.isErased = FALSE
                                 LEFT JOIN ObjectLink AS ObjectLink_Personal_PersonalServiceList
                                                      ON ObjectLink_Personal_PersonalServiceList.ObjectId = View_Personal.PersonalId
                                                     AND ObjectLink_Personal_PersonalServiceList.DescId = zc_ObjectLink_Personal_PersonalServiceList()
                                                     AND vbIsSummCardRecalc = TRUE -- !!!�.�. ���� ��� ��!!!

                                 LEFT JOIN tmpMI ON tmpMI.PersonalId = View_Personal.PersonalId
                                                AND tmpMI.UnitId     = View_Personal.UnitId
                                                AND tmpMI.PositionId = View_Personal.PositionId

                            WHERE tmpMI.PersonalId IS NULL
                           )
          , tmpAll AS (SELECT tmpMI.MovementItemId, tmpMI.Amount, tmpMI.PersonalId, tmpMI.UnitId, tmpMI.PositionId, tmpMI.InfoMoneyId, tmpMI.MemberId_Personal, tmpMI.MemberId , tmpMI.PersonalServiceListId, tmpMI.isErased FROM tmpMI
                      UNION ALL
                       SELECT tmpPersonal.MovementItemId, tmpPersonal.Amount, tmpPersonal.PersonalId, tmpPersonal.UnitId, tmpPersonal.PositionId, tmpPersonal.InfoMoneyId, tmpPersonal.Memberid_Personal, tmpPersonal.MemberId, tmpPersonal.PersonalServiceListId, tmpPersonal.isErased FROM tmpPersonal
                      )
       -- ���������
       SELECT tmpAll.MovementItemId                   AS Id
            , Object_Personal.Id                      AS PersonalId
            , Object_Personal.ObjectCode              AS PersonalCode
            , Object_Personal.ValueData               AS PersonalName
            , ObjectString_Member_INN.ValueData       AS INN
            , ObjectString_Member_Card.ValueData      AS Card
            , ObjectString_Member_CardSecond.ValueData      AS CardSecond
            , CASE WHEN tmpAll.MovementItemId > 0 THEN COALESCE (MIBoolean_Main.ValueData, FALSE) ELSE COALESCE (ObjectBoolean_Personal_Main.ValueData, FALSE) END :: Boolean   AS isMain
            , COALESCE (ObjectBoolean_Member_Official.ValueData, FALSE) :: Boolean AS isOfficial

            , Object_PersonalTo.ObjectCode            AS PersonalCode_to
            , Object_PersonalTo.ValueData             AS PersonalName_to

            , Object_Unit.Id                          AS UnitId
            , Object_Unit.ObjectCode                  AS UnitCode
            , Object_Unit.ValueData                   AS UnitName
            , Object_Position.Id                      AS PositionId
            , Object_Position.ValueData               AS PositionName
            , View_InfoMoney.InfoMoneyId
            , View_InfoMoney.InfoMoneyCode
            , View_InfoMoney.InfoMoneyName
            , View_InfoMoney.InfoMoneyName_all

            , COALESCE (Object_Member.Id, 0)          AS MemberId
            , COALESCE (Object_Member.ValueData, ''::TVarChar) AS MemberName

            , COALESCE (Object_PersonalServiceList.Id, 0)                   AS PersonalServiceListId
            , COALESCE (Object_PersonalServiceList.ValueData, ''::TVarChar) AS PersonalServiceListName

            , tmpAll.Amount :: TFloat           AS Amount
            , MIFloat_SummToPay.ValueData       AS AmountToPay
            , (COALESCE (MIFloat_SummToPay.ValueData, 0)
            + (-1) *  CASE WHEN 1=0 AND inSession = '5'
                               THEN 0
                          ELSE COALESCE (MIFloat_SummCard.ValueData, 0)
                             + COALESCE (MIFloat_SummCardSecond.ValueData, 0)
                             + COALESCE (MIFloat_SummCardSecondCash.ValueData, 0)
                      END 
              ) :: TFloat AS AmountCash
            , MIFloat_SummService.ValueData           AS SummService
            , MIFloat_SummCard.ValueData              AS SummCard
            , MIFloat_SummCardRecalc.ValueData        AS SummCardRecalc
            , MIFloat_SummCardSecond.ValueData        AS SummCardSecond
            , MIFloat_SummCardSecondRecalc.ValueData  AS SummCardSecondRecalc
            , MIFloat_SummCardSecondCash.ValueData    AS SummCardSecondCash
            , MIFloat_SummNalog.ValueData             AS SummNalog
            , MIFloat_SummNalogRecalc.ValueData       AS SummNalogRecalc
            , MIFloat_SummNalogRet.ValueData          AS SummNalogRet
            , MIFloat_SummNalogRetRecalc.ValueData    AS SummNalogRetRecalc
            , MIFloat_SummMinus.ValueData             AS SummMinus
            , MIFloat_SummAdd.ValueData               AS SummAdd
            , MIFloat_SummHoliday.ValueData           AS SummHoliday
            , MIFloat_SummSocialIn.ValueData          AS SummSocialIn
            , MIFloat_SummSocialAdd.ValueData         AS SummSocialAdd
            , MIFloat_SummChild.ValueData             AS SummChild
            , MIFloat_SummChildRecalc.ValueData       AS SummChildRecalc
            , MIFloat_SummMinusExt.ValueData          AS SummMinusExt
            , MIFloat_SummMinusExtRecalc.ValueData    AS SummMinusExtRecalc

            , MIFloat_SummTransport.ValueData         AS SummTransport
            , MIFloat_SummTransportAdd.ValueData      AS SummTransportAdd
            , MIFloat_SummTransportAddLong.ValueData  AS SummTransportAddLong
            , MIFloat_SummTransportTaxi.ValueData     AS SummTransportTaxi
            , MIFloat_SummPhone.ValueData             AS SummPhone

            , COALESCE (tmpMIChild.Amount, 0)                                                :: TFloat AS TotalSummChild
            , (COALESCE (tmpMIChild.Amount, 0) - COALESCE (MIFloat_SummService.ValueData, 0)) :: TFloat AS SummDiff

            , MIString_Comment.ValueData       AS Comment
            , tmpAll.isErased
            , COALESCE (MIBoolean_isAuto.ValueData, FALSE) :: Boolean  AS isAuto

       FROM tmpAll
            LEFT JOIN tmpMIContainer_all ON tmpMIContainer_all.MovementItemId = tmpAll.MovementItemId
                                        AND tmpMIContainer_all.Ord            = 1 -- !!!������ 1-��!!!

            LEFT JOIN MovementItemString AS MIString_Comment
                                         ON MIString_Comment.MovementItemId = tmpAll.MovementItemId
                                        AND MIString_Comment.DescId = zc_MIString_Comment()

            LEFT JOIN MovementItemFloat AS MIFloat_SummToPay
                                        ON MIFloat_SummToPay.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummToPay.DescId = zc_MIFloat_SummToPay()
            LEFT JOIN MovementItemFloat AS MIFloat_SummService
                                        ON MIFloat_SummService.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummService.DescId = zc_MIFloat_SummService()

            LEFT JOIN MovementItemFloat AS MIFloat_SummCard
                                        ON MIFloat_SummCard.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummCard.DescId = zc_MIFloat_SummCard()
            LEFT JOIN MovementItemFloat AS MIFloat_SummCardRecalc
                                        ON MIFloat_SummCardRecalc.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummCardRecalc.DescId = zc_MIFloat_SummCardRecalc()

            LEFT JOIN MovementItemFloat AS MIFloat_SummCardSecond
                                        ON MIFloat_SummCardSecond.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummCardSecond.DescId = zc_MIFloat_SummCardSecond()

            LEFT JOIN MovementItemFloat AS MIFloat_SummCardSecondRecalc
                                        ON MIFloat_SummCardSecondRecalc.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummCardSecondRecalc.DescId = zc_MIFloat_SummCardSecondRecalc()

            LEFT JOIN MovementItemFloat AS MIFloat_SummCardSecondCash
                                        ON MIFloat_SummCardSecondCash.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummCardSecondCash.DescId = zc_MIFloat_SummCardSecondCash()

            LEFT JOIN MovementItemFloat AS MIFloat_SummNalog
                                        ON MIFloat_SummNalog.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummNalog.DescId = zc_MIFloat_SummNalog()
            LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRecalc
                                        ON MIFloat_SummNalogRecalc.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummNalogRecalc.DescId = zc_MIFloat_SummNalogRecalc()

            LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRet
                                        ON MIFloat_SummNalogRet.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummNalogRet.DescId = zc_MIFloat_SummNalogRet()
            LEFT JOIN MovementItemFloat AS MIFloat_SummNalogRetRecalc
                                        ON MIFloat_SummNalogRetRecalc.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummNalogRetRecalc.DescId = zc_MIFloat_SummNalogRetRecalc()
                                       
            LEFT JOIN MovementItemFloat AS MIFloat_SummMinus
                                        ON MIFloat_SummMinus.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummMinus.DescId = zc_MIFloat_SummMinus()
            LEFT JOIN MovementItemFloat AS MIFloat_SummAdd
                                        ON MIFloat_SummAdd.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummAdd.DescId = zc_MIFloat_SummAdd()

            LEFT JOIN MovementItemFloat AS MIFloat_SummHoliday
                                        ON MIFloat_SummHoliday.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummHoliday.DescId = zc_MIFloat_SummHoliday()

            LEFT JOIN MovementItemFloat AS MIFloat_SummSocialIn
                                        ON MIFloat_SummSocialIn.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummSocialIn.DescId = zc_MIFloat_SummSocialIn()
            LEFT JOIN MovementItemFloat AS MIFloat_SummSocialAdd
                                        ON MIFloat_SummSocialAdd.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummSocialAdd.DescId = zc_MIFloat_SummSocialAdd()
            LEFT JOIN MovementItemFloat AS MIFloat_SummChild
                                        ON MIFloat_SummChild.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummChild.DescId = zc_MIFloat_SummChild()

            LEFT JOIN MovementItemFloat AS MIFloat_SummChildRecalc
                                        ON MIFloat_SummChildRecalc.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummChildRecalc.DescId = zc_MIFloat_SummChildRecalc()
            LEFT JOIN MovementItemFloat AS MIFloat_SummMinusExt
                                        ON MIFloat_SummMinusExt.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummMinusExt.DescId = zc_MIFloat_SummMinusExt()
            LEFT JOIN MovementItemFloat AS MIFloat_SummMinusExtRecalc
                                        ON MIFloat_SummMinusExtRecalc.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummMinusExtRecalc.DescId = zc_MIFloat_SummMinusExtRecalc()

            LEFT JOIN MovementItemFloat AS MIFloat_SummTransport
                                        ON MIFloat_SummTransport.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummTransport.DescId = zc_MIFloat_SummTransport()
            LEFT JOIN MovementItemFloat AS MIFloat_SummTransportAdd
                                        ON MIFloat_SummTransportAdd.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummTransportAdd.DescId = zc_MIFloat_SummTransportAdd()
            LEFT JOIN MovementItemFloat AS MIFloat_SummTransportAddLong
                                        ON MIFloat_SummTransportAddLong.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummTransportAddLong.DescId = zc_MIFloat_SummTransportAddLong()
            LEFT JOIN MovementItemFloat AS MIFloat_SummTransportTaxi
                                        ON MIFloat_SummTransportTaxi.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummTransportTaxi.DescId = zc_MIFloat_SummTransportTaxi()
            LEFT JOIN MovementItemFloat AS MIFloat_SummPhone
                                        ON MIFloat_SummPhone.MovementItemId = tmpAll.MovementItemId
                                       AND MIFloat_SummPhone.DescId = zc_MIFloat_SummPhone()

            LEFT JOIN MovementItemBoolean AS MIBoolean_Main
                                          ON MIBoolean_Main.MovementItemId = tmpAll.MovementItemId
                                         AND MIBoolean_Main.DescId = zc_MIBoolean_Main()

            LEFT JOIN MovementItemBoolean AS MIBoolean_isAuto
                                          ON MIBoolean_isAuto.MovementItemId = tmpAll.MovementItemId
                                         AND MIBoolean_isAuto.DescId = zc_MIBoolean_isAuto()

            LEFT JOIN Object AS Object_Personal ON Object_Personal.Id = tmpAll.PersonalId
            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmpAll.UnitId
            LEFT JOIN Object AS Object_Position ON Object_Position.Id = tmpAll.PositionId
            LEFT JOIN Object AS Object_Member ON Object_Member.Id = tmpAll.MemberId
            LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = tmpAll.InfoMoneyId
            LEFT JOIN Object AS Object_PersonalServiceList ON Object_PersonalServiceList.Id = tmpAll.PersonalServiceListId
            LEFT JOIN Object AS Object_PersonalTo ON Object_PersonalTo.Id = tmpMIContainer_all.PersonalId

            LEFT JOIN ObjectBoolean AS ObjectBoolean_Personal_Main
                                    ON ObjectBoolean_Personal_Main.ObjectId = tmpAll.PersonalId
                                   AND ObjectBoolean_Personal_Main.DescId = zc_ObjectBoolean_Personal_Main()
            LEFT JOIN ObjectString AS ObjectString_Member_INN
                                   ON ObjectString_Member_INN.ObjectId = tmpAll.MemberId_Personal
                                  AND ObjectString_Member_INN.DescId = zc_ObjectString_Member_INN()
            LEFT JOIN ObjectString AS ObjectString_Member_Card
                                   ON ObjectString_Member_Card.ObjectId = tmpAll.MemberId_Personal
                                  AND ObjectString_Member_Card.DescId = zc_ObjectString_Member_Card()
            LEFT JOIN ObjectString AS ObjectString_Member_CardSecond
                                   ON ObjectString_Member_CardSecond.ObjectId = tmpAll.MemberId_Personal
                                  AND ObjectString_Member_CardSecond.DescId = zc_ObjectString_Member_CardSecond()
            LEFT JOIN ObjectBoolean AS ObjectBoolean_Member_Official
                                    ON ObjectBoolean_Member_Official.ObjectId = tmpAll.MemberId_Personal
                                   AND ObjectBoolean_Member_Official.DescId = zc_ObjectBoolean_Member_Official()
            LEFT JOIN tmpMIChild ON tmpMIChild.ParentId = tmpAll.MovementItemId
      ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MovementItem_PersonalService (Integer, Boolean, Boolean, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 05.01.18         * add SummNalogRet
                        SummNalogRetRecalc
 20.06.17         * add SummCardSecondCash
 24.02.17         *
 20.02.17         *
 21.06.16         *
 20.04.16         * add SummHoliday
 25.03.16         * add Card
 07.05.15         * add PersonalServiceList
 01.10.14         * add redmine 30.09
 14.09.14                                        * ALL
 11.09.14         *
*/

-- ����
-- SELECT * FROM gpSelect_MovementItem_PersonalService (inMovementId:= 25173, inShowAll:= TRUE, inIsErased:= FALSE, inSession:= '9818')
-- SELECT * FROM gpSelect_MovementItem_PersonalService (inMovementId:= 25173, inShowAll:= FALSE, inIsErased:= FALSE, inSession:= '2')
