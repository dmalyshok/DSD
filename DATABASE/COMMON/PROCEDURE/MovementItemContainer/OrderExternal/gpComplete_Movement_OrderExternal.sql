-- Function: gpComplete_Movement_OrderExternal()

DROP FUNCTION IF EXISTS gpComplete_Movement_OrderExternal (Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpComplete_Movement_OrderExternal(
    IN inMovementId        Integer              , -- ���� ���������
   OUT outPrinted          Boolean              ,
   OUT outMessageText      Text                 ,
    IN inSession           TVarChar DEFAULT ''     -- ������ ������������
)
RETURNS RECORD
AS
$BODY$
  DECLARE vbUserId Integer;

  DECLARE vbOperSumm_Partner_byItem TFloat;
  DECLARE vbOperSumm_Partner TFloat;

  DECLARE vbPriceWithVAT Boolean;
  DECLARE vbVATPercent TFloat;
  DECLARE vbDiscountPercent TFloat;
  DECLARE vbExtraChargesPercent TFloat;

  DECLARE vbPartnerId Integer;
  DECLARE vbUnitId_From Integer;
  DECLARE vbArticleLoss_From Integer;
  DECLARE vbContractId  Integer;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Complete_OrderExternal());

     outPrinted := gpUpdate_Movement_OrderExternal_Print(inId := inMovementId , inNewPrinted := False,  inSession := inSession);

     -- ������� - �������� ���������
     CREATE TEMP TABLE _tmpItem (MovementItemId Integer
                               , GoodsId Integer, GoodsKindId Integer
                               , OperCount TFloat, OperCount_Second TFloat, OperSumm_Partner TFloat
                               , ChangePercent TFloat, PriceEDI TFloat, Price TFloat, CountForPrice TFloat) ON COMMIT DROP;


     -- ��� ��������� ����� ��� ������� �������� ���� �� ����������� ��� ��������� � ��� ������������ �������� � ���������
     SELECT COALESCE (MovementBoolean_PriceWithVAT.ValueData, TRUE) AS PriceWithVAT
          , COALESCE (MovementFloat_VATPercent.ValueData, 0) AS VATPercent
          , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) < 0 THEN -MovementFloat_ChangePercent.ValueData ELSE 0 END AS DiscountPercent
          , CASE WHEN COALESCE (MovementFloat_ChangePercent.ValueData, 0) > 0 THEN MovementFloat_ChangePercent.ValueData ELSE 0 END AS ExtraChargesPercent

          , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Partner() THEN Object_From.Id ELSE 0 END, 0) AS PartnerId
          , COALESCE (CASE WHEN Object_From.DescId = zc_Object_Unit() THEN Object_From.Id ELSE 0 END, 0) AS UnitId_From
          , COALESCE (CASE WHEN Object_From.DescId = zc_Object_ArticleLoss() THEN Object_From.Id ELSE 0 END, 0) AS ArticleLoss_From
          , COALESCE (MovementLinkObject_Contract.ObjectId, 0) AS ContractId

            INTO vbPriceWithVAT, vbVATPercent, vbDiscountPercent, vbExtraChargesPercent
               , vbPartnerId, vbUnitId_From, vbArticleLoss_From, vbContractId
     FROM Movement
          LEFT JOIN MovementBoolean AS MovementBoolean_PriceWithVAT
                                    ON MovementBoolean_PriceWithVAT.MovementId = Movement.Id
                                   AND MovementBoolean_PriceWithVAT.DescId = zc_MovementBoolean_PriceWithVAT()
          LEFT JOIN MovementFloat AS MovementFloat_VATPercent
                                  ON MovementFloat_VATPercent.MovementId = Movement.Id
                                 AND MovementFloat_VATPercent.DescId = zc_MovementFloat_VATPercent()
          LEFT JOIN MovementFloat AS MovementFloat_ChangePercent
                                  ON MovementFloat_ChangePercent.MovementId = Movement.Id
                                 AND MovementFloat_ChangePercent.DescId = zc_MovementFloat_ChangePercent()

          LEFT JOIN MovementLinkObject AS MovementLinkObject_From
                                       ON MovementLinkObject_From.MovementId = Movement.Id
                                      AND MovementLinkObject_From.DescId = zc_MovementLinkObject_From()
          LEFT JOIN Object AS Object_From ON Object_From.Id = MovementLinkObject_From.ObjectId

          LEFT JOIN MovementLinkObject AS MovementLinkObject_Contract
                                       ON MovementLinkObject_Contract.MovementId = Movement.Id
                                      AND MovementLinkObject_Contract.DescId = zc_MovementLinkObject_Contract()
     WHERE Movement.Id = inMovementId
       AND Movement.DescId = zc_Movement_OrderExternal()
       AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased());

     -- ��������
     IF COALESCE (vbContractId, 0) = 0 AND vbUnitId_From = 0 AND vbArticleLoss_From = 0
     THEN
         RAISE EXCEPTION '������.� ��������� �� ��������� <�������>.���������� ����������.';
     END IF;


     -- ��������� ������� - �������������� �������� ���������, �� ����� ����������
     INSERT INTO _tmpItem (MovementItemId
                         , GoodsId, GoodsKindId
                         , OperCount, OperCount_Second, OperSumm_Partner
                         , ChangePercent, PriceEDI, Price, CountForPrice)
        SELECT
              _tmp.MovementItemId
            , _tmp.GoodsId
            , _tmp.GoodsKindId

            , _tmp.OperCount
            , _tmp.OperCount_Second

              -- �������� ����� �� ����������� - � ����������� �� 2-� ������
            , CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                      -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % ������� !!!�� ������/������� ������ � ����!!!
                      THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                ELSE _tmp.tmpOperSumm_Partner
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��) !!!�� ������/������� ������ � ����!!!
                      THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 - vbDiscountPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 + vbExtraChargesPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2))
                           END
                   WHEN vbVATPercent > 0
                      -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��) !!!�� ������/������� ������ � ����!!!
                      THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * _tmp.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                                ELSE CAST ( (1 + vbVATPercent / 100) * (_tmp.tmpOperSumm_Partner) AS NUMERIC (16, 2))
                           END
              END AS OperSumm_Partner

            , _tmp.ChangePercent
            , _tmp.PriceEDI
            , _tmp.Price
            , _tmp.CountForPrice
        FROM
             (SELECT
                    tmpMI.MovementItemId
                  , tmpMI.GoodsId
                  , tmpMI.GoodsKindId

                  , tmpMI.ChangePercent
                  , tmpMI.PriceEDI
                  , tmpMI.Price
                  , tmpMI.CountForPrice
                    -- ����������
                  , tmpMI.OperCount
                    -- ���������� �������
                  , tmpMI.OperCount_Second

                    -- ������������� ����� �� ����������� - � ����������� �� 2-� ������
                  , CASE WHEN tmpMI.CountForPrice <> 0 THEN CAST ((tmpMI.OperCount + tmpMI.OperCount_Second) * tmpMI.Price / tmpMI.CountForPrice AS NUMERIC (16, 2))
                                                       ELSE CAST ((tmpMI.OperCount + tmpMI.OperCount_Second) * tmpMI.Price AS NUMERIC (16, 2))
                    END AS tmpOperSumm_Partner
              FROM
             (SELECT MovementItem.Id AS MovementItemId
                   , MovementItem.ObjectId AS GoodsId
                   , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId

                   , (MovementItem.Amount) AS OperCount
                   , (COALESCE (MIFloat_AmountSecond.ValueData, 0)) AS OperCount_Second

                   , COALESCE (MIFloat_ChangePercent.ValueData, 0) AS ChangePercent
                   , COALESCE (MIFloat_PriceEDI.ValueData, 0) AS PriceEDI
                   , CASE WHEN COALESCE (MIFloat_ChangePercent.ValueData, 0) <> 0 -- vbDiscountPercent <> 0
                               -- ������ � ���� - � ����������� �� 2-� ������
                               THEN CAST ( (1 + COALESCE (MIFloat_ChangePercent.ValueData, 0) /* - vbDiscountPercent*/ / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                          WHEN COALESCE (MIFloat_ChangePercent.ValueData, 0) <> 0 -- vbExtraChargesPercent <> 0
                               -- ������� � ���� - � ����������� �� 2-� ������
                               THEN CAST ( (1 + COALESCE (MIFloat_ChangePercent.ValueData, 0) /*+ vbExtraChargesPercent*/ / 100) * COALESCE (MIFloat_Price.ValueData, 0) AS NUMERIC (16, 2))
                          ELSE COALESCE (MIFloat_Price.ValueData, 0)
                     END AS Price
                   , COALESCE (MIFloat_CountForPrice.ValueData, 0) AS CountForPrice

              FROM Movement
                   JOIN MovementItem ON MovementItem.MovementId = Movement.Id AND MovementItem.DescId = zc_MI_Master() AND MovementItem.isErased = FALSE

                   LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                    ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                   AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()

                   LEFT JOIN MovementItemFloat AS MIFloat_AmountSecond
                                               ON MIFloat_AmountSecond.MovementItemId = MovementItem.Id
                                              AND MIFloat_AmountSecond.DescId = zc_MIFloat_AmountSecond()
                   LEFT JOIN MovementItemFloat AS MIFloat_PriceEDI
                                               ON MIFloat_PriceEDI.MovementItemId = MovementItem.Id
                                              AND MIFloat_PriceEDI.DescId = zc_MIFloat_PriceEDI()
                   LEFT JOIN MovementItemFloat AS MIFloat_Price
                                               ON MIFloat_Price.MovementItemId = MovementItem.Id
                                              AND MIFloat_Price.DescId = zc_MIFloat_Price()
                   LEFT JOIN MovementItemFloat AS MIFloat_CountForPrice
                                               ON MIFloat_CountForPrice.MovementItemId = MovementItem.Id
                                              AND MIFloat_CountForPrice.DescId = zc_MIFloat_CountForPrice()
                   LEFT JOIN MovementItemFloat AS MIFloat_ChangePercent
                                               ON MIFloat_ChangePercent.MovementItemId = MovementItem.Id
                                              AND MIFloat_ChangePercent.DescId = zc_MIFloat_ChangePercent()
              WHERE Movement.Id = inMovementId
                AND Movement.DescId = zc_Movement_OrderExternal()
                AND Movement.StatusId IN (zc_Enum_Status_UnComplete(), zc_Enum_Status_Erased())
             ) AS tmpMI
             ) AS _tmp;


     -- ������� ����
     SELECT -- ������ �������� ����� �� �����������
            CASE WHEN vbPriceWithVAT OR vbVATPercent = 0
                    -- ���� ���� � ��� ��� %���=0, ����� ��������� ��� % ������ ��� % ������� !!!�� ������/������� ������ � ����!!!
                    THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 - vbDiscountPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbExtraChargesPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              ELSE _tmpItem.tmpOperSumm_Partner
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� � ��� (���� ������� ����� � ��� ��� � ��� ��) !!!�� ������/������� ������ � ����!!!
                    THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 - vbDiscountPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * (1 + vbExtraChargesPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                         END
                 WHEN vbVATPercent > 0
                    -- ���� ���� ��� ���, ����� ��������� ��� % ������ ��� % ������� ��� ����� ��� ���, ��������� �� 2-� ������, � ����� ��������� ��� (���� ������� ����� ������������ ��� ��) !!!�� ������/������� ������ � ����!!!
                    THEN CASE WHEN 1=0 AND vbDiscountPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 - vbDiscountPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              WHEN 1=0 AND vbExtraChargesPercent > 0 THEN CAST ( (1 + vbVATPercent / 100) * CAST ( (1 + vbExtraChargesPercent/100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2)) AS NUMERIC (16, 2))
                              ELSE CAST ( (1 + vbVATPercent / 100) * _tmpItem.tmpOperSumm_Partner AS NUMERIC (16, 2))
                         END
            END
            INTO vbOperSumm_Partner
     FROM (SELECT SUM (CASE WHEN _tmpItem.CountForPrice <> 0 THEN CAST ((_tmpItem.OperCount + _tmpItem.OperCount_Second) * _tmpItem.Price / _tmpItem.CountForPrice AS NUMERIC (16, 2))
                                                             ELSE CAST ((_tmpItem.OperCount + _tmpItem.OperCount_Second) * _tmpItem.Price AS NUMERIC (16, 2))
                        END) AS tmpOperSumm_Partner
           FROM (SELECT _tmpItem.Price
                      , _tmpItem.CountForPrice
                      , SUM (_tmpItem.OperCount)        AS OperCount
                      , SUM (_tmpItem.OperCount_Second) AS OperCount_Second
                 FROM _tmpItem
                 GROUP BY _tmpItem.GoodsId
                        , _tmpItem.GoodsKindId
                        , _tmpItem.Price
                        , _tmpItem.CountForPrice
                ) AS _tmpItem
          ) AS _tmpItem
     ;

     -- ������ �������� ���� �� ����������� (�� ���������)
     SELECT SUM (_tmpItem.OperSumm_Partner) INTO vbOperSumm_Partner_byItem FROM _tmpItem;

     -- ���� �� ����� ��� �������� ����� �� �����������
     IF COALESCE (vbOperSumm_Partner, 0) <> COALESCE (vbOperSumm_Partner_byItem, 0)
     THEN
         -- �� ������� ������������ ����� ������� ����� (������������ ����� ���������� �������� < 0, �� ��� ������ �� ������������)
         UPDATE _tmpItem SET OperSumm_Partner = OperSumm_Partner - (vbOperSumm_Partner_byItem - vbOperSumm_Partner)
         WHERE MovementItemId IN (SELECT MAX (MovementItemId) FROM _tmpItem WHERE OperSumm_Partner IN (SELECT MAX (OperSumm_Partner) FROM _tmpItem)
                                 );
     END IF;

     -- ��������
     IF EXISTS (SELECT _tmpItem.Price FROM _tmpItem WHERE _tmpItem.Price = 0) -- AND vbUserId <> 5
           -- ������ ����
       -- AND 8379 <> COALESCE ((SELECT Object_RoleAccessKeyGuide_View.BranchId FROM Object_RoleAccessKeyGuide_View WHERE Object_RoleAccessKeyGuide_View.UserId = vbUserId AND Object_RoleAccessKeyGuide_View.BranchId <> 0 LIMIT 1), 0)
     THEN
         outMessageText:= '������.�������� ����������� �� �� ��������'
            -- || CHR(13) || '���������� <' || lfGet_Object_ValueData (vbPartnerId) || '>.'
            || CHR(13) || '��� ������ <' || (SELECT lfGet_Object_ValueData (_tmpItem.GoodsId) FROM _tmpItem WHERE _tmpItem.Price = 0 ORDER BY MovementItemId LIMIT 1) || '>'
                                 || ' <' || (SELECT lfGet_Object_ValueData (_tmpItem.GoodsKindId) FROM _tmpItem WHERE _tmpItem.Price = 0 ORDER BY MovementItemId LIMIT 1) || '>'
            || CHR(13) || '� ����������� <' || zfConvert_FloatToString ((SELECT _tmpItem.OperCount FROM _tmpItem WHERE _tmpItem.Price = 0 ORDER BY MovementItemId LIMIT 1)) || '> ����������� ���� = 0.'
            || CHR(13) || '���������� ������� ������ � <' || COALESCE ((SELECT Movement.InvNumber FROM Movement WHERE Movement.Id = inMovementId), '') || '>'
                                               || ' �� <' || COALESCE ((SELECT DATE (Movement.OperDate) FROM Movement WHERE Movement.Id = inMovementId) :: TVarChar, '') || '> � ��������� ����.'
              ;
         -- !!! ����� !!!
         RETURN;
     END IF;
     -- ��������
     IF 1=1 AND EXISTS (SELECT 1 FROM _tmpItem WHERE 1 <= CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END)
     THEN
         outMessageText:= '������.�������� ����������� �� �� ��������'
            -- || CHR(13) || '���������� <' || lfGet_Object_ValueData (vbPartnerId) || '>.'
            || CHR(13) || '� ������ <' || (SELECT lfGet_Object_ValueData (_tmpItem.GoodsId) FROM _tmpItem WHERE 1 <= CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END ORDER BY MovementItemId LIMIT 1) || '>'
                               || ' <' || (SELECT lfGet_Object_ValueData (_tmpItem.GoodsKindId) FROM _tmpItem WHERE 1 <= CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END ORDER BY MovementItemId LIMIT 1) || '>'
            || CHR(13) || '���� = <' || zfConvert_FloatToString ((SELECT _tmpItem.Price FROM _tmpItem WHERE 1 <= CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END ORDER BY MovementItemId LIMIT 1)) || '>'
                       || '�� ������������� ���� EDI = <' || zfConvert_FloatToString ((SELECT _tmpItem.PriceEDI FROM _tmpItem WHERE 1 <= CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END ORDER BY MovementItemId LIMIT 1)) || '>.'
            || CHR(13) || '���������� ������� ������ � <' || COALESCE ((SELECT Movement.InvNumber FROM Movement WHERE Movement.Id = inMovementId), '') || '>'
                                               || ' �� <' || COALESCE ((SELECT DATE (Movement.OperDate) FROM Movement WHERE Movement.Id = inMovementId) :: TVarChar, '') || '> � ��������� ����.'
            -- || CHR(13) || ' % <' || zfConvert_FloatToString ((SELECT CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price * (1 + _tmpItem.ChangePercent / 100) /*- _tmpItem.PriceEDI*/) / 1 /*_tmpItem.PriceEDI*/ ELSE 0 END FROM _tmpItem WHERE 1 <= CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price * (1 + _tmpItem.ChangePercent / 100) - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END ORDER BY MovementItemId LIMIT 1)) || '>'
            || CHR(13) || ' % <' || zfConvert_FloatToString ((SELECT CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END FROM _tmpItem WHERE 1 <= CASE WHEN _tmpItem.PriceEDI > 0 THEN 100 * ABS (_tmpItem.Price - _tmpItem.PriceEDI) / _tmpItem.PriceEDI ELSE 0 END ORDER BY MovementItemId LIMIT 1)) || '>'
              ;
         -- !!! ����� !!!
         RETURN;
     END IF;


     -- !!!����������� �������� � ��������� ���������!!!
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_Summ(), _tmpItem.MovementItemId, _tmpItem.OperSumm_Partner)
     FROM _tmpItem;

     -- � MovementLinkMovement ���� ������� ����� � ��� 1
     PERFORM lpInsertUpdate_MovementLinkMovement (zc_MovementLinkMovement_Promo(), inMovementId, CASE WHEN tmp.MovementId_min = tmp.MovementId_max THEN tmp.MovementId_min ELSE NULL END :: Integer)
           , lpInsertUpdate_MovementBoolean (zc_MovementBoolean_Promo(), inMovementId, CASE WHEN tmp.MovementId_min > 0 AND tmp.MovementId_max > 0 THEN TRUE ELSE FALSE END)
     FROM (SELECT 1 AS x) AS x1
           LEFT JOIN
          (SELECT MIN (MIFloat_PromoMovement.ValueData) AS MovementId_min,  MAX (MIFloat_PromoMovement.ValueData) AS MovementId_max
           FROM _tmpItem
                INNER JOIN MovementItemFloat AS MIFloat_PromoMovement
                                             ON MIFloat_PromoMovement.MovementItemId = _tmpItem.MovementItemId
                                            AND MIFloat_PromoMovement.DescId = zc_MIFloat_PromoMovementId()
                                            AND MIFloat_PromoMovement.ValueData <> 0
          ) AS tmp ON 1 = 1;

     -- ����� - ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_OrderExternal()
                                , inUserId     := vbUserId
                                 );

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 25.08.14                                        *
*/

-- ����
-- SELECT * FROM gpUnComplete_Movement (inMovementId:= 579, inSession:= '2')
-- SELECT * FROM gpComplete_Movement_OrderExternal (inMovementId:= 579, inSession:= '2')
