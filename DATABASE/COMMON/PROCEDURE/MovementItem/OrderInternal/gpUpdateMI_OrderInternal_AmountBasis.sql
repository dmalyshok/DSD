-- Function: gpUpdateMI_OrderInternal_AmountBasis()

DROP FUNCTION IF EXISTS gpUpdateMI_OrderInternal_AmountBasis (Integer, TDateTime, Integer, TVarChar);

CREATE OR REPLACE FUNCTION gpUpdateMI_OrderInternal_AmountBasis(
    IN inMovementId          Integer   , -- ���� ������� <��������>
    IN inOperDate            TDateTime , -- ���� ���������
    IN inUnitId              Integer   , -- 
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId Integer;

BEGIN
     -- �������� ���� ������������ �� ����� ���������
     vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_OrderInternal());



    -- ������� -
   CREATE TEMP TABLE tmpAll (MovementItemId Integer, GoodsId Integer, GoodsKindId Integer, ReceiptId Integer, CuterCount TFloat) ON COMMIT DROP;
   --
   INSERT INTO tmpAll (MovementItemId, GoodsId, GoodsKindId, AmountPartner, AmountPartnerPrior)
                                 WITH tmpUnit AS (SELECT UnitId FROM lfSelect_Object_Unit_byGroup (inUnitId) AS lfSelect_Object_Unit_byGroup WHERE UnitId <> inUnitId)
                                    , tmpGoods AS (SELECT ObjectLink_Goods_InfoMoney.ObjectId AS GoodsId
                                                   FROM Object_InfoMoney_View
                                                        LEFT JOIN ObjectLink AS ObjectLink_Goods_InfoMoney
                                                                             ON ObjectLink_Goods_InfoMoney.ChildObjectId = Object_InfoMoney_View.InfoMoneyId
                                                                            AND ObjectLink_Goods_InfoMoney.DescId = zc_ObjectLink_Goods_InfoMoney()
                                                   WHERE Object_InfoMoney_View.InfoMoneyId = zc_Enum_InfoMoney_30101() -- ������ + ��������� + ������� ���������
                                                      OR Object_InfoMoney_View.InfoMoneyId = zc_Enum_InfoMoney_30201() -- ������ + ��������� + ������� ���������
                                                      OR Object_InfoMoney_View.InfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_20900() -- ������������� + ����
                                                  )
                                 SELECT tmp.MovementItemId
                                       , COALESCE (tmp.GoodsId,tmpOrder.GoodsId)          AS GoodsId
                                       , COALESCE (tmp.GoodsKindId, tmpOrder.GoodsKindId) AS GoodsKindId
                                       , COALESCE (tmpOrder.AmountPartner, 0)             AS AmountPartner
                                       , COALESCE (tmpOrder.AmountPartnerPrior, 0)        AS AmountPartnerPrior
                                 FROM (SELECT MovementItem.ObjectId                                                    AS GoodsId
                                            , COALESCE (MILinkObject_GoodsKind.ObjectId, 0)                            AS GoodsKindId
                                            , SUM (CASE WHEN Movement.OperDate = inOperDate THEN MovementItem.Amount + COALESCE (MIFloat_AmountSecond.ValueData, 0) ELSE 0 END) AS AmountPartner
                                            , SUM (CASE WHEN Movement.OperDate = (inOperDate - INTERVAL '1 DAY')
                                                         AND MovementDate_OperDatePartner.ValueData = inOperDate
                                                             THEN MovementItem.Amount + COALESCE (MIFloat_AmountSecond.ValueData, 0)
                                                        ELSE 0
                                                   END) AS AmountPartnerPrior
                                       FROM Movement 
                                            LEFT JOIN MovementDate AS MovementDate_OperDatePartner
                                                                   ON MovementDate_OperDatePartner.MovementId = Movement.Id
                                                                  AND MovementDate_OperDatePartner.DescId = zc_MovementDate_OperDatePartner()
                                            INNER JOIN MovementLinkObject AS MovementLinkObject_To
                                                                          ON MovementLinkObject_To.MovementId = Movement.Id
                                                                         AND MovementLinkObject_To.DescId = zc_MovementLinkObject_To()
                                            INNER JOIN tmpUnit ON tmpUnit.UnitId = MovementLinkObject_To.ObjectId
                                            INNER JOIN MovementItem ON MovementItem.MovementId = Movement.Id
                                                                   AND MovementItem.DescId     = zc_MI_Master()
                                                                   AND MovementItem.isErased   = FALSE
                                            INNER JOIN tmpGoods ON tmpGoods.GoodsId = MovementItem.ObjectId

                                            LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                             ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                            AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                                            LEFT JOIN MovementItemFloat AS MIFloat_AmountSecond
                                                                        ON MIFloat_AmountSecond.MovementItemId = MovementItem.Id
                                                                       AND MIFloat_AmountSecond.DescId = zc_MIFloat_AmountSecond()
                                       WHERE Movement.OperDate BETWEEN (inOperDate - INTERVAL '1 DAY') AND inOperDate
                                         AND Movement.DescId = zc_Movement_OrderExternal()
                                         AND Movement.StatusId = zc_Enum_Status_Complete()
                                       GROUP BY MovementItem.ObjectId
                                              , MILinkObject_GoodsKind.ObjectId
                                       HAVING SUM (CASE WHEN Movement.OperDate = inOperDate THEN MovementItem.Amount + COALESCE (MIFloat_AmountSecond.ValueData, 0) ELSE 0 END) <> 0
                                           OR SUM (CASE WHEN Movement.OperDate = (inOperDate - INTERVAL '1 DAY')
                                                         AND MovementDate_OperDatePartner.ValueData = inOperDate
                                                             THEN MovementItem.Amount + COALESCE (MIFloat_AmountSecond.ValueData, 0)
                                                        ELSE 0
                                                   END)  <> 0
                                       ) AS tmpOrder
                                 FULL JOIN
                                (SELECT MovementItem.Id                               AS MovementItemId 
                                      , MovementItem.ObjectId                         AS GoodsId
                                      , COALESCE (MILinkObject_GoodsKind.ObjectId, 0) AS GoodsKindId
                                      , MovementItem.Amount
                                 FROM MovementItem 
                                      LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                                       ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                                      AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                                 WHERE MovementItem.MovementId = inMovementId
                                   AND MovementItem.DescId     = zc_MI_Master()
                                   AND MovementItem.isErased   = FALSE
                                ) AS tmp  ON tmp.GoodsId = tmpOrder.GoodsId
                                         AND tmp.GoodsKindId = tmpOrder.GoodsKindId
                     ;

       -- ���������
       PERFORM lpUpdate_MI_OrderInternal_Property (ioId                 := tmpAll.MovementItemId
                                                 , inMovementId         := inMovementId
                                                 , inGoodsId            := tmpAll.GoodsId
                                                 , inGoodsKindId        := tmpAll.GoodsKindId
                                                 , inAmount_Param       := tmpAll.AmountPartner * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END
                                                 , inDescId_Param       := zc_MIFloat_AmountPartner()
                                                 , inAmount_ParamOrder  := tmpAll.AmountPartnerPrior * CASE WHEN ObjectLink_Goods_Measure.ChildObjectId = zc_Measure_Sh() THEN COALESCE (ObjectFloat_Weight.ValueData, 0) ELSE 1 END
                                                 , inDescId_ParamOrder  := zc_MIFloat_AmountPartnerPrior()
                                                 , inIsPack             := vbIsPack
                                                 , inUserId             := vbUserId
                                                  ) 
       FROM tmpAll
            LEFT JOIN ObjectLink AS ObjectLink_Goods_Measure
                                 ON ObjectLink_Goods_Measure.ObjectId = tmpAll.GoodsId
                                AND ObjectLink_Goods_Measure.DescId = zc_ObjectLink_Goods_Measure()
            LEFT JOIN ObjectFloat AS ObjectFloat_Weight
                                  ON ObjectFloat_Weight.ObjectId = tmpAll.GoodsId
                                 AND ObjectFloat_Weight.DescId = zc_ObjectFloat_Goods_Weight()
      ;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 27.06.15                                        * ������, �������� �����������
 19.06.15                                        *
 14.02.15         *
*/

-- ����
-- SELECT * FROM gpUpdateMI_OrderInternal_AmountBasis (ioId:= 0, inMovementId:= 10, inGoodsId:= 1, inAmount:= 0, inHeadCount:= 0, inPartionGoods:= '', inGoodsKindId:= 0, inSession:= '2')