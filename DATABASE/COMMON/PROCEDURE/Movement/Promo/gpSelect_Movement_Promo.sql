-- Function: gpSelect_Movement_Promo()

DROP FUNCTION IF EXISTS gpSelect_Movement_Promo (TDateTime, TDateTime, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Movement_Promo (TDateTime, TDateTime, Boolean, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Movement_Promo (TDateTime, TDateTime, Boolean, Boolean, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_Promo(
    IN inStartDate         TDateTime , --
    IN inEndDate           TDateTime , --
    IN inIsErased          Boolean ,
    IN inPeriodForOperDate Boolean ,
    IN inJuridicalBasisId  Integer ,
    IN inSession           TVarChar    -- ������ ������������
)
RETURNS TABLE (Id               Integer     --�������������
             , InvNumber        Integer     --����� ���������
             , OperDate         TDateTime   --���� ���������
             , StatusCode       Integer     --��� �������
             , StatusName       TVarChar    --������
             , PromoKindId      Integer     --��� �����
             , PromoKindName    TVarChar    --��� �����
             , PriceListId      Integer     --����� ����
             , PriceListName    TVarChar    --����� ����
             , StartPromo       TDateTime   --���� ������ �����
             , EndPromo         TDateTime   --���� ��������� �����
             , StartSale        TDateTime   --���� ������ �������� �� ��������� ����
             , EndSale          TDateTime   --���� ��������� �������� �� ��������� ����
             , EndReturn        TDateTime   --���� ��������� ��������� �� ��������� ����
             , OperDateStart    TDateTime   --���� ������ ����. ������ �� �����
             , OperDateEnd      TDateTime   --���� ��������� ����. ������ �� �����
             , MonthPromo       TDateTime   --����� �����
             , CheckDate        TDateTime   --���� ������������
             , CostPromo        TFloat      --��������� ������� � �����
             , Comment          TVarChar    --����������
             , CommentMain      TVarChar    --���������� (�����)
             , UnitId           Integer     --�������������
             , UnitName         TVarChar    --�������������
             , PersonalTradeId  Integer     --������������� ������������� ������������� ������
             , PersonalTradeName TVarChar   --������������� ������������� ������������� ������
             , PersonalId       Integer     --������������� ������������� �������������� ������	
             , PersonalName     TVarChar    --������������� ������������� �������������� ������	
             , PartnerName      TVarChar     --�������
             , PartnerDescName  TVarChar     --��� ��������
             , ContractName     TVarChar     --� ��������
             , ContractTagName  TVarChar     --������� ��������
             , DayCount         Integer     --
             , isFirst          Boolean      --������ �������� � ������ (��� ������������� ������)
             , ChangePercentName TVarChar    -- ������ �� ��������
             , isPromo          Boolean     --����� (��/���)
             , Checked          Boolean     --����������� (��/���)
             , strSign        TVarChar -- ��� �������������. - ���� ��. �������
             , strSignNo      TVarChar -- ��� �������������. - ��������� ��. �������
              )

AS
$BODY$
   DECLARE vbUserId Integer;
BEGIN
    RETURN QUERY
        WITH tmpStatus AS (SELECT zc_Enum_Status_Complete()   AS StatusId
                     UNION SELECT zc_Enum_Status_UnComplete() AS StatusId
                     UNION SELECT zc_Enum_Status_Erased()     AS StatusId WHERE inIsErased = TRUE
                       )
           , tmpMovement AS (SELECT Movement_Promo.*
                                  , MovementDate_StartSale.ValueData            AS StartSale
                                  , MovementDate_EndSale.ValueData              AS EndSale
                             FROM Movement AS Movement_Promo 
                                  INNER JOIN tmpStatus ON Movement_Promo.StatusId = tmpStatus.StatusId
    
                                  LEFT JOIN MovementDate AS MovementDate_StartSale
                                                          ON MovementDate_StartSale.MovementId = Movement_Promo.Id
                                                         AND MovementDate_StartSale.DescId = zc_MovementDate_StartSale()
                                  LEFT JOIN MovementDate AS MovementDate_EndSale
                                                          ON MovementDate_EndSale.MovementId = Movement_Promo.Id
                                                         AND MovementDate_EndSale.DescId = zc_MovementDate_EndSale()
                             
                             WHERE Movement_Promo.DescId = zc_Movement_Promo()
                               AND ( (inPeriodForOperDate = TRUE AND Movement_Promo.OperDate BETWEEN inStartDate AND inEndDate)
                                  OR (inPeriodForOperDate = FALSE AND (MovementDate_StartSale.ValueData BETWEEN inStartDate AND inEndDate
                                                                       OR inStartDate BETWEEN MovementDate_StartSale.ValueData AND MovementDate_EndSale.ValueData
                                                                      )
                                     )
                                   )
                            )
           , tmpMovement_PromoPartner AS (SELECT Movement_PromoPartner.Id                                                 --�������������
                                               , Movement_PromoPartner.StatusId
                                               , Object_Status.ObjectCode               AS StatusCode
                                               , Object_Status.ValueData                AS StatusName 
                                               , Movement_PromoPartner.ParentId                                           --������ �� �������� �������� <�����> (zc_Movement_Promo)
                                               , Object_Partner.ValueData               AS PartnerName             --���������� ��� �����
                                               , ObjectDesc_Partner.ItemName            AS PartnerDescName         --��� ���������� ��� �����
                                               , Object_Contract.ValueData              AS ContractName            --������������ ���������
                                               , Object_ContractTag.ValueData           AS ContractTagName         --������� ���������
                                               
                                          FROM tmpMovement
                                               LEFT JOIN Movement AS Movement_PromoPartner ON Movement_PromoPartner.ParentId = tmpMovement.Id
                                                                                          AND Movement_PromoPartner.DescId = zc_Movement_PromoPartner()
                                                                                          AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
                                               LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement_PromoPartner.StatusId
                                               
                                               LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                                                            ON MovementLinkObject_Partner.MovementId = Movement_PromoPartner.Id
                                                                           AND MovementLinkObject_Partner.DescId = zc_MovementLinkObject_Partner()
                                               LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = MovementLinkObject_Partner.ObjectId
                                               LEFT OUTER JOIN ObjectDesc AS ObjectDesc_Partner ON ObjectDesc_Partner.Id = Object_Partner.DescId
                                       
                                               LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                                                            ON MovementLinkObject_Contract.MovementId = Movement_PromoPartner.Id
                                                                           AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
                                               LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = MovementLinkObject_Contract.ObjectId
                                               
                                               LEFT JOIN ObjectLink AS ObjectLink_Contract_ContractTag
                                                                    ON ObjectLink_Contract_ContractTag.ObjectId = Object_Contract.Id
                                                                   AND ObjectLink_Contract_ContractTag.DescId = zc_ObjectLink_Contract_ContractTag()
                                               LEFT JOIN Object AS Object_ContractTag ON Object_ContractTag.Id = ObjectLink_Contract_ContractTag.ChildObjectId
                                          )

           , tmpMI_Child AS (SELECT MI_Child.MovementId
                                  , Object_ChangePercent.ValueData  AS ChangePercentName
                             FROM tmpMovement
                                  LEFT JOIN MovementItem AS MI_Child
                                                         ON MI_Child.MovementId = tmpMovement.Id
                                                        AND MI_Child.ObjectId = zc_Enum_ConditionPromo_ContractChangePercentOff() -- ��� ����� % ������ �� ��������
                                                        AND MI_Child.isErased   = FALSE
                                  LEFT JOIN Object AS Object_ChangePercent ON Object_ChangePercent.Id = MI_Child.ObjectId
                           )
           , tmpSign AS (SELECT tmpMovement.Id
                              , tmpSign.strSign
                              , tmpSign.strSignNo
                         FROM tmpMovement
                              LEFT JOIN lpSelect_MI_Promo_Sign (inMovementId:= tmpMovement.Id ) AS tmpSign ON tmpSign.Id = tmpMovement.Id 
                         )
                            
        SELECT Movement_Promo.Id                                                 --�������������
             , Movement_Promo.InvNumber :: Integer                               --����� ���������
             , Movement_Promo.OperDate                                           --���� ���������
             , CASE WHEN Movement_PromoPartner.StatusId = zc_Enum_Status_Erased() THEN Movement_PromoPartner.StatusCode ELSE Object_Status.ObjectCode END :: Integer  AS StatusCode
             , CASE WHEN Movement_PromoPartner.StatusId = zc_Enum_Status_Erased() THEN Movement_PromoPartner.StatusName ELSE Object_Status.ValueData END :: TVarChar AS StatusName  
             , MovementLinkObject_PromoKind.ObjectId       AS PromoKindId        --��� �����
             , Object_PromoKind.ValueData                  AS PromoKindName      --��� �����
             , MovementLinkObject_PriceList.ObjectId       AS PriceListId        --����� ����
             , Object_PriceList.ValueData                  AS PriceListName      --����� ����
             , MovementDate_StartPromo.ValueData           AS StartPromo         --���� ������ �����
             , MovementDate_EndPromo.ValueData             AS EndPromo           --���� ��������� �����
             , Movement_Promo.StartSale                    AS StartSale          --���� ������ �������� �� ��������� ����
             , Movement_Promo.EndSale                      AS EndSale            --���� ��������� �������� �� ��������� ����
             , MovementDate_EndReturn.ValueData            AS EndReturn          --���� ��������� ��������� �� ��������� ����
             , MovementDate_OperDateStart.ValueData        AS OperDateStart      --���� ������ ����. ������ �� �����
             , MovementDate_OperDateEnd.ValueData          AS OperDateEnd        --���� ��������� ����. ������ �� �����
             , MovementDate_Month.ValueData                AS MonthPromo         -- ����� �����
             , MovementDate_CheckDate.ValueData            AS CheckDate          --���� ������������
             , MovementFloat_CostPromo.ValueData           AS CostPromo          --��������� ������� � �����
             , MovementString_Comment.ValueData            AS Comment            --����������
             , MovementString_CommentMain.ValueData        AS CommentMain        --���������� (�����)
             , MovementLinkObject_Unit.ObjectId            AS UnitId             --�������������
             , Object_Unit.ValueData                       AS UnitName           --�������������
             , MovementLinkObject_PersonalTrade.ObjectId   AS PersonalTradeId    --������������� ������������� ������������� ������
             , Object_PersonalTrade.ValueData              AS PersonalTradeName  --������������� ������������� ������������� ������
             , MovementLinkObject_Personal.ObjectId        AS PersonalId         --������������� ������������� �������������� ������	
             , Object_Personal.ValueData                   AS PersonalName       --������������� ������������� �������������� ������	
      
             , Movement_PromoPartner.PartnerName     --�������
             , Movement_PromoPartner.PartnerDescName --��� ��������
             , Movement_PromoPartner.ContractName    --�������� ���������
             , Movement_PromoPartner.ContractTagName --������� ��������      
      
             , (1 + EXTRACT (DAY FROM (Movement_Promo.EndSale - Movement_Promo.StartSale))) :: Integer AS DayCount

             , CASE
                  WHEN (ROW_NUMBER() OVER(PARTITION BY Movement_Promo.Id ORDER BY Movement_PromoPartner.Id)) = 1
                      THEN TRUE
              ELSE FALSE
              END as IsFirst
             , COALESCE (MI_Child.ChangePercentName, '��')    :: TVarChar AS ChangePercentName
                
             , COALESCE (MovementBoolean_Promo.ValueData, FALSE)   :: Boolean AS isPromo  -- ����� (��/���)
             , COALESCE (MovementBoolean_Checked.ValueData, FALSE) :: Boolean AS Checked  -- ����������� (��/���)

             , tmpSign.strSign
             , tmpSign.strSignNo    
         
        FROM tmpMovement AS Movement_Promo 
             LEFT JOIN Object AS Object_Status ON Object_Status.Id = Movement_Promo.StatusId
             
             LEFT JOIN MovementLinkObject AS MovementLinkObject_PromoKind
                                          ON MovementLinkObject_PromoKind.MovementId = Movement_Promo.Id
                                         AND MovementLinkObject_PromoKind.DescId = zc_MovementLinkObject_PromoKind()
             LEFT JOIN Object AS Object_PromoKind 
                              ON Object_PromoKind.Id = MovementLinkObject_PromoKind.ObjectId
          
             LEFT JOIN MovementLinkObject AS MovementLinkObject_PriceList
                                          ON MovementLinkObject_PriceList.MovementId = Movement_Promo.Id
                                         AND MovementLinkObject_PriceList.DescId = zc_MovementLinkObject_PriceList()
             LEFT JOIN Object AS Object_PriceList
                              ON Object_PriceList.Id = MovementLinkObject_PriceList.ObjectId
          
             LEFT JOIN MovementDate AS MovementDate_StartPromo
                                     ON MovementDate_StartPromo.MovementId = Movement_Promo.Id
                                    AND MovementDate_StartPromo.DescId = zc_MovementDate_StartPromo()
             LEFT JOIN MovementDate AS MovementDate_EndPromo
                                     ON MovementDate_EndPromo.MovementId =  Movement_Promo.Id
                                    AND MovementDate_EndPromo.DescId = zc_MovementDate_EndPromo()
                                    
             LEFT JOIN MovementDate AS MovementDate_EndReturn
                                    ON MovementDate_EndReturn.MovementId = Movement_Promo.Id
                                   AND MovementDate_EndReturn.DescId = zc_MovementDate_EndReturn()
                                    
             LEFT JOIN MovementDate AS MovementDate_OperDateStart
                                     ON MovementDate_OperDateStart.MovementId = Movement_Promo.Id
                                    AND MovementDate_OperDateStart.DescId = zc_MovementDate_OperDateStart()
             LEFT JOIN MovementDate AS MovementDate_OperDateEnd
                                     ON MovementDate_OperDateEnd.MovementId = Movement_Promo.Id
                                    AND MovementDate_OperDateEnd.DescId = zc_MovementDate_OperDateEnd()
     
             LEFT JOIN MovementDate AS MovementDate_Month
                                    ON MovementDate_Month.MovementId = Movement_Promo.Id
                                   AND MovementDate_Month.DescId = zc_MovementDate_Month()
     
             LEFT JOIN MovementDate AS MovementDate_CheckDate
                                    ON MovementDate_CheckDate.MovementId = Movement_Promo.Id
                                   AND MovementDate_CheckDate.DescId = zc_MovementDate_Check()
                                   
             LEFT JOIN MovementFloat AS MovementFloat_CostPromo
                                     ON MovementFloat_CostPromo.MovementId = Movement_Promo.Id
                                    AND MovementFloat_CostPromo.DescId = zc_MovementFloat_CostPromo()
             
             LEFT JOIN MovementString AS MovementString_Comment
                                      ON MovementString_Comment.MovementId = Movement_Promo.Id
                                     AND MovementString_Comment.DescId = zc_MovementString_Comment()
     
             LEFT JOIN MovementString AS MovementString_CommentMain
                                      ON MovementString_CommentMain.MovementId = Movement_Promo.Id
                                     AND MovementString_CommentMain.DescId = zc_MovementString_CommentMain()
     
             LEFT JOIN MovementBoolean AS MovementBoolean_Checked
                                       ON MovementBoolean_Checked.MovementId = Movement_Promo.Id
                                      AND MovementBoolean_Checked.DescId = zc_MovementBoolean_Checked()
     
             LEFT JOIN MovementBoolean AS MovementBoolean_Promo
                                       ON MovementBoolean_Promo.MovementId = Movement_Promo.Id
                                      AND MovementBoolean_Promo.DescId = zc_MovementBoolean_Promo()
                                          
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                          ON MovementLinkObject_Unit.MovementId = Movement_Promo.Id
                                         AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
             LEFT JOIN Object AS Object_Unit 
                              ON Object_Unit.Id = MovementLinkObject_Unit.ObjectId
     
             LEFT JOIN MovementLinkObject AS MovementLinkObject_PersonalTrade
                                          ON MovementLinkObject_PersonalTrade.MovementId = Movement_Promo.Id
                                         AND MovementLinkObject_PersonalTrade.DescId = zc_MovementLinkObject_PersonalTrade()
             LEFT JOIN Object AS Object_PersonalTrade 
                              ON Object_PersonalTrade.Id = MovementLinkObject_PersonalTrade.ObjectId
     
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Personal
                                          ON MovementLinkObject_Personal.MovementId = Movement_Promo.Id
                                         AND MovementLinkObject_Personal.DescId = zc_MovementLinkObject_Personal()
             LEFT JOIN Object AS Object_Personal
                              ON Object_Personal.Id = MovementLinkObject_Personal.ObjectId
                         
             LEFT JOIN tmpMovement_PromoPartner AS Movement_PromoPartner
                                                  ON Movement_PromoPartner.ParentId = Movement_Promo.Id
                                                  
             LEFT JOIN tmpMI_Child AS MI_Child ON MI_Child.MovementId = Movement_Promo.Id
         
             LEFT JOIN tmpSign ON tmpSign.Id = Movement_Promo.Id   -- ��.�������  --
         ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
--ALTER FUNCTION gpSelect_Movement_Promo (TDateTime, TDateTime, Boolean, Boolean, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.
 01.08.17         *
 25.07.17         *
 05.10.16         * add inJuridicalBasisId
 27.11.15                                                                        *inPeriodForOperDate
 17.11.15                                                                        *Movement_PromoPartner_View
 13.10.15                                                                        *
*/

-- SELECT * FROM gpSelect_Movement_Promo (inStartDate:= '01.11.2016', inEndDate:= '30.11.2016', inIsErased:= FALSE, inPeriodForOperDate:=TRUE, inJuridicalBasisId:= 0, inSession:= zfCalc_UserAdmin())
