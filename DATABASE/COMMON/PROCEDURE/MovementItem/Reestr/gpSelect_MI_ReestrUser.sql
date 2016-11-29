-- Function: gpSelect_MI_ReestrUser()

DROP FUNCTION IF EXISTS gpSelect_MI_ReestrUser(TDateTime, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_ReestrUser(
    IN inStartDate          TDateTime , 
    IN inEndDate            TDateTime , 
    IN inReestrKindId       Integer   ,
    IN inSession            TVarChar    -- ������ ������������
)
RETURNS TABLE ( Id Integer, MovementId Integer, LineNum Integer
              , StatusCode Integer, StatusName TVarChar
              , OperDate TDateTime, InvNumber TVarChar
              , CarName TVarChar, CarModelName TVarChar
              , PersonalDriverName TVarChar
              , MemberName TVarChar
              , UpdateName TVarChar, UpdateDate TDateTime
              , InvNumber_Transport TVarChar, OperDate_Transport TDateTime, StatusCode_Transport Integer, StatusName_Transport TVarChar
              , Date_Insert TDateTime, MemberName_Insert TVarChar
              , BarCode_Sale TVarChar, OperDate_Sale TDateTime, InvNumber_Sale TVarChar
              , OperDatePartner TDateTime, InvNumberPartner TVarChar, StatusCode_Sale Integer, StatusName_Sale TVarChar
              , TotalSumm TFloat
              , FromName TVarChar, ToName TVarChar
              , PaidKindName TVarChar
              , ContractCode Integer, ContractName TVarChar, ContractTagName TVarChar
              , JuridicalName_To TVarChar, OKPO_To TVarChar 
              , ReestrKindName TVarChar
               )
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbMemberId_user  Integer;
   DECLARE vbDateDescId     Integer;
   DECLARE vbMILinkObjectId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpGetUserBySession (inSession);


     -- ������������
     vbDateDescId := (SELECT CASE WHEN inReestrKindId = zc_Enum_ReestrKind_PartnerIn() THEN zc_MIDate_PartnerIn()
                                  WHEN inReestrKindId = zc_Enum_ReestrKind_RemakeIn()  THEN zc_MIDate_RemakeIn()  
                                  WHEN inReestrKindId = zc_Enum_ReestrKind_RemakeBuh() THEN zc_MIDate_RemakeBuh()
                                  WHEN inReestrKindId = zc_Enum_ReestrKind_Remake()    THEN zc_MIDate_Remake() 
                                  WHEN inReestrKindId = zc_Enum_ReestrKind_Buh()       THEN zc_MIDate_Buh()
                             END AS DateDescId
                      );
     -- ������������
     vbMILinkObjectId := (SELECT CASE WHEN inReestrKindId = zc_Enum_ReestrKind_PartnerIn() THEN zc_MILinkObject_PartnerInTo()
                                      WHEN inReestrKindId = zc_Enum_ReestrKind_RemakeIn()  THEN zc_MILinkObject_RemakeInTo()  
                                      WHEN inReestrKindId = zc_Enum_ReestrKind_RemakeBuh() THEN zc_MILinkObject_RemakeBuh()
                                      WHEN inReestrKindId = zc_Enum_ReestrKind_Remake()    THEN zc_MILinkObject_Remake() 
                                      WHEN inReestrKindId = zc_Enum_ReestrKind_Buh()       THEN zc_MILinkObject_Buh()
                                 END AS MILinkObjectId
                      );

     -- ������������ <���������� ����> - ��� ����������� ���� inReestrKindId
     vbMemberId_user:= CASE WHEN vbUserId = 5 THEN 9457 ELSE
                       (SELECT ObjectLink_User_Member.ChildObjectId
                        FROM ObjectLink AS ObjectLink_User_Member
                        WHERE ObjectLink_User_Member.DescId = zc_ObjectLink_User_Member()
                          AND ObjectLink_User_Member.ObjectId = vbUserId)
                       END
                      ;
     -- ��������
     IF COALESCE (vbMemberId_user, 0) = 0
     THEN 
          RAISE EXCEPTION '������.� ������������ <%> �� ��������� �������� <���.����>.', lfGet_Object_ValueData (vbUserId);
     END IF;


     -- ���������
     RETURN QUERY
     WITH
         -- �������� ����� ������� - ��� ������ ������������
         tmpMI AS (SELECT MIDate.MovementItemId 
                        , MovementFloat_MovementItemId.MovementId AS MovementId_Sale
                   FROM MovementItemDate AS MIDate
                        INNER JOIN MovementItemLinkObject AS MILinkObject_PartnerIn
                                                          ON MILinkObject_PartnerIn.MovementItemId = MIDate.MovementItemId
                                                         AND MILinkObject_PartnerIn.DescId         = vbMILinkObjectId 
                                                         AND MILinkObject_PartnerIn.ObjectId       = vbMemberId_user 
                        LEFT JOIN MovementFloat AS MovementFloat_MovementItemId
                                                ON MovementFloat_MovementItemId.ValueData = MIDate.MovementItemId  
                                               AND MovementFloat_MovementItemId.DescId    = zc_MovementFloat_MovementItemId()
                   WHERE MIDate.DescId = vbDateDescId 
                     AND MIDate.ValueData >= inStartDate AND MIDate.ValueData < inEndDate + INTERVAL '1 DAY'
                   )
       -- ���������
       SELECT MovementItem.Id
            , MovementItem.MovementId           AS MovementId
            , CAST (ROW_NUMBER() OVER (ORDER BY MovementItem.Id) AS Integer) AS LineNum
            , Object_Status.ObjectCode          AS StatusCode
            , Object_Status.ValueData           AS StatusName
            , Movement_Reestr.OperDate                  AS OperDate
            , Movement_Reestr.InvNumber                 AS InvNumber
            , Object_Reestr_Car.ValueData               AS CarName
            , Object_CarModel.ValueData                 AS CarModelName
            , Object_Reestr_Personal.ValueData          AS PersonalDriverName
            , Object_Reestr_Member.ValueData            AS MemberName

            , Object_Update.ValueData           AS UpdateName
            , MovementDate_Update.ValueData     AS UpdateDate

            , Movement_Reestr_Transport.InvNumber      AS InvNumber_Transport
            , Movement_Reestr_Transport.OperDate       AS OperDate_Transport
            , Object_Status_Transport.ObjectCode       AS StatusCode_Transport
            , Object_Status_Transport.ValueData        AS StatusName_Transport
  
            , MIDate_Insert.ValueData                   AS Date_Insert
            , Object_Member.ValueData                   AS MemberName_Insert

            , zfFormat_BarCode (zc_BarCodePref_Movement(), Movement_Sale.Id) AS BarCode_Sale
            , Movement_Sale.OperDate                    AS OperDate_Sale
            , Movement_Sale.InvNumber                   AS InvNumber_Sale
            , MovementDate_OperDatePartner.ValueData    AS OperDatePartner
            , MovementString_InvNumberPartner.ValueData AS InvNumberPartner
            , Object_Status_Sale.ObjectCode             AS StatusCode_Sale
            , Object_Status_Sale.ValueData              AS StatusName_Sale

            , MovementFloat_TotalSumm.ValueData         AS TotalSumm

            , Object_From.ValueData                     AS FromName
            , Object_To.ValueData                       AS ToName   
            , Object_PaidKind.ValueData                 AS PaidKindName
            , View_Contract_InvNumber.ContractCode      AS ContractCode
            , View_Contract_InvNumber.InvNumber         AS ContractName
            , View_Contract_InvNumber.ContractTagName
            , Object_JuridicalTo.ValueData              AS JuridicalName_To
            , ObjectHistory_JuridicalDetails_View.OKPO  AS OKPO_To

            , Object_ReestrKind.ValueData               AS ReestrKindName    

       FROM tmpMI
            LEFT JOIN MovementItem ON MovementItem.Id = tmpMI.MovementItemId
            LEFT JOIN Object AS Object_Member ON Object_Member.Id = MovementItem.ObjectId
            LEFT JOIN Movement AS Movement_Reestr ON Movement_Reestr.Id = MovementItem.MovementId
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement_Reestr.StatusId
            
            LEFT JOIN MovementDate AS MovementDate_Update
                                   ON MovementDate_Update.MovementId = Movement_Reestr.Id
                                  AND MovementDate_Update.DescId = zc_MovementDate_Update()
            LEFT JOIN MovementLinkObject AS MLO_Update
                                         ON MLO_Update.MovementId = Movement_Reestr.Id
                                        AND MLO_Update.DescId = zc_MovementLinkObject_Update()
            LEFT JOIN Object AS Object_Update ON Object_Update.Id = MLO_Update.ObjectId  

            LEFT JOIN MovementLinkMovement AS MLM_Reestr_Transpor
                                           ON MLM_Reestr_Transpor.MovementId = Movement_Reestr.Id
                                          AND MLM_Reestr_Transpor.DescId = zc_MovementLinkMovement_Transport()
            LEFT JOIN Movement AS Movement_Reestr_Transport ON Movement_Reestr_Transport.Id = MLM_Reestr_Transpor.MovementChildId
            LEFT JOIN Object AS Object_Status_Transport ON Object_Status_Transport.Id = Movement_Reestr_Transport.StatusId

            LEFT JOIN MovementLinkObject AS MLO_Reestr_Car
                                         ON MLO_Reestr_Car.MovementId = Movement_Reestr.Id
                                        AND MLO_Reestr_Car.DescId = zc_MovementLinkObject_Car()
            LEFT JOIN Object AS Object_Reestr_Car ON Object_Reestr_Car.Id = MLO_Reestr_Car.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Car_CarModel
                                 ON ObjectLink_Car_CarModel.ObjectId = Object_Reestr_Car.Id
                                AND ObjectLink_Car_CarModel.DescId = zc_ObjectLink_Car_CarModel()
            LEFT JOIN Object AS Object_CarModel ON Object_CarModel.Id = ObjectLink_Car_CarModel.ChildObjectId

            LEFT JOIN MovementLinkObject AS MLO_Reestr_PersonalDriver
                                         ON MLO_Reestr_PersonalDriver.MovementId = Movement_Reestr.Id
                                        AND MLO_Reestr_PersonalDriver.DescId = zc_MovementLinkObject_PersonalDriver()
            LEFT JOIN Object AS Object_Reestr_Personal ON Object_Reestr_Personal.Id = MLO_Reestr_PersonalDriver.ObjectId
            --LEFT JOIN Object_Personal_View AS View_PersonalDriver ON View_PersonalDriver.PersonalId = MovementLinkObject_PersonalDriver.ObjectId

            LEFT JOIN MovementLinkObject AS MLO_Reestr_Member
                                         ON MLO_Reestr_Member.MovementId = Movement_Reestr.Id
                                        AND MLO_Reestr_Member.DescId = zc_MovementLinkObject_Member()
            LEFT JOIN Object AS Object_Reestr_Member ON Object_Reestr_Member.Id = MLO_Reestr_Member.ObjectId


            LEFT JOIN MovementItemDate AS MIDate_Insert
                                       ON MIDate_Insert.MovementItemId = MovementItem.Id
                                      AND MIDate_Insert.DescId = zc_MIDate_Insert()
            --
            LEFT JOIN Movement AS Movement_Sale ON Movement_Sale.id = tmpMI.MovementId_Sale  -- ���. �������
            LEFT JOIN Object AS Object_Status_Sale ON Object_Status_Sale.Id = Movement_Sale.StatusId
            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId = Movement_Sale.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId = Movement_Sale.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN MovementFloat AS MovementFloat_TotalSumm
                                    ON MovementFloat_TotalSumm.MovementId = Movement_Sale.Id
                                   AND MovementFloat_TotalSumm.DescId = zc_MovementFloat_TotalSumm()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            
            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                 ON ObjectLink_Partner_Juridical.ObjectId = Object_To.Id
                                AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
            LEFT JOIN Object AS Object_JuridicalTo ON Object_JuridicalTo.Id = ObjectLink_Partner_Juridical.ChildObjectId
            LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = Object_JuridicalTo.Id
           
            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_ReestrKind
                                         ON MovementLinkObject_ReestrKind.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_ReestrKind.DescId = zc_MovementLinkObject_ReestrKind()
            LEFT JOIN Object AS Object_ReestrKind ON Object_ReestrKind.Id = MovementLinkObject_ReestrKind.ObjectId
           ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 23.10.16         * 
*/

-- ����
-- SELECT * FROM gpSelect_MI_ReestrUser (inStartDate:= '24.10.2016', inEndDate:= '24.10.2016', inReestrKindId:= 736914,  inSession := '5');
