-- Function: gpSelect_GoodsPartionHistory()

DROP FUNCTION IF EXISTS gpSelect_GoodsPartionHistory (Integer, Integer, Integer, TDateTime, TDateTime, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_GoodsPartionHistory(
    IN inPartyId          Integer  ,  -- ������
    IN inGoodsId          Integer  ,  -- �����
    IN inUnitId           Integer  ,  -- �������������
    IN inStartDate        TDateTime,  -- ���� ������ �������
    IN inEndDate          TDateTime,  -- ���� ��������� �������
    IN inIsPartion        Boolean  ,  -- ������� ������ ��/���
    IN inSession          TVarChar    -- ������ ������������
)
RETURNS TABLE ( 
    ContainerId      Integer,   --�� 
    MovementId       Integer,   --�� ����������
    OperDate         TDateTime, --���� ���������
    InvNumber        TVarChar,  --� ���������
    MovementDescId   Integer,   --��� ���������
    MovementDescName TVarChar,  --�������� ���� ���������
    FromId           Integer,   --�� ����
    FromName         TVarChar,  --�� ���� (��������)
    ToId             Integer,   -- ����
    ToName           TVarChar,  -- ���� (��������)
    Price            TFloat,    --���� � ���������
    Summa            TFloat,    --����� � ���������
    AmountIn         TFloat,    --���-�� ������
    AmountOut        TFloat,    --���-�� ������
    AmountInvent     TFloat,    --���-�� ��������
    Saldo            TFloat,    --������� ����� ��������
    MCSValue         TFloat,     --���
    CheckMember      TVarChar,  --��������
    Bayer            TVarChar,  --����������
    PartyId          Integer,
    PartionInvNumber TVarChar,  --� ��������� ������
    PartionOperDate  TDateTime, --���� ��������� ������
    PartionDescName  TVarChar,  --��� ��������� ������
    PartionPrice     TFloat,    --���� ������
    InsertName       TVarChar,  --������������(����.) 
    InsertDate       TDateTime  --����(����.)
  )
AS
$BODY$
   DECLARE vbUserId Integer;
--   DECLARE vbRemainsStart TFloat;
--   DECLARE vbRemainsEnd TFloat;
   DECLARE vbObjectId Integer;
BEGIN

    -- �������� ���� ������������ �� ����� ���������
    -- PERFORM lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Income());
    vbUserId:= lpGetUserBySession (inSession);


    -- ������������ <�������� ����>
    IF vbUserId = 3 THEN vbObjectId:= 0;
    ELSE vbObjectId:= lpGet_DefaultValue ('zc_Object_Retail', vbUserId);
    END IF;


    CREATE TEMP TABLE _tmpRem (ContainerId Integer, RemainsStart TFloat, RemainsEnd TFloat) ON COMMIT DROP;

    INSERT INTO _tmpRem (ContainerId, RemainsStart, RemainsEnd)
    --
    SELECT tmp.ContainerId, tmp.RemainsStart, tmp.RemainsEnd
    FROM
   (SELECT *, ROW_NUMBER() OVER(ORDER BY ABS (tmp.RemainsStart) DESC, tmp.ContainerId DESC) AS num 
    FROM
   (SELECT CASE WHEN inIsPartion = TRUE THEN Remains.ContainerId ELSE 0 END AS ContainerId
         , SUM (Remains.AmountStart) AS RemainsStart
         , SUM (Remains.AmountEnd)   AS RemainsEnd
    FROM(
            SELECT Container.Id AS ContainerId,
              Container.Amount - COALESCE(SUM(MovementItemContainer.Amount),0) AS AmountStart,
              Container.Amount - COALESCE(SUM(CASE WHEN DATE_TRUNC ('DAY', MovementItemContainer.OperDate) > inEndDate THEN MovementItemContainer.Amount ELSE 0 END),0) AS AmountEnd
              
            FROM (-- !!!�������� �����������, ����� ��� ����!!!!
                  SELECT ObjectLink_Child_ALL.ChildObjectId AS GoodsId
                  FROM ObjectLink AS ObjectLink_Child
                                    INNER JOIN  ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                                             AND ObjectLink_Main.DescId   = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Main_ALL ON ObjectLink_Main_ALL.ChildObjectId = ObjectLink_Main.ChildObjectId
                                                                                AND ObjectLink_Main_ALL.DescId        = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Child_ALL ON ObjectLink_Child_ALL.ObjectId = ObjectLink_Main_ALL.ObjectId
                                                                                 AND ObjectLink_Child_ALL.DescId   = zc_ObjectLink_LinkGoods_Goods()
                                    INNER JOIN ObjectLink AS ObjectLink_Goods_Object
                                                          ON ObjectLink_Goods_Object.ObjectId = ObjectLink_Child_ALL.ChildObjectId
                                                         AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object()
                                                         AND (ObjectLink_Goods_Object.ChildObjectId = vbObjectId OR vbObjectId = 0)
                                    INNER JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Goods_Object.ChildObjectId
                                                                      AND Object_Retail.DescId = zc_Object_Retail()
                  WHERE ObjectLink_Child.ChildObjectId = inGoodsId
                    AND ObjectLink_Child.DescId        = zc_ObjectLink_LinkGoods_Goods()
                 ) tmp
                INNER JOIN Container ON Container.DescId   = zc_Container_Count()
                                    AND Container.ObjectId = tmp.GoodsId
                INNER JOIN ContainerLinkObject AS CLO_Unit
                                               ON CLO_Unit.ContainerId = Container.Id
                                              AND CLO_Unit.DescId = zc_ContainerLinkObject_Unit()
                                              AND CLO_Unit.ObjectId = inUnitId
                LEFT OUTER JOIN ContainerLinkObject AS CLO_Party
                                                    ON CLO_Party.containerid = container.id 
                                                   AND CLO_Party.descid = zc_ContainerLinkObject_PartionMovementItem()
                LEFT OUTER JOIN MovementItemContainer ON MovementItemContainer.ContainerId = Container.Id
                                                     -- AND DATE_TRUNC ('DAY', MovementItemContainer.OperDate) >= inStartDate
                                                     AND MovementItemContainer.OperDate >= DATE_TRUNC ('DAY', inStartDate)
            WHERE (CLO_Party.ObjectId = inPartyId
                OR COALESCE (inPartyId, 0) = 0
                   )
            GROUP BY Container.Amount
                   , Container.Id
        ) AS Remains
      GROUP BY CASE WHEN inIsPartion = TRUE THEN Remains.ContainerId ELSE 0 END
      ) AS tmp
      ) AS tmp
      WHERE RemainsStart <> 0 OR RemainsEnd <> 0 OR num = 1
     ;

    -- ���������
    RETURN QUERY
        WITH RES AS
        (
            SELECT
                MovementItemContainer.ContainerId                     AS ContainerId,
                Movement.Id                                           AS MovementId,   --�� ����������
                MovementItemContainer.OperDate                        AS OperDate, --���� ���������
                Movement.InvNumber                                    AS InvNumber,  --� ���������
                MovementDesc.Id                                       AS MovementDescId,   --��� ���������
                MovementDesc.ItemName                                 AS MovementDescName,  --�������� ���� ���������
                COALESCE(Object_From.Id,Object_Unit.ID)               AS FromId,   --�� ����
                COALESCE(Object_From.ValueData,Object_Unit.ValueData) AS FromName,  --�� ���� (��������)
                COALESCE(Object_To.Id,Object_Unit.ID)                 AS ToId,   -- ����
                COALESCE(Object_To.ValueData,Object_Unit.ValueData)   AS ToName,  -- ���� (��������)
                MIFloat_Price.ValueData                               AS Price,    --���� � ���������
                ABS(MIFloat_Price.ValueData * MovementItemContainer.Amount) AS Summa, -- ����� � ���������
                CASE 
                  WHEN MovementItemContainer.Amount > 0 
                       AND 
                       Movement.DescId <> zc_Movement_Inventory() 
                    THEN MovementItemContainer.Amount 
                ELSE 0.0 END::TFloat                                  AS AmountIn,    --���-�� ������
                CASE 
                  WHEN MovementItemContainer.Amount < 0 
                       AND 
                       Movement.DescId <> zc_Movement_Inventory() 
                    THEN ABS(MovementItemContainer.Amount) 
                ELSE 0.0 
                END::TFloat                                           AS AmountOut,    --���-�� ������
                CASE 
                  WHEN Movement.DescId = zc_Movement_Inventory() 
                    THEN MovementItemContainer.Amount 
                ELSE 0.0 
                END::TFloat                                           AS AmountInvent, --���-�� ��������
                Object_Price_View.MCSValue                            AS MCSValue,     --���
                Object_CheckMember.ValueData                          AS CheckMember,  --��������
                MovementString_Bayer.ValueData                        AS Bayer,        --����������
                CLO_Party.ObjectID                                    AS PartyId,      --# ������
                ROW_NUMBER() OVER(ORDER BY MovementItemContainer.OperDate, 
                                           CASE WHEN MovementDesc.Id = zc_Movement_Inventory() THEN 1 else 0 end, 
                                           CASE WHEN MovementItemContainer.Amount > 0 THEN 0 ELSE 0 END,
                                           MovementItemContainer.MovementId,MovementItemContainer.MovementItemId,CLO_Party.ObjectID) AS OrdNum,
                (SUM(MovementItemContainer.Amount)OVER(ORDER BY MovementItemContainer.OperDate, 
                                                                CASE WHEN MovementDesc.Id = zc_Movement_Inventory() THEN 1 else 0 end, 
                                                                CASE WHEN MovementItemContainer.Amount > 0 THEN 0 ELSE 0 END,
                                                                MovementItemContainer.MovementId,MovementItemContainer.MovementItemId,CLO_Party.ObjectID)) + _tmpRem.RemainsStart AS Saldo,
                Object_Insert.ValueData              AS InsertName,
                MovementDate_Insert.ValueData        AS InsertDate
            FROM (-- !!!�������� �����������, ����� ��� ����!!!!
                  SELECT ObjectLink_Child_ALL.ChildObjectId AS GoodsId
                  FROM ObjectLink AS ObjectLink_Child
                                    INNER JOIN  ObjectLink AS ObjectLink_Main ON ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                                                                             AND ObjectLink_Main.DescId   = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Main_ALL ON ObjectLink_Main_ALL.ChildObjectId = ObjectLink_Main.ChildObjectId
                                                                                AND ObjectLink_Main_ALL.DescId        = zc_ObjectLink_LinkGoods_GoodsMain()
                                    INNER JOIN ObjectLink AS ObjectLink_Child_ALL ON ObjectLink_Child_ALL.ObjectId = ObjectLink_Main_ALL.ObjectId
                                                                                 AND ObjectLink_Child_ALL.DescId   = zc_ObjectLink_LinkGoods_Goods()
                                    INNER JOIN ObjectLink AS ObjectLink_Goods_Object
                                                          ON ObjectLink_Goods_Object.ObjectId = ObjectLink_Child_ALL.ChildObjectId
                                                         AND ObjectLink_Goods_Object.DescId = zc_ObjectLink_Goods_Object()
                                                         AND (ObjectLink_Goods_Object.ChildObjectId = vbObjectId OR vbObjectId = 0)
                                    INNER JOIN Object AS Object_Retail ON Object_Retail.Id = ObjectLink_Goods_Object.ChildObjectId
                                                                      AND Object_Retail.DescId = zc_Object_Retail()
                  WHERE ObjectLink_Child.ChildObjectId = inGoodsId
                    AND ObjectLink_Child.DescId        = zc_ObjectLink_LinkGoods_Goods()
                 ) tmp
                INNER JOIN Container ON Container.ObjectId = tmp.GoodsId
                                    AND Container.DescId = zc_Container_Count()
                LEFT JOIN _tmpRem ON _tmpRem.ContainerId = Container.Id OR _tmpRem.ContainerId = 0
                INNER JOIN ContainerLinkObject ON ContainerLinkObject.ContainerId = Container.Id
                                              AND ContainerLinkObject.DescId = zc_ContainerLinkObject_Unit()
                                              AND ContainerLinkObject.ObjectId = inUnitId

                INNER JOIN MovementItemContainer ON MovementItemContainer.ContainerId = Container.Id
                                                AND MovementItemContainer.OperDate >= DATE_TRUNC ('DAY', inStartDate) AND MovementItemContainer.OperDate < DATE_TRUNC ('DAY', inEndDate) + INTERVAL '1 DAY'


                INNER JOIN Movement ON MovementItemContainer.MovementId = Movement.Id
                INNER JOIN MovementDesc ON Movement.DescId = MovementDesc.Id

                LEFT OUTER JOIN ContainerLinkObject AS CLO_Party
                                                    ON CLO_Party.containerid = container.id 
                                                   AND CLO_Party.descid = zc_ContainerLinkObject_PartionMovementItem()                              
                
                LEFT OUTER JOIN MovementLinkObject AS MovementLinkObject_From
                                                   ON MovementLinkObject_From.MovementId = Movement.Id
                                                  AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
                LEFT OUTER JOIN Object AS Object_From
                                       ON MovementLinkObject_From.ObjectId = Object_From.Id

                LEFT OUTER JOIN MovementLinkObject AS MovementLinkObject_To
                                                   ON MovementLinkObject_To.MovementId = Movement.Id
                                                  AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                LEFT OUTER JOIN Object AS Object_To
                                       ON MovementLinkObject_To.ObjectId = Object_To.Id
                
                LEFT OUTER JOIN MovementLinkObject AS MovementLinkObject_Unit
                                                   ON MovementLinkObject_Unit.MovementId = Movement.Id
                                                  AND MovementLinkObject_Unit.DescId = zc_MovementLinkObject_Unit()
                LEFT OUTER JOIN Object AS Object_Unit
                                       ON MovementLinkObject_Unit.ObjectId = Object_Unit.Id
                
                LEFT OUTER JOIN Object_Price_View ON Object_Price_View.UnitId = inUnitId
                                                 AND Object_Price_View.GoodsId = inGoodsId
                
                LEFT OUTER JOIN MovementItemFloat AS MIFloat_Price 
                                                  ON MIFloat_Price.MovementItemId = MovementItemContainer.MovementItemId
                                                 AND MIFloat_Price.DescId = zc_MIFloat_Price()
                                                 
                LEFT JOIN MovementLinkObject AS MovementLinkObject_CheckMember
                                             ON MovementLinkObject_CheckMember.MovementId = MovementItemContainer.MovementId
                                            AND MovementLinkObject_CheckMember.DescId = zc_MovementLinkObject_CheckMember()
                LEFT JOIN Object AS Object_CheckMember ON Object_CheckMember.Id = MovementLinkObject_CheckMember.ObjectId
                LEFT JOIN MovementString AS MovementString_Bayer
                                         ON MovementString_Bayer.MovementId = Movement.Id
                                        AND MovementString_Bayer.DescId = zc_MovementString_Bayer()
                -- ������������(����.) + ����(����.)  
                LEFT JOIN MovementDate AS MovementDate_Insert
                                       ON MovementDate_Insert.MovementId = Movement.Id
                                      AND MovementDate_Insert.DescId = zc_MovementDate_Insert()

                LEFT JOIN MovementLinkObject AS MLO_Insert
                                             ON MLO_Insert.MovementId = Movement.Id
                                            AND MLO_Insert.DescId = zc_MovementLinkObject_Insert()
                LEFT JOIN Object AS Object_Insert ON Object_Insert.Id = MLO_Insert.ObjectId  

            WHERE (CLO_Party.ObjectID = inPartyId 
                OR inPartyId = 0
                  )
            UNION ALL
            SELECT
                _tmpRem.ContainerId        AS ContainerId,
                NULL                       AS MovementId,    --�� ����������
                inStartDate                AS OperDate,      --���� ���������
                NULL                       AS InvNumber,     --� ���������
                NULL                       AS MovementDescId,    --��� ���������
                '������� �� ������'        AS MovementDescName,  --�������� ���� ���������
                NULL                       AS FromId,        --�� ����
                NULL                       AS FromName,      --�� ���� (��������)
                NULL                       AS ToId,          -- ����
                NULL                       AS ToName,        -- ���� (��������)
                NULL::TFloat               AS Price,         --���� � ���������
                NULL::TFloat               AS Summa,         --���� � ���������
                NULL                       AS AmountIn,      --���-�� ������
                NULL                       AS AmountOut,     --���-�� ������
                NULL                       AS AmountInvent,  --���-�� ��������
                Object_Price_View.MCSValue AS MCSValue,      --���
                NULL                       AS CheckMember,   --��������
                NULL                       AS Bayer,         --����������
                CLO_Party.ObjectID         AS PartyId,       --# ������
                0                          AS OrdNum,
                _tmpRem.RemainsStart       AS Saldo,
                NULL                       AS InsertName,
                NULL                       AS InsertDate
            FROM _tmpRem
                LEFT JOIN Container ON Container.Id = _tmpRem.ContainerId
                LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = COALESCE (Container.ObjectId, inGoodsId)
                LEFT OUTER JOIN Object_Price_View ON Object_Price_View.UnitId = inUnitId
                                                 AND Object_Price_View.GoodsId = Object_Goods.Id
                LEFT OUTER JOIN ContainerLinkObject AS CLO_Party
                                                    ON CLO_Party.containerid = container.id 
                                                   AND CLO_Party.descid = zc_ContainerLinkObject_PartionMovementItem()                              
           UNION ALL
            SELECT
                _tmpRem.ContainerId        AS ContainerId,
                NULL                       AS MovementId,   --�� ����������
                inEndDate                  AS OperDate,     --���� ���������
                NULL                       AS InvNumber,    --� ���������
                NULL                       AS MovementDescId,    --��� ���������
                '������� �� �����'         AS MovementDescName,  --�������� ���� ���������
                NULL                       AS FromId,       --�� ����
                NULL                       AS FromName,     --�� ���� (��������)
                NULL                       AS ToId,         -- ����
                NULL                       AS ToName,       -- ���� (��������)
                NULL::TFloat               AS Price,        --���� � ���������
                NULL::TFloat               AS Summa,        --���� � ���������
                NULL                       AS AmountIn,     --���-�� ������
                NULL                       AS AmountOut,    --���-�� ������
                NULL                       AS AmountInvent, --���-�� ��������
                Object_Price_View.MCSValue AS MCSValue,     --���
                NULL                       AS CheckMember,  --��������
                NULL                       AS Bayer,        --����������
                CLO_Party.ObjectID         AS PartyId,      --# ������
                999999999                  AS OrdNum,
                _tmpRem.RemainsEnd         AS Saldo,
                NULL                       AS InsertName,
                NULL                       AS InsertDate 
            FROM _tmpRem
                LEFT JOIN Container ON Container.Id = _tmpRem.ContainerId
                LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = COALESCE (Container.ObjectId, inGoodsId)
                LEFT JOIN Object_Price_View ON Object_Price_View.UnitId = inUnitId
                                                 AND Object_Price_View.GoodsId = Object_Goods.Id
                LEFT OUTER JOIN ContainerLinkObject AS CLO_Party
                                                    ON CLO_Party.containerid = container.id 
                                                   AND CLO_Party.descid = zc_ContainerLinkObject_PartionMovementItem()                              
        )

        SELECT
            Res.ContainerId,
            Res.MovementId::Integer,            --�� ����������
            Res.OperDate::TDateTime,            --���� ���������
            Res.InvNumber::TVarChar,            --� ���������
            Res.MovementDescId::Integer,        --��� ���������
            Res.MovementDescName::TVarChar,     --�������� ���� ���������
            Res.FromId::Integer,                --�� ����
            Res.FromName::TVarChar,             --�� ���� (��������)
            Res.ToId::Integer,                  -- ����
            Res.ToName::TVarChar,               -- ���� (��������)
            Res.Price::TFloat,                  --���� � ���������
            Res.Summa::TFloat,                  --����� � ���������
            NULLIF(Res.AmountIn,0)::TFloat,     --���-�� ������
            NULLIF(Res.AmountOut,0)::TFloat,    --���-�� ������
            NULLIF(Res.AmountInvent,0)::TFloat, --���-�� ��������
            Res.Saldo::TFloat,                  --������� ����� ��������
            Res.MCSValue::TFloat,               --���
            Res.CheckMember::TVarChar,          --��������
            Res.Bayer::TVarChar,                --����������
            Res.PartyId ,                       --# ������
            COALESCE(Movement_Party.InvNumber, NULL) ::TVarChar  AS PartionInvNumber,  -- � ���.������
            COALESCE(Movement_Party.OperDate, NULL)  ::TDateTime AS PartionOperDate,   -- ���� ���.������
            COALESCE(MovementDesc.ItemName, NULL)    ::TVarChar  AS PartionDescName,
            COALESCE(MIFloat_Price.ValueData, NULL)  ::TFloat    AS PartionPrice,
            Res.InsertName  ::TVarChar,         --������������(����.) 
            Res.InsertDate  ::TDateTime         --����(����.)
        FROM Res 
           LEFT JOIN OBJECT AS Object_PartionMovementItem 
                            ON Object_PartionMovementItem.Id = Res.PartyId --CLI_MI.ObjectId
                            AND inIsPartion = True
           LEFT JOIN MovementItem ON MovementItem.Id = Object_PartionMovementItem.ObjectCode

           LEFT OUTER JOIN MovementItemFloat AS MIFloat_Price
                                             ON MIFloat_Price.MovementItemId = MovementItem.ID
                                            AND MIFloat_Price.DescId = zc_MIFloat_Price()

           LEFT JOIN Movement AS Movement_Party ON Movement_Party.Id = MovementItem.MovementId 
                                         --     AND inIsPartion = True
           LEFT JOIN MovementDesc ON MovementDesc.Id = Movement_Party.DescId
          
        ORDER BY 
            Res.OrdNum;
END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.  ��������� �.�.
 07.01.17         *
 01.07.16         * add inIsPartion
 26.08.15                                                                       *
*/

-- ����
-- SELECT * FROM gpSelect_GoodsPartionHistory (inPartyId := 0,inGoodsId := 0,inUnitId := 0,inStartDate := '20150801',inEndDate := '20150830', inSession := '3')
