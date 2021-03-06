-- Function: gpSelect_Scale_Personal()

DROP FUNCTION IF EXISTS gpSelect_Scale_Personal (TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Scale_Personal(
    IN inSession     TVarChar      -- ������ ������������
)
RETURNS TABLE (PersonalId     Integer
             , PersonalCode   Integer
             , PersonalName   TVarChar
             , PositionId     Integer
             , PositionCode   Integer
             , PositionName   TVarChar
             , UnitId         Integer
             , UnitCode       Integer
             , UnitName       TVarChar
             , IsErased       Boolean
              )
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbIsConstraint Boolean;
   DECLARE vbBranchId_Constraint Integer;
BEGIN
   -- �������� ���� ������������ �� ����� ���������
   -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Scale_Personal());
   vbUserId:= lpGetUserBySession (inSession);


   -- ������������ ������� �������
   vbBranchId_Constraint:= COALESCE ((SELECT Object_RoleAccessKeyGuide_View.BranchId FROM Object_RoleAccessKeyGuide_View WHERE Object_RoleAccessKeyGuide_View.UserId = vbUserId AND Object_RoleAccessKeyGuide_View.BranchId <> 0 GROUP BY Object_RoleAccessKeyGuide_View.BranchId), 0);
   vbIsConstraint:= vbBranchId_Constraint > 0;

    -- ���������
    RETURN QUERY
       WITH tmpPersonal AS (SELECT View_Personal.PersonalId
                                 , View_Personal.PersonalCode
                                 , View_Personal.PersonalName
                                 , View_Personal.PositionId
                                 , View_Personal.PositionCode
                                 , View_Personal.PositionName
                                 , View_Personal.UnitId
                                 , View_Personal.UnitCode
                                 , View_Personal.UnitName
                                 , View_Personal.IsErased
                                 , ROW_NUMBER() OVER (PARTITION BY View_Personal.PersonalCode ORDER BY CASE WHEN View_Personal.PositionId = 12939 THEN 1 ELSE 0 END, View_Personal.PersonalId) AS Ord
                            FROM Object_Personal_View AS View_Personal
                            WHERE View_Personal.IsErased = FALSE
                              AND View_Personal.isDateOut = FALSE
                              AND ((vbIsConstraint = FALSE
                                AND View_Personal.UnitId IN (8459 -- ����� ����������
                                                           , 8461 -- ����� ���������
                                                            )
                                AND View_Personal.PositionId IN (12970 -- ���������
                                                               , 12964 -- ��������� ����
                                                               , 12981 -- ��������� ���������
                                                               , 12971 -- ��������� ����
                                                               , 18315 -- �������������
                                                               , 12943 -- ���. ������ ������������
                                                               , 12988 -- ������������
                                                               , 12939 -- ������� ����������
                                                               -- , 12982 -- ������� ���������
                                                                )
                                   )
                                OR (View_Personal.BranchId = vbBranchId_Constraint
                                AND vbIsConstraint = TRUE)
                                OR (View_Personal.PositionId IN (8466 -- ��������
                                                               , 81178 -- ����������
                                                                )
                                  ))
                           )

       -- ���������
       SELECT tmpPersonal.PersonalId
            , tmpPersonal.PersonalCode
            , tmpPersonal.PersonalName
            , tmpPersonal.PositionId
            , tmpPersonal.PositionCode
            , tmpPersonal.PositionName
            , tmpPersonal.UnitId
            , tmpPersonal.UnitCode
            , tmpPersonal.UnitName
            , tmpPersonal.IsErased
       FROM tmpPersonal
       WHERE tmpPersonal.Ord = 1
       ORDER BY tmpPersonal.PersonalName
              , tmpPersonal.PositionName
      ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Scale_Personal (TVarChar) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 17.05.15                                        *
*/

-- ����
-- SELECT * FROM gpSelect_Scale_Personal (zfCalc_UserAdmin())
