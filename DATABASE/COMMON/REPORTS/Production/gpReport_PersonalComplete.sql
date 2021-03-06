-- Function: gpReport_PersonalComplete()

DROP FUNCTION IF EXISTS gpReport_PersonalComplete (TDateTime, TDateTime, Integer, Integer, Integer, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpReport_PersonalComplete (TDateTime, TDateTime, Integer, Integer, Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_PersonalComplete(
    IN inStartDate   TDateTime ,              --
    IN inEndDate     TDateTime ,              --
    IN inPersonalId  Integer   ,              -- ��������
    IN inPositionId  Integer   ,              -- ���������
    IN inBranchId    Integer   ,              -- ������
    IN inIsDay       Boolean   ,              -- ������� ����������� �� ���� - ��/���
    IN inIsDetail    Boolean   DEFAULT FALSE, -- ������� ����������� �� ���� - ��/���
    IN inSession     TVarChar  DEFAULT ''      -- ������ ������������
)
RETURNS TABLE (OperDate TDateTime
             , UnitId Integer, UnitCode Integer, UnitName TVarChar
             , PersonalId Integer, PersonalCode Integer, PersonalName TVarChar
             , PositionId Integer, PositionCode Integer, PositionName TVarChar

             , TotalCount     TFloat   -- ���������� (�����.)
             , TotalCountKg   TFloat   -- ��� (�����.)
             , CountMI        TFloat   -- ���. ����� (�����.)
             , CountMovement  TFloat   -- ���. ���. (�����.)

             , TotalCount1    TFloat
             , TotalCountKg1  TFloat
             , CountMI1       TFloat
             , CountMovement1 TFloat

             , BranchName  TVarChar
             , FromId Integer, ToId  Integer
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_Select_Movement_PersonalComplete());
     vbUserId:= lpGetUserBySession (inSession);

     -- ���������
     RETURN QUERY
        WITH
        -- ����������
        tmpPersonal_all AS (SELECT Object_Personal_View.MemberId, Object_Personal_View.PersonalId, Object_Personal_View.UnitId, Object_Personal_View.PositionId
                                 , COALESCE (ObjectLink_Unit_Branch.ChildObjectId, zc_Branch_Basis()) AS BranchId
                            FROM Object_Personal_View
                                 LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                                                      ON ObjectLink_Unit_Branch.ObjectId =  Object_Personal_View.UnitId
                                                     AND ObjectLink_Unit_Branch.DescId   = zc_ObjectLink_Unit_Branch()
                            WHERE (Object_Personal_View.PersonalId = inPersonalId OR inPersonalId = 0)
                              AND (COALESCE (ObjectLink_Unit_Branch.ChildObjectId, zc_Branch_Basis()) = inBranchId OR inBranchId = 0)
                           )
        -- ������������ - � ��� ��� ����������
      , tmpUser_findPersonal AS
                           (SELECT lfSelect.MemberId, lfSelect.PersonalId, lfSelect.UnitId, lfSelect.PositionId
                                 , COALESCE (lfSelect.BranchId, zc_Branch_Basis()) AS BranchId
                                 , ObjectLink_User_Member.ObjectId AS UserId
                            FROM lfSelect_Object_Member_findPersonal (inSession) AS lfSelect
                                 INNER JOIN ObjectLink AS ObjectLink_User_Member
                                                       ON ObjectLink_User_Member.ChildObjectId =  lfSelect.MemberId
                                                      AND ObjectLink_User_Member.DescId        = zc_ObjectLink_User_Member()
                            WHERE (lfSelect.PersonalId = inPersonalId OR inPersonalId = 0)
                            --  AND (COALESCE (lfSelect.BranchId, zc_Branch_Basis()) = inBranchId OR inBranchId = 0)
                           )
            -- �������� - ��������������
          , tmpListDesc AS (SELECT zc_MovementLinkObject_PersonalComplete1() AS PersonalDescId
                           UNION ALL
                            SELECT zc_MovementLinkObject_PersonalComplete2() AS PersonalDescId
                           UNION ALL
                            SELECT zc_MovementLinkObject_PersonalComplete3() AS PersonalDescId
                           UNION ALL
                            SELECT zc_MovementLinkObject_PersonalComplete4() AS PersonalDescId
                           )
        -- ��� ���������
      , tmpMovement_all AS (SELECT Movement.Id AS MovementId
                                 , Movement.InvNumber
                                 , Movement.OperDate
                                 , MovementLinkObject_Personal.ObjectId                        AS PersonalId
                                 , MovementLinkObject_User.ObjectId                            AS UserId
                                 , COALESCE (tmpUser_findPersonal.BranchId, zc_Branch_Basis()) AS BranchId
                                 , COALESCE (MovementFloat_TotalCount.ValueData, 0)            AS TotalCount
                                 , COALESCE (MovementFloat_TotalCountKg.ValueData, 0)          AS TotalCountKg
                                 , COALESCE (MovementLinkObject_From.ObjectId, 0)              AS FromId
                                 , COALESCE (MovementLinkObject_To.ObjectId, 0)                AS ToId
                            FROM Movement
                                 LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                                              ON MovementLinkObject_From.MovementId = Movement.Id
                                                             AND MovementLinkObject_From.DescId     = zc_MovementLinkObject_From()
                                                             AND inIsDetail = TRUE
                                 LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                              ON MovementLinkObject_To.MovementId = Movement.Id
                                                             AND MovementLinkObject_To.DescId     = zc_MovementLinkObject_To()
                                                             AND inIsDetail = TRUE
                                 LEFT JOIN MovementLinkObject AS MovementLinkObject_Personal
                                                              ON MovementLinkObject_Personal.MovementId = Movement.Id
                                                             AND MovementLinkObject_Personal.DescId     IN (SELECT tmpListDesc.PersonalDescId FROM tmpListDesc)
                                 LEFT JOIN MovementLinkObject AS MovementLinkObject_User
                                                              ON MovementLinkObject_User.MovementId = Movement.Id
                                                             AND MovementLinkObject_User.DescId     = zc_MovementLinkObject_User()

                                 LEFT JOIN tmpUser_findPersonal ON tmpUser_findPersonal.UserId = MovementLinkObject_User.ObjectId

                                 LEFT JOIN MovementFloat AS MovementFloat_TotalCount
                                                         ON MovementFloat_TotalCount.MovementId = Movement.Id
                                                        AND MovementFloat_TotalCount.DescId     = zc_MovementFloat_TotalCount()
                                 LEFT JOIN MovementFloat AS MovementFloat_TotalCountKg
                                                         ON MovementFloat_TotalCountKg.MovementId =  Movement.Id
                                                        AND MovementFloat_TotalCountKg.DescId     = zc_MovementFloat_TotalCountKg()

                            WHERE Movement.DescId   = zc_Movement_WeighingPartner()
                              -- AND Movement.Id = 7594708 
                              AND Movement.StatusId = zc_Enum_Status_Complete()
                              AND Movement.OperDate BETWEEN inStartDate AND inEndDate
                              AND (MovementLinkObject_Personal.ObjectId = inPersonalId OR tmpUser_findPersonal.PersonalId = inPersonalId OR inPersonalId = 0)
                              AND (COALESCE (tmpUser_findPersonal.BranchId, zc_Branch_Basis()) = inBranchId OR inBranchId = 0)
                           )
        -- ������ ���� ������� ���� ��� ������ inPersonalId, ���� �������� ��������� ��� ���������
      , tmpMovement_add AS (SELECT MovementLinkObject_Personal.MovementId
                                 , MovementLinkObject_Personal.ObjectId AS PersonalId
                            FROM MovementLinkObject AS MovementLinkObject_Personal
                            WHERE MovementLinkObject_Personal.MovementId IN (SELECT DISTINCT tmpMovement_all.MovementId FROM tmpMovement_all)
                              AND MovementLinkObject_Personal.DescId     IN (SELECT tmpListDesc.PersonalDescId FROM tmpListDesc)
                              AND inPersonalId <> 0
                           )
            -- ������������� � ...
          , tmpMovement AS (SELECT tmpMovement_all.MovementId
                                   -- ���� ������� ���� ��� ������ inPersonalId - �������� ��������� � ������ ����� ������ COUNT
                                 , COUNT (COALESCE (tmpMovement_add.PersonalId, tmpMovement_all.PersonalId)) :: TFloat AS CountPersonal
                            FROM tmpMovement_all
                                 LEFT JOIN tmpMovement_add ON tmpMovement_add.MovementId = tmpMovement_all.MovementId
                            GROUP BY tmpMovement_all.MovementId
                           )
         -- �������� �����
       , tmpMI AS (SELECT tmpMI.MovementId           AS MovementId
                          -- ���-�� ����� !!!��� �������������!!!
                        , COUNT (*)        :: TFloat AS CountMI
                          -- ���-�� ����� !!!��� ������������ - ���������!!!
                        , SUM (tmpMI.CountMI_detail) AS CountMI_detail

                   FROM (SELECT MovementItem.MovementId
                              , MovementItem.ObjectId AS GoodsId
                              , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                              , COUNT (*) :: TFloat AS CountMI_detail
                         FROM MovementItem
                              LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                               ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                              AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                         WHERE MovementItem.MovementId IN (SELECT DISTINCT tmpMovement.MovementId FROM tmpMovement)
                           AND MovementItem.DescId     = zc_MI_Master()
                           AND MovementItem.isErased   = FALSE
                         GROUP BY MovementItem.MovementId
                                , MovementItem.ObjectId
                                , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)
                        ) AS tmpMI
                   GROUP BY tmpMI.MovementId
                  )
        -- ���������
        SELECT  tmp.OperDate
              , tmp.UnitId
              , tmp.UnitCode
              , tmp.UnitName
              , tmp.PersonalId
              , tmp.PersonalCode
              , tmp.PersonalName
              , tmp.PositionId
              , tmp.PositionCode
              , tmp.PositionName

              , SUM (tmp.TotalCount)        :: TFloat AS TotalCount
              , SUM (tmp.TotalCountKg)      :: TFloat AS TotalCountKg
              , SUM (tmp.CountMI)           :: TFloat AS CountMI
              , SUM (tmp.CountMovement)     :: TFloat AS CountMovement

              , SUM (tmp.TotalCount1)       :: TFloat AS TotalCount1
              , SUM (tmp.TotalCountKg1)     :: TFloat AS TotalCountKg1
              , SUM (tmp.CountMI1)          :: TFloat AS CountMI1
              , SUM (tmp.CountMovement1)    :: TFloat AS CountMovement1

              , Object_Branch.ValueData AS BranchName

              , tmp.FromId
              , tmp.ToId

        FROM (-- ��� �������������
              SELECT CASE WHEN inIsDay = TRUE THEN tmpMovement_all.OperDate ELSE inEndDate END AS OperDate
                   , Object_Unit.Id             AS UnitId
                   , Object_Unit.ObjectCode     AS UnitCode
                   , Object_Unit.ValueData      AS UnitName
                   , Object_Personal.Id         AS PersonalId
                   , Object_Personal.ObjectCode AS PersonalCode
                   , Object_Personal.ValueData  AS PersonalName
                   , Object_Position.Id         AS PositionId
                   , Object_Position.ObjectCode AS PositionCode
                   , Object_Position.ValueData  AS PositionName

                   , CASE WHEN tmpMovement.CountPersonal > 0 THEN tmpMovement_all.TotalCount   / tmpMovement.CountPersonal :: TFloat ELSE tmpMovement_all.TotalCount   END AS TotalCount
                   , CASE WHEN tmpMovement.CountPersonal > 0 THEN tmpMovement_all.TotalCountKg / tmpMovement.CountPersonal :: TFloat ELSE tmpMovement_all.TotalCountKg END AS TotalCountKg
                   , CASE WHEN tmpMovement.CountPersonal > 0 THEN tmpMI.CountMI                / tmpMovement.CountPersonal :: TFloat ELSE tmpMI.CountMI                END AS CountMI
                   , CASE WHEN tmpMovement.CountPersonal > 0 THEN 1                            / tmpMovement.CountPersonal :: TFloat ELSE 1                            END AS CountMovement
                   -- , 1 AS CountMovement

                   , 0 AS TotalCount1
                   , 0 AS TotalCountKg1
                   , 0 AS CountMI1
                   , 0 AS CountMovement1

                   , tmpMovement_all.BranchId
                   , tmpMovement_all.FromId
                   , tmpMovement_all.ToId

              FROM tmpMovement_all
                   INNER JOIN tmpPersonal_all          ON tmpPersonal_all.PersonalId = tmpMovement_all.PersonalId
                   LEFT JOIN Object AS Object_Unit     ON Object_Unit.Id             = tmpPersonal_all.UnitId
                   LEFT JOIN Object AS Object_Personal ON Object_Personal.Id         = tmpPersonal_all.PersonalId
                   LEFT JOIN Object AS Object_Position ON Object_Position.Id         = tmpPersonal_all.PositionId

                   INNER JOIN tmpMovement ON tmpMovement.MovementId = tmpMovement_all.MovementId
                   INNER JOIN tmpMI       ON tmpMI.MovementId       = tmpMovement_all.MovementId

             UNION ALL
              -- ��� ������������ - ���������
              SELECT CASE WHEN inIsDay = TRUE THEN tmpMovement_all.OperDate ELSE inEndDate END AS OperDate

                   , Object_Unit.Id             AS UnitId
                   , Object_Unit.ObjectCode     AS UnitCode
                   , Object_Unit.ValueData      AS UnitName
                   , Object_Personal.Id         AS PersonalId
                   , Object_Personal.ObjectCode AS PersonalCode
                   , Object_Personal.ValueData  AS PersonalName
                   , Object_Position.Id         AS PositionId
                   , Object_Position.ObjectCode AS PositionCode
                   , Object_Position.ValueData  AS PositionName

                   , 0 AS TotalCount
                   , 0 AS TotalCountKg
                   , 0 AS CountMI
                   , 0 AS CountMovement

                   , tmpMovement_all.TotalCount   AS TotalCount
                   , tmpMovement_all.TotalCountKg AS TotalCountKg
                   , tmpMI.CountMI_detail         AS CountMI1
                   , 1                            AS CountMovement1

                   , tmpMovement_all.BranchId
                   , tmpMovement_all.FromId
                   , tmpMovement_all.ToId

              FROM (SELECT DISTINCT tmpMovement_all.MovementId, tmpMovement_all.OperDate, tmpMovement_all.UserId, tmpMovement_all.TotalCount, tmpMovement_all.TotalCountKg, tmpMovement_all.BranchId, tmpMovement_all.FromId, tmpMovement_all.ToId FROM tmpMovement_all) AS tmpMovement_all
                    LEFT JOIN tmpUser_findPersonal ON tmpUser_findPersonal.UserId = tmpMovement_all.UserId

                    LEFT JOIN Object AS Object_Unit     ON Object_Unit.Id             = tmpUser_findPersonal.UnitId
                    LEFT JOIN Object AS Object_Personal ON Object_Personal.Id         = COALESCE (tmpUser_findPersonal.PersonalId, tmpMovement_all.UserId)
                    LEFT JOIN Object AS Object_Position ON Object_Position.Id         = tmpUser_findPersonal.PositionId

                    INNER JOIN tmpMI       ON tmpMI.MovementId       = tmpMovement_all.MovementId

              WHERE tmpUser_findPersonal.UserId > 0 OR inPersonalId = 0

            ) AS tmp

            LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = tmp.BranchId

        GROUP BY tmp.OperDate
               , tmp.UnitId
               , tmp.UnitCode
               , tmp.UnitName
               , tmp.PersonalId
               , tmp.PersonalCode
               , tmp.PersonalName
               , tmp.PositionId
               , tmp.PositionCode
               , tmp.PositionName
               , Object_Branch.ValueData
               , tmp.FromId
               , tmp.ToId
                ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 26.11.17                                        * all
 15.12.15         * add Branch
 27.05.15         *
*/

-- ����
-- SELECT * FROM gpReport_PersonalComplete (inStartDate:= '01.10.2017', inEndDate:= '31.10.2017', inPersonalId:= 0, inPositionId:= 0, inBranchId:= 0, inIsDay:= FALSE, inIsDetail:= FALSE, inSession:= zfCalc_UserAdmin())
-- SELECT * FROM gpReport_PersonalComplete (inStartDate:= '01.11.2017', inEndDate:= '02.11.2017', inPersonalId:= 0, inPositionId:= 0, inBranchId:= 0, inIsDay:= FALSE, inIsDetail:= FALSE, inSession:= zfCalc_UserAdmin())
