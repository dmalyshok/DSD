-- Function: lpSelectMinPrice_AllGoods_onDate()

DROP FUNCTION IF EXISTS lpSelectMinPrice_AllGoods_onDate (TDateTime, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpSelectMinPrice_AllGoods_onDate(
    IN inOperdate    TDateTime    , -- �� ����
    IN inUnitId      Integer      , -- ������
    IN inObjectId    Integer      , -- �������� ����
    IN inUserId      Integer        -- ������ ������������
)

RETURNS TABLE (
    GoodsId            Integer,
    GoodsCode          Integer,
    GoodsName          TVarChar,
    PartionGoodsDate   TDateTime,
    Partner_GoodsId    Integer,
    Partner_GoodsCode  TVarChar,
    Partner_GoodsName  TVarChar,
    MakerName          TVarChar,
    ContractId         Integer,
    JuridicalId        Integer,
    JuridicalName      TVarChar,
    Price              TFloat, 
    SuperFinalPrice    TFloat,
    isTop              Boolean,
    isOneJuridical     Boolean
)

AS
$BODY$
  DECLARE vbMainJuridicalId Integer;
BEGIN

    -- ����� � ������ "������� �� ����"
    SELECT Object_Unit_View.JuridicalId INTO vbMainJuridicalId FROM Object_Unit_View WHERE Object_Unit_View.Id = inUnitId;


    -- ���������
    RETURN QUERY
    WITH
    -- ��������� ��� ������� ����� (���� ����� � ��������� - ����� ���� ������� �������������� ������ � ������� �� �����) !!!������ ���� ������������ ObjectId!!!
    PriceSettings AS (SELECT * FROM gpSelect_Object_PriceGroupSettingsInterval (inUserId::TVarChar)
                     )
    -- ��������� ��� ��. ��� (��� ���������� ������������ ������� � �.�)
  , JuridicalSettings AS (SELECT * FROM lpSelect_Object_JuridicalSettingsRetail (inObjectId)
                         )
    -- ������������� ��������
  , GoodsPromo AS (SELECT tmp.JuridicalId
                        , tmp.GoodsId        -- ����� ����� "����"
                        , tmp.ChangePercent
                   FROM lpSelect_MovementItem_Promo_onDate (inOperDate:= CURRENT_DATE) AS tmp
                  )
  
 -- ������ ��������� ��� (����������) !!!�� ����������!!! (�.�. ��������� �������� � �� ��������� ��������� ����)
  , Movement_PriceList AS
       (-- ���������� � "������" ��������� �� JuridicalSettings
        SELECT tmp.MovementId
             , tmp.JuridicalId
             , tmp.ContractId
             , COALESCE (JuridicalSettings.PriceLimit, 0) AS PriceLimit
             , COALESCE (JuridicalSettings.Bonus, 0)      AS Bonus
        FROM
       (-- ���������� � "����" �����
        SELECT *
        FROM
       (-- ���������� ��� !!!�� ������ "ObjectId"!!!
        SELECT MAX (Movement.OperDate) OVER (PARTITION BY MovementLinkObject_Juridical.ObjectId, COALESCE (MovementLinkObject_Contract.ObjectId, 0)) AS Max_Date
             , Movement.OperDate
             , Movement.Id                                        AS MovementId
             , MovementLinkObject_Juridical.ObjectId              AS JuridicalId
             , COALESCE (MovementLinkObject_Contract.ObjectId, 0) AS ContractId
        FROM MovementLinkObject AS MovementLinkObject_Juridical
--                                ON MovementLinkObject_Juridical.ObjectId = tmp.ObjectId
             INNER JOIN Movement ON Movement.Id     = MovementLinkObject_Juridical.MovementId
                                AND Movement.DescId = zc_Movement_PriceList()
                                AND Movement.OperDate <= inOperDate
             LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                          ON MovementLinkObject_Contract.MovementId = Movement.Id
                                         AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
        WHERE MovementLinkObject_Juridical.DescId = zc_MovementLinkObject_Juridical() 
          AND Movement.DescId = zc_Movement_PriceList()
       ) AS tmp
        WHERE tmp.Max_Date = tmp.OperDate -- �.�. ��� �������� � �� ���� ����� 1 ��������
       ) AS tmp
        -- !!!INNER!!!
        INNER JOIN (SELECT DISTINCT JuridicalSettings.JuridicalId, JuridicalSettings.ContractId, JuridicalSettings.PriceLimit, JuridicalSettings.Bonus
                    FROM JuridicalSettings
                   ) AS JuridicalSettings ON JuridicalSettings.JuridicalId = tmp.JuridicalId
                                         AND JuridicalSettings.ContractId  = tmp.ContractId
       )
    -- ��������� ���� (����������) �� "������" ������� �� GoodsList
  , MI_PriceList AS
       (SELECT Movement_PriceList.MovementId
             , Movement_PriceList.JuridicalId
             , Movement_PriceList.ContractId
             , Movement_PriceList.PriceLimit
             , Movement_PriceList.Bonus
             , MovementItem.Id     AS MovementItemId
             , MovementItem.Amount AS Price
            -- , GoodsList.GoodsId      -- ����� ����� "����"
            -- , GoodsList.GoodsId_main -- ����� "�����" �����
            -- , GoodsList.GoodsId_jur  -- ����� ����� "����������"
             , MILinkObject_Goods.ObjectId  AS GoodsId_jur -- ����� "����������"
            -- , GoodsList.ObjectId     -- ����� �� ���� ���� ����� ��� � � Movement_PriceList.JuridicalId
        FROM Movement_PriceList
             INNER JOIN MovementItem ON MovementItem.MovementId = Movement_PriceList.MovementId
             INNER JOIN MovementItemLinkObject AS MILinkObject_Goods
                                               ON MILinkObject_Goods.MovementItemId = MovementItem.Id
                                              AND MILinkObject_Goods.DescId         = zc_MILinkObject_Goods()
            -- INNER JOIN GoodsList ON GoodsList.GoodsId_jur = MILinkObject_Goods.ObjectId -- ����� "����������"
       )

    -- ���� + ���� ...
  , GoodsList AS
       (SELECT PriceList_GoodsLink.GoodsId     AS ObjectId      -- ����� ����� "����"
             , Object_LinkGoods_View.GoodsMainId                -- ����� "�����" �����
             , Object_LinkGoods_View.GoodsId                    -- ����� ����� "����������"
             , MI_PriceList.MovementId
             , MI_PriceList.JuridicalId
             , MI_PriceList.ContractId
             , MI_PriceList.PriceLimit
             , MI_PriceList.Bonus
             , MI_PriceList.MovementItemId
             , MI_PriceList.Price
        FROM 
            MI_PriceList
            INNER JOIN Object_LinkGoods_View ON Object_LinkGoods_View.GoodsId = MI_PriceList.GoodsId_jur -- ����� ������ ���������� � �������
            LEFT JOIN Object_LinkGoods_View AS PriceList_GoodsLink -- ����� ������ � ������ � ������� �������
                                            ON PriceList_GoodsLink.GoodsMainId = Object_LinkGoods_View.GoodsMainId
                                            AND PriceList_GoodsLink.ObjectId = inObjectId
       )

    -- ����� ��������� ������
  , FinalList AS
       (SELECT 
        ddd.GoodsId
      , ddd.GoodsCode
      , ddd.GoodsName  

      , ddd.Price
      , ddd.PartionGoodsDate
      , ddd.Partner_GoodsId
      , ddd.Partner_GoodsCode
      , ddd.Partner_GoodsName
      , ddd.MakerName
      , ddd.ContractId
      , ddd.JuridicalId
      , ddd.JuridicalName 
      , ddd.Deferment
      , ddd.PriceListMovementItemId

      , CASE -- ���� ���� �������� �� �������� = 0 ��� ���-�������
             WHEN ddd.Deferment = 0 OR ddd.isTOP = TRUE
                  THEN FinalPrice
             -- ����� ��������� % �� ��������� ��� ������� ����� (��� � ������������ ... )
             ELSE FinalPrice * (100 - PriceSettings.Percent) / 100

        END :: TFloat AS SuperFinalPrice

      , ddd.isTOP

    FROM (SELECT DISTINCT 
            GoodsList.ObjectId                 AS GoodsId
          , Goods.GoodsCodeInt                 AS GoodsCode
          , Goods.GoodsName                    AS GoodsName  

            -- ������ ���� ����������
          , PriceList.Amount                   AS Price
            -- ����������� ���� ���������� - ��� ������ "����"
          , MIN (PriceList.Amount) OVER (PARTITION BY GoodsList.ObjectId) AS MinPrice
          , PriceList.Id                       AS PriceListMovementItemId
          , MIDate_PartionGoods.ValueData      AS PartionGoodsDate

          , CASE -- ���� ���-������� ��� ���� ���������� >= PriceLimit (�� ����� ���� ��������� ����� ��� ������� �����. ����)
                 WHEN Goods.isTOP = TRUE OR COALESCE (JuridicalSettings.PriceLimit, 0) <= PriceList.Amount
                    THEN PriceList.Amount
                         -- � ����������� % ������ �� ������������� ��������
                       * (1 - COALESCE (GoodsPromo.ChangePercent, 0) / 100)
                 -- ����� ����������� �����
                 ELSE (PriceList.Amount * (100 - COALESCE (JuridicalSettings.Bonus, 0)) / 100)
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
          , Goods.isTOP
        
        FROM -- ������� + ���� ...
             GoodsList 
             -- ������ � �����-����� (����������)
             LEFT JOIN MovementItemLinkObject AS MILinkObject_Goods
                                              ON MILinkObject_Goods.DescId = zc_MILinkObject_Goods()
                                             AND MILinkObject_Goods.ObjectId = GoodsList.GoodsId  -- ����� "����������"
             -- �����-���� (����������) - MovementItem
            JOIN MovementItem AS PriceList ON PriceList.Id = MILinkObject_Goods.MovementItemId
             -- �����-���� (����������) - Movement
            JOIN LastPriceList_View ON LastPriceList_View.MovementId = PriceList.MovementId

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
            LEFT JOIN Object_Goods_View AS Goods ON Goods.Id = GoodsList.ObjectId
       
            -- ���������
            INNER JOIN Object AS Juridical ON Juridical.Id = LastPriceList_View.JuridicalId

            -- ���� �������� �� ��������
            LEFT JOIN ObjectFloat AS ObjectFloat_Deferment 
                                  ON ObjectFloat_Deferment.ObjectId = LastPriceList_View.ContractId
                                 AND ObjectFloat_Deferment.DescId = zc_ObjectFloat_Contract_Deferment()
       
            -- % ������ �� ������������� ��������
            LEFT JOIN GoodsPromo ON GoodsPromo.GoodsId     = GoodsList.ObjectId
                                AND GoodsPromo.JuridicalId = LastPriceList_View.JuridicalId

        WHERE  COALESCE (JuridicalSettings.isPriceClose, FALSE) <> TRUE 

       ) AS ddd
       -- ��������� ��� ������� ����� (���� ����� � ��������� - ����� ���� ������� �������������� ������ � ������� �� �����)
       LEFT JOIN PriceSettings ON ddd.MinPrice BETWEEN PriceSettings.MinPrice AND PriceSettings.MaxPrice
   )
    -- ������������� �� ���� � �������� �������
  , MinPriceList AS (SELECT *
                     FROM (SELECT FinalList.*
                                , ROW_NUMBER() OVER (PARTITION BY FinalList.GoodsId ORDER BY FinalList.SuperFinalPrice, FinalList.PriceListMovementItemId) AS Ord
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
        MinPriceList.GoodsCode,
        MinPriceList.GoodsName,
        MinPriceList.PartionGoodsDate,
        MinPriceList.Partner_GoodsId,
        MinPriceList.Partner_GoodsCode,
        MinPriceList.Partner_GoodsName,
        MinPriceList.MakerName,
        MinPriceList.ContractId,
        MinPriceList.JuridicalId,
        MinPriceList.JuridicalName,
        MinPriceList.Price,
        MinPriceList.SuperFinalPrice,
        MinPriceList.isTop,
        CASE WHEN tmpCountJuridical.CountJuridical > 1 THEN FALSE ELSE TRUE END ::Boolean AS isOneJuridical
    FROM MinPriceList
         LEFT JOIN tmpCountJuridical ON tmpCountJuridical.GoodsId = MinPriceList.GoodsId
    ;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
--ALTER FUNCTION lpSelectMinPrice_AllGoods_onDate (Integer, Integer, Integer) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.
 04.05.16         * 
                                                                         * 
*/

-- ����
 --SELECT * FROM lpSelectMinPrice_AllGoods_onDate ('30.01.2016' ::TDateTime , 183292 , 4, 3) WHERE GoodsCode = 4797 --  unit 183292