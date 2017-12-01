
DROP FUNCTION IF EXISTS gpSelect_Report_Promo_Plan_Plan(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Integer,   --������������� 
    TVarChar   --������ ������������
);
DROP FUNCTION IF EXISTS gpSelect_Report_Promo_Plan(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Boolean,   --�������� ������ �����
    Boolean,   --�������� ������ �������
    Integer,   --������������� 
    TVarChar   --������ ������������
);
DROP FUNCTION IF EXISTS gpSelect_Report_Promo_Plan(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Boolean,   --�������� ������ �����
    Boolean,   --�������� ������ �������
    Integer,   --������������� 
    Integer,   --������������� ��� ������
    TVarChar   --������ ������������
);
DROP FUNCTION IF EXISTS gpSelect_Report_Promo_Plan(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Boolean,   --�������� ������ �����
    Boolean,   --�������� ������ �������
    Boolean,   --�������� ������ �������
    Integer,   --������������� 
    Integer,   --������������� ��� ������
    TVarChar   --������ ������������
);

DROP FUNCTION IF EXISTS gpSelect_Report_Promo_Plan(
    TDateTime, --���� ������ �������
    TDateTime, --���� ��������� �������
    Boolean,   --�������� ������ �����
    Boolean,   --�������� ������ �������
    Boolean,   --�������� ������ �������
    Integer,   --������������� 
    TVarChar   --������ ������������
);


CREATE OR REPLACE FUNCTION gpSelect_Report_Promo_Plan(
    IN inStartDate      TDateTime, --���� ������ �������
    IN inEndDate        TDateTime, --���� ��������� �������
    IN inIsPromo        Boolean,   --�������� ������ �����
    IN inIsTender       Boolean,   --�������� ������ �������
    IN inIsUnitSale     Boolean,   --�������� ������ �������
    IN inUnitId         Integer,   --������������� 
    IN inSession        TVarChar   --������ ������������
)

RETURNS TABLE(
      MovementId                Integer   --�� ��������� �����
    , MovementItemId            Integer
    , InvNumber                 Integer   --� ��������� �����
    , UnitName                  TVarChar  --�����
    , UnitCode_Sale             Integer   -- ��� ����� �������
    , UnitName_Sale             TVarChar  -- ����� �������    
    , PersonalTradeName         TVarChar  --������������� ������������� ������������� ������
    , UnitCode_PersonalTrade    Integer
    , UnitName_PersonalTrade    TVarChar
    , BranchCode_PersonalTrade  Integer
    , BranchName_PersonalTrade  TVarChar
    , PersonalName              TVarChar  --������������� ������������� �������������� ������	
    , DateStartSale             TDateTime --���� �������� �� ��������� �����
    , DeteFinalSale             TDateTime --���� �������� �� ��������� �����
    , DateStartPromo            TDateTime --���� ���������� �����
    , DateFinalPromo            TDateTime --���� ���������� �����
    , MonthPromo                TDateTime --����� �����
    , CountDaysPromo            Integer   -- ����� ���� �����
    , CountDaysEndPromo         Integer   -- ����� ���� �� ��������� �����
    , RetailName                TBlob     --�����������
    , PartnerName               TBlob     --�����������
    , GoodsName                 TVarChar  --�������
    , GoodsCode                 Integer   --��� �������
    , MeasureName               TVarChar  --������� ���������
    , GoodsKindName             TVarChar  --��� ��������
    , GoodsKindCompleteName     TVarChar  --��� �������� ( ����������)
    , GoodsKindName_Sale        TVarChar  -- ������ ���.��. ���.������
    , GoodsKindName_List        TVarChar  --��� ������ (���������)
    , TradeMarkName             TVarChar  --�������� �����
    , isPromo                   Boolean   --����� (��/���)
    , Checked                   Boolean   --����������� (��/���)
    , GoodsWeight               TFloat    --���
    
    , AmountPlan1         TFloat -- ���-�� ���� �������� �� ��.
    , AmountPlan2         TFloat -- ���-�� ���� �������� �� ��.
    , AmountPlan3         TFloat -- ���-�� ���� �������� �� ��.
    , AmountPlan4         TFloat -- ���-�� ���� �������� �� ��.
    , AmountPlan5         TFloat -- ���-�� ���� �������� �� ��.
    , AmountPlan6         TFloat -- ���-�� ���� �������� �� ��.
    , AmountPlan7         TFloat -- ���-�� ���� �������� �� ��.

    , AmountPlan1_Wh      TFloat --
    , AmountPlan2_Wh      TFloat --
    , AmountPlan3_Wh      TFloat --
    , AmountPlan4_Wh      TFloat --
    , AmountPlan5_Wh      TFloat --
    , AmountPlan6_Wh      TFloat --
    , AmountPlan7_Wh      TFloat --
     
    , AmountSale1         TFloat
    , AmountSale2         TFloat
    , AmountSale3         TFloat
    , AmountSale4         TFloat
    , AmountSale5         TFloat
    , AmountSale6         TFloat
    , AmountSale7         TFloat
       
    , AmountPlanMin_Calc1  TFloat
    , AmountPlanMin_Calc2  TFloat
    , AmountPlanMin_Calc3  TFloat
    , AmountPlanMin_Calc4  TFloat
    , AmountPlanMin_Calc5  TFloat
    , AmountPlanMin_Calc6  TFloat
    , AmountPlanMin_Calc7  TFloat

    , TotalAmountPlan_Wh TFloat
    , TotalAmountSale    TFloat
    , TotalAmountPlanMin_Calc TFloat
    , TotalAmount_Diff   TFloat
    , Persent_Diff       TFloat

    , isPlan1             Boolean
    , isPlan2             Boolean
    , isPlan3             Boolean
    , isPlan4             Boolean
    , isPlan5             Boolean
    , isPlan6             Boolean
    , isPlan7             Boolean

    , Color_EndDate       Integer
    , isEndDate           Boolean
    , isSale              Boolean
    )
AS
$BODY$
    DECLARE vbUserId Integer;
    DECLARE vbShowAll Boolean;
    DECLARE vbDayStart integer;
    DECLARE vbDayEnd integer;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_MI_SheetWorkTime());
     vbUserId:= lpGetUserBySession (inSession);


     vbDayStart := CASE EXTRACT (DOW FROM inStartDate) WHEN 0 THEN 7 ELSE EXTRACT (DOW FROM inStartDate) END  ::integer;
     vbDayEnd   := CASE EXTRACT (DOW FROM inEndDate)   WHEN 0 THEN 7 ELSE EXTRACT (DOW FROM inEndDate) END  ::integer;
     
    -- ������� ��� ��������� ��� ������ (���������) �� GoodsListSale
    CREATE TEMP TABLE _tmpWord_Split_from (WordList TVarChar) ON COMMIT DROP;
    CREATE TEMP TABLE _tmpWord_Split_to (Ord Integer, Word TVarChar, WordList TVarChar) ON COMMIT DROP;

    INSERT INTO _tmpWord_Split_from (WordList) 
            SELECT DISTINCT ObjectString_GoodsKind.ValueData AS WordList
            FROM ObjectString AS ObjectString_GoodsKind
            WHERE ObjectString_GoodsKind.DescId = zc_ObjectString_GoodsListSale_GoodsKind()
              AND ObjectString_GoodsKind.ValueData <> '';
    
    PERFORM zfSelect_Word_Split (inSep:= ',', inUserId:= vbUserId);
    --
    
    -- ���������
    RETURN QUERY
     WITH tmpGoodsKind AS (SELECT _tmpWord_Split_to.WordList, Object.ValueData :: TVarChar AS GoodsKindName
                           FROM _tmpWord_Split_to 
                                LEFT JOIN Object ON Object.Id = _tmpWord_Split_to.Word :: Integer
                           GROUP BY _tmpWord_Split_to.WordList, Object.ValueData
                           )
        --������� ��������� �������
        , tmpMov_Sale_All AS (SELECT MIFloat_PromoMovement.ValueData ::Integer                                       AS MovementId_Promo
                                   , Movement_Sale.OperDate                                                          AS OperDate
                                   , MI_Sale.ObjectId                                                                AS GoodsId
                                   , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)                                   AS GoodsKindId
                                   , SUM (COALESCE (MI_Sale.Amount, 0))                                              AS Amount
                                   , CASE WHEN inIsUnitSale = TRUE THEN MovementLinkObject_From.ObjectId ELSE 0 END  AS UnitId_Sale
                                   , MAX (Movement_Sale.OperDate) OVER (PARTITION BY MI_Sale.ObjectId, MIFloat_PromoMovement.ValueData) AS OperDateMax_Sale
                              FROM Movement AS Movement_Sale
                                   INNER JOIN MovementLinkObject AS MovementLinkObject_From
                                                                 ON MovementLinkObject_From.MovementId = Movement_Sale.Id
                                                                AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                                                                AND (MovementLinkObject_From.ObjectId = inUnitId OR inUnitId = 0)
                                   
                                   INNER JOIN MovementItem AS MI_Sale ON MI_Sale.MovementId = Movement_Sale.Id
                                                                     AND MI_Sale.IsErased = FALSE
                                  
                                   INNER JOIN MovementItemFloat AS MIFloat_PromoMovement
                                                                ON MIFloat_PromoMovement.MovementItemId = MI_Sale.Id
                                                               AND MIFloat_PromoMovement.DescId = zc_MIFloat_PromoMovementId()
  
                                   LEFT JOIN MovementBoolean AS MovementBoolean_Promo
                                                             ON MovementBoolean_Promo.MovementId = MIFloat_PromoMovement.ValueData ::Integer
                                                            AND MovementBoolean_Promo.DescId = zc_MovementBoolean_Promo()
                                                              
                                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                    ON MILinkObject_GoodsKind.MovementItemId = MI_Sale.Id
                                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                              WHERE Movement_Sale.DescId = zc_Movement_Sale()
                                AND Movement_Sale.OperDate BETWEEN inStartDate AND inEndDate
                                AND Movement_Sale.StatusId = zc_Enum_Status_Complete()
                                AND (  (COALESCE (MovementBoolean_Promo.ValueData, FALSE) = TRUE AND inIsPromo = TRUE) 
                                    OR (COALESCE (MovementBoolean_Promo.ValueData, FALSE) = FALSE AND inIsTender = TRUE)
                                    OR (inIsPromo = FALSE AND inIsTender = FALSE)
                                       )

                              GROUP BY MIFloat_PromoMovement.ValueData
                                     , Movement_Sale.OperDate
                                     , MI_Sale.ObjectId
                                     , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)
                                     , CASE WHEN inIsUnitSale = TRUE THEN MovementLinkObject_From.ObjectId ELSE 0 END
                              )
         -- ����������� ������� �� ����
        , tmpMovement_Sale AS (SELECT tmpSale.MovementId_Promo
                                    , tmpSale.OperDateMax_Sale
                                    , tmpSale.UnitId_Sale
                                    , tmpSale.GoodsId 
                                    , Object_Goods.ObjectCode                     AS GoodsCode 
                                    , Object_Goods.ValueData                      AS GoodsName
                                   -- , STRING_AGG (Object_GoodsKind.ValueData, '; ')  AS GoodsKindName
                                    , tmpSale.GoodsKindId                         AS GoodsKindId
                                    , COALESCE (Object_GoodsKind.ValueData, '')   AS GoodsKindName
                                    , Object_Measure.ValueData                    AS Measure
                                    , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE NULL END :: TFloat AS GoodsWeight
                                    , SUM (CASE WHEN EXTRACT (DOW FROM tmpSale.OperDate) = 1 THEN tmpSale.Amount ELSE 0 END * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Goods_Weight.ValueData, 0) ELSE 1 END) AS AmountSale1
                                    , SUM (CASE WHEN EXTRACT (DOW FROM tmpSale.OperDate) = 2 THEN tmpSale.Amount ELSE 0 END * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Goods_Weight.ValueData, 0) ELSE 1 END) AS AmountSale2
                                    , SUM (CASE WHEN EXTRACT (DOW FROM tmpSale.OperDate) = 3 THEN tmpSale.Amount ELSE 0 END * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Goods_Weight.ValueData, 0) ELSE 1 END) AS AmountSale3
                                    , SUM (CASE WHEN EXTRACT (DOW FROM tmpSale.OperDate) = 4 THEN tmpSale.Amount ELSE 0 END * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Goods_Weight.ValueData, 0) ELSE 1 END) AS AmountSale4
                                    , SUM (CASE WHEN EXTRACT (DOW FROM tmpSale.OperDate) = 5 THEN tmpSale.Amount ELSE 0 END * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Goods_Weight.ValueData, 0) ELSE 1 END) AS AmountSale5
                                    , SUM (CASE WHEN EXTRACT (DOW FROM tmpSale.OperDate) = 6 THEN tmpSale.Amount ELSE 0 END * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Goods_Weight.ValueData, 0) ELSE 1 END) AS AmountSale6
                                    , SUM (CASE WHEN EXTRACT (DOW FROM tmpSale.OperDate) = 0 THEN tmpSale.Amount ELSE 0 END * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Goods_Weight.ValueData, 0) ELSE 1 END) AS AmountSale7
                               FROM tmpMov_Sale_All AS tmpSale
                                    LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpSale.GoodsId
                                    LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpSale.GoodsKindId
                                    LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                                         ON ObjectLink_Goods_Measure.ObjectId = tmpSale.GoodsId
                                                        AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
                                    LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId
                            
                                    LEFT OUTER JOIN ObjectFloat AS ObjectFloat_Goods_Weight
                                                                ON ObjectFloat_Goods_Weight.ObjectId = tmpSale.GoodsId
                                                               AND ObjectFloat_Goods_Weight.DescId = zc_ObjectFloat_Goods_Weight()
                                                               
                               GROUP BY tmpSale.MovementId_Promo
                                      , tmpSale.GoodsId, Object_Goods.ObjectCode, Object_Goods.ValueData
                                      , tmpSale.OperDateMax_Sale
                                      , tmpSale.UnitId_Sale
                                      , tmpSale.GoodsKindId
                                      , Object_GoodsKind.ValueData
                                      , COALESCE (Object_GoodsKind.ValueData, '')
                                      , Object_Measure.ValueData
                                      , CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Goods_Weight.ValueData ELSE NULL END
                               )

        -- ��������� �����
        , tmpMovement_Promo AS (SELECT Movement_Promo.*
                                     , MovementDate_StartSale.ValueData            AS StartSale
                                     , MovementDate_EndSale.ValueData              AS EndSale
                                     , MovementLinkObject_Unit.ObjectId            AS UnitId
                                     , COALESCE (MovementBoolean_Promo.ValueData, FALSE)   :: Boolean AS isPromo  -- ����� (��/���)
                                     , COALESCE (MovementBoolean_Checked.ValueData, FALSE) :: Boolean AS Checked  -- ����������� (��/���)
                                     
                                     , CASE WHEN MovementDate_StartSale.ValueData >= inStartDate THEN EXTRACT (DOW FROM MovementDate_StartSale.ValueData) ELSE 0 END :: Integer AS DayStartSale
                                     , CASE WHEN MovementDate_EndSale.ValueData   <= inEndDate   THEN EXTRACT (DOW FROM MovementDate_EndSale.ValueData)   ELSE 0 END :: Integer AS DayEndSale
                                     
                                     , (ROUND( ((date_part('DAY', MovementDate_EndSale.ValueData - MovementDate_StartSale.ValueData)+1) / 3) ::TFloat, 0)) :: Integer  AS CountDays -- ����� ������� �����
                                FROM Movement AS Movement_Promo 
                                     LEFT JOIN MovementDate AS MovementDate_StartSale
                                                             ON MovementDate_StartSale.MovementId = Movement_Promo.Id
                                                            AND MovementDate_StartSale.DescId = zc_MovementDate_StartSale()
                                     LEFT JOIN MovementDate AS MovementDate_EndSale
                                                             ON MovementDate_EndSale.MovementId = Movement_Promo.Id
                                                            AND MovementDate_EndSale.DescId = zc_MovementDate_EndSale()
            
                                     LEFT JOIN MovementBoolean AS MovementBoolean_Checked
                                                               ON MovementBoolean_Checked.MovementId = Movement_Promo.Id
                                                              AND MovementBoolean_Checked.DescId = zc_MovementBoolean_Checked()
                             
                                     LEFT JOIN MovementBoolean AS MovementBoolean_Promo
                                                               ON MovementBoolean_Promo.MovementId = Movement_Promo.Id
                                                              AND MovementBoolean_Promo.DescId = zc_MovementBoolean_Promo()
            
                                     LEFT JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                                  ON MovementLinkObject_Unit.MovementId = Movement_Promo.Id
                                                                 AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                                                                 
                                WHERE Movement_Promo.DescId = zc_Movement_Promo()
                                 AND ( ( MovementDate_StartSale.ValueData BETWEEN inStartDate AND inEndDate
                                        OR
                                        inStartDate BETWEEN MovementDate_StartSale.ValueData AND MovementDate_EndSale.ValueData
                                       )
                                   AND (MovementLinkObject_Unit.ObjectId = inUnitId OR inUnitId = 0)
                                   AND Movement_Promo.StatusId = zc_Enum_Status_Complete()
                                   AND (  (COALESCE (MovementBoolean_Promo.ValueData, FALSE) = TRUE AND inIsPromo = TRUE) 
                                       OR (COALESCE (MovementBoolean_Promo.ValueData, FALSE) = FALSE AND inIsTender = TRUE)
                                       OR (inIsPromo = FALSE AND inIsTender = FALSE)
                                       )
                                      )
                               )

        -- ��� ���. ����� ���� �� ��������
        , tmpMov AS (SELECT tmpMovement_Promo.Id AS MovementId_Promo
                          , tmpMovement_Promo.DayStartSale
                          , tmpMovement_Promo.DayEndSale
                          , tmpMovement_Promo.CountDays
                     FROM tmpMovement_Promo
                   UNION 
                     SELECT tmp.MovementId_Promo AS MovementId_Promo
                          , tmp.DayStartSale
                          , tmp.DayEndSale
                          , tmp.CountDays
                     FROM (SELECT tmpMov_Sale_All.*
                                , tmp.DayStartSale
                                , tmp.DayEndSale   
                                , tmp.CountDays      
                           FROM tmpMov_Sale_All
                                LEFT JOIN ( SELECT tmp.MovementId_Promo
                                                 , CASE WHEN MovementDate_StartSale.ValueData >= inStartDate THEN EXTRACT (DOW FROM MovementDate_StartSale.ValueData) ELSE 0 END :: Integer AS DayStartSale
                                                 , CASE WHEN MovementDate_EndSale.ValueData   <= inEndDate   THEN EXTRACT (DOW FROM MovementDate_EndSale.ValueData)   ELSE 0 END :: Integer AS DayEndSale     
                                                 , (ROUND( ((date_part('DAY', MovementDate_EndSale.ValueData - MovementDate_StartSale.ValueData)+1) / 3) ::TFloat, 0))               :: Integer AS CountDays -- ����� ������� �����
                                            FROM (SELECT DISTINCT tmpMov_Sale_All.MovementId_Promo FROM tmpMov_Sale_All) AS tmp
                                                 LEFT JOIN MovementDate AS MovementDate_StartSale
                                                        ON MovementDate_StartSale.MovementId = tmp.MovementId_Promo
                                                       AND MovementDate_StartSale.DescId = zc_MovementDate_StartSale()
                                                 LEFT JOIN MovementDate AS MovementDate_EndSale
                                                        ON MovementDate_EndSale.MovementId = tmp.MovementId_Promo
                                                       AND MovementDate_EndSale.DescId = zc_MovementDate_EndSale()
                                            ) AS tmp ON tmp.MovementId_Promo = tmpMov_Sale_All.MovementId_Promo
                           ) AS tmp
                     )

        --C����� ���.�����
        , tmpMI_Promo AS (SELECT MI_PromoGoods.*
                               , CASE WHEN vbDayStart  = 1                   AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale = 1)                                                                        THEN MIFloat_Plan1.ValueData ELSE 0 END AS AmountPlan1
                               , CASE WHEN vbDayStart <= 2 AND vbDayEnd >= 2 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 2) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 2) THEN MIFloat_Plan2.ValueData ELSE 0 END AS AmountPlan2
                               , CASE WHEN vbDayStart <= 3 AND vbDayEnd >= 3 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 3) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 3) THEN MIFloat_Plan3.ValueData ELSE 0 END AS AmountPlan3
                               , CASE WHEN vbDayStart <= 4 AND vbDayEnd >= 4 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 4) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 4) THEN MIFloat_Plan4.ValueData ELSE 0 END AS AmountPlan4
                               , CASE WHEN vbDayStart <= 5 AND vbDayEnd >= 5 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 5) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 5) THEN MIFloat_Plan5.ValueData ELSE 0 END AS AmountPlan5
                               , CASE WHEN vbDayStart <= 6 AND vbDayEnd >= 6 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 6) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 6) THEN MIFloat_Plan6.ValueData ELSE 0 END AS AmountPlan6
                               , CASE WHEN vbDayStart <= 7 AND vbDayEnd  = 7 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 7) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale  = 7) THEN MIFloat_Plan7.ValueData ELSE 0 END AS AmountPlan7
                               
                               , CASE WHEN vbDayStart  = 1                   AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale = 1)                                                                        THEN TRUE ELSE FALSE END AS isPlan1
                               , CASE WHEN vbDayStart <= 2 AND vbDayEnd >= 2 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 2) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 2) THEN TRUE ELSE FALSE END AS isPlan2
                               , CASE WHEN vbDayStart <= 3 AND vbDayEnd >= 3 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 3) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 3) THEN TRUE ELSE FALSE END AS isPlan3
                               , CASE WHEN vbDayStart <= 4 AND vbDayEnd >= 4 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 4) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 4) THEN TRUE ELSE FALSE END AS isPlan4
                               , CASE WHEN vbDayStart <= 5 AND vbDayEnd >= 5 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 5) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 5) THEN TRUE ELSE FALSE END AS isPlan5
                               , CASE WHEN vbDayStart <= 6 AND vbDayEnd >= 6 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 6) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale >= 6) THEN TRUE ELSE FALSE END AS isPlan6
                               , CASE WHEN vbDayStart <= 7 AND vbDayEnd  = 7 AND (Movement_Promo.DayStartSale = 0 OR Movement_Promo.DayStartSale <= 7) AND (Movement_Promo.DayEndSale = 0 OR Movement_Promo.DayEndSale  = 7) THEN TRUE ELSE FALSE END AS isPlan7


                               , CAST (COALESCE (MI_PromoGoods.AmountPlanMin, 0) / 2    AS NUMERIC (16,2))  AS AmountPlanMin_50
                               , CAST (COALESCE (MI_PromoGoods.AmountPlanMin, 0) * 0.3  AS NUMERIC (16,2))  AS AmountPlanMin_30
                               , CAST (COALESCE (MI_PromoGoods.AmountPlanMin, 0) * 0.2  AS NUMERIC (16,2))  AS AmountPlanMin_20
                               
                          FROM (SELECT DISTINCT tmpMov.MovementId_Promo, tmpMov.DayStartSale, tmpMov.DayEndSale FROM tmpMov) AS Movement_Promo
                               LEFT OUTER JOIN MovementItem_PromoGoods_View AS MI_PromoGoods
                                                                            ON MI_PromoGoods.MovementId = Movement_Promo.MovementId_Promo
                                                                           AND MI_PromoGoods.IsErased = FALSE
                               LEFT JOIN MovementItemFloat AS MIFloat_Plan1
                                                           ON MIFloat_Plan1.MovementItemId = MI_PromoGoods.Id
                                                          AND MIFloat_Plan1.DescId = zc_MIFloat_Plan1()
                               LEFT JOIN MovementItemFloat AS MIFloat_Plan2
                                                           ON MIFloat_Plan2.MovementItemId = MI_PromoGoods.Id
                                                          AND MIFloat_Plan2.DescId = zc_MIFloat_Plan2()
                               LEFT JOIN MovementItemFloat AS MIFloat_Plan3
                                                           ON MIFloat_Plan3.MovementItemId = MI_PromoGoods.Id
                                                          AND MIFloat_Plan3.DescId = zc_MIFloat_Plan3()
                               LEFT JOIN MovementItemFloat AS MIFloat_Plan4
                                                           ON MIFloat_Plan4.MovementItemId = MI_PromoGoods.Id
                                                          AND MIFloat_Plan4.DescId = zc_MIFloat_Plan4()
                               LEFT JOIN MovementItemFloat AS MIFloat_Plan5
                                                           ON MIFloat_Plan5.MovementItemId = MI_PromoGoods.Id
                                                          AND MIFloat_Plan5.DescId = zc_MIFloat_Plan5()
                               LEFT JOIN MovementItemFloat AS MIFloat_Plan6
                                                           ON MIFloat_Plan6.MovementItemId = MI_PromoGoods.Id
                                                          AND MIFloat_Plan6.DescId = zc_MIFloat_Plan6()
                               LEFT JOIN MovementItemFloat AS MIFloat_Plan7
                                                           ON MIFloat_Plan7.MovementItemId = MI_PromoGoods.Id
                                                          AND MIFloat_Plan7.DescId = zc_MIFloat_Plan7()
                         )

        -- ������ ������ , ��� ������� ����� � ������
        , tmpGoods AS (SELECT tmpMI_Promo.MovementId           AS MovementId_Promo
                            , tmpMI_Promo.GoodsId              AS GoodsId
                            , tmpMI_Promo.GoodsKindCompleteId  AS GoodsKindCompleteId
                            , 0                                AS UnitId_Sale
                       FROM tmpMI_Promo
                      UNION
                       SELECT tmpMovement_Sale.MovementId_Promo AS MovementId_Promo
                            , tmpMovement_Sale.GoodsId          AS GoodsId
                            , tmpMovement_Sale.GoodsKindId      AS GoodsKindCompleteId
                            , tmpMovement_Sale.UnitId_Sale      AS UnitId_Sale
                       FROM tmpMovement_Sale
                       )

   -- ������ ��� ������
   , tmpOperDate AS (SELECT GENERATE_SERIES (inStartDate,inEndDate, '1 DAY' :: INTERVAL) AS OperDate)
   
   -- ������ ����� ���.�����
   , tmpPromoDetail AS (SELECT Movement_Promo.*
                             , tmpMov.CountDays
                             , (Movement_Promo.StartSale + ('' ||tmpMov.CountDays || 'DAY ')  :: interval )   ::TDateTime AS Date1
                             , (Movement_Promo.StartSale + ('' ||2*tmpMov.CountDays || 'DAY ')  :: interval ) ::TDateTime AS Date2
                        FROM (SELECT DISTINCT tmpMov.MovementId_Promo, tmpMov.CountDays FROM tmpMov) AS tmpMov
                             LEFT JOIN Movement_Promo_View AS Movement_Promo ON Movement_Promo.Id = tmpMov.MovementId_Promo
                        )
   , tmpPeriodPlanMin  AS (SELECT tmp.Id
                                , SUM (CASE WHEN tmp.Number = 1 THEN NumPeriod ELSE 0 END) AS NumPeriod1
                                , SUM (CASE WHEN tmp.Number = 2 THEN NumPeriod ELSE 0 END) AS NumPeriod2
                                , SUM (CASE WHEN tmp.Number = 3 THEN NumPeriod ELSE 0 END) AS NumPeriod3
                                , SUM (CASE WHEN tmp.Number = 4 THEN NumPeriod ELSE 0 END) AS NumPeriod4
                                , SUM (CASE WHEN tmp.Number = 5 THEN NumPeriod ELSE 0 END) AS NumPeriod5
                                , SUM (CASE WHEN tmp.Number = 6 THEN NumPeriod ELSE 0 END) AS NumPeriod6
                                , SUM (CASE WHEN tmp.Number = 7 THEN NumPeriod ELSE 0 END) AS NumPeriod7
                           FROM (SELECT tmpPromoDetail.Id
                                      , tmpWeekDay.Number
                                      , CASE WHEN tmpOperDate.OperDate >= tmpPromoDetail.StartSale AND tmpOperDate.OperDate < tmpPromoDetail.Date1   THEN 1
                                             WHEN tmpOperDate.OperDate >= tmpPromoDetail.Date1     AND tmpOperDate.OperDate < tmpPromoDetail.Date2   THEN 2
                                             WHEN tmpOperDate.OperDate >= tmpPromoDetail.Date2     AND tmpOperDate.OperDate < tmpPromoDetail.EndSale THEN 3
                                             ELSE 0 END NumPeriod
                                 FROM tmpOperDate
                                      LEFT JOIN zfCalc_DayOfWeekName (tmpOperDate.OperDate) AS tmpWeekDay ON 1=1
                                      LEFT JOIN tmpPromoDetail ON 1 = 1
                                 ) AS tmp
                           GROUP BY tmp.Id
                          )

   , tmpData AS (SELECT 
                     Movement_Promo.Id                 --�� ��������� �����
                   , MI_PromoGoods.Id                    AS MovementItemId
                   , Movement_Promo.InvNumber          --� ��������� �����
                   , Movement_Promo.UnitName           --�����
                   
                   , Object_UnitSale.ObjectCode          AS UnitCode_Sale   -- ��� ����� �������
                   , Object_UnitSale.ValueData           AS UnitName_Sale   -- ����� �������
                   
                   , Movement_Promo.PersonalTradeName  --������������� ������������� ������������� ������
                   
                   , Object_Unit.ObjectCode              AS UnitCode_PersonalTrade
                   , Object_Unit.ValueData               AS UnitName_PersonalTrade
                   , Object_Branch.ObjectCode            AS BranchCode_PersonalTrade
                   , Object_Branch.ValueData             AS BranchName_PersonalTrade
                   
                   , Movement_Promo.PersonalName       --������������� ������������� �������������� ������
                   , Movement_Promo.StartSale          --���� ������ �������� �� ��������� ����
                   , Movement_Promo.EndSale            --���� ��������� �������� �� ��������� ����
                   , Movement_Promo.StartPromo         --���� ������ �����
                   , Movement_Promo.EndPromo           --���� ��������� �����
                   , Movement_Promo.MonthPromo         --����� �����
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN ( date_part('DAY', Movement_Promo.EndSale - Movement_Promo.StartSale) + 1) ELSE 0 END :: Integer  AS CountDaysPromo
         
                   , COALESCE ((SELECT STRING_AGG (DISTINCT COALESCE (MovementString_Retail.ValueData, Object_Retail.ValueData),'; ')
                                FROM Movement AS Movement_PromoPartner
                                   INNER JOIN MovementItem AS MI_PromoPartner
                                                           ON MI_PromoPartner.MovementId = Movement_PromoPartner.ID
                                                          AND MI_PromoPartner.DescId     = zc_MI_Master()
                                                          AND MI_PromoPartner.IsErased   = FALSE
                                   LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                                        ON ObjectLink_Partner_Juridical.ObjectId = MI_PromoPartner.ObjectId
                                                       AND ObjectLink_Partner_Juridical.DescId   = zc_ObjectLink_Partner_Juridical()
                                   LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                                        ON ObjectLink_Juridical_Retail.ObjectId = COALESCE (ObjectLink_Partner_Juridical.ChildObjectId, MI_PromoPartner.ObjectId)
                                                       AND ObjectLink_Juridical_Retail.DescId   = zc_ObjectLink_Juridical_Retail()
                                   LEFT JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Juridical_Retail.ChildObjectId
                                   
                                   LEFT OUTER JOIN MovementString AS MovementString_Retail
                                                                  ON MovementString_Retail.MovementId = Movement_PromoPartner.Id
                                                                 AND MovementString_Retail.DescId = zc_MovementString_Retail()
                                                                 AND MovementString_Retail.ValueData <> ''
                                               
                                WHERE Movement_PromoPartner.ParentId = Movement_Promo.Id
                                  AND Movement_PromoPartner.DescId   = zc_Movement_PromoPartner()
                                  AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
                               )
                     , (SELECT STRING_AGG (DISTINCT Object.ValueData,'; ')
                        FROM
                           Movement AS Movement_PromoPartner
                           INNER JOIN MovementLinkObject AS MLO_Partner
                                                         ON MLO_Partner.MovementId = Movement_PromoPartner.ID
                                                        AND MLO_Partner.DescId     = zc_MovementLinkObject_Partner()
                           INNER JOIN Object ON Object.Id = MLO_Partner.ObjectId
                        WHERE Movement_PromoPartner.ParentId = Movement_Promo.Id
                          AND Movement_PromoPartner.DescId   = zc_Movement_PromoPartner()
                          AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
                         ))::TBlob AS RetailName
                   , RetailName AS PartnerName
          
                   , COALESCE (MI_PromoGoods.GoodsName, tmpMovement_Sale.GoodsName) :: TVarchar AS GoodsName
                   , COALESCE (MI_PromoGoods.GoodsCode, tmpMovement_Sale.GoodsCode) :: Integer  AS GoodsCode
                   , COALESCE (MI_PromoGoods.Measure, tmpMovement_Sale.Measure)     :: TVarchar AS Measure
                   , MI_PromoGoods.GoodsKindName                                    :: TVarchar AS GoodsKindName 
                   , MI_PromoGoods.GoodsKindCompleteName                            :: TVarchar AS GoodsKindCompleteName
                   , tmpMovement_Sale.GoodsKindName                                 :: TVarChar AS GoodsKindName_Sale
         
                   , (SELECT STRING_AGG (DISTINCT tmpGoodsKind.GoodsKindName,'; ')
                      FROM Movement AS Movement_PromoPartner
                         INNER JOIN MovementItem AS MI_PromoPartner
                                                 ON MI_PromoPartner.MovementId = Movement_PromoPartner.ID
                                                AND MI_PromoPartner.DescId     = zc_MI_Master()
                                                AND MI_PromoPartner.IsErased   = FALSE
                                                
                         LEFT JOIN ObjectLink AS ObjectLink_GoodsListSale_Partner
                                              ON ObjectLink_GoodsListSale_Partner.ChildObjectId = MI_PromoPartner.ObjectId
                                             AND ObjectLink_GoodsListSale_Partner.DescId = zc_ObjectLink_GoodsListSale_Partner()
                                              
                         INNER JOIN ObjectLink AS ObjectLink_GoodsListSale_Goods
                                              ON ObjectLink_GoodsListSale_Goods.ObjectId = ObjectLink_GoodsListSale_Partner.ObjectId
                                             AND ObjectLink_GoodsListSale_Goods.DescId = zc_ObjectLink_GoodsListSale_Goods()
                                             AND ObjectLink_GoodsListSale_Goods.ChildObjectId = MI_PromoGoods.GoodsId 
                         INNER JOIN ObjectString AS ObjectString_GoodsKind
                                                 ON ObjectString_GoodsKind.ObjectId = ObjectLink_GoodsListSale_Partner.ObjectId
                                                AND ObjectString_GoodsKind.DescId = zc_ObjectString_GoodsListSale_GoodsKind()
                                                
                         LEFT JOIN tmpGoodsKind ON tmpGoodsKind.WordList = ObjectString_GoodsKind.ValueData
         
                      WHERE Movement_PromoPartner.ParentId = Movement_Promo.Id
                        AND Movement_PromoPartner.DescId   = zc_Movement_PromoPartner()
                        AND Movement_PromoPartner.StatusId <> zc_Enum_Status_Erased()
                     )::TVarChar AS GoodsKindName_List
                     
                   , MI_PromoGoods.TradeMark
                   , Movement_Promo.isPromo                 AS isPromo
                   , Movement_Promo.Checked                 AS Checked
         
                   , COALESCE (CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN MI_PromoGoods.GoodsWeight ELSE NULL END, tmpMovement_Sale.GoodsWeight)  :: TFloat AS GoodsWeight
         
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN MI_PromoGoods.AmountPlan1 ELSE 0 END     ::TFloat  AS AmountPlan1
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN MI_PromoGoods.AmountPlan2 ELSE 0 END     ::TFloat  AS AmountPlan2
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN MI_PromoGoods.AmountPlan3 ELSE 0 END     ::TFloat  AS AmountPlan3
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN MI_PromoGoods.AmountPlan4 ELSE 0 END     ::TFloat  AS AmountPlan4
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN MI_PromoGoods.AmountPlan5 ELSE 0 END     ::TFloat  AS AmountPlan5
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN MI_PromoGoods.AmountPlan6 ELSE 0 END     ::TFloat  AS AmountPlan6
                   , CASE WHEN tmpGoods.UnitId_Sale = 0 THEN MI_PromoGoods.AmountPlan7 ELSE 0 END     ::TFloat  AS AmountPlan7
                   
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) * (MI_PromoGoods.AmountPlan1 * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END))    ::TFloat  AS AmountPlan1_Wh
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) * (MI_PromoGoods.AmountPlan2 * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END))    ::TFloat  AS AmountPlan2_Wh
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) * (MI_PromoGoods.AmountPlan3 * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END))    ::TFloat  AS AmountPlan3_Wh
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) * (MI_PromoGoods.AmountPlan4 * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END))    ::TFloat  AS AmountPlan4_Wh
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) * (MI_PromoGoods.AmountPlan5 * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END))    ::TFloat  AS AmountPlan5_Wh
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) * (MI_PromoGoods.AmountPlan6 * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END))    ::TFloat  AS AmountPlan6_Wh
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) * (MI_PromoGoods.AmountPlan7 * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END))    ::TFloat  AS AmountPlan7_Wh
                   
         
                   , tmpMovement_Sale.AmountSale1  ::TFloat  AS AmountSale1
                   , tmpMovement_Sale.AmountSale2  ::TFloat  AS AmountSale2
                   , tmpMovement_Sale.AmountSale3  ::TFloat  AS AmountSale3
                   , tmpMovement_Sale.AmountSale4  ::TFloat  AS AmountSale4
                   , tmpMovement_Sale.AmountSale5  ::TFloat  AS AmountSale5
                   , tmpMovement_Sale.AmountSale6  ::TFloat  AS AmountSale6
                   , tmpMovement_Sale.AmountSale7  ::TFloat  AS AmountSale7
         
                   , (CASE WHEN tmpPeriodPlanMin.NumPeriod1 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod1 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod1 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                       ::TFloat  AS AmountPlanMin_Calc1
                   , (CASE WHEN tmpPeriodPlanMin.NumPeriod2 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod2 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod2 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                       ::TFloat  AS AmountPlanMin_Calc2
                   , (CASE WHEN tmpPeriodPlanMin.NumPeriod3 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod3 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod3 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                       ::TFloat  AS AmountPlanMin_Calc3
                   , (CASE WHEN tmpPeriodPlanMin.NumPeriod4 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod4 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod4 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                       ::TFloat  AS AmountPlanMin_Calc4
                   , (CASE WHEN tmpPeriodPlanMin.NumPeriod5 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod5 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod5 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                       ::TFloat  AS AmountPlanMin_Calc5
                   , (CASE WHEN tmpPeriodPlanMin.NumPeriod6 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod6 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod6 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                      ::TFloat  AS AmountPlanMin_Calc6
                   , (CASE WHEN tmpPeriodPlanMin.NumPeriod7 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod7 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                          WHEN tmpPeriodPlanMin.NumPeriod7 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                       ::TFloat  AS AmountPlanMin_Calc7
         
                   , ((CASE WHEN tmpGoods.UnitId_Sale = 0 THEN 1 ELSE 0 END) 
                      * ( MI_PromoGoods.AmountPlan1
                        + MI_PromoGoods.AmountPlan2
                        + MI_PromoGoods.AmountPlan3
                        + MI_PromoGoods.AmountPlan4
                        + MI_PromoGoods.AmountPlan5
                        + MI_PromoGoods.AmountPlan6
                        + MI_PromoGoods.AmountPlan7) * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)    ::TFloat  AS TotalAmountPlan_Wh
         
                   , ( tmpMovement_Sale.AmountSale1 
                     + tmpMovement_Sale.AmountSale2 
                     + tmpMovement_Sale.AmountSale3 
                     + tmpMovement_Sale.AmountSale4 
                     + tmpMovement_Sale.AmountSale5 
                     + tmpMovement_Sale.AmountSale6 
                     + tmpMovement_Sale.AmountSale7)                                                                                                                   ::TFloat  AS TotalAmountSale
         
                   , ((CASE WHEN tmpPeriodPlanMin.NumPeriod1 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod1 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod1 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                     + CASE WHEN tmpPeriodPlanMin.NumPeriod2 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod2 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod2 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                     + CASE WHEN tmpPeriodPlanMin.NumPeriod3 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod3 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod3 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                     + CASE WHEN tmpPeriodPlanMin.NumPeriod4 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod4 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod4 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                     + CASE WHEN tmpPeriodPlanMin.NumPeriod5 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod5 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod5 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                     + CASE WHEN tmpPeriodPlanMin.NumPeriod6 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod6 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod6 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END 
                     + CASE WHEN tmpPeriodPlanMin.NumPeriod7 = 1 THEN MI_PromoGoods.AmountPlanMin_50 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod7 = 2 THEN MI_PromoGoods.AmountPlanMin_30 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END
                            WHEN tmpPeriodPlanMin.NumPeriod7 = 3 THEN MI_PromoGoods.AmountPlanMin_20 / CASE WHEN Movement_Promo.CountDays <> 0 THEN Movement_Promo.CountDays ELSE 1 END ELSE 0 END) 
                        * CASE WHEN MI_PromoGoods.MeasureId = zc_Measure_Sh() THEN COALESCE (MI_PromoGoods.GoodsWeight, 0) ELSE 1 END)                                 ::TFloat  AS TotalAmountPlanMin_Calc
         
                   , MI_PromoGoods.isPlan1         ::Boolean
                   , MI_PromoGoods.isPlan2         ::Boolean
                   , MI_PromoGoods.isPlan3         ::Boolean
                   , MI_PromoGoods.isPlan4         ::Boolean
                   , MI_PromoGoods.isPlan5         ::Boolean
                   , MI_PromoGoods.isPlan6         ::Boolean
                   , MI_PromoGoods.isPlan7         ::Boolean
         
                   --���� ����� ������������� � ���� �������, �.�. EndSale <= inEndDate + ������������ ������� - ���� ���� ������� ����� ��� EndSale
                   , CASE WHEN tmpMovement_Sale.OperDateMax_Sale > Movement_Promo.EndSale THEN zc_Color_Red()                         -- ���� ������� ����� ��� EndSale
                          WHEN Movement_Promo.EndSale <= inEndDate THEN 16777158                                                      --������� 16777158   16316574
                          ELSE zc_Color_White() 
                     END AS Color_EndDate           
                   , CASE WHEN Movement_Promo.EndSale <= inEndDate THEN TRUE ELSE FALSE END                         AS isEndDate               -- ���� ����� ������������� � ���� �������
                   , CASE WHEN tmpMovement_Sale.OperDateMax_Sale > Movement_Promo.EndSale THEN TRUE ELSE FALSE END  AS isSale                                                                                                 --���� ���� ������� ����� ��� EndSale

                   , CASE WHEN inStartDate > Movement_Promo.StartSale THEN inStartDate ELSE Movement_Promo.StartSale END AS Date_Max
                   , tmpGoods.UnitId_Sale 
                 FROM tmpGoods
                     LEFT JOIN tmpPromoDetail AS Movement_Promo ON Movement_Promo.Id = tmpGoods.MovementId_Promo
                     LEFT JOIN tmpPeriodPlanMin ON tmpPeriodPlanMin.Id = Movement_Promo.Id AND tmpGoods.UnitId_Sale = 0
                     
                     LEFT JOIN ObjectLink AS ObjectLink_Personal_Unit
                                          ON ObjectLink_Personal_Unit.ObjectId = Movement_Promo.PersonalTradeId
                                         AND ObjectLink_Personal_Unit.DescId = zc_ObjectLink_Personal_Unit()
                     LEFT JOIN Object AS Object_Unit ON Object_Unit.Id = ObjectLink_Personal_Unit.ChildObjectId
         
                     LEFT JOIN ObjectLink AS ObjectLink_Unit_Branch
                                          ON ObjectLink_Unit_Branch.ObjectId = Object_Unit.Id
                                         AND ObjectLink_Unit_Branch.DescId = zc_ObjectLink_Unit_Branch()
                     LEFT JOIN Object AS Object_Branch ON Object_Branch.Id = ObjectLink_Unit_Branch.ChildObjectId
         
                     LEFT JOIN tmpMI_Promo AS MI_PromoGoods ON MI_PromoGoods.MovementId = tmpGoods.MovementId_Promo
                                                           AND MI_PromoGoods.GoodsId    = tmpGoods.GoodsId
                                                           AND COALESCE (MI_PromoGoods.GoodsKindCompleteId,0) = COALESCE (tmpGoods.GoodsKindCompleteId, 0)
         
                     LEFT JOIN tmpMovement_Sale ON tmpMovement_Sale.MovementId_Promo = tmpGoods.MovementId_Promo
                                               AND tmpMovement_Sale.GoodsId = tmpGoods.GoodsId 
                                               AND tmpMovement_Sale.GoodsKindId = tmpGoods.GoodsKindCompleteId
                                              -- AND Movement_Promo.isPromo_inf = CASE WHEN inIsUnitSale = TRUE THEN FALSE ELSE TRUE END
                                               AND tmpMovement_Sale.UnitId_Sale = tmpGoods.UnitId_Sale
         
                     LEFT JOIN Object AS Object_UnitSale ON Object_UnitSale.Id = tmpMovement_Sale.UnitId_Sale
                     
                 WHERE tmpGoods.UnitId_Sale = 0
                    OR (tmpGoods.UnitId_Sale <> 0 AND
                        (tmpMovement_Sale.AmountSale1 <> 0
                      OR tmpMovement_Sale.AmountSale2 <> 0
                      OR tmpMovement_Sale.AmountSale3 <> 0
                      OR tmpMovement_Sale.AmountSale4 <> 0
                      OR tmpMovement_Sale.AmountSale5 <> 0
                      OR tmpMovement_Sale.AmountSale6 <> 0
                      OR tmpMovement_Sale.AmountSale7 <> 0) 
                        )
                )
         
         -- ���������       
              SELECT tmpData.Id                 --�� ��������� �����
                   , tmpData.MovementItemId
                   , tmpData.InvNumber          --� ��������� �����
                   , tmpData.UnitName           --�����
                   , tmpData.UnitCode_Sale   -- ��� ����� �������
                   , tmpData.UnitName_Sale   -- ����� �������
                   , tmpData.PersonalTradeName  --������������� ������������� ������������� ������
                   , tmpData.UnitCode_PersonalTrade
                   , tmpData.UnitName_PersonalTrade
                   , tmpData.BranchCode_PersonalTrade
                   , tmpData.BranchName_PersonalTrade
                   , tmpData.PersonalName       --������������� ������������� �������������� ������
                   , tmpData.StartSale          --���� ������ �������� �� ��������� ����
                   , tmpData.EndSale            --���� ��������� �������� �� ��������� ����
                   , tmpData.StartPromo         --���� ������ �����
                   , tmpData.EndPromo           --���� ��������� �����
                   , tmpData.MonthPromo         --����� �����
                   , tmpData.CountDaysPromo
                   , CASE WHEN tmpData.UnitId_Sale = 0 THEN ( date_part('DAY', tmpData.EndSale - tmpData.Date_Max) + 1) ELSE 0 END :: Integer  AS CountDaysEndPromo
                   , tmpData.RetailName  ::TBlob
                   , tmpData.PartnerName ::TBlob
                   , tmpData.GoodsName
                   , tmpData.GoodsCode
                   , tmpData.Measure
                   , tmpData.GoodsKindName
                   , tmpData.GoodsKindCompleteName
                   , tmpData.GoodsKindName
                   , tmpData.GoodsKindName_List
                   , tmpData.TradeMark
                   , tmpData.isPromo
                   , tmpData.Checked
                   , tmpData.GoodsWeight  :: TFloat

                   , tmpData.AmountPlan1     ::TFloat
                   , tmpData.AmountPlan2     ::TFloat
                   , tmpData.AmountPlan3     ::TFloat
                   , tmpData.AmountPlan4     ::TFloat
                   , tmpData.AmountPlan5     ::TFloat
                   , tmpData.AmountPlan6     ::TFloat
                   , tmpData.AmountPlan7     ::TFloat
                   
                   , tmpData.AmountPlan1_Wh    ::TFloat
                   , tmpData.AmountPlan2_Wh    ::TFloat
                   , tmpData.AmountPlan3_Wh    ::TFloat
                   , tmpData.AmountPlan4_Wh    ::TFloat
                   , tmpData.AmountPlan5_Wh    ::TFloat
                   , tmpData.AmountPlan6_Wh    ::TFloat
                   , tmpData.AmountPlan7_Wh    ::TFloat
                   
         
                   , tmpData.AmountSale1  ::TFloat
                   , tmpData.AmountSale2  ::TFloat
                   , tmpData.AmountSale3  ::TFloat
                   , tmpData.AmountSale4  ::TFloat
                   , tmpData.AmountSale5  ::TFloat
                   , tmpData.AmountSale6  ::TFloat
                   , tmpData.AmountSale7  ::TFloat
         
                   , tmpData.AmountPlanMin_Calc1    ::TFloat
                   , tmpData.AmountPlanMin_Calc2    ::TFloat
                   , tmpData.AmountPlanMin_Calc3    ::TFloat
                   , tmpData.AmountPlanMin_Calc4    ::TFloat
                   , tmpData.AmountPlanMin_Calc5    ::TFloat
                   , tmpData.AmountPlanMin_Calc6    ::TFloat
                   , tmpData.AmountPlanMin_Calc7    ::TFloat
         
                   , tmpData.TotalAmountPlan_Wh     ::TFloat
                   , tmpData.TotalAmountSale        ::TFloat
                   , tmpData.TotalAmountPlanMin_Calc ::TFloat
         
                   , (COALESCE (tmpData.TotalAmountPlanMin_Calc, 0) - COALESCE (tmpData.TotalAmountSale, 0) ) :: TFloat AS TotalAmount_Diff
                   , CASE WHEN COALESCE (tmpData.TotalAmountPlanMin_Calc, 0) <> 0 THEN (COALESCE (tmpData.TotalAmountPlanMin_Calc, 0) - COALESCE (tmpData.TotalAmountSale, 0) ) * 100 / tmpData.TotalAmountPlanMin_Calc ELSE 0 END :: TFloat AS Persent_Diff

                   , tmpData.isPlan1         ::Boolean
                   , tmpData.isPlan2         ::Boolean
                   , tmpData.isPlan3         ::Boolean
                   , tmpData.isPlan4         ::Boolean
                   , tmpData.isPlan5         ::Boolean
                   , tmpData.isPlan6         ::Boolean
                   , tmpData.isPlan7         ::Boolean
         
                   , tmpData.Color_EndDate           
                   , tmpData.isEndDate
                   , tmpData.isSale
                 
              FROM tmpData
       ;
            
END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.    ��������� �.�.
 11.11.17         *
*/

-- ����
-- SELECT * FROM gpSelect_Report_Promo_Plan (inStartDate:= '01.09.2017', inEndDate:= '01.09.2017', inIsPromo:= True, inIsTender:= False, inUnitId:= 0, inUnitId_Sale:= 0, inSession:= zfCalc_UserAdmin());
