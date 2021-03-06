     -- ��������� - master
-- Function: gpSelect_MI_OrderInternalPackRemains()

DROP FUNCTION IF EXISTS gpSelect_MI_OrderInternalPackRemains (Integer, Boolean, Boolean, TVarChar);

CREATE OR REPLACE FUNCTION gpSelect_MI_OrderInternalPackRemains(
    IN inMovementId  Integer      , -- ���� ���������
    IN inShowAll     Boolean      , --
    IN inIsErased    Boolean      , --
    IN inSession     TVarChar       -- ������ ������������
)
RETURNS SETOF REFCURSOR
AS
$BODY$
   DECLARE vbUserId Integer;

   DECLARE Cursor1 refcursor;
   DECLARE Cursor2 refcursor;
   DECLARE Cursor3 refcursor;
BEGIN
     -- �������� ���� ������������ �� ����� ���������
     -- vbUserId:= lpCheckRight (inSession, zc_Enum_Process_Select_MI_OrderInternal());
     vbUserId:= lpGetUserBySession (inSession);


-- IF inSession <> '5' THEN inShowAll:= TRUE; END IF;


     -- ���������  _Result_Master, _Result_Child, _Result_ChildTotal
     PERFORM lpSelect_MI_OrderInternalPackRemains (inMovementId:= inMovementId, inShowAll:= FALSE, inIsErased:= FALSE, inUserId:= vbUserId) ;

       --
       OPEN Cursor1 FOR

       -- ���������
       SELECT _Result_Master.Id
            , _Result_Master.KeyId
            , _Result_Master.GoodsId
            , _Result_Master.GoodsCode
            , _Result_Master.GoodsName
            , _Result_Master.GoodsId_basis
            , _Result_Master.GoodsCode_basis
            , _Result_Master.GoodsName_basis
            , _Result_Master.GoodsKindId
            , _Result_Master.GoodsKindName
            , _Result_Master.MeasureName
            , _Result_Master.MeasureName_basis
            , _Result_Master.GoodsGroupNameFull
            , _Result_Master.isCheck_basis

            , _Result_Master.Amount
            , _Result_Master.AmountSecond
            , _Result_Master.AmountTotal

            , _Result_Master.AmountNext
            , _Result_Master.AmountNextSecond
            , _Result_Master.AmountNextTotal
            , _Result_Master.AmountAllTotal

            , _Result_Master.Amount_result
            , _Result_Master.Amount_result_two
            , _Result_Master.Amount_result_pack

            , _Result_Master.Num
            , _Result_Master.Income_CEH
            , _Result_Master.Income_PACK_to
            , _Result_Master.Income_PACK_from

            , _Result_Master.Remains
            , _Result_Master.Remains_pack
            , _Result_Master.Remains_CEH
            , _Result_Master.Remains_CEH_Next

              -- �������. ������
            , _Result_Master.AmountPartnerPrior
            , _Result_Master.AmountPartnerPriorPromo
            , _Result_Master.AmountPartnerPriorTotal
              -- ������� ������
            , _Result_Master.AmountPartner
            , _Result_Master.AmountPartnerNext
            , _Result_Master.AmountPartnerPromo
            , _Result_Master.AmountPartnerNextPromo
            , _Result_Master.AmountPartnerTotal
            -- ������� �� ����.
            , _Result_Master.AmountForecast
            , _Result_Master.AmountForecastPromo
             -- ������� �� ����.
            , _Result_Master.AmountForecastOrder
            , _Result_Master.AmountForecastOrderPromo

             -- "�������" �� 1 ���� - ������� ����������� ��� ����� - ���� 1� (�� ��.) ��� �
            , CAST (_Result_Master.CountForecast AS NUMERIC (16, 1)) :: TFloat AS CountForecast
             -- "�������" �� 1 ���� - ������ ����������� ��� ����� - ���� 1� (�� ��.) ��� �
            , CAST (_Result_Master.CountForecastOrder AS NUMERIC (16, 1)) :: TFloat AS CountForecastOrder

              -- "�������" �� 1 ���� - ������� ��� �������
            , CAST (_Result_Master.Plan1 AS NUMERIC (16, 1)) :: TFloat AS Plan1
            , CAST (_Result_Master.Plan2 AS NUMERIC (16, 1)) :: TFloat AS Plan2
            , CAST (_Result_Master.Plan3 AS NUMERIC (16, 1)) :: TFloat AS Plan3
            , CAST (_Result_Master.Plan4 AS NUMERIC (16, 1)) :: TFloat AS Plan4
            , CAST (_Result_Master.Plan5 AS NUMERIC (16, 1)) :: TFloat AS Plan5
            , CAST (_Result_Master.Plan6 AS NUMERIC (16, 1)) :: TFloat AS Plan6
            , CAST (_Result_Master.Plan7 AS NUMERIC (16, 1)) :: TFloat AS Plan7
              -- "�������" �� 1 ���� - ����� - �������
            , CAST (_Result_Master.Promo1 AS NUMERIC (16, 1)) :: TFloat AS Promo1
            , CAST (_Result_Master.Promo2 AS NUMERIC (16, 1)) :: TFloat AS Promo2
            , CAST (_Result_Master.Promo3 AS NUMERIC (16, 1)) :: TFloat AS Promo3
            , CAST (_Result_Master.Promo4 AS NUMERIC (16, 1)) :: TFloat AS Promo4
            , CAST (_Result_Master.Promo5 AS NUMERIC (16, 1)) :: TFloat AS Promo5
            , CAST (_Result_Master.Promo6 AS NUMERIC (16, 1)) :: TFloat AS Promo6
            , CAST (_Result_Master.Promo7 AS NUMERIC (16, 1)) :: TFloat AS Promo7

              -- ���. � ���� (�� ��.) - ��� �
            , _Result_Master.DayCountForecast
              -- ���. � ���� (�� ��.) - ��� �
            , _Result_Master.DayCountForecastOrder
              -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
            , _Result_Master.DayCountForecast_calc
              -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
            , zfCalc_StatDayCount_Week (inAmount           := COALESCE (_Result_Master.Amount_result_pack, 0)
                                      , inAmountPartnerNext:= COALESCE (_Result_Master.AmountPartnerNext, 0) + COALESCE (_Result_Master.AmountPartnerNextPromo, 0)
                                      , inCountForecast    := CASE WHEN _Result_Master.CountForecast > 0 THEN COALESCE (_Result_Master.CountForecast, 0) ELSE COALESCE (_Result_Master.CountForecastOrder, 0) END
                                      , inPlan1            := COALESCE (_Result_Master.Plan1, 0) + COALESCE (_Result_Master.Promo1, 0)
                                      , inPlan2            := COALESCE (_Result_Master.Plan2, 0) + COALESCE (_Result_Master.Promo2, 0)
                                      , inPlan3            := COALESCE (_Result_Master.Plan3, 0) + COALESCE (_Result_Master.Promo3, 0)
                                      , inPlan4            := COALESCE (_Result_Master.Plan4, 0) + COALESCE (_Result_Master.Promo4, 0)
                                      , inPlan5            := COALESCE (_Result_Master.Plan5, 0) + COALESCE (_Result_Master.Promo5, 0)
                                      , inPlan6            := COALESCE (_Result_Master.Plan6, 0) + COALESCE (_Result_Master.Promo6, 0)
                                      , inPlan7            := COALESCE (_Result_Master.Plan7, 0) + COALESCE (_Result_Master.Promo7, 0)
                                       ) AS DayCountForecast_new

            , _Result_Master.ReceiptId
            , _Result_Master.ReceiptCode
            , _Result_Master.ReceiptName
            , _Result_Master.ReceiptId_basis
            , _Result_Master.ReceiptCode_basis
            , _Result_Master.ReceiptName_basis
            , _Result_Master.UnitId
            , _Result_Master.UnitCode
            , _Result_Master.UnitName
            , _Result_Master.isErased

       FROM _Result_Master
       ;
       RETURN NEXT Cursor1;


       OPEN Cursor2 FOR
            WITH -- �������� ������ �� "������� ����� � ������������ ������� � ��������"
                 tmpGoodsByGoodsKind AS (SELECT ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId         AS GoodsId
                                              , ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId     AS GoodsKindId
                                              , ObjectLink_GoodsByGoodsKind_GoodsPack.ChildObjectId     AS GoodsId_pack
                                              , ObjectLink_GoodsByGoodsKind_GoodsKindPack.ChildObjectId AS GoodsKindId_pack
                                         FROM Object AS Object_GoodsByGoodsKind
                                              INNER JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_Goods
                                                                    ON ObjectLink_GoodsByGoodsKind_Goods.ObjectId          = Object_GoodsByGoodsKind.Id
                                                                   AND ObjectLink_GoodsByGoodsKind_Goods.DescId            = zc_ObjectLink_GoodsByGoodsKind_Goods()
                                                                   AND ObjectLink_GoodsByGoodsKind_Goods.ChildObjectId     > 0
                                              INNER JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_GoodsKind
                                                                    ON ObjectLink_GoodsByGoodsKind_GoodsKind.ObjectId      = Object_GoodsByGoodsKind.Id
                                                                   AND ObjectLink_GoodsByGoodsKind_GoodsKind.DescId        = zc_ObjectLink_GoodsByGoodsKind_GoodsKind()
                                                                   AND ObjectLink_GoodsByGoodsKind_GoodsKind.ChildObjectId > 0

                                              INNER JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_GoodsPack
                                                                    ON ObjectLink_GoodsByGoodsKind_GoodsPack.ObjectId      = Object_GoodsByGoodsKind.Id
                                                                   AND ObjectLink_GoodsByGoodsKind_GoodsPack.DescId        = zc_ObjectLink_GoodsByGoodsKind_GoodsPack()
                                                                   AND ObjectLink_GoodsByGoodsKind_GoodsPack.ChildObjectId > 0
                                              INNER JOIN ObjectLink AS ObjectLink_GoodsByGoodsKind_GoodsKindPack
                                                                    ON ObjectLink_GoodsByGoodsKind_GoodsKindPack.ObjectId      = Object_GoodsByGoodsKind.Id
                                                                   AND ObjectLink_GoodsByGoodsKind_GoodsKindPack.DescId        = zc_ObjectLink_GoodsByGoodsKind_GoodsKindPack()
                                                                   AND ObjectLink_GoodsByGoodsKind_GoodsKindPack.ChildObjectId > 0
                                         WHERE Object_GoodsByGoodsKind.DescId   = zc_Object_GoodsByGoodsKind()
                                           AND Object_GoodsByGoodsKind.isErased = FALSE
                                        )
       SELECT _Result_Child.Id
            , _Result_Child.ContainerId
            , _Result_Child.KeyId
            , _Result_Child.GoodsId
            , _Result_Child.GoodsCode
            , _Result_Child.GoodsName
            , _Result_Child.GoodsKindId
            , _Result_Child.GoodsKindName
            , _Result_Child.MeasureName
            , _Result_Child.GoodsGroupNameFull

            , _Result_Child.AmountPack
            , _Result_Child.AmountPackSecond
            , _Result_Child.AmountPackTotal

            , _Result_Child.AmountPack_calc
            , _Result_Child.AmountSecondPack_calc
            , _Result_Child.AmountPackTotal_calc

            , _Result_Child.AmountPackNext
            , _Result_Child.AmountPackNextSecond
            , _Result_Child.AmountPackNextTotal

            , _Result_Child.AmountPackNext_calc
            , _Result_Child.AmountPackNextSecond_calc
            , _Result_Child.AmountPackNextTotal_calc

            , _Result_Child.AmountPackAllTotal
            , _Result_Child.AmountPackAllTotal_calc

            , _Result_Child.Amount_result_two
            , _Result_Child.Amount_result_pack
            , _Result_Child.Amount_result_pack_pack

            , _Result_Child.Income_PACK_to
            , _Result_Child.Income_PACK_from

            , _Result_Child.Remains
            , _Result_Child.Remains_pack

              -- �������. ������
            , _Result_Child.AmountPartnerPrior
            , _Result_Child.AmountPartnerPriorPromo
            , _Result_Child.AmountPartnerPriorTotal
              -- ������� ������
            , _Result_Child.AmountPartner
            , _Result_Child.AmountPartnerNext
            , _Result_Child.AmountPartnerPromo
            , _Result_Child.AmountPartnerNextPromo
            , _Result_Child.AmountPartnerTotal
              -- ������� �� ����.
            , _Result_Child.AmountForecast
            , _Result_Child.AmountForecastPromo
              -- ������� �� ����.
            , _Result_Child.AmountForecastOrder
            , _Result_Child.AmountForecastOrderPromo

              -- "�������" �� 1 ���� - ������� ����������� ��� ����� - ���� 1� (�� ��.) ��� �
            , CAST (_Result_Child.CountForecast AS NUMERIC (16, 1)) :: TFloat AS CountForecast
              -- "�������" �� 1 ���� - ������ ����������� ��� ����� - ���� 1� (�� ��.) ��� �
            , CAST (_Result_Child.CountForecastOrder AS NUMERIC (16, 1)) :: TFloat AS CountForecastOrder

              -- "�������" �� 1 ���� - ������� ��� �������
            , CAST (_Result_Child.Plan1 AS NUMERIC (16, 1)) :: TFloat AS Plan1
            , CAST (_Result_Child.Plan2 AS NUMERIC (16, 1)) :: TFloat AS Plan2
            , CAST (_Result_Child.Plan3 AS NUMERIC (16, 1)) :: TFloat AS Plan3
            , CAST (_Result_Child.Plan4 AS NUMERIC (16, 1)) :: TFloat AS Plan4
            , CAST (_Result_Child.Plan5 AS NUMERIC (16, 1)) :: TFloat AS Plan5
            , CAST (_Result_Child.Plan6 AS NUMERIC (16, 1)) :: TFloat AS Plan6
            , CAST (_Result_Child.Plan7 AS NUMERIC (16, 1)) :: TFloat AS Plan7
              -- "�������" �� 1 ���� - ����� - �������
            , CAST (_Result_Child.Promo1 AS NUMERIC (16, 1)) :: TFloat AS Promo1
            , CAST (_Result_Child.Promo2 AS NUMERIC (16, 1)) :: TFloat AS Promo2
            , CAST (_Result_Child.Promo3 AS NUMERIC (16, 1)) :: TFloat AS Promo3
            , CAST (_Result_Child.Promo4 AS NUMERIC (16, 1)) :: TFloat AS Promo4
            , CAST (_Result_Child.Promo5 AS NUMERIC (16, 1)) :: TFloat AS Promo5
            , CAST (_Result_Child.Promo6 AS NUMERIC (16, 1)) :: TFloat AS Promo6
            , CAST (_Result_Child.Promo7 AS NUMERIC (16, 1)) :: TFloat AS Promo7

              -- ���. � ���� (�� ��.) - ��� �
           , CAST (CASE WHEN _Result_Child.CountForecast > 0
                             THEN (_Result_Child.Remains + _Result_Child.Remains_pack - COALESCE (_Result_Child.Amount_master, 0) - COALESCE (_Result_Child.AmountNext_master, 0)) / _Result_Child.CountForecast
                         ELSE 0
                   END
             AS NUMERIC (16, 1)) :: TFloat AS DayCountForecast
              -- ���. � ���� (�� ��.) - ��� �
           , CAST (CASE WHEN _Result_Child.CountForecastOrder > 0
                             THEN (_Result_Child.Remains + _Result_Child.Remains_pack - COALESCE (_Result_Child.Amount_master, 0) - COALESCE (_Result_Child.AmountNext_master, 0)) / _Result_Child.CountForecastOrder
                         ELSE 0
                   END
             AS NUMERIC (16, 1)) :: TFloat AS DayCountForecastOrder
              -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
           , CAST (CASE WHEN _Result_Child.CountForecast > 0
                             THEN (_Result_Child.Remains + _Result_Child.Remains_pack + _Result_Child.AmountPack + _Result_Child.AmountPackSecond + _Result_Child.AmountPackNext + _Result_Child.AmountPackNextSecond
                                 - COALESCE (_Result_Child.Amount_master, 0) - COALESCE (_Result_Child.AmountNext_master, 0)
                                 - _Result_Child.AmountPartnerPrior - _Result_Child.AmountPartnerPriorPromo
                                 - _Result_Child.AmountPartner      - _Result_Child.AmountPartnerPromo
                                  ) / _Result_Child.CountForecast
                        WHEN _Result_Child.CountForecastOrder > 0
                             THEN (_Result_Child.Remains + _Result_Child.Remains_pack + _Result_Child.AmountPack + _Result_Child.AmountPackSecond + _Result_Child.AmountPackNext + _Result_Child.AmountPackNextSecond
                                 - COALESCE (_Result_Child.Amount_master, 0) - COALESCE (_Result_Child.AmountNext_master, 0)
                                 - _Result_Child.AmountPartnerPrior - _Result_Child.AmountPartnerPriorPromo
                                 - _Result_Child.AmountPartner      - _Result_Child.AmountPartnerPromo
                                  ) / _Result_Child.CountForecastOrder
                        ELSE 0
                   END
             AS NUMERIC (16, 1)) :: TFloat AS DayCountForecast_calc

              -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
            , zfCalc_StatDayCount_Week (inAmount           := COALESCE (_Result_Child.Amount_result_pack, 0)
                                      , inAmountPartnerNext:= COALESCE (_Result_Child.AmountPartnerNext, 0) + COALESCE (_Result_Child.AmountPartnerNextPromo, 0)
                                      , inCountForecast    := CASE WHEN _Result_Child.CountForecast > 0 THEN COALESCE (_Result_Child.CountForecast, 0) ELSE COALESCE (_Result_Child.CountForecastOrder, 0) END
                                      , inPlan1            := COALESCE (_Result_Child.Plan1, 0) + COALESCE (_Result_Child.Promo1, 0)
                                      , inPlan2            := COALESCE (_Result_Child.Plan2, 0) + COALESCE (_Result_Child.Promo2, 0)
                                      , inPlan3            := COALESCE (_Result_Child.Plan3, 0) + COALESCE (_Result_Child.Promo3, 0)
                                      , inPlan4            := COALESCE (_Result_Child.Plan4, 0) + COALESCE (_Result_Child.Promo4, 0)
                                      , inPlan5            := COALESCE (_Result_Child.Plan5, 0) + COALESCE (_Result_Child.Promo5, 0)
                                      , inPlan6            := COALESCE (_Result_Child.Plan6, 0) + COALESCE (_Result_Child.Promo6, 0)
                                      , inPlan7            := COALESCE (_Result_Child.Plan7, 0) + COALESCE (_Result_Child.Promo7, 0)
                                       ) AS DayCountForecast_new
              -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
            , zfCalc_StatDayCount_Week (inAmount           := COALESCE (_Result_Child.Amount_result_pack_pack, 0)
                                      , inAmountPartnerNext:= COALESCE (_Result_Child.AmountPartnerNext, 0) + COALESCE (_Result_Child.AmountPartnerNextPromo, 0)
                                      , inCountForecast    := CASE WHEN _Result_Child.CountForecast > 0 THEN COALESCE (_Result_Child.CountForecast, 0) ELSE COALESCE (_Result_Child.CountForecastOrder, 0) END
                                      , inPlan1            := COALESCE (_Result_Child.Plan1, 0) + COALESCE (_Result_Child.Promo1, 0)
                                      , inPlan2            := COALESCE (_Result_Child.Plan2, 0) + COALESCE (_Result_Child.Promo2, 0)
                                      , inPlan3            := COALESCE (_Result_Child.Plan3, 0) + COALESCE (_Result_Child.Promo3, 0)
                                      , inPlan4            := COALESCE (_Result_Child.Plan4, 0) + COALESCE (_Result_Child.Promo4, 0)
                                      , inPlan5            := COALESCE (_Result_Child.Plan5, 0) + COALESCE (_Result_Child.Promo5, 0)
                                      , inPlan6            := COALESCE (_Result_Child.Plan6, 0) + COALESCE (_Result_Child.Promo6, 0)
                                      , inPlan7            := COALESCE (_Result_Child.Plan7, 0) + COALESCE (_Result_Child.Promo7, 0)
                                       ) AS DayCountForecast_new_new

            , _Result_Child.ReceiptId
            , _Result_Child.ReceiptCode
            , _Result_Child.ReceiptName
            , _Result_Child.ReceiptId_basis
            , _Result_Child.ReceiptCode_basis
            , _Result_Child.ReceiptName_basis
            , _Result_Child.isErased

            , Object_Goods_packTo.ObjectCode     AS GoodsCode_packTo
            , Object_Goods_packTo.ValueData      AS GoodsName_packTo
            , Object_GoodsKind_packTo.ValueData  AS GoodsKindName_packTo

       FROM (SELECT _Result_Child.Id
                  , _Result_Child.ContainerId
                  , _Result_Child.KeyId
                  , COALESCE (Object_Goods.Id, _Result_Child.GoodsId)                  :: Integer  AS GoodsId
                  , COALESCE (Object_Goods.ObjectCode, _Result_Child.GoodsCode)        :: Integer  AS GoodsCode
                  , COALESCE (Object_Goods.ValueData, _Result_Child.GoodsName)         :: TVarChar AS GoodsName
                  , COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId)          :: Integer  AS GoodsKindId
                  , COALESCE (Object_GoodsKind.ValueData, _Result_Child.GoodsKindName) :: TVarChar AS GoodsKindName
                  , _Result_Child.MeasureName
                  , _Result_Child.GoodsGroupNameFull

                    -- ***����1 ����� ���� (� ���.) - ������ � ����
                  , SUM (_Result_Child.AmountPack)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPack
                    -- ***����1 ����� ���� (� ����) - ������ � ����
                  , SUM (_Result_Child.AmountPackSecond)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackSecond
                    -- ***����1 ����� ����� ���� - ������ � ����
                  , SUM (_Result_Child.AmountPackTotal)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackTotal

                    -- ***����1 ����� ����. (� ���.) - ������ � ����
                  , SUM (_Result_Child.AmountPack_calc)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPack_calc
                    -- ***����1 ����� ����. (� ����) - ������ � ����
                  , SUM (_Result_Child.AmountSecondPack_calc)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountSecondPack_calc
                    -- ***����1 ����� ����� ����. - ������ � ����
                  , SUM (_Result_Child.AmountPackTotal_calc)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackTotal_calc

                    -- ***����2 ������ � ���. �� ����
                  , SUM (_Result_Child.AmountPackNext)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackNext
                    -- ***����2 ������ � ���� �� ����
                  , SUM (_Result_Child.AmountPackNextSecond)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackNextSecond
                    -- ***����2 ����� ������ �� ����
                  , SUM (_Result_Child.AmountPackNextTotal)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackNextTotal

                    -- 
                  , SUM (_Result_Child.AmountPackNext_calc)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackNext_calc
                    -- 
                  , SUM (_Result_Child.AmountPackNextSecond_calc)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackNextSecond_calc
                    -- 
                  , SUM (_Result_Child.AmountPackNextTotal_calc)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackNextTotal_calc

                    -- 
                  , SUM (_Result_Child.AmountPackAllTotal)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackAllTotal
                    -- 
                  , SUM (_Result_Child.AmountPackAllTotal_calc)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPackAllTotal_calc

                    -- 
                  , SUM (_Result_Child.Amount_result_two)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Amount_result_two
                    -- 
                  , SUM (_Result_Child.Amount_result_pack)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Amount_result_pack
                    -- 
                  , SUM (_Result_Child.Amount_result_pack_pack)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Amount_result_pack_pack

                    -- ���� - ����������� �� ��� ��������
                  , SUM (_Result_Child.Income_PACK_to)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Income_PACK_to
                    -- ���� - ����������� � ���� ��������
                  , SUM (_Result_Child.Income_PACK_from)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Income_PACK_from

                    -- ���. �������. - �� �����������
                  , SUM (_Result_Child.Remains)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Remains
                    -- ���. �������. - �����������
                  , SUM (_Result_Child.Remains_pack)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Remains_pack

                    -- �������. ������
                  , SUM (_Result_Child.AmountPartnerPrior)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartnerPrior
                    -- 
                  , SUM (_Result_Child.AmountPartnerPriorPromo)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartnerPriorPromo
                    -- 
                  , SUM (_Result_Child.AmountPartnerPriorTotal)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartnerPriorTotal

                    -- ������� ������
                  , SUM (_Result_Child.AmountPartner)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartner
                    -- 
                  , SUM (_Result_Child.AmountPartnerNext)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartnerNext
                    -- 
                  , SUM (_Result_Child.AmountPartnerPromo)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartnerPromo
                    -- 
                  , SUM (_Result_Child.AmountPartnerNextPromo)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartnerNextPromo
                    -- 
                  , SUM (_Result_Child.AmountPartnerTotal)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountPartnerTotal

                    -- ������� �� ����.
                  , SUM (_Result_Child.AmountForecast)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountForecast
                    -- 
                  , SUM (_Result_Child.AmountForecastPromo)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountForecastPromo

                    -- ������� �� ����.
                  , SUM (_Result_Child.AmountForecastOrder)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountForecastOrder
                    -- 
                  , SUM (_Result_Child.AmountForecastOrderPromo)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountForecastOrderPromo

                    -- "�������" �� 1 ���� - ������� ����������� ��� ����� - ���� 1� (�� ��.) ��� �
                  , SUM (_Result_Child.CountForecast)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS CountForecast
                    -- "�������" �� 1 ���� - ������ ����������� ��� ����� - ���� 1� (�� ��.) ��� �
                  , SUM (_Result_Child.CountForecastOrder)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS CountForecastOrder

                    -- "�������" �� 1 ���� - ������� ��� �������
                  , SUM (_Result_Child.Plan1)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Plan1
                    -- 
                  , SUM (_Result_Child.Plan2)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Plan2
                    -- 
                  , SUM (_Result_Child.Plan3)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Plan3
                    -- 
                  , SUM (_Result_Child.Plan4)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Plan4
                    -- 
                  , SUM (_Result_Child.Plan5)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Plan5
                    -- 
                  , SUM (_Result_Child.Plan6)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Plan6
                    -- 
                  , SUM (_Result_Child.Plan7)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Plan7

                    -- "�������" �� 1 ���� - ����� - �������
                    -- 
                  , SUM (_Result_Child.Promo1)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Promo1
                    -- 
                  , SUM (_Result_Child.Promo2)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Promo2
                    -- 
                  , SUM (_Result_Child.Promo3)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Promo3
                    -- 
                  , SUM (_Result_Child.Promo4)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Promo4
                    -- 
                  , SUM (_Result_Child.Promo5)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Promo5
                    -- 
                  , SUM (_Result_Child.Promo6)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Promo6
                    -- 
                  , SUM (_Result_Child.Promo7)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Promo7

                    -- ���. � ���� (�� ��.) - ��� �
                  -- , _Result_Child.DayCountForecast
                    -- ���. � ���� (�� ��.) - ��� �
                  -- , _Result_Child.DayCountForecastOrder
                    -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
                  -- , _Result_Child.DayCountForecast_calc

                    -- �� master - ��
                  , SUM (_Result_Child.Amount_master)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS Amount_master
                    -- 
                  , SUM (_Result_Child.AmountNext_master)
                        OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                           END
                              ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END ASC
                                     , _Result_Child.Id ASC
                             ) AS AmountNext_master

                  , _Result_Child.ReceiptId
                  , _Result_Child.ReceiptCode
                  , _Result_Child.ReceiptName
                  , _Result_Child.ReceiptId_basis
                  , _Result_Child.ReceiptCode_basis
                  , _Result_Child.ReceiptName_basis
                  , _Result_Child.isErased

                    --  � �/�
                  , ROW_NUMBER() OVER (PARTITION BY CASE WHEN inShowAll = TRUE THEN _Result_Child.Id :: TVarChar
                                                         ELSE _Result_Child.KeyId || '_' || COALESCE (Object_Goods.Id, _Result_Child.GoodsId) :: TVarChar  || '_' || COALESCE (Object_GoodsKind.Id, _Result_Child.GoodsKindId) :: TVarChar
                                                    END
                                       ORDER BY CASE WHEN Object_Goods.Id > 0 THEN 0 ELSE _Result_Child.Id END DESC
                                              , _Result_Child.Id DESC
                                      ) AS Ord
             FROM _Result_Child
                  LEFT JOIN tmpGoodsByGoodsKind ON tmpGoodsByGoodsKind.GoodsId     = _Result_Child.GoodsId
                                               AND tmpGoodsByGoodsKind.GoodsKindId = _Result_Child.GoodsKindId
                                               AND inShowAll = FALSE
                  LEFT JOIN Object AS Object_Goods     ON Object_Goods.Id     = tmpGoodsByGoodsKind.GoodsId_pack
                  LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = tmpGoodsByGoodsKind.GoodsKindId_pack
            ) AS _Result_Child
            LEFT JOIN tmpGoodsByGoodsKind ON tmpGoodsByGoodsKind.GoodsId     = _Result_Child.GoodsId
                                         AND tmpGoodsByGoodsKind.GoodsKindId = _Result_Child.GoodsKindId
                                         AND inShowAll = TRUE
            LEFT JOIN Object AS Object_Goods_packTo     ON Object_Goods_packTo.Id     = tmpGoodsByGoodsKind.GoodsId_pack
            LEFT JOIN Object AS Object_GoodsKind_packTo ON Object_GoodsKind_packTo.Id = tmpGoodsByGoodsKind.GoodsKindId_pack
       WHERE _Result_Child.Ord = 1
       ;
       RETURN NEXT Cursor2;

       OPEN Cursor3 FOR
       SELECT _Result_ChildTotal.Id
            , _Result_ChildTotal.ContainerId
            , _Result_ChildTotal.GoodsId
            , _Result_ChildTotal.GoodsCode
            , _Result_ChildTotal.GoodsName
            , _Result_ChildTotal.GoodsId_complete
            , _Result_ChildTotal.GoodsCode_complete
            , _Result_ChildTotal.GoodsName_complete
            , _Result_ChildTotal.GoodsId_basis
            , _Result_ChildTotal.GoodsCode_basis
            , _Result_ChildTotal.GoodsName_basis
            , _Result_ChildTotal.GoodsKindId
            , _Result_ChildTotal.GoodsKindName
            , _Result_ChildTotal.GoodsKindId_complete
            , _Result_ChildTotal.GoodsKindName_complete
            , _Result_ChildTotal.MeasureName
            , _Result_ChildTotal.MeasureName_complete
            , _Result_ChildTotal.MeasureName_basis
            , _Result_ChildTotal.GoodsGroupNameFull
            , _Result_ChildTotal.isCheck_basis

              -- ����1 + ����2 ����� ������ �� ����
            , (_Result_ChildTotal.AmountTotal + _Result_ChildTotal.AmountNextTotal)                   :: TFloat AS AmountAllTotal
              -- ����1 + ����2 ����� ����� ���� - ������ � ����
            , (_Result_ChildTotal.AmountPackTotal + _Result_ChildTotal.AmountPackNextTotal)           :: TFloat AS AmountPackAllTotal
              -- ����1 + ����2 ����� ����� ����. - ������ � ����
            , (_Result_ChildTotal.AmountPackTotal_calc + _Result_ChildTotal.AmountPackNextTotal_calc) :: TFloat AS AmountPackAllTotal_calc

              -- ***����1 ������ �� ���� ...
            , _Result_ChildTotal.Amount
            , _Result_ChildTotal.AmountSecond
            , _Result_ChildTotal.AmountTotal
              -- ***����1 ����� ���� - ������ � ����
            , _Result_ChildTotal.AmountPack
            , _Result_ChildTotal.AmountPackSecond
            , _Result_ChildTotal.AmountPackTotal
              -- ***����1 ����� ����. - ������ � ����
            , _Result_ChildTotal.AmountPack_calc
            , _Result_ChildTotal.AmountSecondPack_calc
            , _Result_ChildTotal.AmountPackTotal_calc

              -- ***����2 ������ �� ���� ...
            , _Result_ChildTotal.AmountNext
            , _Result_ChildTotal.AmountNextSecond
            , _Result_ChildTotal.AmountNextTotal
              -- ***����2 ����� ���� - ������ � ����
            , _Result_ChildTotal.AmountPackNext
            , _Result_ChildTotal.AmountPackNextSecond
            , _Result_ChildTotal.AmountPackNextTotal
              -- ***����2 ����� ����. - ������ � ����
            , _Result_ChildTotal.AmountPackNext_calc
            , _Result_ChildTotal.AmountPackNextSecond_calc
            , _Result_ChildTotal.AmountPackNextTotal_calc

              -- ��������� c ��-���
            , _Result_ChildTotal.Amount_result
              -- ��������� ��� ��-��
            , _Result_ChildTotal.Amount_result_two
              -- ��������� ***����
            , _Result_ChildTotal.Amount_result_pack

            , _Result_ChildTotal.Income_CEH
            , _Result_ChildTotal.Income_PACK_to
            , _Result_ChildTotal.Income_PACK_from

            , _Result_ChildTotal.Remains_CEH
            , _Result_ChildTotal.Remains_CEH_Next
            , _Result_ChildTotal.Remains_CEH_err
            , _Result_ChildTotal.Remains
            , _Result_ChildTotal.Remains_pack
            , _Result_ChildTotal.Remains_err

              -- �������. ������
            , _Result_ChildTotal.AmountPartnerPrior
            , _Result_ChildTotal.AmountPartnerPriorPromo
            , _Result_ChildTotal.AmountPartnerPriorTotal
              -- ������� ������
            , _Result_ChildTotal.AmountPartner
            , _Result_ChildTotal.AmountPartnerNext
            , _Result_ChildTotal.AmountPartnerPromo
            , _Result_ChildTotal.AmountPartnerNextPromo
            , _Result_ChildTotal.AmountPartnerTotal
              -- ������� �� ����.
            , _Result_ChildTotal.AmountForecast
            , _Result_ChildTotal.AmountForecastPromo
              -- ������� �� ����.
            , _Result_ChildTotal.AmountForecastOrder
            , _Result_ChildTotal.AmountForecastOrderPromo

              -- "�������" �� 1 ���� - ������� ����������� ��� ����� - ���� 1� (�� ��.) ��� �
            , CAST (_Result_ChildTotal.CountForecast AS NUMERIC (16, 1)) :: TFloat AS CountForecast
              -- "�������" �� 1 ���� - ������ ����������� ��� ����� - ���� 1� (�� ��.) ��� �
            , CAST (_Result_ChildTotal.CountForecastOrder AS NUMERIC (16, 1)) :: TFloat AS CountForecastOrder

              -- "�������" �� 1 ���� - ������� ��� �������
            , CAST (_Result_ChildTotal.Plan1 AS NUMERIC (16, 1)) :: TFloat AS Plan1
            , CAST (_Result_ChildTotal.Plan2 AS NUMERIC (16, 1)) :: TFloat AS Plan2
            , CAST (_Result_ChildTotal.Plan3 AS NUMERIC (16, 1)) :: TFloat AS Plan3
            , CAST (_Result_ChildTotal.Plan4 AS NUMERIC (16, 1)) :: TFloat AS Plan4
            , CAST (_Result_ChildTotal.Plan5 AS NUMERIC (16, 1)) :: TFloat AS Plan5
            , CAST (_Result_ChildTotal.Plan6 AS NUMERIC (16, 1)) :: TFloat AS Plan6
            , CAST (_Result_ChildTotal.Plan7 AS NUMERIC (16, 1)) :: TFloat AS Plan7
              -- "�������" �� 1 ���� - ����� - �������
            , CAST (_Result_ChildTotal.Promo1 AS NUMERIC (16, 1)) :: TFloat AS Promo1
            , CAST (_Result_ChildTotal.Promo2 AS NUMERIC (16, 1)) :: TFloat AS Promo2
            , CAST (_Result_ChildTotal.Promo3 AS NUMERIC (16, 1)) :: TFloat AS Promo3
            , CAST (_Result_ChildTotal.Promo4 AS NUMERIC (16, 1)) :: TFloat AS Promo4
            , CAST (_Result_ChildTotal.Promo5 AS NUMERIC (16, 1)) :: TFloat AS Promo5
            , CAST (_Result_ChildTotal.Promo6 AS NUMERIC (16, 1)) :: TFloat AS Promo6
            , CAST (_Result_ChildTotal.Promo7 AS NUMERIC (16, 1)) :: TFloat AS Promo7

              -- ���. � ���� (�� ��.) - ��� �
            , _Result_ChildTotal.DayCountForecast
              -- ���. � ���� (�� ��.) - ��� �
            , _Result_ChildTotal.DayCountForecastOrder
              -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
            , _Result_ChildTotal.DayCountForecast_calc
              -- ���. � ���� (�� ��. !!!���!!! �� ��.) - ����� ��������
            , zfCalc_StatDayCount_Week (inAmount           := COALESCE (_Result_ChildTotal.Amount_result_pack, 0)
                                      , inAmountPartnerNext:= COALESCE (_Result_ChildTotal.AmountPartnerNext, 0) + COALESCE (_Result_ChildTotal.AmountPartnerNextPromo, 0)
                                      , inCountForecast    := CASE WHEN _Result_ChildTotal.CountForecast > 0 THEN COALESCE (_Result_ChildTotal.CountForecast, 0) ELSE COALESCE (_Result_ChildTotal.CountForecastOrder, 0) END
                                      , inPlan1            := COALESCE (_Result_ChildTotal.Plan1, 0) + COALESCE (_Result_ChildTotal.Promo1, 0)
                                      , inPlan2            := COALESCE (_Result_ChildTotal.Plan2, 0) + COALESCE (_Result_ChildTotal.Promo2, 0)
                                      , inPlan3            := COALESCE (_Result_ChildTotal.Plan3, 0) + COALESCE (_Result_ChildTotal.Promo3, 0)
                                      , inPlan4            := COALESCE (_Result_ChildTotal.Plan4, 0) + COALESCE (_Result_ChildTotal.Promo4, 0)
                                      , inPlan5            := COALESCE (_Result_ChildTotal.Plan5, 0) + COALESCE (_Result_ChildTotal.Promo5, 0)
                                      , inPlan6            := COALESCE (_Result_ChildTotal.Plan6, 0) + COALESCE (_Result_ChildTotal.Promo6, 0)
                                      , inPlan7            := COALESCE (_Result_ChildTotal.Plan7, 0) + COALESCE (_Result_ChildTotal.Promo7, 0)
                                       ) AS DayCountForecast_new

            , _Result_ChildTotal.ReceiptId
            , _Result_ChildTotal.ReceiptCode
            , _Result_ChildTotal.ReceiptName
            , _Result_ChildTotal.ReceiptId_basis
            , _Result_ChildTotal.ReceiptCode_basis
            , _Result_ChildTotal.ReceiptName_basis
            , _Result_ChildTotal.UnitId
            , _Result_ChildTotal.UnitCode
            , _Result_ChildTotal.UnitName
            , _Result_ChildTotal.GoodsKindName_pf
            , _Result_ChildTotal.GoodsKindCompleteName_pf
            , _Result_ChildTotal.PartionDate_pf
            , _Result_ChildTotal.PartionGoods_start
            , _Result_ChildTotal.TermProduction
            , _Result_ChildTotal.isErased

       FROM _Result_ChildTotal
       ;

       RETURN NEXT Cursor3;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;
ALTER FUNCTION gpSelect_MI_OrderInternalPackRemains (Integer, Boolean, Boolean, TVarChar) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 17.11.17         *
 13.11.17         *
 29.10.17         *
 19.06.15                                        * all
 31.03.15         * add GoodsGroupNameFull
 02.03.14         * add AmountRemains, AmountPartner, AmountForecast, AmountForecastOrder
 06.06.14                                                       *
*/

-- ����
-- SELECT * FROM gpSelect_MI_OrderInternalPackRemains (inMovementId:= 1828419, inShowAll:= TRUE, inIsErased:= FALSE, inSession:= '9818')
-- SELECT * FROM gpSelect_MI_OrderInternalPackRemains (inMovementId:= 1828419, inShowAll:= FALSE, inIsErased:= FALSE, inSession:= '2'); -- FETCH ALL "<unnamed portal 1>";
