-- Function: gpReport_SaleByReturnIn ()

DROP FUNCTION IF EXISTS gpReport_SaleByReturnIn (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Tfloat, TVarChar);
DROP FUNCTION IF EXISTS gpReport_SaleByReturnIn (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Tfloat, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_SaleByReturnIn (
    IN inStartDate         TDateTime ,
    IN inEndDate           TDateTime ,
    IN inPartnerId         Integer   ,
    IN inJuridicalId       Integer   ,
    IN inRetailId          Integer   ,
    IN inBranchId          Integer   ,
    IN inContractId        Integer   ,
    IN inPaidKindId        Integer   ,
    IN inGoodsId           Integer   ,
    IN inGoodsKindId       Integer   , --
    IN inPrice             Tfloat    , --
    IN inSession           TVarChar    -- ������ ������������
)
RETURNS TABLE (GoodsCode Integer, GoodsName TVarChar, GoodsKindName TVarChar
             , JuridicalCode Integer, JuridicalName TVarChar
             , PartnerId Integer, PartnerCode Integer, PartnerName TVarChar
             , RetailName TVarChar
             , PaidKindId TVarChar, PaidKindName TVarChar
             , BranchName TVarChar, UnitName TVarChar
             , ContractCode Integer, ContractName TVarChar

             , Amount        TFloat  -- 
             , AmountReturn  TFloat  -- 
             , AmountRem     TFloat  -- 
             , Price         TFloat  -- 
             
             , InvNumber TVarChar, InvNumberPartner TVarChar, OperDate TDateTime, OperDatePartner TDateTime
             , InvNumberPartner_Master TVarChar, OperDate_Master TDateTime
             , DocumentTaxKindName TVarChar
             
             ) 

AS
$BODY$
 DECLARE vbUserId Integer;
BEGIN
     vbUserId:= lpGetUserBySession (inSession);

    CREATE TEMP TABLE _tmpListPartner (PartnerId Integer, JuridicalId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpListUnit (UnitId Integer) ON COMMIT DROP;

    -- ����������� 
    IF inPartnerId <> 0
    THEN
        INSERT INTO _tmpListPartner (PartnerId, JuridicalId)
           SELECT inPartnerId AS PartnerId
                , OL_Partner_Juridical.ChildObjectId AS JuridicalId
           FROM ObjectLink AS OL_Partner_Juridical
               WHERE OL_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                 AND OL_Partner_Juridical.ObjectId = inPartnerId
          ;
    ELSE 
        IF inJuridicalId <> 0
        THEN
            INSERT INTO _tmpListPartner (PartnerId, JuridicalId)
               SELECT OL_Partner_Juridical.ObjectId AS PartnerId
                    , OL_Partner_Juridical.ChildObjectId AS JuridicalId
               FROM ObjectLink AS OL_Partner_Juridical
               WHERE OL_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                 AND OL_Partner_Juridical.ChildObjectId = inJuridicalId --250209
           ;
        ELSE 
            IF inRetailId <> 0 THEN
               INSERT INTO _tmpListPartner (PartnerId, JuridicalId)
                  SELECT  ObjectLink_Partner_Juridical.ObjectId 
                        , ObjectLink_Partner_Juridical.ChildObjectId AS JuridicalId
                  FROM ObjectLink AS ObjectLink_Juridical_Retail 
                     LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                          ON ObjectLink_Partner_Juridical.ChildObjectId = ObjectLink_Juridical_Retail.ObjectId
                                         AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                  WHERE ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                    AND ObjectLink_Juridical_Retail.ChildObjectId = inRetailId --310842 
                 ;
            ELSE 
                RAISE EXCEPTION '������.�� ����������� �������� <����� ��������>.';
            END IF;
        END IF;
    END IF;
    

IF inBranchId <> 0
    THEN
        INSERT INTO _tmpListUnit (UnitId)
           SELECT ObjectLink_Unit_Branch.ObjectId      AS UnitId
           FROM ObjectLink AS ObjectLink_Unit_Branch
           WHERE ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
             AND ObjectLink_Unit_Branch.ChildObjectId = inBranchId
          ;
    /*ELSE 
            INSERT INTO _tmpListUnit (UnitId, BranchId)
               SELECT Object_Unit.Id      AS UnitId
                    , COALESCE(ObjectLink_Unit_Branch.ChildObjectId,0) AS BranchId
               FROM Object AS Object_Unit
                   LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                                        ON ObjectLink_Unit_Branch.ObjectId = Object_Unit.Id
                                       AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
               WHERE Object_Unit.DescId = zc_Object_Unit()
           ;*/
    END IF;



    -- �����������
    ANALYZE _tmpListPartner;
    ANALYZE _tmpListUnit;


    -- ���������
    RETURN QUERY
    WITH tmpContainer_All AS (
              SELECT MIContainer.MovementId  
                   , MIContainer.MovementItemId
                   , MD_OperDatePartner.ValueData         AS OperDatePartner
                   , MIContainer.ObjectExtId_analyzer     AS PartnerId
                   --, _tmpListPartner.JuridicalId
                   , MIContainer.WhereObjectId_analyzer   AS UnitId
                   , COALESCE (ContainerLO_PaidKind.ObjectId, 0) AS PaidKindId
                   , COALESCE (ContainerLO_Contract.ObjectId, 0) AS ContractId 
                   , MIContainer.ObjectId_Analyzer        AS GoodsId
                   , MIContainer.ObjectIntId_Analyzer     AS GoodsKindId       
            
                   , SUM (-1 * MIContainer.Amount)        AS Amount
                   , MIFloat_Price.ValueData              AS Price
          
               FROM MovementDate AS MD_OperDatePartner
                      INNER JOIN MovementItemContainer AS MIContainer
                                                       ON MIContainer.MovementId             = MD_OperDatePartner.MovementId
                                                       AND MIContainer.DescId                = zc_MIContainer_Count()
                                                       AND MIContainer.AnalyzerId            = zc_Enum_AnalyzerId_SaleCount_10400() -- ���-��, ����������, � ����������
                                                       AND MIContainer.MovementDescId        = zc_Movement_Sale()
                                                       AND MIContainer.ObjectId_Analyzer     = inGoodsId
                                                       AND MIContainer.ObjectExtId_analyzer IN (SELECT _tmpListPartner.PartnerId FROM _tmpListPartner) 
                                                       -- AND (MIContainer.ObjectIntId_Analyzer = inGoodsKindId OR inGoodsKindId = 0)
                      -- INNER JOIN _tmpListPartner ON _tmpListPartner.PartnerId = MIContainer.ObjectExtId_analyzer

                      LEFT JOIN ContainerLinkObject AS ContainerLO_PaidKind
                                                    ON ContainerLO_PaidKind.ContainerId = MIContainer.ContainerId_analyzer
                                                   AND ContainerLO_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
                      LEFT JOIN ContainerLinkObject AS ContainerLO_Contract 
                                                    ON ContainerLO_Contract.ContainerId = MIContainer.ContainerId_analyzer
                                                   AND ContainerLO_Contract.DescId = zc_ContainerLinkObject_Contract()               
                                                  
                      LEFT JOIN MovementItemFloat AS MIFloat_Price
                                                  ON MIFloat_Price.MovementItemId = MIContainer.MovementItemId
                                                 AND MIFloat_Price.DescId = zc_MIFloat_Price()                                                   
                                       
              WHERE MD_OperDatePartner.ValueData BETWEEN inStartDate AND inEndDate - INTERVAL '1 DAY'
                AND MD_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
              GROUP BY MIContainer.MovementId  
                   , MIContainer.MovementItemId
                   , MIContainer.ObjectExtId_analyzer     
                   --, _tmpListPartner.JuridicalId     
                   , MIContainer.WhereObjectId_analyzer   
                   , COALESCE (ContainerLO_PaidKind.ObjectId, 0) 
                   , MIContainer.ObjectId_Analyzer       
                   , MIContainer.ObjectIntId_Analyzer    
                   , MIFloat_Price.ValueData 
                   , MD_OperDatePartner.ValueData
                   , COALESCE (ContainerLO_Contract.ObjectId, 0)
                )
  , tmpContainer AS (SELECT tmpContainer_All.*
                     FROM tmpContainer_All
                          LEFT JOIN _tmpListUnit ON _tmpListUnit.UnitId = tmpContainer_All.UnitId
                     WHERE (tmpContainer_All.PaidKindId  = inPaidKindId  OR inPaidKindId  = 0)
                       AND (tmpContainer_All.GoodsKindId = inGoodsKindId OR inGoodsKindId = 0)
                       AND (tmpContainer_All.Price       = inPrice       OR inPrice       = 0)
                       AND (tmpContainer_All.ContractId  = inContractId  OR inContractId  = 0)
                       AND (_tmpListUnit.UnitId          > 0 OR inBranchId  = 0)
                    )
  , tmpMI AS (SELECT DISTINCT tmpContainer.MovementItemId FROM tmpContainer)
                        
  , tmpReturnAmount AS (SELECT tmpMI.MovementItemId 
                             , SUM (MI_Child.Amount) AS Amount
                        FROM tmpMI
                             INNER JOIN MovementItemFloat AS MIFloat_MovementItem 
                                                          ON MIFloat_MovementItem.ValueData = tmpMI.MovementItemId
                                                         AND MIFloat_MovementItem.DescId = zc_MIFloat_MovementItemId()
                             INNER JOIN MovementItem AS MI_Child ON MI_Child.Id = MIFloat_MovementItem.MovementItemId
                                                                AND MI_Child.isErased = FALSE
                                                               -- AND MI_Child.DescId = zc_MI_Child()
                             INNER JOIN Movement ON Movement.Id       = MI_Child.MovementId
                                                AND Movement.DescId  IN (zc_Movement_ReturnIn(), zc_Movement_TransferDebtIn())
                                                AND Movement.StatusId = zc_Enum_Status_Complete()
                        GROUP BY tmpMI.MovementItemId
                       )

                                             
    SELECT Object_Goods.ObjectCode                    AS GoodsCode
         , Object_Goods.ValueData                     AS GoodsName
         , Object_GoodsKind.ValueData                 AS GoodsKindName
        
         , Object_Juridical.ObjectCode AS JuridicalCode
         , Object_Juridical.ValueData  AS JuridicalName

         , Object_Partner.Id            AS PartnerId
         , Object_Partner.ObjectCode    AS PartnerCode
         , Object_Partner.ValueData     AS PartnerName

          , Object_Retail.ValueData     AS RetailName

         , Object_PaidKind.Id :: TVarChar AS PaidKindId
         , Object_PaidKind.ValueData      AS PaidKindName

         , Object_Branch.ValueData        AS BranchName
         , Object_Unit.ValueData          AS UnitName

         , View_Contract_InvNumber.ContractCode    AS ContractCode
         , View_Contract_InvNumber.InvNumber       AS ContractName
         
         , tmpContainer.Amount   ::tfloat 
        --, (select count(*) from tmpContainer) ::tfloat  as Amount 
         , COALESCE(tmpReturnAmount.Amount,0)                         ::tfloat AmountReturn
         , (tmpContainer.Amount - COALESCE(tmpReturnAmount.Amount,0)) ::tfloat AS AmountRem  
         , tmpContainer.Price    ::tfloat
         

         , Movement_Sale.InvNumber
         , MovementString_InvNumberPartner.ValueData      AS InvNumberPartner
         , Movement_Sale.Operdate
         , tmpContainer.OperDatePartner
         
         , MS_InvNumberPartner_Master.ValueData     AS InvNumberPartner_Master
         , Movement_DocumentMaster.OperDate         AS OperDate_Master
         , Object_TaxKind_Master.ValueData     	    AS DocumentTaxKindName
                    
       FROM tmpContainer
          LEFT JOIN tmpReturnAmount ON tmpReturnAmount.MovementItemId = tmpContainer.MovementItemId

          LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = tmpContainer.PartnerId
          LEFT JOIN _tmpListPartner ON _tmpListPartner.PartnerId = Object_Partner.Id
          LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = _tmpListPartner.JuridicalId
          LEFT JOIN Object AS Object_PaidKind ON Object_PaidKind.Id = tmpContainer.PaidKindId
          LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = tmpContainer.UnitId
          LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = tmpContainer.ContractId
           
          LEFT JOIN Object AS Object_Goods on Object_Goods.Id = tmpContainer.GoodsId
          LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpContainer.GoodsKindId
          
          LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                               ON ObjectLink_Unit_Branch.ObjectId = Object_Unit.Id
                              AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
          LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = ObjectLink_Unit_Branch.ChildObjectId


          LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                               ON ObjectLink_Juridical_Retail.ObjectId = Object_Juridical.Id
                              AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
          LEFT JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Juridical_Retail.ChildObjectId

          LEFT JOIN Movement AS Movement_Sale ON Movement_Sale.Id = tmpContainer.MovementId

          LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                   ON MovementString_InvNumberPartner.MovementId = Movement_Sale.Id 
                                  AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()

          LEFT JOIN MovementLinkMovement AS MovementLinkMovement_Master
                                           ON MovementLinkMovement_Master.MovementId = Movement_Sale.Id
                                          AND MovementLinkMovement_Master.DescId = zc_MovementLinkMovement_Master()
          LEFT JOIN Movement AS Movement_DocumentMaster ON Movement_DocumentMaster.Id = MovementLinkMovement_Master.MovementChildId
          LEFT JOIN MovementString AS MS_InvNumberPartner_Master
                                   ON MS_InvNumberPartner_Master.MovementId = MovementLinkMovement_Master.MovementChildId
                                  AND MS_InvNumberPartner_Master.DescId = zc_MovementString_InvNumberPartner()

          LEFT JOIN MovementLinkObject AS MovementLinkObject_DocumentTaxKind_Master
                                       ON MovementLinkObject_DocumentTaxKind_Master.MovementId = Movement_DocumentMaster.Id 
                                      AND MovementLinkObject_DocumentTaxKind_Master.DescId = zc_MovementLinkObject_DocumentTaxKind()
          LEFT JOIN Object AS Object_TaxKind_Master ON Object_TaxKind_Master.Id = MovementLinkObject_DocumentTaxKind_Master.ObjectId
                                                   AND Movement_DocumentMaster.StatusId = zc_Enum_Status_Complete() 


  ;
         
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 15.05.15         * 
*/

-- ����
-- SELECT * FROM gpReport_SaleByReturnIn (inStartDate:= '04.11.2015'::TDateTime, inEndDate:= '04.11.2015'::TDateTime,  inPartnerId:= 112464, inJuridicalId:=0, inRetailId:=0, inBranchId:=0, inContractId:= 0, inPaidKindId:= 0, inGoodsId:= 2507, inGoodsKindId:= 0, inPrice:= 0 :: Tfloat, inSession:= zfCalc_UserAdmin()); -- 
-- SELECT * FROM gpReport_SaleByReturnIn(inStartDate := ('01.01.2016')::TDateTime , inEndDate := ('10.05.2016')::TDateTime , inPartnerId := 17784 , inJuridicalId := 0 , inRetailId := 0 , inBranchId := 0 , inContractId := 16591 , inPaidKindId := 3 , inGoodsId := 2156 , inGoodsKindId := 8328 , inPrice := 127.25 ,  inSession := '5');