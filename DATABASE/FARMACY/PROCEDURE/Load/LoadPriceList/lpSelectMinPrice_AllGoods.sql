-- Function: lpSelectMinPrice_AllGoods()

DROP FUNCTION IF EXISTS lpSelectMinPrice_AllGoods (Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpSelectMinPrice_AllGoods(
    IN inUnitId      Integer      , -- ������
    IN inObjectId    Integer      , -- �������� ����
    IN inUserId      Integer        -- ������ ������������
)

RETURNS TABLE (
    GoodsId            Integer,
    GoodsId_retail     Integer,
    GoodsCode          Integer,
    GoodsName          TVarChar,
    Remains            TFloat,
    MidPriceSale       TFloat,
    MinExpirationDate  TDateTime,
    PartionGoodsDate   TDateTime,
    Partner_GoodsId    Integer,
    Partner_GoodsCode  TVarChar,
    Partner_GoodsName  TVarChar,
    MakerName          TVarChar,
    ContractId         Integer,
    JuridicalId        Integer,
    JuridicalName      TVarChar,
    AreaId             Integer,   
    AreaName           TVarChar,
    Price              TFloat, 
    SuperFinalPrice    TFloat,
    isTop              Boolean,
    isOneJuridical     Boolean,
    PercentMarkup      TFloat
)

AS
$BODY$
  DECLARE vbMainJuridicalId Integer;
  DECLARE vbIsGoodsPromo Boolean;
BEGIN
    -- !!!��� "�����" ����������� ���� �� ��������� ������. ��������!!!
    vbIsGoodsPromo:= inObjectId >=0;
    -- !!!�������� �������� � ���������� ��������!!!
    inObjectId:= ABS (inObjectId);


    -- ����� � ������ "������� �� ����"
    SELECT Object_Unit_View.JuridicalId INTO vbMainJuridicalId FROM Object_Unit_View WHERE Object_Unit_View.Id = inUnitId;


    -- !!!�����������!!!
    ANALYZE ObjectLink;

    -- ������� - �����������
    CREATE TEMP TABLE _tmpMinPrice_Remains ON COMMIT DROP AS
       (WITH tmpRemains AS
       (SELECT
            Container.ObjectId           AS ObjectId_retail -- ����� ����� "����"
          , SUM (Container.Amount)       AS Amount
          , MIN (COALESCE (MIDate_ExpirationDate.ValueData, zc_DateEnd()))  AS MinExpirationDate -- ���� ��������
          , SUM (Container.Amount * COALESCE (MIFloat_PriceSale.ValueData, 0)) / SUM (Container.Amount) AS MidPriceSale -- !!! ������� ���� ����. � ���!!!
        FROM 
            Container
            LEFT OUTER JOIN ContainerLinkObject AS CLO_PartionMovementItem
                                                ON CLO_PartionMovementItem.ContainerId = Container.Id
                                               AND CLO_PartionMovementItem.DescId = zc_ContainerLinkObject_PartionMovementItem()
            LEFT OUTER JOIN OBJECT AS Object_PartionMovementItem 
                                   ON Object_PartionMovementItem.Id = CLO_PartionMovementItem.ObjectId
            LEFT OUTER JOIN MovementItemDate  AS MIDate_ExpirationDate
                                              ON MIDate_ExpirationDate.MovementItemId = Object_PartionMovementItem.ObjectCode
                                             AND MIDate_ExpirationDate.DescId = zc_MIDate_PartionGoods()
            -- ���� ����. � ���
            LEFT JOIN MovementItemFloat AS MIFloat_PriceSale
                                        ON MIFloat_PriceSale.MovementItemId = Object_PartionMovementItem.ObjectCode
                                       AND MIFloat_PriceSale.DescId = zc_MIFloat_PriceSale() 
        WHERE Container.DescId = zc_Container_Count()
          AND Container.WhereObjectId = inUnitId
          AND Container.Amount <> 0
        GROUP BY Container.ObjectId
        HAVING SUM (Container.Amount) > 0
       )
        -- 
        SELECT 
            ObjectLink_Child_NB.ChildObjectId         AS ObjectID           -- !!!�������� �����������, ����� ������ ����� �������!!!
          , tmpRemains.ObjectId_retail                                      -- ����� ����� "����"
          , tmpRemains.Amount ::TFloat                AS Amount
          , tmpRemains.MinExpirationDate :: TDateTime AS MinExpirationDate  -- ���� ��������
          , tmpRemains.MidPriceSale       -- !!! ������� ���� ����. � ���!!!
        FROM tmpRemains
                                    -- !!!�������� �����������, ����� ������ ����� �������!!!!
                                    INNER JOIN ObjectLink AS ObjectLink_Child
                                                          ON ObjectLink_Child.ChildObjectId = tmpRemains.ObjectId_retail
                                                         AND ObjectLink_Child.DescId        = zc_ObjectLink_LinkGoods_Goods()
                                    INNER JOIN  ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                                             AND ObjectLink_Main.DescId   = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Main_NB ON ObjectLink_Main_NB.ChildObjectId = ObjectLink_Main.ChildObjectId
                                                                               AND ObjectLink_Main_NB.DescId        = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Child_NB ON ObjectLink_Child_NB.ObjectId = ObjectLink_Main_NB.ObjectId
                                                                                AND ObjectLink_Child_NB.DescId   = zc_ObjectLink_LinkGoods_Goods()
                                    INNER JOIN ObjectLink AS ObjectLink_Goods_Object
                                                          ON ObjectLink_Goods_Object.ObjectId = ObjectLink_Child_NB.ChildObjectId
                                                         AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object()
                                                         AND ObjectLink_Goods_Object.ChildObjectId = 4 -- !!!NeBoley!!!
       );


-- RAISE EXCEPTION '<%>', (select count(*) from Remains);

    -- ������� + ���� ...
    CREATE TEMP TABLE _tmpMinPrice_RemainsList ON COMMIT DROP AS
       (SELECT 
            _tmpMinPrice_Remains.ObjectId,                  -- ����� ����� "����"
            _tmpMinPrice_Remains.ObjectId_retail,           -- ����� ����� "����"
            Object_LinkGoods_View.GoodsMainId, -- ����� "�����" �����
            PriceList_GoodsLink.GoodsId,       -- ����� ����� "����������"
            _tmpMinPrice_Remains.Amount,
            _tmpMinPrice_Remains.MinExpirationDate,
            _tmpMinPrice_Remains.MidPriceSale
        FROM _tmpMinPrice_Remains
            INNER JOIN Object_LinkGoods_View ON Object_LinkGoods_View.GoodsId = _tmpMinPrice_Remains.objectid -- ����� ������ ���� � �����
            LEFT JOIN Object_LinkGoods_View AS PriceList_GoodsLink -- ����� ������ � ������ � ������� �������
                                            ON PriceList_GoodsLink.GoodsMainId = Object_LinkGoods_View.GoodsMainId
       );
/*    -- ������� + ���� ...
    CREATE TEMP TABLE _tmpMinPrice_RemainsList ON COMMIT DROP AS
       (SELECT 
            _tmpMinPrice_Remains.ObjectId,                  -- ����� ����� "����"
            _tmpMinPrice_Remains.ObjectId_retail,           -- ����� ����� "����"
            ObjectLink_LinkGoods_Goods.ChildObjectId as GoodsMainId, -- ����� "�����" �����
            ObjectLink_LinkGoods_Goods2.ChildObjectId as GoodsId,       -- ����� ����� "����������"
            _tmpMinPrice_Remains.Amount,
            _tmpMinPrice_Remains.MinExpirationDate,
            _tmpMinPrice_Remains.MidPriceSale
        FROM _tmpMinPrice_Remains
                 INNER JOIN ObjectLink AS ObjectLink_LinkGoods_Goods
                                       ON ObjectLink_LinkGoods_Goods.ChildObjectId = _tmpMinPrice_Remains.objectid -- ����� ������ ���� � �����
                                      AND ObjectLink_LinkGoods_Goods.DescId = zc_ObjectLink_LinkGoods_Goods()

                 INNER join ObjectLink AS ObjectLink_LinkGoods_GoodsMain
                                        ON ObjectLink_LinkGoods_GoodsMain.ObjectId = ObjectLink_LinkGoods_Goods.ObjectId
                                       AND ObjectLink_LinkGoods_GoodsMain.DescId = zc_ObjectLink_LinkGoods_GoodsMain()


                 INNER join ObjectLink AS ObjectLink_LinkGoods_GoodsMain2
                                        ON ObjectLink_LinkGoods_GoodsMain2.ChildObjectId = ObjectLink_LinkGoods_GoodsMain.ChildObjectId
                                       AND ObjectLink_LinkGoods_GoodsMain2.DescId = zc_ObjectLink_LinkGoods_GoodsMain()

                 INNER JOIN ObjectLink AS ObjectLink_LinkGoods_Goods2
                                      ON ObjectLink_LinkGoods_Goods2.ObjectId = ObjectLink_LinkGoods_GoodsMain2.ObjectId
                                     AND ObjectLink_LinkGoods_Goods2.DescId = zc_ObjectLink_LinkGoods_Goods()
       );*/

-- RAISE EXCEPTION '<%>      <%>', (select count(*) from Remains), (select count(*) from _tmpMinPrice_RemainsList);

    -- ���������
    RETURN QUERY
    WITH
    -- ��������� ��� ������� ����� (���� ����� � ��������� - ����� ���� ������� �������������� ������ � ������� �� �����) !!!������ ���� ������������ ObjectId!!!
    PriceSettings    AS (SELECT * FROM gpSelect_Object_PriceGroupSettingsInterval    (inUserId::TVarChar))
  , PriceSettingsTOP AS (SELECT * FROM gpSelect_Object_PriceGroupSettingsTOPInterval (inUserId::TVarChar) WHERE vbIsGoodsPromo = TRUE)

    -- ��������� ��� ��. ��� (��� ���������� ������������ ������� � �.�)
  , JuridicalSettings AS (SELECT * FROM lpSelect_Object_JuridicalSettingsRetail (inObjectId)
                         )
    -- ������������� ��������
  , GoodsPromo AS (SELECT tmp.JuridicalId
                        , tmp.GoodsId        -- ����� ����� "����"
                        , tmp.ChangePercent
                   FROM lpSelect_MovementItem_Promo_onDate (inOperDate:= CURRENT_DATE) AS tmp
                   WHERE vbIsGoodsPromo = TRUE -- !!!�.�. ������ � ���� ������ ����������� ������. ��������!!!
                  )
    -- ������ ���� + ��� + % �������
  , GoodsPrice AS
       (SELECT _tmpMinPrice_RemainsList.GoodsId, COALESCE (ObjectBoolean_Top.ValueData, FALSE) AS isTOP, COALESCE (ObjectFloat_PercentMarkup.ValueData, 0) AS PercentMarkup
        FROM _tmpMinPrice_RemainsList
             INNER JOIN ObjectLink AS ObjectLink_Price_Goods
                                   -- ON ObjectLink_Price_Goods.ChildObjectId = _tmpMinPrice_RemainsList.GoodsId
                                   ON ObjectLink_Price_Goods.ChildObjectId = _tmpMinPrice_RemainsList.ObjectId_retail
                                  AND ObjectLink_Price_Goods.DescId = zc_ObjectLink_Price_Goods()
             INNER JOIN ObjectLink AS ObjectLink_Price_Unit
                                   ON ObjectLink_Price_Unit.ChildObjectId = inUnitId
                                  AND ObjectLink_Price_Unit.ObjectId = ObjectLink_Price_Goods.ObjectId
                                  AND ObjectLink_Price_Unit.DescId = zc_ObjectLink_Price_Unit()
             LEFT JOIN ObjectBoolean AS ObjectBoolean_Top
                                     ON ObjectBoolean_Top.ObjectId = ObjectLink_Price_Goods.ObjectId
                                     -- ON ObjectBoolean_Top.ObjectId = _tmpMinPrice_RemainsList.ObjectId_retail
                                    AND ObjectBoolean_Top.DescId = zc_ObjectBoolean_Price_Top()
             LEFT JOIN ObjectFloat AS ObjectFloat_PercentMarkup
                                   ON ObjectFloat_PercentMarkup.ObjectId = ObjectLink_Price_Goods.ObjectId
                                   -- ON ObjectFloat_PercentMarkup.ObjectId = _tmpMinPrice_RemainsList.ObjectId_retail
                                  AND ObjectFloat_PercentMarkup.DescId = zc_ObjectFloat_Price_PercentMarkup()
        WHERE ObjectBoolean_Top.ValueData = TRUE OR ObjectFloat_PercentMarkup.ValueData <> 0
       )
       
  , tmpJuridicalArea AS (SELECT DISTINCT 
                                tmp.UnitId                   AS UnitId            
                              , tmp.JuridicalId              AS JuridicalId
                              , tmp.AreaId_Juridical         AS AreaId
                              , tmp.AreaName_Juridical       AS AreaName
                         FROM lpSelect_Object_JuridicalArea_byUnit (inUnitId, 0) AS tmp
                         )
                         
    -- ����� ��������� ������
  , FinalList AS
       (SELECT 
        ddd.GoodsId
      , ddd.GoodsId_retail
      , ddd.GoodsCode
      , ddd.GoodsName  
      , ddd.Remains
      , ddd.MinExpirationDate
      , ddd.MidPriceSale
      , ddd.Price
      , ddd.PartionGoodsDate
      , ddd.Partner_GoodsId
      , ddd.Partner_GoodsCode
      , ddd.Partner_GoodsName
      , ddd.MakerName
      , ddd.ContractId
      , ddd.JuridicalId
      , ddd.JuridicalName 
      , ddd.AreaId
      , ddd.AreaName 
      , ddd.Deferment
      , ddd.PriceListMovementItemId
/* * /  
      , CASE -- ���� ���� �������� �� �������� = 0
             WHEN ddd.Deferment = 0
                  THEN FinalPrice
             -- ���� ���-�������
             WHEN ddd.isTOP = TRUE
                  THEN FinalPrice * (100 - COALESCE (PriceSettingsTOP.Percent, 0)) / 100
             -- ����� ��������� % �� ��������� ��� ������� ����� (��� � ������������ ... )
             ELSE FinalPrice * (100 - PriceSettings.Percent) / 100

        END :: TFloat AS SuperFinalPrice
/ */
      , CASE -- ���� ���� �������� �� �������� = 0 + ���-������� ��������� % �� ... (��� � ������������ ... )
             WHEN ddd.Deferment = 0 AND ddd.isTOP = TRUE
                  THEN FinalPrice * (100 + COALESCE (PriceSettingsTOP.Percent, 0)) / 100
             -- ���� ���� �������� �� �������� = 0 + �� ���-������� = ��������� % �� ��������� ��� ������� ����� (��� � ������������ ... )
             WHEN ddd.Deferment = 0 AND ddd.isTOP = FALSE
                  THEN FinalPrice * (100 + COALESCE (PriceSettings.Percent, 0)) / 100
             -- ����� �� ���������
             ELSE FinalPrice

        END :: TFloat AS SuperFinalPrice
/* */     
      , ddd.isTOP
      , ddd.PercentMarkup

    FROM (SELECT DISTINCT 
            _tmpMinPrice_RemainsList.ObjectId                 AS GoodsId
          , _tmpMinPrice_RemainsList.ObjectId_retail          AS GoodsId_retail
          , Goods.GoodsCodeInt                 AS GoodsCode
          , Goods.GoodsName                    AS GoodsName  
          , _tmpMinPrice_RemainsList.Amount                   AS Remains
          , _tmpMinPrice_RemainsList.MinExpirationDate        AS MinExpirationDate
          , _tmpMinPrice_RemainsList.MidPriceSale             AS MidPriceSale
            -- ������ ���� ����������
          , PriceList.Amount                   AS Price
            -- ����������� ���� ���������� - ��� ������ "����"
          , MIN (PriceList.Amount) OVER (PARTITION BY _tmpMinPrice_RemainsList.ObjectId) AS MinPrice
          , PriceList.Id                       AS PriceListMovementItemId
          , MIDate_PartionGoods.ValueData      AS PartionGoodsDate

          , CASE -- ���� ���� ���������� >= PriceLimit (�� ����� ���� ��������� ����� ��� ������� �����. ����)
                 WHEN COALESCE (JuridicalSettings.PriceLimit, 0) <= PriceList.Amount
                    THEN PriceList.Amount
                         -- ����������� % ������ �� ������������� ��������
                       * (1 - COALESCE (GoodsPromo.ChangePercent, 0) / 100)

                 ELSE -- ����� ����������� ����� - ��� ���-������� ��� �� ���-�������
                      (PriceList.Amount * (100 - COALESCE (JuridicalSettings.Bonus, 0)) / 100)
                       -- � ����������� % ������ �� ������������� ��������
                    * (1 - COALESCE (GoodsPromo.ChangePercent, 0) / 100)
            END :: TFloat AS FinalPrice

          , MILinkObject_Goods.ObjectId        AS Partner_GoodsId
          , Object_JuridicalGoods.GoodsCode    AS Partner_GoodsCode
          , Object_JuridicalGoods.GoodsName    AS Partner_GoodsName
          , Object_JuridicalGoods.MakerName    AS MakerName
          , LastPriceList_View.ContractId      AS ContractId
          , Juridical.Id                       AS JuridicalId
          , Juridical.ValueData                AS JuridicalName
          , COALESCE (ObjectFloat_Deferment.ValueData, 0) :: Integer AS Deferment
          , COALESCE (NULLIF (GoodsPrice.isTOP, FALSE), COALESCE (ObjectBoolean_Goods_TOP.ValueData, FALSE) /*Goods.isTOP*/) AS isTOP
          , COALESCE (GoodsPrice.PercentMarkup, 0) AS PercentMarkup
        
          , tmpJuridicalArea.AreaId            AS AreaId
          , tmpJuridicalArea.AreaName          AS AreaName
        FROM -- ������� + ���� ...
             _tmpMinPrice_RemainsList 
             -- ������ � �����-����� (����������)
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Goods
                                              ON MILinkObject_Goods.DescId = zc_MILinkObject_Goods()
                                             AND MILinkObject_Goods.ObjectId = _tmpMinPrice_RemainsList.GoodsId  -- ����� "����������"
             -- �����-���� (����������) - MovementItem
            JOIN MovementItem AS PriceList ON PriceList.Id = MILinkObject_Goods.MovementItemId
             -- �����-���� (����������) - Movement
            JOIN LastPriceList_View ON LastPriceList_View.MovementId = PriceList.MovementId
            
            JOIN tmpJuridicalArea ON tmpJuridicalArea.JuridicalId = LastPriceList_View.JuridicalId 
                                 AND tmpJuridicalArea.AreaId      = LastPriceList_View.AreaId 

             -- ���� ������ ������ (��� ���� ��������?) � �����-���� (����������)
            LEFT JOIN MovementItemDate AS MIDate_PartionGoods
                                       ON MIDate_PartionGoods.MovementItemId =  PriceList.Id
                                      AND MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()

             -- ��������� ��� ��. ��� (��� ���������� ������������ ������� � �.�)
            LEFT JOIN JuridicalSettings ON JuridicalSettings.JuridicalId     = LastPriceList_View.JuridicalId 
                                       AND JuridicalSettings.MainJuridicalId = vbMainJuridicalId
                                       AND JuridicalSettings.ContractId      = LastPriceList_View.ContractId 
            -- ����� "����������", ���� �� ���� � ������� !!!� �� ����!!!
            LEFT JOIN Object_Goods_View AS Object_JuridicalGoods ON Object_JuridicalGoods.Id = MILinkObject_Goods.ObjectId
            -- ����� "����"
            LEFT JOIN Object_Goods_View AS Goods ON Goods.Id = _tmpMinPrice_RemainsList.ObjectId
            -- LEFT JOIN Object_Goods_View AS Goods ON Goods.Id = _tmpMinPrice_RemainsList.ObjectId_retail
            LEFT JOIN ObjectBoolean AS ObjectBoolean_Goods_TOP
                                    ON ObjectBoolean_Goods_TOP.ObjectId = _tmpMinPrice_RemainsList.ObjectId_retail
                                   AND ObjectBoolean_Goods_TOP.DescId = zc_ObjectBoolean_Goods_TOP()  
            LEFT JOIN GoodsPrice ON GoodsPrice.GoodsId = _tmpMinPrice_RemainsList.ObjectId
       
            -- ���������
            INNER JOIN Object AS Juridical ON Juridical.Id = LastPriceList_View.JuridicalId

            -- ���� �������� �� ��������
            LEFT JOIN ObjectFloat AS ObjectFloat_Deferment 
                                  ON ObjectFloat_Deferment.ObjectId = LastPriceList_View.ContractId
                                 AND ObjectFloat_Deferment.DescId = zc_ObjectFloat_Contract_Deferment()
       
            -- % ������ �� ������������� ��������
            LEFT JOIN GoodsPromo ON GoodsPromo.GoodsId     = _tmpMinPrice_RemainsList.ObjectId
                                AND GoodsPromo.JuridicalId = LastPriceList_View.JuridicalId

        WHERE  COALESCE (JuridicalSettings.isPriceClose, FALSE) <> TRUE 

       ) AS ddd
       -- ��������� ��� ������� ����� (���� ����� � ��������� - ����� ���� ������� �������������� ������ � ������� �� �����)
       LEFT JOIN PriceSettings    ON ddd.MinPrice BETWEEN PriceSettings.MinPrice    AND PriceSettings.MaxPrice
       LEFT JOIN PriceSettingsTOP ON ddd.MinPrice BETWEEN PriceSettingsTOP.MinPrice AND PriceSettingsTOP.MaxPrice
   )
    -- ������������� �� ���� + ���� �������� � �������� �������
  , MinPriceList AS (SELECT *
                     FROM (SELECT FinalList.*
                                , ROW_NUMBER() OVER (PARTITION BY FinalList.GoodsId ORDER BY FinalList.SuperFinalPrice ASC, FinalList.Deferment DESC, FinalList.PriceListMovementItemId ASC) AS Ord
                           FROM FinalList
                          ) AS T0
                     WHERE T0.Ord = 1
                    )
    -- ������� ����������� � ������
  , tmpCountJuridical AS (SELECT FinalList.GoodsId, COUNT (DISTINCT FinalList.JuridicalId) AS CountJuridical
                          FROM FinalList
                          GROUP BY FinalList.GoodsId
                         )
    -- ���������
    SELECT
        MinPriceList.GoodsId,
        MinPriceList.GoodsId_retail,
        MinPriceList.GoodsCode,
        MinPriceList.GoodsName,
        MinPriceList.Remains,
        MinPriceList.MidPriceSale ::TFloat,
        MinPriceList.MinExpirationDate,
        MinPriceList.PartionGoodsDate,
        MinPriceList.Partner_GoodsId,
        MinPriceList.Partner_GoodsCode,
        MinPriceList.Partner_GoodsName,
        MinPriceList.MakerName,
        MinPriceList.ContractId,
        MinPriceList.JuridicalId,
        MinPriceList.JuridicalName,
        MinPriceList.AreaId,
        MinPriceList.AreaName,
        MinPriceList.Price,
        MinPriceList.SuperFinalPrice,
        MinPriceList.isTop :: Boolean AS isTop,
        CASE WHEN tmpCountJuridical.CountJuridical > 1 THEN FALSE ELSE TRUE END :: Boolean AS isOneJuridical,
        MinPriceList.PercentMarkup :: TFloat AS PercentMarkup
    FROM MinPriceList
         LEFT JOIN tmpCountJuridical ON tmpCountJuridical.GoodsId = MinPriceList.GoodsId
    ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION lpSelectMinPrice_AllGoods (Integer, Integer, Integer) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.
 11.10.17         * add area
 16.02.16         * add isOneJuridical
 03.12.15                                                                          * 
*/

-- ����
-- SELECT * FROM lpSelectMinPrice_AllGoods (3031072, 3031066, 3) WHERE GoodsCode = 1069 -- !!!��������!!!
-- SELECT * FROM lpSelectMinPrice_AllGoods (2144918, 2140932, 3) WHERE GoodsCode = 4797 -- !!!��������!!!
-- SELECT * FROM lpSelectMinPrice_AllGoods (1781716 , 4, 3) WHERE GoodsCode = 8969 -- "������_"
-- SELECT * FROM lpSelectMinPrice_AllGoods (183292, 4, 3) WHERE GoodsCode = 8969 -- "������_1 ��_������_6"
