-- Function: gpSelect_Movement_Inventory()

DROP FUNCTION IF EXISTS gpSelect_Movement_Inventory (TDateTime, TDateTime, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_Inventory(
    IN inStartDate   TDateTime , --� ����
    IN inEndDate     TDateTime , --�� ����
    IN inIsErased    Boolean ,   --��� �� ���������
    IN inSession     TVarChar    --������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, OperDate TDateTime, StatusCode Integer, StatusName TVarChar
             , DeficitSumm TFloat, ProficitSumm TFloat, Diff TFloat, DiffSumm TFloat
             , UnitId Integer, UnitName TVarChar, FullInvent Boolean
             , Diff_calc TFloat, DeficitSumm_calc TFloat, ProficitSumm_calc TFloat, DiffSumm_calc TFloat
             )
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbObjectId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Inventory());
     vbUserId:= lpGetUserBySession (inSession);
     
     -- ������������ <�������� ����>
     vbObjectId:= lpGet_DefaultValue ('zc_Object_Retail', vbUserId);

     RETURN QUERY
     WITH tmpStatus AS (SELECT zc_Enum_Status_Complete()   AS StatusId
                  UNION SELECT zc_Enum_Status_UnComplete() AS StatusId
                  UNION SELECT zc_Enum_Status_Erased()     AS StatusId WHERE inIsErased = TRUE
                       )

        , tmpUnit  AS  (SELECT ObjectLink_Unit_Juridical.ObjectId AS UnitId
                        FROM ObjectLink AS ObjectLink_Unit_Juridical
                           INNER JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                                 ON ObjectLink_Juridical_Retail.ObjectId = ObjectLink_Unit_Juridical.ChildObjectId
                                                AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                                                AND ObjectLink_Juridical_Retail.ChildObjectId = vbObjectId
                        WHERE  ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                        )

        , tmpMovement_calc AS (SELECT Movement.Id
                                    , SUM (MovementItemContainer.Amount) AS Diff
                                    , SUM (CASE WHEN MovementItemContainer.Amount < 0 THEN -1 * MovementItemContainer.Amount * COALESCE (MovementItemFloat.ValueData, 0) ELSE 0 END) AS DeficitSumm
                                    , SUM (CASE WHEN MovementItemContainer.Amount > 0 THEN  1 * MovementItemContainer.Amount * COALESCE (MovementItemFloat.ValueData, 0) ELSE 0 END) AS ProficitSumm
                               FROM Movement
                                    INNER JOIN MovementItemContainer ON MovementItemContainer.MovementId = Movement.Id
                                                                    AND MovementItemContainer.DescId     = zc_MIContainer_Count()
                                    LEFT JOIN MovementItemFloat ON MovementItemFloat.MovementItemId = MovementItemContainer.MovementItemId
                                                               AND MovementItemFloat.DescId         = zc_MIFloat_Price()
                               WHERE Movement.OperDate BETWEEN inStartDate AND inEndDate 
                                 AND Movement.DescId = zc_Movement_Inventory()
                               GROUP BY Movement.Id
                              )
       -- ���������
       SELECT
             Movement.Id                                          AS Id
           , Movement.InvNumber                                   AS InvNumber
           , Movement.OperDate                                    AS OperDate
           , Object_Status.ObjectCode                             AS StatusCode
           , Object_Status.ValueData                              AS StatusName
           , MovementFloat_DeficitSumm.ValueData                  AS DeficitSumm
           , MovementFloat_ProficitSumm.ValueData                 AS ProficitSumm
           , MovementFloat_Diff.ValueData                         AS Diff
           , MovementFloat_DiffSumm.ValueData                     AS DiffSumm
           , Object_Unit.Id                                       AS UnitId
           , Object_Unit.ValueData                                AS UnitName
           , COALESCE(MovementBoolean_FullInvent.ValueData,False) AS FullInvent

           , tmpMovement_calc.Diff         :: TFloat AS Diff_calc
           , tmpMovement_calc.DeficitSumm  :: TFloat AS DeficitSumm_calc
           , tmpMovement_calc.ProficitSumm :: TFloat AS ProficitSumm_calc
           , (tmpMovement_calc.ProficitSumm - tmpMovement_calc.DeficitSumm) :: TFloat AS DiffSumm_calc

       FROM (SELECT Movement.Id
                  , MovementLinkObject_Unit.ObjectId AS UnitId
             FROM tmpStatus
                  JOIN Movement ON Movement.OperDate BETWEEN inStartDate AND inEndDate 
                               AND Movement.DescId = zc_Movement_Inventory() AND Movement.StatusId = tmpStatus.StatusId
                  LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                               ON MovementLinkObject_Unit.MovementId = Movement.Id
                                              AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                  INNER JOIN tmpUnit ON tmpUnit.UnitId = MovementLinkObject_Unit.ObjectId
            ) AS tmpMovement
            LEFT JOIN tmpMovement_calc ON tmpMovement_calc.Id = tmpMovement.Id
            LEFT JOIN Movement ON Movement.Id = tmpMovement.Id
            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmpMovement.UnitId
            
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

/*            LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                         ON MovementLinkObject_Unit.MovementId = Movement.Id
                                        AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
            LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = MovementLinkObject_Unit.ObjectId
*/
            LEFT OUTER JOIN MovementBoolean AS MovementBoolean_FullInvent
                                            ON MovementBoolean_FullInvent.MovementId = Movement.Id
                                           AND MovementBoolean_FullInvent.DescId = zc_MovementBoolean_FullInvent()

            LEFT OUTER JOIN MovementFloat AS MovementFloat_DeficitSumm
                                          ON MovementFloat_DeficitSumm.MovementId = Movement.Id
                                         AND MovementFloat_DeficitSumm.DescId = zc_MovementFloat_TotalDeficitSumm()
            LEFT OUTER JOIN MovementFloat AS MovementFloat_ProficitSumm
                                          ON MovementFloat_ProficitSumm.MovementId = Movement.Id
                                         AND MovementFloat_ProficitSumm.DescId = zc_MovementFloat_TotalProficitSumm()
            LEFT OUTER JOIN MovementFloat AS MovementFloat_Diff
                                          ON MovementFloat_Diff.MovementId = Movement.Id
                                         AND MovementFloat_Diff.DescId = zc_MovementFloat_TotalDiff()
            LEFT OUTER JOIN MovementFloat AS MovementFloat_DiffSumm
                                          ON MovementFloat_DiffSumm.MovementId = Movement.Id
                                         AND MovementFloat_DiffSumm.DescId = zc_MovementFloat_TotalDiffSumm()
            ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Movement_Inventory (TDateTime, TDateTime, Boolean, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.A.   ��������� �.�.
 04.05.16         *
 16.09.15                                                                       * + FullInvent
 11.07.15                                                                       *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_Inventory (inStartDate:= '30.01.2013', inEndDate:= '01.02.2013', inIsErased:= FALSE, inSession:= '2')
