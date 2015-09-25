-- Function: gpSelect_Movement_Income()

DROP FUNCTION IF EXISTS gpSelect_CashRemains_Diff (Integer, TVarChar, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_CashRemains_Diff(
    IN inMovementId    Integer,    -- ������� ���������
    IN inCashSessionId TVarChar,   -- ������ ��������� �����
    IN inSession       TVarChar    -- ������ ������������
)
RETURNS TABLE (
    Id Integer,
    GoodsCode Integer,
    GoodsName TVarChar,
    Price TFloat,
    Remains TFloat,
    MCSValue TFloat,
    Reserved TFloat,
    NewRow Boolean)

AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;
   DECLARE vbUnitKey TVarChar;
BEGIN

    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Income());
    vbUserId:= lpGetUserBySession (inSession);
    vbUnitKey := COALESCE(lpGet_DefaultValue('zc_Object_Unit', vbUserId), '');
    IF vbUnitKey = '' THEN
       vbUnitKey := '0';
    END IF;
    vbUnitId := vbUnitKey::Integer;
    
    --�������� ���� ���������� ��������� �� ������
    PERFORM lpInsertUpdate_CashSession(inCashSessionId := inCashSessionId,
                                        inDateConnect := CURRENT_TIMESTAMP::TDateTime);
    
    --���������� ������� � �������� �������� � ����������
    CREATE TEMP TABLE _DIFF (ObjectId  Integer
                           , GoodsCode Integer
                           , GoodsName TVarChar
                           , Price     TFloat
                           , Remains   TFloat
                           , MCSValue  TFloat
                           , Reserved  TFloat
                           , NewRow    Boolean) ON COMMIT DROP;    
    WITH GoodsRemains
    AS
    (
        SELECT 
            SUM(Amount) AS Remains, 
            container.objectid 
        FROM container
            -- INNER JOIN containerlinkobject AS CLO_Unit
                                           -- ON CLO_Unit.containerid = container.id 
                                          -- AND CLO_Unit.descid = zc_ContainerLinkObject_Unit()
                                          -- AND CLO_Unit.objectid = vbUnitId
        WHERE 
            container.descid = zc_container_count() 
            AND
            container.WhereObjectId = vbUnitId
            AND 
            Amount<>0
        GROUP BY 
            container.objectid
    ),
    RESERVE
    AS
    (
        SELECT
            MovementItem_Reserve.GoodsId,
            SUM(MovementItem_Reserve.Amount)::TFloat as Amount
        FROM
            gpSelect_MovementItem_CheckDeferred(inSession) as MovementItem_Reserve
        WHERE
            MovementItem_Reserve.MovementId <> inMovementId
        Group By
            MovementItem_Reserve.GoodsId
    ),
    SESSIONDATA --��������� � ������
    AS
    (
        SELECT 
            CashSessionSnapShot.ObjectId,
            CashSessionSnapShot.Price,
            CashSessionSnapShot.Remains,
            CashSessionSnapShot.MCSValue,
            CashSessionSnapShot.Reserved
        FROM
            CashSessionSnapShot
        WHERE
            CashSessionSnapShot.CashSessionId = inCashSessionId
    )
    --�������� �������
    INSERT INTO _DIFF (ObjectId, GoodsCode, GoodsName, Price, Remains, MCSValue, Reserved, NewRow)
    SELECT
        COALESCE(GoodsRemains.ObjectId,SESSIONDATA.ObjectId)         AS ObjectId
       ,Object_Goods.ObjectCode::Integer                             AS GoodsCode
       ,Object_Goods.ValueData                                       AS GoodsName
       ,ROUND(COALESCE(Object_Price_View.Price,0),2)                 AS Price
       ,COALESCE(GoodsRemains.Remains,0)-COALESCE(Reserve.Amount,0)  AS Remains
       ,Object_Price_View.MCSValue                                   AS MCSValue
       ,Reserve.Amount::TFloat                                       AS Reserved
       ,CASE 
          WHEN SESSIONDATA.ObjectId Is Null 
            THEN TRUE 
        ELSE FALSE 
        END                                              AS NewRow
    FROM
        GoodsRemains
        FULL OUTER JOIN SESSIONDATA ON GoodsRemains.ObjectId = SESSIONDATA.ObjectId
        INNER JOIN Object AS Object_Goods
                          ON COALESCE(GoodsRemains.ObjectId,SESSIONDATA.ObjectId) = Object_Goods.Id
        LEFT OUTER JOIN Object_Price_View ON Object_Goods.Id = Object_Price_View.GoodsId
                                         AND Object_Price_View.UnitId = vbUnitId
        LEFT OUTER JOIN RESERVE ON Object_Goods.Id = RESERVE.GoodsId
    WHERE
        ROUND(COALESCE(Object_Price_View.Price,0),2) <> COALESCE(SESSIONDATA.Price,0)
        OR
        COALESCE(GoodsRemains.Remains,0)-COALESCE(Reserve.Amount,0) <> COALESCE(SESSIONDATA.Remains,0)
        OR
        COALESCE(Object_Price_View.MCSValue,0) <> COALESCE(SESSIONDATA.MCSValue,0)
        OR
        COALESCE(Reserve.Amount,0) <> COALESCE(SESSIONDATA.Reserved,0);
    --��������� ������ � ������
    UPDATE CashSessionSnapShot SET
        Price = _DIFF.Price,
        Remains = _DIFF.Remains,
        MCSValue = _DIFF.MCSValue,
        Reserved = _DIFF.Reserved
    FROM
        _DIFF
    WHERE
        CashSessionSnapShot.CashSessionId = inCashSessionId
        AND
        CashSessionSnapShot.ObjectId = _DIFF.ObjectId;
    
    --�������� ��, ��� ���������
    Insert Into CashSessionSnapShot(CashSessionId,ObjectId,Price,Remains,MCSValue,Reserved)
    SELECT
        inCashSessionId
       ,_DIFF.ObjectId
       ,_DIFF.Price
       ,_DIFF.Remains
       ,_DIFF.MCSValue
       ,_DIFF.Reserved
    FROM
        _DIFF
    WHERE
        _DIFF.NewRow = TRUE;
    --���������� ������� � �������
    RETURN QUERY
        SELECT
            _DIFF.ObjectId,
            _DIFF.GoodsCode,
            _DIFF.GoodsName,
            _DIFF.Price,
            (_DIFF.Remains - COALESCE(CurrentMovement.Amount,0))::TFloat AS Remains,
            _DIFF.MCSValue,
            _DIFF.Reserved,
            _DIFF.NewRow
        FROM
            _DIFF
            LEFT OUTER JOIN (
                                SELECT
                                    ObjectId,
                                    SUM(Amount)::TFloat as Amount
                                FROM
                                    MovementItem
                                WHERE
                                    MovementId = inMovementId
                                    AND
                                    Amount <> 0
                                Group By
                                    ObjectId
                            ) AS CurrentMovement
                              ON CurrentMovement.ObjectId = _DIFF.ObjectId;
END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_CashRemains_Diff (Integer, TVarChar, TVarChar) OWNER TO postgres;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.   ��������� �.�.
 12.09.15                                                                       *CashSessionSnapShot
*/