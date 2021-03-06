-- Function: gpGet_Movement_WeighingPartner (Integer, TVarChar)

DROP FUNCTION IF EXISTS gpGet_Movement_WeighingPartner (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpGet_Movement_WeighingPartner(
    IN inMovementId        Integer  , -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS TABLE (Id Integer, InvNumber TVarChar, OperDate TDateTime, StatusCode Integer, StatusName TVarChar
             , MovementId_parent Integer, OperDate_parent TDateTime, InvNumber_parent TVarChar
             , StartWeighing TDateTime, EndWeighing TDateTime
             , MovementId_Order Integer, InvNumberOrder TVarChar
             , PartionGoods TVarChar
             , WeighingNumber TFloat
             , MovementId_Transport Integer, InvNumber_Transport TVarChar, OperDate_Transport TDateTime
             , PriceWithVAT Boolean, VATPercent TFloat, ChangePercent TFloat
             , MovementDescId Integer
             , MovementDescNumber Integer, MovementDescName TVarChar
             , DescId_from Integer, FromId Integer, FromName TVarChar
             , DescId_to Integer, ToId Integer, ToName TVarChar
             , JuridicalId Integer, JuridicalName TVarChar
             , PaidKindId Integer, PaidKindName TVarChar
             , ContractId Integer, ContractName TVarChar, ContractTagName TVarChar
             , UserId Integer, UserName TVarChar
             , MemberId Integer, MemberName TVarChar
             , isPromo Boolean
              )
AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId := lpCheckRight (inSession, zc_Enum_Process_Get_Movement_WeighingPartner());
     vbUserId:= lpGetUserBySession (inSession);

     IF COALESCE (inMovementId, 0) = 0
     THEN
         RAISE EXCEPTION '������.��� ����.';
     ELSE
       RETURN QUERY
       SELECT  Movement.Id
             , Movement.InvNumber
             , Movement.OperDate
             , Object_Status.ObjectCode          AS StatusCode
             , Object_Status.ValueData           AS StatusName

             , Movement_Parent.Id                AS MovementId_parent
             , Movement_Parent.OperDate          AS OperDate_parent
             , Movement_Parent.InvNumber         AS InvNumber_parent

             , MovementDate_StartWeighing.ValueData  AS StartWeighing
             , MovementDate_EndWeighing.ValueData    AS EndWeighing

             , MovementLinkMovement_Order.MovementChildId AS MovementId_Order
             , CASE WHEN MovementLinkMovement_Order.MovementChildId IS NOT NULL
                         THEN CASE WHEN Movement_Order.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Complete())
                                        THEN ''
                                   ELSE '???'
                              END
                           || CASE WHEN TRIM (COALESCE (MovementString_InvNumberPartner_Order.ValueData, '')) <> ''
                                        THEN MovementString_InvNumberPartner_Order.ValueData
                                   ELSE '***' || Movement_Order.InvNumber
                              END
                    ELSE MovementString_InvNumberOrder.ValueData
               END :: TVarChar AS InvNumberOrder
             , MovementString_PartionGoods.ValueData      AS PartionGoods

             , MovementFloat_WeighingNumber.ValueData     AS WeighingNumber

             , Movement_Transport.Id                     AS MovementId_Transport
             , Movement_Transport.InvNumber              AS InvNumber_Transport
             , Movement_Transport.OperDate               AS OperDate_Transport

             , COALESCE (MovementBoolean_PriceWithVAT.ValueData, FALSE) :: Boolean AS PriceWithVAT
             , MovementFloat_VATPercent.ValueData             AS VATPercent
             , MovementFloat_ChangePercent.ValueData          AS ChangePercent

             , MovementFloat_MovementDesc.ValueData :: Integer AS MovementDescId
             , MovementFloat_MovementDescNumber.ValueData :: Integer AS MovementDescNumber
             , MovementDesc.ItemName                      AS MovementDescName

             , Object_From.DescId                   AS DescId_from
             , Object_From.Id                       AS FromId
             , Object_From.ValueData                AS FromName
             , Object_To.DescId                     AS DescId_to
             , Object_To.Id                         AS ToId
             , Object_To.ValueData                  AS ToName
             , CASE WHEN Object_To.DescId = zc_Object_Partner() THEN ObjectLink_To_Juridical.ChildObjectId
                    WHEN Object_From.DescId = zc_Object_Partner() THEN ObjectLink_From_Juridical.ChildObjectId
                    ELSE 0
               END AS JuridicalId
             , CASE WHEN Object_To.DescId = zc_Object_Partner() THEN Object_JuridicalTo.ValueData
                    WHEN Object_From.DescId = zc_Object_Partner() THEN Object_JuridicalFrom.ValueData
                    ELSE ''
               END :: TVarChar AS JuridicalName

             , Object_PaidKind.Id                   AS PaidKindId
             , Object_PaidKind.ValueData            AS PaidKindName
             , MovementLinkObject_Contract.ObjectId AS ContractId
             , View_Contract_InvNumber.InvNumber    AS ContractName
             , View_Contract_InvNumber.ContractTagName

             , Object_User.Id                     AS UserId
             , Object_User.ValueData              AS UserName

             , Object_Member.Id                   AS MemberId
             , Object_Member.ValueData            AS MemberName

             , COALESCE (MovementBoolean_Promo.ValueData, FALSE) AS isPromo

       FROM Movement
            LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement.StatusId

            LEFT JOIN Movement AS Movement_Parent ON Movement_Parent.Id = Movement.ParentId

            LEFT JOIN MovementDate AS MovementDate_StartWeighing
                                   ON MovementDate_StartWeighing.MovementId = Movement.Id
                                  AND MovementDate_StartWeighing.DescId = zc_MovementDate_StartWeighing()
            LEFT JOIN MovementDate AS MovementDate_EndWeighing
                                   ON MovementDate_EndWeighing.MovementId = Movement.Id
                                  AND MovementDate_EndWeighing.DescId = zc_MovementDate_EndWeighing()

            LEFT JOIN MovementFloat AS MovementFloat_WeighingNumber
                                    ON MovementFloat_WeighingNumber.MovementId = Movement.Id
                                   AND MovementFloat_WeighingNumber.DescId = zc_MovementFloat_WeighingNumber()

            LEFT JOIN MovementString AS MovementString_InvNumberOrder
                                     ON MovementString_InvNumberOrder.MovementId = Movement.Id
                                    AND MovementString_InvNumberOrder.DescId = zc_MovementString_InvNumberOrder()
            LEFT JOIN MovementString AS MovementString_PartionGoods
                                     ON MovementString_PartionGoods.MovementId = Movement.Id
                                    AND MovementString_PartionGoods.DescId = zc_MovementString_PartionGoods()

            LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                                      ON MovementBoolean_PriceWithVAT.MovementId =  Movement.Id
                                     AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()
            LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                                    ON MovementFloat_VATPercent.MovementId =  Movement.Id
                                   AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
            LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                                    ON MovementFloat_ChangePercent.MovementId =  Movement.Id
                                   AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()

            LEFT JOIN MovementFloat AS MovementFloat_MovementDescNumber
                                    ON MovementFloat_MovementDescNumber.MovementId =  Movement.Id
                                   AND MovementFloat_MovementDescNumber.DescId = zc_MovementFloat_MovementDescNumber()
            LEFT JOIN MovementFloat AS MovementFloat_MovementDesc
                                    ON MovementFloat_MovementDesc.MovementId =  Movement.Id
                                   AND MovementFloat_MovementDesc.DescId = zc_MovementFloat_MovementDesc()
            LEFT JOIN MovementDesc ON MovementDesc.Id = MovementFloat_MovementDesc.ValueData :: Integer -- COALESCE (Movement_Parent.DescId, MovementFloat_MovementDesc.ValueData)

            LEFT JOIN MovementBoolean AS MovementBoolean_Promo
                                      ON MovementBoolean_Promo.MovementId =  Movement.Id
                                     AND MovementBoolean_Promo.DescId = zc_MovementBoolean_Promo()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = Movement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = Movement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId

            LEFT JOIN ObjectLink AS ObjectLink_From_Juridical
                                 ON ObjectLink_From_Juridical.ObjectId = Object_From.Id
                                AND ObjectLink_From_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
            LEFT JOIN Object AS Object_JuridicalFrom ON Object_JuridicalFrom.Id = ObjectLink_From_Juridical.ChildObjectId
            LEFT JOIN ObjectLink AS ObjectLink_To_Juridical
                                 ON ObjectLink_To_Juridical.ObjectId = Object_To.Id
                                AND ObjectLink_To_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
            LEFT JOIN Object AS Object_JuridicalTo ON Object_JuridicalTo.Id = ObjectLink_To_Juridical.ChildObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_PaidKind
                                         ON MovementLinkObject_PaidKind.MovementId = Movement.Id
                                        AND MovementLinkObject_PaidKind.DescId = zc_MovementLinkObject_PaidKind()
            LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = MovementLinkObject_PaidKind.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_User
                                         ON MovementLinkObject_User.MovementId = Movement.Id
                                        AND MovementLinkObject_User.DescId = zc_MovementLinkObject_User()
            LEFT JOIN Object AS Object_User ON Object_User.Id = MovementLinkObject_User.ObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Member
                                         ON MovementLinkObject_Member.MovementId = Movement.Id
                                        AND MovementLinkObject_Member.DescId = zc_MovementLinkObject_Member()
            LEFT JOIN Object AS Object_Member ON Object_Member.Id = MovementLinkObject_Member.ObjectId

            LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Order
                                           ON MovementLinkMovement_Order.MovementId = Movement.Id
                                          AND MovementLinkMovement_Order.DescId = zc_MovementLinkMovement_Order()
            LEFT JOIN Movement AS Movement_Order ON Movement_Order.Id = MovementLinkMovement_Order.MovementChildId
            LEFT JOIN MovementString AS MovementString_InvNumberPartner_Order
                                     ON MovementString_InvNumberPartner_Order.MovementId =  Movement_Order.Id
                                    AND MovementString_InvNumberPartner_Order.DescId = zc_MovementString_InvNumberPartner()

            LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Transport
                                           ON MovementLinkMovement_Transport.MovementId = Movement.Id
                                          AND MovementLinkMovement_Transport.DescId = zc_MovementLinkMovement_Transport()
            LEFT JOIN Movement AS Movement_Transport ON Movement_Transport.Id = MovementLinkMovement_Transport.MovementChildId

       WHERE Movement.Id =  inMovementId
         AND Movement.DescId = zc_Movement_WeighingPartner();
     END IF;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpGet_Movement_WeighingPartner (Integer, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 15.03.17         * add Member
 01.12.15         * add Promo
 11.10.14                                        * all
 11.03.14         *
*/

-- ����
-- SELECT * FROM gpGet_Movement_WeighingPartner (inMovementId := 1, inSession:= zfCalc_UserAdmin())
