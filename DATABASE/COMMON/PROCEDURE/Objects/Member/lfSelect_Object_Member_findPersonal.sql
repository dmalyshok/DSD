-- Function: lfSelect_Object_Member_findPersonal (TVarChar)

DROP FUNCTION IF EXISTS lfSelect_Object_Member_findPersonal (TVarChar);

CREATE OR REPLACE FUNCTION lfSelect_Object_Member_findPersonal(
    IN inSession          TVarChar       -- ������ ������������
)
RETURNS TABLE (MemberId Integer, PersonalId Integer
             , UnitId   Integer, PositionId Integer
             , BranchId Integer, isDateOut  Boolean
             , Ord      Integer
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Object_Member());
   vbUserId:= lpGetUserBySession (inSession);

   -- ���������
   RETURN QUERY 
     WITH tmpPersonal AS (SELECT ObjectLink_Personal_Member.ChildObjectId   AS MemberId
                               , ObjectLink_Personal_Member.ObjectId        AS PersonalId
                               , ObjectLink_Personal_Unit.ChildObjectId     AS UnitId
                               , ObjectLink_Personal_Position.ChildObjectId AS PositionId
                               , ObjectLink_Unit_Branch.ChildObjectId       AS BranchId
                               , CASE WHEN COALESCE (ObjectDate_DateOut.ValueData, zc_DateEnd()) = zc_DateEnd() THEN FALSE ELSE TRUE END AS isDateOut
                               , ROW_NUMBER() OVER (PARTITION BY ObjectLink_Personal_Member.ChildObjectId
                                                    -- ����������� ������������ ��������� ��� ������, �.�. �������� � Ord = 1
                                                    ORDER BY CASE WHEN Object_Personal.isErased = FALSE THEN 0 ELSE 1 END
                                                           , CASE WHEN COALESCE (ObjectDate_DateOut.ValueData, zc_DateEnd()) = zc_DateEnd() THEN 0 ELSE 1 END
                                                           -- , CASE WHEN ObjectLink_Personal_PersonalServiceList.ChildObjectId > 0 THEN 0 ELSE 1 END
                                                           , CASE WHEN ObjectBoolean_Official.ValueData = TRUE THEN 0 ELSE 1 END
                                                           , CASE WHEN ObjectBoolean_Main.ValueData = TRUE THEN 0 ELSE 1 END
                                                           , ObjectLink_Personal_Member.ObjectId
                                                   ) AS Ord
                          FROM ObjectLink AS ObjectLink_Personal_Member
                               LEFT JOIN Object AS Object_Personal ON Object_Personal.Id = ObjectLink_Personal_Member.ObjectId
                               LEFT JOIN ObjectDate AS ObjectDate_DateOut
                                                    ON ObjectDate_DateOut.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                   AND ObjectDate_DateOut.DescId   = zc_ObjectDate_Personal_Out()          
                               LEFT JOIN ObjectLink AS ObjectLink_Personal_Unit
                                                    ON ObjectLink_Personal_Unit.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                   AND ObjectLink_Personal_Unit.DescId   = zc_ObjectLink_Personal_Unit()
                               LEFT JOIN ObjectLink AS ObjectLink_Personal_Position
                                                    ON ObjectLink_Personal_Position.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                   AND ObjectLink_Personal_Position.DescId = zc_ObjectLink_Personal_Position()
                               LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                                                    ON ObjectLink_Unit_Branch.ObjectId = ObjectLink_Personal_Unit.ChildObjectId
                                                   AND ObjectLink_Unit_Branch.DescId   = zc_ObjectLink_Unit_Branch()
                               -- LEFT JOIN ObjectLink AS ObjectLink_Personal_PersonalServiceList
                               --                      ON ObjectLink_Personal_PersonalServiceList.ObjectId = ObjectLink_Personal_Member.ObjectId
                               --                     AND ObjectLink_Personal_PersonalServiceList.DescId = zc_ObjectLink_Personal_PersonalServiceList()
                               LEFT JOIN ObjectBoolean AS ObjectBoolean_Official
                                                       ON ObjectBoolean_Official.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                      AND ObjectBoolean_Official.DescId   = zc_ObjectBoolean_Member_Official()
                               LEFT JOIN ObjectBoolean AS ObjectBoolean_Main
                                                       ON ObjectBoolean_Main.ObjectId = ObjectLink_Personal_Member.ObjectId
                                                      AND ObjectBoolean_Main.DescId   = zc_ObjectBoolean_Personal_Main()
                          WHERE ObjectLink_Personal_Member.ChildObjectId > 0
                            AND ObjectLink_Personal_Member.DescId        = zc_ObjectLink_Personal_Member()
                         )
     -- ���������
     SELECT tmpPersonal.MemberId
          , tmpPersonal.PersonalId
          , tmpPersonal.UnitId
          , tmpPersonal.PositionId
          , tmpPersonal.BranchId
          , tmpPersonal.isDateOut
          , tmpPersonal.Ord :: Integer AS Ord
     FROM tmpPersonal
     WHERE tmpPersonal.Ord = 1
    ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 10.03.17                                        *
*/

-- ����
-- SELECT * FROM lfSelect_Object_Member_findPersonal(zfCalc_UserAdmin())
