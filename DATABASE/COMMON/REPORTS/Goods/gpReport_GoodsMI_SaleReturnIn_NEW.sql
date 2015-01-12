-- Function: gpReport_Goods_Movement ()

DROP FUNCTION IF EXISTS gpReport_GoodsMI_SaleReturnIn (TDateTime, TDateTime, Integer, Integer, Integer, Integer, TVarChar);
DROP FUNCTION IF EXISTS gpReport_GoodsMI_SaleReturnIn (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Boolean, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpReport_GoodsMI_SaleReturnIn (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Boolean, TVarChar);
DROP FUNCTION IF EXISTS gpReport_GoodsMI_SaleReturnIn (TDateTime, TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpReport_GoodsMI_SaleReturnIn (
    IN inStartDate    TDateTime ,
    IN inEndDate      TDateTime ,
    IN inBranchId     Integer   , -- ������
    IN inAreaId       Integer   , -- ������ (����������� -> �� ����)
    IN inRetailId     Integer   , -- �������� ���� (�� ����)
    IN inJuridicalId  Integer   ,
    IN inPaidKindId   Integer   , --
    IN inTradeMarkId  Integer   ,
    IN inGoodsGroupId Integer   ,
    IN inInfoMoneyId  Integer   ,-- �������������� ������
    IN inIsPartner    Boolean   , --
    IN inIsTradeMark  Boolean   , --
    IN inIsGoods      Boolean   , --
    IN inSession      TVarChar    -- ������ ������������
)
RETURNS TABLE (GoodsGroupName TVarChar, GoodsGroupNameFull TVarChar
             , GoodsCode Integer, GoodsName TVarChar, GoodsKindName TVarChar, MeasureName TVarChar
             , TradeMarkName TVarChar, GoodsTagName TVarChar, GoodsGroupStatName TVarChar
             , JuridicalGroupName TVarChar
             , BranchCode Integer, BranchName TVarChar
             , JuridicalCode Integer, JuridicalName TVarChar, OKPO TVarChar
             , RetailName TVarChar, RetailReportName TVarChar
             , AreaName TVarChar, PartnerTagName TVarChar
             , RegionName TVarChar, ProvinceName TVarChar, CityKindName TVarChar, CityName TVarChar, ProvinceCityName TVarChar, StreetKindName TVarChar, StreetName TVarChar
             , PartnerId Integer, PartnerCode Integer, PartnerName TVarChar
             , ContractCode Integer, ContractNumber TVarChar, ContractTagName TVarChar
             , PersonalName TVarChar, UnitName_Personal TVarChar, BranchName_Personal TVarChar
             , PersonalTradeName TVarChar, UnitName_PersonalTrade TVarChar
             , InfoMoneyGroupName TVarChar, InfoMoneyDestinationName TVarChar, InfoMoneyCode Integer, InfoMoneyName TVarChar, InfoMoneyName_all TVarChar
             , AccountName TVarChar
             , Sale_Summ TFloat, Sale_Summ_10200 TFloat, Sale_Summ_10300 TFloat, Sale_SummCost TFloat, Sale_SummCost_10500 TFloat, Sale_SummCost_40200 TFloat
             , Sale_Amount_Weight TFloat , Sale_Amount_Sh TFloat, Sale_AmountPartner_Weight TFloat , Sale_AmountPartner_Sh TFloat
             , Return_Summ TFloat, Return_SummCost TFloat, Return_SummCost_40200 TFloat
             , Return_Amount_Weight TFloat, Return_Amount_Sh TFloat, Return_AmountPartner_Weight TFloat, Return_AmountPartner_Sh TFloat
             , Sale_Amount_10500_Weight TFloat
             , Sale_Amount_40200_Weight TFloat
             , Return_Amount_40200_Weight TFloat
              )
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE vbIsGoods Boolean;
   DECLARE vbIsPartner Boolean;
   DECLARE vbIsJuridical Boolean;
   DECLARE vbIsCost Boolean;

   DECLARE vbObjectId_Constraint_Branch Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_...());
     vbUserId:= lpGetUserBySession (inSession);

    -- !!!�.�. ������ ����� ����� ������ � �����!!!
    IF inStartDate + (INTERVAL '62 DAY') <= inEndDate AND inIsPartner = TRUE AND inIsGoods = TRUE
    THEN
        inStartDate:= inEndDate + (INTERVAL '1 DAY');
    END IF;


    -- ������������ ������� �������
    vbObjectId_Constraint_Branch:= (SELECT Object_RoleAccessKeyGuide_View.BranchId FROM Object_RoleAccessKeyGuide_View WHERE Object_RoleAccessKeyGuide_View.UserId = vbUserId AND Object_RoleAccessKeyGuide_View.BranchId <> 0);
     -- !!!�������� ��������!!!
     IF vbObjectId_Constraint_Branch > 0 THEN inBranchId:= vbObjectId_Constraint_Branch; END IF;

    -- ������������ ������� ������� ��� �/�
    vbIsCost:= EXISTS (SELECT UserId FROM ObjectLink_UserRole_View WHERE RoleId IN (zc_Enum_Role_Admin(), 10898, 326391) AND UserId = vbUserId); -- ������ (����������) + ��������� �� ��������


    vbIsGoods:= FALSE;
    vbIsPartner:= FALSE;
    vbIsJuridical:= FALSE;


    -- ����������� �� ������
    CREATE TEMP TABLE _tmpGoods (GoodsId Integer, TradeMarkId Integer) ON COMMIT DROP;
    IF inGoodsGroupId <> 0
    THEN
        -- ��������������� �������
        vbIsGoods:= TRUE;
        -- ����������
        INSERT INTO _tmpGoods (GoodsId, TradeMarkId)
           SELECT lfObject_Goods_byGoodsGroup.GoodsId AS GoodsId
                , CASE WHEN inIsTradeMark = TRUE OR inIsGoods = TRUE THEN COALESCE (ObjectLink_Goods_TradeMark.ChildObjectId, 0) ELSE 0 END AS TradeMarkId
                -- , COALESCE (ObjectLink_Goods_Measure.ChildObjectId, 0) AS MeasureId
                -- , COALESCE (ObjectFloat_Weight.ValueData, 0)           AS Weight
           FROM lfSelect_Object_Goods_byGoodsGroup (inGoodsGroupId) AS lfObject_Goods_byGoodsGroup
                LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                                     ON ObjectLink_Goods_TradeMark.ObjectId = lfObject_Goods_byGoodsGroup.GoodsId
                                    AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
/*                LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                     ON ObjectLink_Goods_Measure.ObjectId = lfObject_Goods_byGoodsGroup.GoodsId
                                    AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                      ON ObjectFloat_Weight.ObjectId = lfObject_Goods_byGoodsGroup.GoodsId
                                     AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()*/
           WHERE (ObjectLink_Goods_TradeMark.ChildObjectId = inTradeMarkId OR COALESCE (inTradeMarkId, 0) = 0)
       ;
    ELSE IF inTradeMarkId <> 0
         THEN
             -- ��������������� �������
             vbIsGoods:= TRUE;
             -- ����������
             INSERT INTO _tmpGoods (GoodsId, TradeMarkId)
                SELECT ObjectLink_Goods_TradeMark.ObjectId AS GoodsId
                     , CASE WHEN inIsTradeMark = TRUE OR inIsGoods = TRUE THEN COALESCE (ObjectLink_Goods_TradeMark.ChildObjectId, 0) ELSE 0 END AS TradeMarkId
                FROM ObjectLink AS ObjectLink_Goods_TradeMark
                WHERE ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
                  AND ObjectLink_Goods_TradeMark.ChildObjectId = inTradeMarkId
            ;
         ELSE
             -- ��������������� �������
             vbIsGoods:= FALSE;
             -- ����������
             INSERT INTO _tmpGoods (GoodsId, TradeMarkId)
                SELECT Object.Id AS GoodsId
                     , COALESCE (ObjectLink_Goods_TradeMark.ChildObjectId, 0) AS TradeMarkId
                FROM Object
                     LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                                          ON ObjectLink_Goods_TradeMark.ObjectId = Object.Id
                                         AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
                WHERE Object.DescId = zc_Object_Goods()
                  AND (inIsTradeMark = TRUE AND inIsGoods = FALSE AND ObjectLink_Goods_TradeMark.ChildObjectId > 0)
            ;

         END IF;
    END IF;

    -- �����������
    CREATE TEMP TABLE _tmpPartner (PartnerId Integer, JuridicalId Integer, AreaId Integer) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpJuridical (JuridicalId Integer, RetailId Integer, JuridicalGroupId Integer, OKPO TVarChar) ON COMMIT DROP;
    IF inAreaId <> 0
    THEN
        -- ��������������� �������
        vbIsPartner:= TRUE;
        -- ���������� �� �����������
        INSERT INTO _tmpPartner (PartnerId, JuridicalId, AreaId)
           SELECT ObjectLink_Partner_Area.ObjectId
                , COALESCE (ObjectLink_Partner_Juridical.ChildObjectId, 0)
                , COALESCE (ObjectLink_Partner_Area.ChildObjectId, 0)
           FROM ObjectLink AS ObjectLink_Partner_Area
                LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                     ON ObjectLink_Partner_Juridical.ObjectId = ObjectLink_Partner_Area.ObjectId
                                    AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
           WHERE ObjectLink_Partner_Area.DescId = zc_ObjectLink_Partner_Area()
             AND ObjectLink_Partner_Area.ChildObjectId = inAreaId
       ;
        -- ��������������� �������
        vbIsJuridical:= TRUE;
        -- ���������� �� �� ����
        INSERT INTO _tmpJuridical (JuridicalId, RetailId, JuridicalGroupId, OKPO)
           SELECT _tmpPartner.JuridicalId
                , COALESCE (ObjectLink_Juridical_Retail.ChildObjectId, 0)
                , COALESCE (ObjectLink_Juridical_JuridicalGroup.ChildObjectId, 0)
                , COALESCE (ObjectHistory_JuridicalDetails_View.OKPO, '')
           FROM _tmpPartner
                LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                     ON ObjectLink_Juridical_Retail.ObjectId = _tmpPartner.JuridicalId
                                    AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                LEFT JOIN ObjectLink AS ObjectLink_Juridical_JuridicalGroup
                                     ON ObjectLink_Juridical_JuridicalGroup.ObjectId = _tmpPartner.JuridicalId
                                    AND ObjectLink_Juridical_JuridicalGroup.DescId = zc_ObjectLink_Juridical_JuridicalGroup()
                LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = _tmpPartner.JuridicalId
           WHERE (ObjectLink_Juridical_Retail.ChildObjectId = inRetailId OR COALESCE (inRetailId, 0) = 0)
             AND (_tmpPartner.JuridicalId = inJuridicalId OR COALESCE (inJuridicalId, 0) = 0)
       ;
    ELSE
        -- �� �� ���� (������)
        IF inJuridicalId <> 0
        THEN
            -- ��������������� �������
            vbIsJuridical:= TRUE;
            -- ����������
            INSERT INTO _tmpJuridical (JuridicalId, RetailId, JuridicalGroupId, OKPO)
               SELECT Object.Id
                    , COALESCE (ObjectLink_Juridical_Retail.ChildObjectId, 0)
                    , COALESCE (ObjectLink_Juridical_JuridicalGroup.ChildObjectId, 0)
                    , COALESCE (ObjectHistory_JuridicalDetails_View.OKPO, '')
               FROM Object
                    LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                         ON ObjectLink_Juridical_Retail.ObjectId = Object.Id
                                        AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                    LEFT JOIN ObjectLink AS ObjectLink_Juridical_JuridicalGroup
                                         ON ObjectLink_Juridical_JuridicalGroup.ObjectId = Object.Id
                                        AND ObjectLink_Juridical_JuridicalGroup.DescId = zc_ObjectLink_Juridical_JuridicalGroup()
                    LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = Object.Id
               WHERE Object.Id = inJuridicalId
                 AND (ObjectLink_Juridical_Retail.ChildObjectId = inRetailId OR COALESCE (inRetailId, 0) = 0)
           ;
        ELSE
            IF inRetailId <> 0
            THEN
                -- ��������������� �������
                vbIsJuridical:= TRUE;
                -- ����������
                INSERT INTO _tmpJuridical (JuridicalId, RetailId, JuridicalGroupId, OKPO)
                   SELECT ObjectLink_Juridical_Retail.ObjectId
                        , COALESCE (ObjectLink_Juridical_Retail.ChildObjectId, 0)
                        , COALESCE (ObjectLink_Juridical_JuridicalGroup.ChildObjectId, 0)
                        , COALESCE (ObjectHistory_JuridicalDetails_View.OKPO, '')
                   FROM ObjectLink AS ObjectLink_Juridical_Retail
                        LEFT JOIN ObjectLink AS ObjectLink_Juridical_JuridicalGroup
                                             ON ObjectLink_Juridical_JuridicalGroup.ObjectId = ObjectLink_Juridical_Retail.ObjectId
                                            AND ObjectLink_Juridical_JuridicalGroup.DescId = zc_ObjectLink_Juridical_JuridicalGroup()
                        LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = ObjectLink_Juridical_Retail.ObjectId
                   WHERE ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                     AND ObjectLink_Juridical_Retail.ChildObjectId = inRetailId
                  ;
            END IF;
        END IF;
    END IF;

/*
    CREATE TEMP TABLE tmpAnalyzer (AnalyzerId Integer, isSale Boolean, isCost Boolean, isSumm Boolean, MLO_DescId Integer) ON COMMIT DROP;
    INSERT INTO tmpAnalyzer (AnalyzerId, isSale, isCost, isSumm, MLO_DescId)
         SELECT AnalyzerId, isSale, isCost, isSumm
              , CASE WHEN isSale = TRUE THEN zc_MovementLinkObject_To() ELSE zc_MovementLinkObject_From() END AS MLO_DescId
         FROM Constant_ProfitLoss_AnalyzerId_View
         WHERE isCost = FALSE OR (isCost = TRUE AND vbIsCost = TRUE);

    ANALYZE tmpAnalyzer;*/
    ANALYZE _tmpGoods;
    ANALYZE _tmpPartner;
    ANALYZE _tmpJuridical;


    -- ���������
    RETURN QUERY

    -- �������� ��� ������
    WITH tmpAnalyzer AS (SELECT Constant_ProfitLoss_AnalyzerId_View.*
                              , CASE WHEN isSale = TRUE THEN zc_MovementLinkObject_To() ELSE zc_MovementLinkObject_From() END AS MLO_DescId
                         FROM Constant_ProfitLoss_AnalyzerId_View
                         WHERE isCost = FALSE OR (isCost = TRUE AND vbIsCost = TRUE)
                        ) 
       , tmpPartnerAddress AS (SELECT * FROM Object_Partner_Address_View)
       -- , tmpPersonal AS (SELECT * FROM Object_Personal_View)

 , tmpOperationGroup AS (SELECT CASE WHEN inIsPartner = TRUE THEN ContainerLO_Juridical.ObjectId ELSE 0 END AS JuridicalId
                              , CASE WHEN inIsPartner = TRUE THEN ContainerLinkObject_Contract.ObjectId ELSE 0 END AS ContractId
                              , CASE WHEN inIsPartner = FALSE THEN 0 WHEN MIContainer.MovementDescId = zc_Movement_Service() THEN MIContainer.ObjectId_Analyzer ELSE MovementLinkObject_Partner.ObjectId END AS PartnerId

                              , ContainerLinkObject_InfoMoney.ObjectId      AS InfoMoneyId
                              , COALESCE (MILinkObject_Branch.ObjectId, 0)  AS BranchId
                              , 0 AS ChildAccountId -- MIContainer.AccountId

                              , _tmpGoods.TradeMarkId
                              , CASE WHEN inIsGoods = TRUE THEN MIContainer.ObjectId_Analyzer ELSE 0 END                 AS GoodsId
                              , CASE WHEN inIsGoods = TRUE THEN COALESCE (MILinkObject_GoodsKind.ObjectId, 0) ELSE 0 END AS GoodsKindId

                              , SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Sale()     AND MIContainer.DescId = zc_MIContainer_Summ() AND tmpAnalyzer.isCost = FALSE THEN  1 * MIContainer.Amount ELSE 0 END) AS Sale_Summ
                              , SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_ReturnIn() AND MIContainer.DescId = zc_MIContainer_Summ() AND tmpAnalyzer.isCost = FALSE THEN -1 * MIContainer.Amount ELSE 0 END) AS Return_Summ

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10200() THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_Summ_10200
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10300() THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_Summ_10300
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInSumm_10300() THEN 1 * MIContainer.Amount ELSE 0 END) AS Return_Summ_10300

                              , SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Sale()     AND MIContainer.DescId = zc_MIContainer_Count()                                                              THEN -1 * MIContainer.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END ELSE 0 END) AS Sale_Amount_Weight
                              , SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_Sale()     AND MIContainer.DescId = zc_MIContainer_Count() AND ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_Amount_Sh
                              , SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_ReturnIn() AND MIContainer.DescId = zc_MIContainer_Count()                                                              THEN  1 * MIContainer.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END ELSE 0 END) AS Return_Amount_Weight
                              , SUM (CASE WHEN MIContainer.MovementDescId = zc_Movement_ReturnIn() AND MIContainer.DescId = zc_MIContainer_Count() AND ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN  1 * MIContainer.Amount ELSE 0 END) AS Return_Amount_Sh

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleCount_10400()                                                                  THEN -1 * MIContainer.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END ELSE 0 END) AS Sale_AmountPartner_Weight
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleCount_10400() AND ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh()     THEN -1 * MIContainer.Amount ELSE 0 END) AS Sale_AmountPartner_Sh
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInCount_10800()                                                              THEN  1 * MIContainer.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END ELSE 0 END) AS Return_AmountPartner_Weight
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInCount_10800() AND ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN  1 * MIContainer.Amount ELSE 0 END) AS Return_AmountPartner_Sh

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleCount_10500()     THEN -1 * MIContainer.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END ELSE 0 END) AS Sale_Amount_10500_Weight
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleCount_40200()     THEN -1 * MIContainer.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END ELSE 0 END) AS Sale_Amount_40200_Weight
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInCount_40200() THEN  1 * MIContainer.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 1 END ELSE 0 END) AS Return_Amount_40200_Weight

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10400() THEN -1 * COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Sale_SummCost
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_10500() THEN -1 * COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Sale_SummCost_10500
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_SaleSumm_40200() THEN      COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Sale_SummCost_40200

                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInSumm_10800() THEN COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Return_SummCost
                              , SUM (CASE WHEN tmpAnalyzer.AnalyzerId = zc_Enum_AnalyzerId_ReturnInSumm_40200() THEN COALESCE (MIContainer.Amount, 0) ELSE 0 END) AS Return_SummCost_40200
                         FROM tmpAnalyzer
                              INNER JOIN MovementItemContainer AS MIContainer
                                                               ON MIContainer.AnalyzerId = tmpAnalyzer.AnalyzerId
                                                              AND MIContainer.OperDate BETWEEN inStartDate AND inEndDate
                                  INNER JOIN ContainerLinkObject AS ContainerLO_Juridical
                                                                 ON ContainerLO_Juridical.ContainerId = MIContainer.ContainerId_Analyzer
                                                                AND ContainerLO_Juridical.DescId = zc_ContainerLinkObject_Juridical()
                                  INNER JOIN ContainerLinkObject AS ContainerLinkObject_InfoMoney
                                                                 ON ContainerLinkObject_InfoMoney.ContainerId = MIContainer.ContainerId_Analyzer
                                                                AND ContainerLinkObject_InfoMoney.DescId = zc_ContainerLinkObject_InfoMoney()
                                                                AND (ContainerLinkObject_InfoMoney.ObjectId = inInfoMoneyId OR COALESCE (inInfoMoneyId, 0) = 0)
                                  INNER JOIN ContainerLinkObject AS ContainerLinkObject_PaidKind
                                                                 ON ContainerLinkObject_PaidKind.ContainerId = MIContainer.ContainerId_Analyzer
                                                                AND ContainerLinkObject_PaidKind.DescId = zc_ContainerLinkObject_PaidKind()
                                                                AND (ContainerLinkObject_PaidKind.ObjectId = inPaidKindId OR COALESCE (inPaidKindId, 0) = 0)
                                  LEFT JOIN ContainerLinkObject AS ContainerLinkObject_Contract
                                                                ON ContainerLinkObject_Contract.ContainerId = MIContainer.ContainerId_Analyzer
                                                               AND ContainerLinkObject_Contract.DescId = zc_ContainerLinkObject_Contract()
                                  LEFT JOIN MovementLinkObject AS MovementLinkObject_Partner
                                                               ON MovementLinkObject_Partner.MovementId = MIContainer.MovementId
                                                              AND MovementLinkObject_Partner.DescId = CASE WHEN MIContainer.MovementDescId = zc_Movement_PriceCorrective() THEN zc_MovementLinkObject_Partner() ELSE tmpAnalyzer.MLO_DescId END

                                  LEFT JOIN _tmpJuridical ON _tmpJuridical.JuridicalId = ContainerLO_Juridical.ObjectId
                                  LEFT JOIN _tmpPartner ON _tmpPartner.PartnerId = CASE WHEN MIContainer.MovementDescId = zc_Movement_Service() THEN MIContainer.ObjectId_Analyzer ELSE MovementLinkObject_Partner.ObjectId END

                              LEFT JOIN _tmpGoods ON _tmpGoods.GoodsId = MIContainer.ObjectId_Analyzer

                              LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                               ON MILinkObject_GoodsKind.MovementItemId = MIContainer.MovementItemId
                                                              AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                              LEFT JOIN MovementItemLinkObject AS MILinkObject_Branch
                                                               ON MILinkObject_Branch.MovementItemId = MIContainer.MovementItemId
                                                              AND MILinkObject_Branch.DescId = zc_MILinkObject_Branch()

                              LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                                   ON ObjectLink_Goods_Measure.ObjectId = MIContainer.ObjectId_Analyzer
                                                  AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                              LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                                    ON ObjectFloat_Weight.ObjectId = MIContainer.ObjectId_Analyzer
                                                   AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()

                         WHERE (_tmpJuridical.JuridicalId > 0 OR vbIsJuridical = FALSE)
                           AND (_tmpPartner.PartnerId > 0 OR vbIsPartner = FALSE)
                           AND (_tmpGoods.GoodsId > 0 OR vbIsGoods = FALSE)
                           AND (MILinkObject_Branch.ObjectId = inBranchId OR COALESCE (inBranchId, 0) = 0)
                         GROUP BY CASE WHEN inIsPartner = TRUE THEN ContainerLO_Juridical.ObjectId ELSE 0 END
                                , CASE WHEN inIsPartner = TRUE THEN ContainerLinkObject_Contract.ObjectId ELSE 0 END
                                , CASE WHEN inIsPartner = FALSE THEN 0 WHEN MIContainer.MovementDescId = zc_Movement_Service() THEN MIContainer.ObjectId_Analyzer ELSE MovementLinkObject_Partner.ObjectId END
                                , ContainerLinkObject_InfoMoney.ObjectId
                                , COALESCE (MILinkObject_Branch.ObjectId, 0)
                                -- , MIContainer.AccountId
                                , _tmpGoods.TradeMarkId
                                , CASE WHEN inIsGoods = TRUE THEN MIContainer.ObjectId_Analyzer ELSE 0 END
                                , CASE WHEN inIsGoods = TRUE THEN COALESCE (MILinkObject_GoodsKind.ObjectId, 0) ELSE 0 END
                        )
     SELECT Object_GoodsGroup.ValueData AS GoodsGroupName
          , ObjectString_Goods_GroupNameFull.ValueData AS GoodsGroupNameFull
          , Object_Goods.ObjectCode     AS GoodsCode
          , Object_Goods.ValueData      AS GoodsName
          , Object_GoodsKind.ValueData  AS GoodsKindName
          , Object_Measure.ValueData    AS MeasureName
          , Object_TradeMark.ValueData  AS TradeMarkName
          , Object_GoodsTag.ValueData   AS GoodsTagName
          , Object_GoodsGroupStat.ValueData  AS GoodsGroupStatName

          , Object_JuridicalGroup.ValueData  AS JuridicalGroupName
          , Object_Branch.ObjectCode    AS BranchCode
          , Object_Branch.ValueData     AS BranchName
          , Object_Juridical.ObjectCode AS JuridicalCode
          , Object_Juridical.ValueData  AS JuridicalName
          , ObjectHistory_JuridicalDetails_View.OKPO

          , Object_Retail.ValueData       AS RetailName
          , Object_RetailReport.ValueData AS RetailReportName
/*
       , Object_Area.ValueData                AS AreaName
       , Object_PartnerTag.ValueData          AS PartnerTagName
       , Object_Region.ValueData              AS RegionName
       , Object_Province.ValueData            AS ProvinceName
       , Object_CityKind.ValueData            AS CityKindName
       , Object_Street_View.CityName          AS CityName
       , Object_Street_View.ProvinceCityName  AS ProvinceCityName
       , Object_Street_View.StreetKindName    AS StreetKindName
       , Object_Street_View.Name              AS StreetName

       , Object_Partner.Id                          AS PartnerId
       , Object_Partner.ObjectCode                  AS PartnerCode
       , Object_Partner.ValueData                   AS PartnerName*/

          , View_Partner_Address.AreaName
          , View_Partner_Address.PartnerTagName
          , View_Partner_Address.RegionName
          , View_Partner_Address.ProvinceName
          , View_Partner_Address.CityKindName
          , View_Partner_Address.CityName
          , View_Partner_Address.ProvinceCityName
          , View_Partner_Address.StreetKindName
          , View_Partner_Address.StreetName

          , View_Partner_Address.PartnerId
          , View_Partner_Address.PartnerCode
          , View_Partner_Address.PartnerName

          , View_Contract_InvNumber.ContractCode
          , View_Contract_InvNumber.InvNumber              AS ContractNumber
          , View_Contract_InvNumber.ContractTagName

          , View_Personal.PersonalName       AS PersonalName
          , View_Personal.UnitName           AS UnitName_Personal
          , Object_BranchPersonal.ValueData  AS BranchName_Personal

          , View_PersonalTrade.PersonalName  AS PersonalTradeName
          , View_PersonalTrade.UnitName      AS UnitName_PersonalTrade

          , View_InfoMoney.InfoMoneyGroupName              AS InfoMoneyGroupName
          , View_InfoMoney.InfoMoneyDestinationName        AS InfoMoneyDestinationName
          , View_InfoMoney.InfoMoneyCode                   AS InfoMoneyCode
          , View_InfoMoney.InfoMoneyName                   AS InfoMoneyName
          , View_InfoMoney.InfoMoneyName_all               AS InfoMoneyName_all

          , Object_Account_View.AccountName_all AS AccountName

         , tmpOperationGroup.Sale_Summ          :: TFloat  AS Sale_Summ
         , tmpOperationGroup.Sale_Summ_10200    :: TFloat  AS Sale_Summ_10200
         , tmpOperationGroup.Sale_Summ_10300    :: TFloat  AS Sale_Summ_10300
         , tmpOperationGroup.Sale_SummCost      :: TFloat  AS Sale_SummCost
         , tmpOperationGroup.Sale_SummCost_10500:: TFloat  AS Sale_SummCost_10500
         , tmpOperationGroup.Sale_SummCost_40200:: TFloat  AS Sale_SummCost_40200

         , tmpOperationGroup.Sale_Amount_Weight :: TFloat  AS Sale_Amount_Weight
         , tmpOperationGroup.Sale_Amount_Sh     :: TFloat  AS Sale_Amount_Sh

         , tmpOperationGroup.Sale_AmountPartner_Weight :: TFloat AS Sale_AmountPartner_Weight
         , tmpOperationGroup.Sale_AmountPartner_Sh     :: TFloat AS Sale_AmountPartner_Sh

         , tmpOperationGroup.Return_Summ          :: TFloat AS Return_Summ
         , tmpOperationGroup.Return_SummCost      :: TFloat AS Return_SummCost
         , tmpOperationGroup.Return_SummCost_40200:: TFloat AS Return_SummCost_40200

         , tmpOperationGroup.Return_Amount_Weight :: TFloat AS Return_Amount_Weight
         , tmpOperationGroup.Return_Amount_Sh     :: TFloat AS Return_Amount_Sh

         , tmpOperationGroup.Return_AmountPartner_Weight :: TFloat AS Return_AmountPartner_Weight
         , tmpOperationGroup.Return_AmountPartner_Sh     :: TFloat AS Return_AmountPartner_Sh

         , tmpOperationGroup.Sale_Amount_10500_Weight    :: TFloat AS Sale_Amount_10500_Weight
         , tmpOperationGroup.Sale_Amount_40200_Weight    :: TFloat AS Sale_Amount_40200_Weight
         , tmpOperationGroup.Return_Amount_40200_Weight  :: TFloat AS Return_Amount_40200_Weight

     FROM tmpOperationGroup

          LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = tmpOperationGroup.BranchId
          LEFT JOIN Object AS Object_Goods on Object_Goods.Id = tmpOperationGroup.GoodsId
          LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpOperationGroup.GoodsKindId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_TradeMark
                               ON ObjectLink_Goods_TradeMark.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_TradeMark.DescId = zc_ObjectLink_Goods_TradeMark()
          LEFT JOIN Object AS Object_TradeMark ON Object_TradeMark.Id = COALESCE (ObjectLink_Goods_TradeMark.ChildObjectId, tmpOperationGroup.TradeMarkId)

          LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                               ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
          LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsTag
                               ON ObjectLink_Goods_GoodsTag.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsTag.DescId = zc_ObjectLink_Goods_GoodsTag()
          LEFT JOIN Object AS Object_GoodsTag ON Object_GoodsTag.Id = ObjectLink_Goods_GoodsTag.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroupStat
                               ON ObjectLink_Goods_GoodsGroupStat.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsGroupStat.DescId = zc_ObjectLink_Goods_GoodsGroupStat()
          LEFT JOIN Object AS Object_GoodsGroupStat ON Object_GoodsGroupStat.Id = ObjectLink_Goods_GoodsGroupStat.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Goods_GoodsGroup
                               ON ObjectLink_Goods_GoodsGroup.ObjectId = Object_Goods.Id
                              AND ObjectLink_Goods_GoodsGroup.DescId = zc_ObjectLink_Goods_GoodsGroup()
          LEFT JOIN Object AS Object_GoodsGroup ON Object_GoodsGroup.Id = ObjectLink_Goods_GoodsGroup.ChildObjectId

          LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = tmpOperationGroup.JuridicalId

          LEFT JOIN ObjectString AS ObjectString_Goods_GroupNameFull
                                 ON ObjectString_Goods_GroupNameFull.ObjectId = Object_Goods.Id
                                AND ObjectString_Goods_GroupNameFull.DescId = zc_ObjectString_Goods_GroupNameFull()

          LEFT JOIN tmpPartnerAddress AS View_Partner_Address ON View_Partner_Address.PartnerId = tmpOperationGroup.PartnerId

          LEFT JOIN Object AS Object_Partner ON Object_Partner.Id = tmpOperationGroup.PartnerId

          LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                               ON ObjectLink_Juridical_Retail.ObjectId = Object_Juridical.Id
                              AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
          LEFT JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Juridical_Retail.ChildObjectId
          LEFT JOIN ObjectLink AS ObjectLink_Juridical_RetailReport
                               ON ObjectLink_Juridical_RetailReport.ObjectId = Object_Juridical.Id
                              AND ObjectLink_Juridical_RetailReport.DescId = zc_ObjectLink_Juridical_RetailReport()
          LEFT JOIN Object AS Object_RetailReport ON Object_RetailReport.Id = ObjectLink_Juridical_RetailReport.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Juridical_JuridicalGroup
                               ON ObjectLink_Juridical_JuridicalGroup.ObjectId = Object_Juridical.Id
                              AND ObjectLink_Juridical_JuridicalGroup.DescId = zc_ObjectLink_Juridical_JuridicalGroup()
          LEFT JOIN Object AS Object_JuridicalGroup ON Object_JuridicalGroup.Id = ObjectLink_Juridical_JuridicalGroup.ChildObjectId

          LEFT JOIN ObjectHistory_JuridicalDetails_View ON ObjectHistory_JuridicalDetails_View.JuridicalId = Object_Juridical.Id
          LEFT JOIN Object_Contract_InvNumber_View AS View_Contract_InvNumber ON View_Contract_InvNumber.ContractId = tmpOperationGroup.ContractId
          LEFT JOIN Object_InfoMoney_View AS View_InfoMoney ON View_InfoMoney.InfoMoneyId = tmpOperationGroup.InfoMoneyId

          LEFT JOIN ObjectLink AS ObjectLink_Partner_Personal
                               ON ObjectLink_Partner_Personal.ObjectId = tmpOperationGroup.PartnerId
                              AND ObjectLink_Partner_Personal.DescId = zc_ObjectLink_Partner_Personal()
          LEFT JOIN Object_Personal_View AS View_Personal ON View_Personal.PersonalId = ObjectLink_Partner_Personal.ChildObjectId
          LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                               ON ObjectLink_Unit_Branch.ObjectId = View_Personal.UnitId
                              AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
          LEFT JOIN Object AS Object_BranchPersonal ON Object_BranchPersonal.Id = ObjectLink_Unit_Branch.ChildObjectId

          LEFT JOIN ObjectLink AS ObjectLink_Partner_PersonalTrade
                               ON ObjectLink_Partner_PersonalTrade.ObjectId = tmpOperationGroup.PartnerId
                              AND ObjectLink_Partner_PersonalTrade.DescId = zc_ObjectLink_Partner_PersonalTrade()
          LEFT JOIN Object_Personal_View AS View_PersonalTrade ON View_PersonalTrade.PersonalId = ObjectLink_Partner_PersonalTrade.ChildObjectId

          LEFT JOIN Object_Account_View ON Object_Account_View.AccountId = tmpOperationGroup.ChildAccountId
    ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 11.01.15                                        * all
 12.12.14                                        * all
 27.10.14                                        * add inIsPartner AND inIsGoods
 13.09.14                                        * add GoodsTagName and GroupStatName and BranchName and JuridicalGroupName
 11.07.14                                        * add RetailName and OKPO
 06.05.14                                        * add GoodsGroupNameFull
 28.03.14                                        * all
 06.02.14         *
*/

-- ����
-- SELECT * FROM gpReport_GoodsMI_SaleReturnIn (inStartDate:= '01.11.2014', inEndDate:= '30.11.2014', inBranchId:= 0, inAreaId:= 0, inRetailId:= 1, inJuridicalId:= 0, inPaidKindId:= 0, inTradeMarkId:= 0, inGoodsGroupId:= 0, inInfoMoneyId:= 0, inIsPartner:= TRUE, inIsTradeMark:= FALSE, inIsGoods:= FALSE, inSession:= zfCalc_UserAdmin());
