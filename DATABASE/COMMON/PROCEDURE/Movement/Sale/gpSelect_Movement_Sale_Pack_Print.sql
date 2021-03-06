 -- Function: gpSelect_Movement_Sale_Pack_Print()

DROP FUNCTION IF EXISTS gpSelect_Movement_Sale_Pack_Print21 (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Movement_Sale_Pack_Print (Integer, TVarChar);
DROP FUNCTION IF EXISTS gpSelect_Movement_Sale_Pack_Print (Integer, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_Movement_Sale_Pack_Print(
    IN inMovementId        Integer  , -- ���� ���������
    IN inMovementId_by     Integer  , -- ���� ���������
    IN inSession           TVarChar   -- ������ ������������
)
RETURNS SETOF refcursor
AS
$BODY$
    DECLARE vbUserId Integer;

    DECLARE vbGoodsPropertyId Integer;

    DECLARE Cursor1 refcursor;
    DECLARE vbOperDatePartner TDateTime;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_Movement_Sale_Pack_Print());
     vbUserId:= lpGetUserBySession (inSession);

     -- ����
     vbOperDatePartner:= (SELECT COALESCE (MovementDate_OperDatePartner.ValueData, Movement.OperDate) AS OperDatePartner
                          FROM Movement
                               LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                                      ON MovementDate_OperDatePartner.MovementId =  Movement.Id
                                                     AND MovementDate_OperDatePartner.DescId     = zc_MovementDate_OperDatePartner()
                          WHERE Movement.Id = inMovementId
                         );



     -- ������������ ��������
     vbGoodsPropertyId:= (SELECT zfCalc_GoodsPropertyId (MovementLinkObject_Contract.ObjectId, COALESCE (ObjectLink_Partner_Juridical.ChildObjectId, MovementLinkObject_To.ObjectId), MovementLinkObject_To.ObjectId)
                          FROM Movement
                               LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                                            ON MovementLinkObject_Contract.MovementId = Movement.Id
                                                           AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
                               LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                                            ON MovementLinkObject_To.MovementId = Movement.Id
                                                           AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                               LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                                    ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                                   AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
                          WHERE Movement.Id = inMovementId
                         );
-- RAISE EXCEPTION '<%>', lfGet_Object_ValueData (vbGoodsPropertyId);

     -- ������: ��������� + �������� �����
     OPEN Cursor1 FOR
     WITH -- ������ ���� ���������� ����������� ��� ������ - inMovementId_by
          tmpMovement AS (SELECT Movement.Id, Movement.ParentId
                          FROM Movement
                          WHERE Movement.ParentId = inMovementId
                            AND Movement.DescId = zc_Movement_WeighingPartner()
                            -- AND Movement.StatusId = zc_Enum_Status_Complete()
                            AND (Movement.Id = inMovementId_by OR COALESCE (inMovementId_by, 0) = 0)
                         )
     , tmpMovementCount AS (SELECT Count(*) AS WeighingCount
                            FROM Movement
                            WHERE Movement.ParentId = inMovementId
                              AND Movement.DescId = zc_Movement_WeighingPartner()
                              AND Movement.StatusId = zc_Enum_Status_Complete()
                           )
       -- ������ �������� ���������� ��� ������� + GoodsKindId
     , tmpObject_GoodsPropertyValue AS (SELECT ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                             , ObjectLink_GoodsPropertyValue_Goods.ChildObjectId                   AS GoodsId
                                             , COALESCE (ObjectLink_GoodsPropertyValue_GoodsKind.ChildObjectId, 0) AS GoodsKindId
                                             , Object_GoodsPropertyValue.ValueData  AS Name
                                             , ObjectString_BarCode.ValueData       AS BarCode
                                             , ObjectString_BarCodeGLN.ValueData    AS BarCodeGLN
                                             , ObjectString_Article.ValueData       AS Article
                                             , COALESCE (ObjectLink_GoodsPropertyValue_GoodsBox.ChildObjectId, 0)  AS GoodsBoxId
                                             , COALESCE (ObjectFloat_Weight.ValueData, 0)                          AS GoodsBox_Weight
                                        FROM (SELECT vbGoodsPropertyId AS GoodsPropertyId WHERE vbGoodsPropertyId <> 0
                                             ) AS tmpGoodsProperty
                                             INNER JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_GoodsProperty
                                                                   ON ObjectLink_GoodsPropertyValue_GoodsProperty.ChildObjectId = tmpGoodsProperty.GoodsPropertyId
                                                                  AND ObjectLink_GoodsPropertyValue_GoodsProperty.DescId = zc_ObjectLink_GoodsPropertyValue_GoodsProperty()
                                             LEFT JOIN Object AS Object_GoodsPropertyValue ON Object_GoodsPropertyValue.Id = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId

                                             LEFT JOIN ObjectString AS ObjectString_BarCode
                                                                    ON ObjectString_BarCode.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                                                   AND ObjectString_BarCode.DescId = zc_ObjectString_GoodsPropertyValue_BarCode()
                                             LEFT JOIN ObjectString AS ObjectString_BarCodeGLN
                                                                    ON ObjectString_BarCodeGLN.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                                                   AND ObjectString_BarCodeGLN.DescId = zc_ObjectString_GoodsPropertyValue_BarCodeGLN()
                                             LEFT JOIN ObjectString AS ObjectString_Article
                                                                    ON ObjectString_Article.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                                                   AND ObjectString_Article.DescId = zc_ObjectString_GoodsPropertyValue_Article()
                                             LEFT JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_Goods
                                                                  ON ObjectLink_GoodsPropertyValue_Goods.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                                                 AND ObjectLink_GoodsPropertyValue_Goods.DescId = zc_ObjectLink_GoodsPropertyValue_Goods()
                                             LEFT JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_GoodsKind
                                                                  ON ObjectLink_GoodsPropertyValue_GoodsKind.ObjectId = ObjectLink_GoodsPropertyValue_GoodsProperty.ObjectId
                                                                 AND ObjectLink_GoodsPropertyValue_GoodsKind.DescId = zc_ObjectLink_GoodsPropertyValue_GoodsKind()

                                             LEFT JOIN ObjectLink AS ObjectLink_GoodsPropertyValue_GoodsBox
                                                                  ON ObjectLink_GoodsPropertyValue_GoodsBox.ObjectId = Object_GoodsPropertyValue.Id
                                                                 AND ObjectLink_GoodsPropertyValue_GoodsBox.DescId = zc_ObjectLink_GoodsPropertyValue_GoodsBox()
                                             LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                                                   ON ObjectFloat_Weight.ObjectId = ObjectLink_GoodsPropertyValue_GoodsBox.ChildObjectId
                                                                  AND ObjectFloat_Weight.DescId   = zc_ObjectFloat_Goods_Weight()
                                                                 
                                       )
       -- ������ �������� ��� ������� (����� ���� �� ������ �� GoodsKindId)
     , tmpObject_GoodsPropertyValueGroup AS (SELECT tmpObject_GoodsPropertyValue.GoodsId
                                                  , tmpObject_GoodsPropertyValue.Name
                                                  , tmpObject_GoodsPropertyValue.Article
                                                  , tmpObject_GoodsPropertyValue.BarCode
                                                  , tmpObject_GoodsPropertyValue.BarCodeGLN
                                             FROM (SELECT MAX (tmpObject_GoodsPropertyValue.ObjectId) AS ObjectId, GoodsId FROM tmpObject_GoodsPropertyValue WHERE Article <> '' GROUP BY GoodsId
                                                  ) AS tmpGoodsProperty_find
                                                  LEFT JOIN tmpObject_GoodsPropertyValue ON tmpObject_GoodsPropertyValue.ObjectId =  tmpGoodsProperty_find.ObjectId
                                            )
       -- �������� ����� ���������� ����������� ��� ������ - inMovementId_by
     , tmpMovementItem AS (SELECT MovementItem.MovementId                           AS MovementId
                                , MovementItem.ObjectId                             AS GoodsId
                                , SUM (MovementItem.Amount)                         AS Amount
                                , SUM (MovementItem.Amount * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) AS AmountWeight
                                , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)     AS GoodsKindId
                                , MAX (COALESCE (MIFloat_LevelNumber.ValueData, 0)) AS LevelNumber
                                , SUM (COALESCE (MIFloat_BoxCount.ValueData, 0))    AS BoxCount
                                , SUM (COALESCE (MIFloat_AmountPartner.ValueData, 0)) AS AmountPartner
                                , SUM (COALESCE (MIFloat_AmountPartner.ValueData, 0) * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Kg() THEN 1 WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN ObjectFloat_Weight.ValueData ELSE 0 END) AS AmountPartnerWeight
                                , SUM (CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (MIFloat_AmountPartner.ValueData, 0) ELSE 0 END) AS AmountPartnerSh
                           FROM tmpMovement
                                INNER JOIN MovementItem ON MovementItem.MovementId =  tmpMovement.Id
                                                       AND MovementItem.DescId     = zc_MI_Master()
                                                       AND MovementItem.isErased   = FALSE
                                                       -- AND MovementItem.Amount    <> 0
                                LEFT JOIN MovementItemFloat AS MIFloat_AmountPartner
                                                            ON MIFloat_AmountPartner.MovementItemId = MovementItem.Id
                                                           AND MIFloat_AmountPartner.DescId = zc_MIFloat_AmountPartner()
                                LEFT JOIN MovementItemFloat AS MIFloat_BoxCount
                                                            ON MIFloat_BoxCount.MovementItemId = MovementItem.Id
                                                           AND MIFloat_BoxCount.DescId = zc_MIFloat_BoxCount()
                                LEFT JOIN MovementItemFloat AS MIFloat_LevelNumber
                                                            ON MIFloat_LevelNumber.MovementItemId = MovementItem.Id
                                                           AND MIFloat_LevelNumber.DescId = zc_MIFloat_LevelNumber()
                                LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                 ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()

                                LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                                      ON ObjectFloat_Weight.ObjectId = MovementItem.ObjectId
                                                     AND ObjectFloat_Weight.DescId   = zc_ObjectFloat_Goods_Weight()
                                LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                                     ON ObjectLink_Goods_Measure.ObjectId = MovementItem.ObjectId
                                                    AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()

                           GROUP BY MovementItem.MovementId, MovementItem.ObjectId, MILinkObject_GoodsKind.ObjectId
                          )
       -- StickerProperty -  ������� �� 
     , tmpStickerProperty AS (SELECT ObjectLink_Sticker_Goods.ChildObjectId              AS GoodsId
                                   , ObjectLink_StickerProperty_GoodsKind.ChildObjectId  AS GoodsKindId
                                   , COALESCE (ObjectFloat_Value5.ValueData, 0)          AS Value5
                                     --  � �/�
                                   , ROW_NUMBER() OVER (PARTITION BY ObjectLink_Sticker_Goods.ChildObjectId, ObjectLink_StickerProperty_GoodsKind.ChildObjectId ORDER BY COALESCE (ObjectFloat_Value5.ValueData, 0) DESC) AS Ord
                              FROM Object AS Object_StickerProperty
                                    LEFT JOIN ObjectLink AS ObjectLink_StickerProperty_Sticker
                                                         ON ObjectLink_StickerProperty_Sticker.ObjectId = Object_StickerProperty.Id
                                                        AND ObjectLink_StickerProperty_Sticker.DescId   = zc_ObjectLink_StickerProperty_Sticker()
                                    LEFT JOIN ObjectLink AS ObjectLink_Sticker_Goods
                                                         ON ObjectLink_Sticker_Goods.ObjectId = ObjectLink_StickerProperty_Sticker.ChildObjectId
                                                        AND ObjectLink_Sticker_Goods.DescId   = zc_ObjectLink_Sticker_Goods()
                                    LEFT JOIN ObjectLink AS ObjectLink_Sticker_Juridical
                                                         ON ObjectLink_Sticker_Juridical.ObjectId = ObjectLink_StickerProperty_Sticker.ChildObjectId
                                                        AND ObjectLink_Sticker_Juridical.DescId   = zc_ObjectLink_StickerProperty_GoodsKind()

                                    LEFT JOIN ObjectLink AS ObjectLink_StickerProperty_GoodsKind
                                                         ON ObjectLink_StickerProperty_GoodsKind.ObjectId = Object_StickerProperty.Id
                                                        AND ObjectLink_StickerProperty_GoodsKind.DescId = zc_ObjectLink_StickerProperty_GoodsKind()

                                    LEFT JOIN ObjectFloat AS ObjectFloat_Value5
                                                          ON ObjectFloat_Value5.ObjectId = Object_StickerProperty.Id
                                                         AND ObjectFloat_Value5.DescId = zc_ObjectFloat_StickerProperty_Value5()

                              WHERE Object_StickerProperty.DescId   = zc_Object_StickerProperty()
                                AND Object_StickerProperty.isErased = FALSE
                                AND ObjectLink_Sticker_Juridical.ChildObjectId IS NULL -- !!!����������� ��� ����������!!!
                             )
      -- ���������
      SELECT tmpMovementItem.MovementId	                                            AS MovementId
           , CAST (ROW_NUMBER() OVER (PARTITION BY MovementFloat_WeighingNumber.ValueData ORDER BY MovementFloat_WeighingNumber.ValueData, ObjectString_Goods_GoodsGroupFull.ValueData, Object_Goods.ValueData, Object_GoodsKind.ValueData) AS Integer) AS NumOrder
           , Movement_Sale.OperDate				                    AS OperDate
           , COALESCE (MovementDate_OperDatePartner.ValueData, Movement_Sale.OperDate)  AS OperDatePartner
           , MovementFloat_WeighingNumber.ValueData                                 AS WeighingNumber
           , (SELECT WeighingCount FROM tmpMovementCount) :: Integer                AS WeighingCount
           , Movement_Sale.InvNumber		                                    AS InvNumber
           , MovementString_InvNumberPartner.ValueData                              AS InvNumberPartner
           , MovementString_InvNumberOrder.ValueData                                AS InvNumberOrder
           , MovementFloat_TotalCountKg.ValueData                                   AS TotalCountKg

           , OH_JuridicalDetails_From.FullName                                      AS JuridicalName_From
           , OH_JuridicalDetails_From.JuridicalAddress                              AS JuridicalAddress_From

           , OH_JuridicalDetails_To.FullName                                        AS JuridicalName_To
           , OH_JuridicalDetails_To.JuridicalAddress                                AS JuridicalAddress_To
           , ObjectString_ToAddress.ValueData                                       AS PartnerAddress_To

           , Object_From.ValueData             		                            AS FromName
           , Object_To.ValueData                                                    AS ToName

           , View_Contract.InvNumber        	                                    AS ContractName
           , ObjectDate_Signing.ValueData                                           AS ContractSigningDate

           , ObjectString_Goods_GoodsGroupFull.ValueData                            AS GoodsGroupNameFull
           , Object_Goods.ObjectCode                                                AS GoodsCode
           , (CASE WHEN tmpObject_GoodsPropertyValue.Name <> '' THEN tmpObject_GoodsPropertyValue.Name ELSE Object_Goods.ValueData END || CASE WHEN COALESCE (Object_GoodsKind.Id, zc_Enum_GoodsKind_Main()) = zc_Enum_GoodsKind_Main() THEN '' ELSE ' ' || Object_GoodsKind.ValueData END) :: TVarChar AS GoodsName
           , CASE WHEN tmpObject_GoodsPropertyValue.Name <> '' THEN tmpObject_GoodsPropertyValue.Name ELSE Object_Goods.ValueData END :: TVarChar AS GoodsName_two
           , COALESCE (tmpObject_GoodsPropertyValueGroup.Name, tmpObject_GoodsPropertyValue.Name) AS GoodsName_Juridical
           , Object_GoodsKind.ValueData                                             AS GoodsKindName
           , Object_Measure.ValueData                                               AS MeasureName
           , COALESCE (tmpObject_GoodsPropertyValue.Article, COALESCE (tmpObject_GoodsPropertyValueGroup.Article, '')) AS Article_Juridical
           , COALESCE (tmpObject_GoodsPropertyValue.BarCode, COALESCE (tmpObject_GoodsPropertyValueGroup.BarCode, '')) AS BarCode_Juridical
           , tmpMovementItem.LevelNumber                                            AS LevelNumber
           , tmpMovementItem.BoxCount                                               AS BoxCount
           , (COALESCE (tmpMovementItem.BoxCount, 0) * COALESCE (tmpObject_GoodsPropertyValue.GoodsBox_Weight, 0)):: TFloat AS BoxWeight

           , tmpMovementItem.Amount                                       :: TFloat AS Amount
           , tmpMovementItem.AmountWeight                                 :: TFloat AS AmountWeight
           , tmpMovementItem.AmountPartner                                :: TFloat AS AmountPartner
           , tmpMovementItem.AmountPartnerWeight                          :: TFloat AS AmountPartnerWeight
           , tmpMovementItem.AmountPartnerSh                              :: TFloat AS AmountPartnerSh

             -- ��� ������
           , (-- "������" ��� "� ����������" - ???������ �� �� ������ �� ��� �� ������ �����������???
              tmpMovementItem.AmountPartnerWeight
            + -- ���� ��� "�����������"
              COALESCE (tmpMovementItem.BoxCount, 0) * COALESCE (tmpObject_GoodsPropertyValue.GoodsBox_Weight, 0)
            + -- ���� ��� �������� (�������)
              CASE WHEN COALESCE (ObjectFloat_WeightTotal.ValueData, 0) - COALESCE (ObjectFloat_WeightPackage.ValueData, 0) > 0
                        THEN -- "������" ��� "� ����������" ����� �� ��� � ��������: "������" ��� + ��� 1-��� ������ ����� ��� 1-��� ������
                             CAST (tmpMovementItem.AmountPartnerWeight / (COALESCE (ObjectFloat_WeightTotal.ValueData, 0) - COALESCE (ObjectFloat_WeightPackage.ValueData, 0)) AS NUMERIC (16, 0))
                           * -- ��� 1-��� ������
                             COALESCE (ObjectFloat_WeightPackage.ValueData, 0)
                   ELSE 0
              END
             ) :: TFloat AS AmountPartnerWeightWithBox

             -- ���-�� �������� (�������)
           , CASE WHEN COALESCE (ObjectFloat_WeightTotal.ValueData, 0) - COALESCE (ObjectFloat_WeightPackage.ValueData, 0) > 0
                       THEN -- "������" ��� "� ����������" ����� �� ��� � ��������: "������" ��� + ��� 1-��� ������ ����� ��� 1-��� ������
                            CAST (tmpMovementItem.AmountPartnerWeight / (COALESCE (ObjectFloat_WeightTotal.ValueData, 0) - COALESCE (ObjectFloat_WeightPackage.ValueData, 0)) AS NUMERIC (16, 0))
                  ELSE 0
             END :: TFloat AS CountPackage_calc
             -- ��� �������� (�������)
           , CASE WHEN COALESCE (ObjectFloat_WeightTotal.ValueData, 0) - COALESCE (ObjectFloat_WeightPackage.ValueData, 0) > 0
                       THEN -- "������" ��� "� ����������" ����� �� ��� � ��������: "������" ��� + ��� 1-��� ������ ����� ��� 1-��� ������
                            CAST (tmpMovementItem.AmountPartnerWeight / (COALESCE (ObjectFloat_WeightTotal.ValueData, 0) - COALESCE (ObjectFloat_WeightPackage.ValueData, 0)) AS NUMERIC (16, 0))
                          * -- ��� 1-��� ������
                            COALESCE (ObjectFloat_WeightPackage.ValueData, 0)
                  ELSE 0
             END :: TFloat AS WeightPackage_calc


              -- �����-��� GS1-128
           ,  -- 01 - EAN ��� ������ �� ����� - 14
             ('01' || '0' || CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh()
                                  THEN COALESCE (tmpObject_GoodsPropertyValue.BarCodeGLN, COALESCE (tmpObject_GoodsPropertyValueGroup.BarCodeGLN, ''))
                                  ELSE COALESCE (tmpObject_GoodsPropertyValue.BarCode,    COALESCE (tmpObject_GoodsPropertyValueGroup.BarCode, ''))
                             END
              -- 37 - ʳ������ ������ - 8
           || '37' || REPEAT ('0', 8 - LENGTH ((tmpMovementItem.BoxCount :: Integer) :: TVarChar)) || (tmpMovementItem.BoxCount :: Integer) :: TVarChar
              -- 3103 - ���� � � ����� ���� ���� - 6
           || '3103' || REPEAT ('0', 3 - LENGTH (FLOOR (tmpMovementItem.AmountPartnerWeight) :: TVarChar))
                            || FLOOR (tmpMovementItem.AmountPartnerWeight) :: TVarChar
                     || REPEAT ('0', 3 - LENGTH ((FLOOR (tmpMovementItem.AmountPartnerWeight * 1000) - FLOOR (tmpMovementItem.AmountPartnerWeight) * 1000) :: TVarChar))
                            || (FLOOR (tmpMovementItem.AmountPartnerWeight * 1000) - FLOOR (tmpMovementItem.AmountPartnerWeight) * 1000) :: TVarChar
              -- 15 - ���� ��������� ������ ���������� - 6 - ������
           || '15' || (EXTRACT (YEAR  FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL) - 2000) :: TVarChar
                   || CASE WHEN EXTRACT (MONTH FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL) < 10
                                THEN '0'
                           ELSE ''
                      END || EXTRACT (MONTH FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL)  :: TVarChar
                   || CASE WHEN EXTRACT (DAY   FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL) < 10
                                THEN '0'
                           ELSE ''
                      END || EXTRACT (DAY   FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL)  :: TVarChar
             ) :: TVarChar AS BarCode_128

              -- �����-��� GS1-128
           ,  -- 01 - EAN ��� ������ �� ����� - 14
             ('(01)' || '0' || CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh()
                                    THEN COALESCE (tmpObject_GoodsPropertyValue.BarCodeGLN, COALESCE (tmpObject_GoodsPropertyValueGroup.BarCodeGLN, ''))
                                    ELSE COALESCE (tmpObject_GoodsPropertyValue.BarCode,    COALESCE (tmpObject_GoodsPropertyValueGroup.BarCode, ''))
                               END
              -- 37 - ʳ������ ������ - 8
           || '(37)' || REPEAT ('0', 8 - LENGTH ((tmpMovementItem.BoxCount :: Integer) :: TVarChar)) || (tmpMovementItem.BoxCount :: Integer) :: TVarChar
              -- 3103 - ���� � � ����� ���� ���� - 6
           || '(3103)' || REPEAT ('0', 3 - LENGTH (FLOOR (tmpMovementItem.AmountPartnerWeight) :: TVarChar))
                            || FLOOR (tmpMovementItem.AmountPartnerWeight) :: TVarChar
                     || REPEAT ('0', 3 - LENGTH ((FLOOR (tmpMovementItem.AmountPartnerWeight * 1000) - FLOOR (tmpMovementItem.AmountPartnerWeight) * 1000) :: TVarChar))
                            || (FLOOR (tmpMovementItem.AmountPartnerWeight * 1000) - FLOOR (tmpMovementItem.AmountPartnerWeight) * 1000) :: TVarChar
              -- 15 - ���� ��������� ������ ���������� - 6 - ������
           || '(15)' || (EXTRACT (YEAR  FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL) - 2000) :: TVarChar
                   || CASE WHEN EXTRACT (MONTH FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL) < 10
                                THEN '0'
                           ELSE ''
                      END || EXTRACT (MONTH FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL)  :: TVarChar
                   || CASE WHEN EXTRACT (DAY   FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL) < 10
                                THEN '0'
                           ELSE ''
                      END || EXTRACT (DAY   FROM vbOperDatePartner + ((COALESCE (tmpStickerProperty.Value5, 0) :: Integer) :: TVarChar || ' DAY' ):: INTERVAL)  :: TVarChar
             ) :: TVarChar AS BarCode_128_str
             
           , tmpStickerProperty.Value5 :: Integer AS Value5_termin


           , CASE WHEN MovementLinkObject_Contract.ObjectId > 0
                       AND Object_InfoMoney_View.InfoMoneyDestinationId NOT IN (zc_Enum_InfoMoneyDestination_20500() -- ������������� + ��������� ����
                                                                              , zc_Enum_InfoMoneyDestination_20600() -- ������������� + ������ ���������
                                                                                )
                      THEN FALSE
                  ELSE TRUE
             END AS isBranch

           , CASE WHEN ObjectLink_Juridical_Retail.ChildObjectId = 310853 -- ����
                      THEN TRUE
                  ELSE FALSE
             END AS isAshan
           , CASE WHEN ObjectLink_Juridical_Retail.ChildObjectId = 310854 -- ����
                      THEN TRUE
                  ELSE FALSE
             END AS isFozzi

       FROM tmpMovement
            INNER JOIN tmpMovementItem ON tmpMovementItem.MovementId = tmpMovement.Id AND tmpMovementItem.AmountPartner <> 0

            LEFT JOIN tmpStickerProperty ON tmpStickerProperty.GoodsId     = tmpMovementItem.GoodsId
                                        AND tmpStickerProperty.GoodsKindId = tmpMovementItem.GoodsKindId
                                        AND tmpStickerProperty.Ord         = 1
            
            LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                 ON ObjectLink_Goods_InfoMoney.ObjectId = tmpMovementItem.GoodsId
                               AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
            LEFT JOIN Object_InfoMoney_View ON Object_InfoMoney_View.InfoMoneyId = ObjectLink_Goods_InfoMoney.ChildObjectId

            LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                         ON MovementLinkObject_From.MovementId = tmpMovement.Id
                                        AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
            LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId
            LEFT JOIN ObjectLink AS ObjectLink_Unit_Juridical
                                 ON ObjectLink_Unit_Juridical.ObjectId = Object_From.Id
                                AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_To
                                         ON MovementLinkObject_To.MovementId = tmpMovement.Id
                                        AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
            LEFT JOIN Object AS Object_To ON Object_To.Id = MovementLinkObject_To.ObjectId


            LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = tmpMovementItem.GoodsId
            LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpMovementItem.GoodsKindId

            LEFT JOIN ObjectString AS ObjectString_Goods_GoodsGroupFull
                                   ON ObjectString_Goods_GoodsGroupFull.ObjectId = Object_Goods.Id
                                  AND ObjectString_Goods_GoodsGroupFull.DescId = zc_ObjectString_Goods_GroupNameFull()

            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = Object_Goods.Id
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN Object AS Object_Measure ON Object_Measure.Id = ObjectLink_Goods_Measure.ChildObjectId

            LEFT JOIN MovementFloat AS MovementFloat_WeighingNumber
                                    ON MovementFloat_WeighingNumber.MovementId = tmpMovement.Id
                                   AND MovementFloat_WeighingNumber.DescId = zc_MovementFloat_WeighingNumber()

            LEFT JOIN MovementFloat AS MovementFloat_TotalCountKg
                                    ON MovementFloat_TotalCountKg.MovementId = tmpMovement.Id
                                   AND MovementFloat_TotalCountKg.DescId = zc_MovementFloat_TotalCountKg()

            LEFT JOIN tmpObject_GoodsPropertyValue ON tmpObject_GoodsPropertyValue.GoodsId = Object_Goods.Id
                                                  AND tmpObject_GoodsPropertyValue.GoodsKindId = Object_GoodsKind.Id
            LEFT JOIN tmpObject_GoodsPropertyValueGroup ON tmpObject_GoodsPropertyValueGroup.GoodsId = Object_Goods.Id
                                                       AND tmpObject_GoodsPropertyValue.GoodsId IS NULL

-- MOVEMENT
            LEFT JOIN Movement AS Movement_Sale ON Movement_Sale.Id = tmpMovement.ParentId
            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                   ON MovementDate_OperDatePartner.MovementId = Movement_Sale.Id
                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
            LEFT JOIN MovementString AS MovementString_InvNumberPartner
                                     ON MovementString_InvNumberPartner.MovementId = Movement_Sale.Id
                                    AND MovementString_InvNumberPartner.DescId = zc_MovementString_InvNumberPartner()
            LEFT JOIN MovementString AS MovementString_InvNumberOrder
                                     ON MovementString_InvNumberOrder.MovementId = Movement_Sale.Id
                                    AND MovementString_InvNumberOrder.DescId = zc_MovementString_InvNumberOrder()

            LEFT JOIN ObjectLink AS ObjectLink_Partner_Juridical
                                 ON ObjectLink_Partner_Juridical.ObjectId = MovementLinkObject_To.ObjectId
                                AND ObjectLink_Partner_Juridical.DescId = zc_ObjectLink_Partner_Juridical()
            LEFT JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                 ON ObjectLink_Juridical_Retail.ObjectId = ObjectLink_Partner_Juridical.ChildObjectId
                                AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()

            LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                         ON MovementLinkObject_Contract.MovementId = Movement_Sale.Id
                                        AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
            LEFT JOIN Object_Contract_View AS View_Contract ON View_Contract.ContractId = MovementLinkObject_Contract.ObjectId

            LEFT JOIN ObjectDate AS ObjectDate_Signing
                                 ON ObjectDate_Signing.ObjectId = View_Contract.ContractId
                                AND ObjectDate_Signing.DescId = zc_ObjectDate_Contract_Signing()
                                AND View_Contract.InvNumber <> '-'

            LEFT JOIN ObjectHistory_JuridicalDetails_ViewByDate AS OH_JuridicalDetails_From
                                                                ON OH_JuridicalDetails_From.JuridicalId = COALESCE (ObjectLink_Unit_Juridical.ChildObjectId, View_Contract.JuridicalBasisId)
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement_Sale.OperDate) >= OH_JuridicalDetails_From.StartDate
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement_Sale.OperDate) <  OH_JuridicalDetails_From.EndDate
            LEFT JOIN ObjectHistory_JuridicalDetails_ViewByDate AS OH_JuridicalDetails_To
                                                                ON OH_JuridicalDetails_To.JuridicalId = ObjectLink_Partner_Juridical.ChildObjectId
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement_Sale.OperDate) >= OH_JuridicalDetails_To.StartDate
                                                               AND COALESCE (MovementDate_OperDatePartner.ValueData, Movement_Sale.OperDate) <  OH_JuridicalDetails_To.EndDate
            LEFT JOIN ObjectString AS ObjectString_FromAddress
                                   ON ObjectString_FromAddress.ObjectId = MovementLinkObject_From.ObjectId
                                  AND ObjectString_FromAddress.DescId = zc_ObjectString_Partner_Address()
            LEFT JOIN ObjectString AS ObjectString_ToAddress
                                   ON ObjectString_ToAddress.ObjectId = MovementLinkObject_To.ObjectId
                                  AND ObjectString_ToAddress.DescId = zc_ObjectString_Partner_Address()

           -- ����� � ��� ������
           LEFT JOIN Object_GoodsByGoodsKind_View ON Object_GoodsByGoodsKind_View.GoodsId     = tmpMovementItem.GoodsId
                                                 AND Object_GoodsByGoodsKind_View.GoodsKindId = tmpMovementItem.GoodsKindId
           -- ��� 1-��� ������
           LEFT JOIN ObjectFloat AS ObjectFloat_WeightPackage
                                 ON ObjectFloat_WeightPackage.ObjectId = Object_GoodsByGoodsKind_View.Id
                                AND ObjectFloat_WeightPackage.DescId   = zc_ObjectFloat_GoodsByGoodsKind_WeightPackage()
           -- ��� � ��������: "������" ��� + ��� 1-��� ������
           LEFT JOIN ObjectFloat AS ObjectFloat_WeightTotal
                                 ON ObjectFloat_WeightTotal.ObjectId = Object_GoodsByGoodsKind_View.Id
                                AND ObjectFloat_WeightTotal.DescId   = zc_ObjectFloat_GoodsByGoodsKind_WeightTotal()

      -- ORDER BY MovementFloat_WeighingNumber
             -- , tmpMovementItem.MovementId
             -- , tmpMovementItem.BoxNumber
             -- , tmpMovementItem.Num
      ;
     RETURN NEXT Cursor1;


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION gpSelect_Movement_Sale_Pack_Print (Integer, Integer, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 25.05.15                                        * ALL
 24.11.14                                                       *
 03.11.14                                                       *
 31.10.14                                                       *
*/

-- ����
-- SELECT * FROM gpSelect_Movement_Sale_Pack_Print (inMovementId := 130359, inMovementId_by:=0, inSession:= zfCalc_UserAdmin());
