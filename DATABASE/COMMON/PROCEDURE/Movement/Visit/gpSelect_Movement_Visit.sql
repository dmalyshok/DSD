-- Function: gpSelect_Movement_Visit()

DROP FUNCTION IF EXISTS gpSelect_Movement_Visit(TDateTime, TDateTime, Boolean, Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_Visit (
    IN inStartDate        TDateTime , --
    IN inEndDate          TDateTime , --
    IN inIsErased         Boolean   ,
    IN inJuridicalBasisId Integer   ,
    IN inMemberId         Integer   ,
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE (Id Integer
             , InvNumber TVarChar
             , OperDate TDateTime
             , StatusCode Integer, StatusName TVarChar
             , InsertDate TDateTime
             , InsertMobileDate TDateTime
             , InsertName TVarChar
             , PartnerName TVarChar
             , GUID TVarChar
             , Comment TVarChar
              )
AS
$BODY$
   DECLARE vbUserId      Integer;

   DECLARE vbMemberId Integer;
   DECLARE vbPersonalId Integer;
BEGIN
      -- �������� ���� ������������ �� ����� ���������
      -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Visit());
      vbUserId := lpGetUserBySession(inSession);

     SELECT tmp.MemberId, tmp.PersonalId
     INTO vbMemberId, vbPersonalId     
     FROM gpGetMobile_Object_Const (inSession) AS tmp;

     IF (COALESCE(inMemberId,0) <> 0 AND COALESCE(vbMemberId,0) <> inMemberId)
        THEN
            RAISE EXCEPTION '������.�� ���������� ���� �������.'; 
     END IF;

      -- ���������
      RETURN QUERY
        WITH tmpStatus AS (SELECT zc_Enum_Status_Complete()   AS StatusId
                           UNION 
                           SELECT zc_Enum_Status_UnComplete() AS StatusId
                           UNION 
                           SELECT zc_Enum_Status_Erased()     AS StatusId WHERE inIsErased = TRUE
                          )
        , tmpPartner AS (SELECT ObjectLink_Partner_PersonalTrade.ObjectId AS PartnerId
                         FROM ObjectLink AS ObjectLink_Partner_PersonalTrade
                         WHERE ObjectLink_Partner_PersonalTrade.DescId = zc_ObjectLink_Partner_PersonalTrade()
                           AND ObjectLink_Partner_PersonalTrade.ChildObjectId = vbPersonalId --301468 --
                         )

        SELECT Movement.Id
             , Movement.InvNumber    
             , Movement.OperDate       
             , Object_Status.ObjectCode               AS StatusCode
             , Object_Status.ValueData                AS StatusName
             , MovementDate_Insert.ValueData          AS InsertDate
             , MovementDate_InsertMobile.ValueData    AS InsertMobileDate
             , Object_User.ValueData                  AS InsertName
             , Object_Partner.ValueData               AS PartnerName
             , MovementString_GUID.ValueData          AS GUID
             , MovementString_Comment.ValueData       AS Comment
        FROM (SELECT Movement.Id
              FROM tmpStatus
                   JOIN Movement ON Movement.OperDate BETWEEN inStartDate AND inEndDate 
                                AND Movement.DescId = zc_Movement_Visit() 
                                AND Movement.StatusId = tmpStatus.StatusId
             ) AS tmpMovement
             LEFT JOIN Movement ON Movement.Id = tmpMovement.Id

             LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

             LEFT JOIN MovementDate AS MovementDate_Insert 
                                    ON MovementDate_Insert.MovementId = Movement.Id
                                   AND MovementDate_Insert.DescId = zc_MovementDate_Insert()
             LEFT JOIN MovementDate AS MovementDate_InsertMobile 
                                    ON MovementDate_InsertMobile.MovementId = Movement.Id
                                   AND MovementDate_InsertMobile.DescId = zc_MovementDate_InsertMobile()

             LEFT JOIN MovementLinkObject AS MovementLinkObject_Insert 
                                          ON MovementLinkObject_Insert.MovementId = Movement.Id
                                         AND MovementLinkObject_Insert.DescId = zc_MovementLinkObject_Insert()
             LEFT JOIN Object AS Object_User ON Object_User.Id = MovementLinkObject_Insert.ObjectId

             LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                          ON MovementLinkObject_Partner.MovementId = Movement.Id
                                         AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
             LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = MovementLinkObject_Partner.ObjectId
             LEFT JOIN tmpPartner ON tmpPartner.PartnerId = Object_Partner.Id

             LEFT JOIN MovementString AS MovementString_Comment
                                      ON MovementString_Comment.MovementId = Movement.Id
                                     AND MovementString_Comment.DescId = zc_MovementString_Comment()
             LEFT JOIN MovementString AS MovementString_GUID
                                      ON MovementString_GUID.MovementId = Movement.Id
                                     AND MovementString_GUID.DescId = zc_MovementString_GUID()
        WHERE (tmpPartner.PartnerId IS NOT NULL AND COALESCE(inMemberId,0) <> 0) OR COALESCE(inMemberId,0) = 0 
;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   �������� �.�.
 26.03.17         *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_Visit(inStartDate:= '01.01.2017', inEndDate:= CURRENT_DATE, inIsErased:= FALSE, inJuridicalBasisId:= 0, inSession := zfCalc_UserAdmin())
