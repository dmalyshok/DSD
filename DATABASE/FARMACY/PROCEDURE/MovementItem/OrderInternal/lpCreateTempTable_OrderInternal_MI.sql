-- Function: lpCreateTempTable_OrderInternal_MI()

DROP FUNCTION IF EXISTS lpCreateTempTable_OrderInternal_MI (Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpCreateTempTable_OrderInternal_MI(
    IN inMovementId  Integer      , -- ���� ���������
    IN inObjectId    Integer      , 
    IN inGoodsId     Integer      , 
    IN inUserId      Integer        -- ������ ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbMainJuridicalId Integer;
  DECLARE vbUnitId Integer;
BEGIN

     SELECT Object_Unit_View.JuridicalId, MovementLinkObject.ObjectId
            INTO vbMainJuridicalId, vbUnitId
         FROM Object_Unit_View 
               JOIN  MovementLinkObject ON MovementLinkObject.ObjectId = Object_Unit_View.Id 
                AND  MovementLinkObject.MovementId = inMovementId 
                AND  MovementLinkObject.DescId = zc_MovementLinkObject_Unit();

     CREATE TEMP TABLE _tmpOrderInternal_MI (Id integer
             , MovementItemId   Integer
             , GoodsId          Integer
             , PartnerGoodsId   Integer
             , JuridicalId      Integer
             , JuridicalName    TVarChar
             , ContractId       Integer
             , ContractName     TVarChar
             , MakerName        TVarChar
             , PartionGoodsDate TDateTime
             , Amount           TFloat
             , MinimumLot       TFloat
             , MCS              TFloat
             , Remains          TFloat
             , Income           TFloat
             , CheckAmount      TFloat
             , SendAmount       TFloat
             , AmountDeferred   TFloat
             , isClose          Boolean
             , isFirst          Boolean
             , isSecond         Boolean
             , isTOP            Boolean
             , isUnitTOP        Boolean
             , MCSNotRecalc     Boolean
             , MCSIsClose       Boolean
             , isErased         Boolean

) ON COMMIT DROP;

      -- ���������� ������
      INSERT INTO _tmpOrderInternal_MI 

      WITH      
          MovementItemOrder AS (SELECT MovementItem.Id, MovementItem.ObjectId, MovementItem.isErased, MovementItem.Movementid, MovementItem.Amount
                                FROM MovementItem    
                                WHERE MovementItem.MovementId = inMovementId
                                  AND MovementItem.DescId     = zc_MI_Master()
                                  AND ((inGoodsId = 0) OR (inGoodsId = MovementItem.ObjectId))
                            )

        , tmpMIB_MCSNotRecalc AS (SELECT MIBoolean_MCSNotRecalc.*
                                  FROM MovementItemOrder
                                       LEFT JOIN MovementItemBoolean AS MIBoolean_MCSNotRecalc
                                              ON MIBoolean_MCSNotRecalc.MovementItemId = MovementItemOrder.Id
                                             AND MIBoolean_MCSNotRecalc.DescId = zc_MIBoolean_MCSNotRecalc()
                                 )
          
        , tmpMIB_MCSIsClose AS (SELECT MIBoolean_MCSIsClose.*
                                FROM MovementItemOrder
                                     LEFT JOIN MovementItemBoolean AS MIBoolean_MCSIsClose
                                            ON MIBoolean_MCSIsClose.MovementItemId = MovementItemOrder.Id
                                           AND MIBoolean_MCSIsClose.DescId = zc_MIBoolean_MCSIsClose()
                                )

        , tmpMIB_Close AS (SELECT MIBoolean_Close.*
                           FROM MovementItemOrder
                                LEFT JOIN MovementItemBoolean AS MIBoolean_Close 
                                       ON MIBoolean_Close.DescId = zc_MIBoolean_Close()
                                      AND MIBoolean_Close.MovementItemId = MovementItemOrder.Id
                          )
        , tmpMIB_First AS (SELECT MIBoolean_First.*
                           FROM MovementItemOrder
                                LEFT JOIN MovementItemBoolean AS MIBoolean_First
                                       ON MIBoolean_First.DescId = zc_MIBoolean_First()
                                      AND MIBoolean_First.MovementItemId = MovementItemOrder.Id
                           )
        , tmpMIB_Second AS (SELECT MIBoolean_Second.*
                            FROM MovementItemOrder
                                 LEFT JOIN MovementItemBoolean AS MIBoolean_Second
                                        ON MIBoolean_Second.DescId = zc_MIBoolean_Second()
                                       AND MIBoolean_Second.MovementItemId = MovementItemOrder.Id
                           )
        , tmpMIB_TOP AS (SELECT MIBoolean_TOP.*
                         FROM MovementItemOrder
                              LEFT JOIN MovementItemBoolean AS MIBoolean_TOP
                                     ON MIBoolean_TOP.DescId = zc_MIBoolean_TOP()
                                    AND MIBoolean_TOP.MovementItemId = MovementItemOrder.Id
                         )
        , tmpMIB_UnitTOP AS (SELECT MIBoolean_UnitTOP.*
                             FROM MovementItemOrder
                                  LEFT JOIN MovementItemBoolean AS MIBoolean_UnitTOP
                                         ON MIBoolean_UnitTOP.DescId = zc_MIBoolean_UnitTOP()
                                        AND MIBoolean_UnitTOP.MovementItemId = MovementItemOrder.Id
                            )
 
        , tmpMIS_Maker AS (SELECT MIString_Maker.*
                           FROM MovementItemOrder
                                LEFT JOIN MovementItemString AS MIString_Maker 
                                       ON MIString_Maker.MovementItemId = MovementItemOrder.Id
                                      AND MIString_Maker.DescId = zc_MIString_Maker()
                          )
    
        , tmpMIF_MinimumLot AS (SELECT MIFloat_MinimumLot.*
                                FROM MovementItemOrder
                                     LEFT JOIN MovementItemFloat AS MIFloat_MinimumLot                                             
                                            ON MIFloat_MinimumLot.DescId = zc_MIFloat_MinimumLot()
                                           AND MIFloat_MinimumLot.MovementItemId = MovementItemOrder.Id
                                )
  
        , tmpMIF_MCS AS (SELECT MIFloat_MCS.*
                         FROM MovementItemOrder
                              LEFT JOIN MovementItemFloat AS MIFloat_MCS                                           
                                     ON MIFloat_MCS.DescId = zc_MIFloat_MCS()
                                    AND MIFloat_MCS.MovementItemId = MovementItemOrder.Id 
                         )
        , tmpMIF_Remains AS (SELECT MIFloat_Remains.*
                             FROM MovementItemOrder
                                  LEFT JOIN MovementItemFloat AS MIFloat_Remains
                                         ON MIFloat_Remains.MovementItemId = MovementItemOrder.Id
                                        AND MIFloat_Remains.DescId = zc_MIFloat_Remains()
                             )
        , tmpMIF_Income AS (SELECT MIFloat_Income.*
                            FROM MovementItemOrder
                                 LEFT JOIN MovementItemFloat AS MIFloat_Income
                                        ON MIFloat_Income.MovementItemId = MovementItemOrder.Id
                                       AND MIFloat_Income.DescId = zc_MIFloat_Income()  
                            )
        , tmpMIF_Check AS (SELECT MIFloat_Check.*
                           FROM MovementItemOrder
                                LEFT JOIN MovementItemFloat AS MIFloat_Check
                                       ON MIFloat_Check.MovementItemId = MovementItemOrder.Id
                                      AND MIFloat_Check.DescId = zc_MIFloat_Check() 
                           )
        , tmpMIF_Send AS (SELECT MIFloat_Send.*
                          FROM MovementItemOrder
                               LEFT JOIN MovementItemFloat AS MIFloat_Send
                                      ON MIFloat_Send.MovementItemId = MovementItemOrder.Id
                                     AND MIFloat_Send.DescId = zc_MIFloat_Send()
                         )
        , tmpMIF_AmountDeferred AS (SELECT MIFloat_AmountDeferred.*
                                    FROM MovementItemOrder
                                         LEFT JOIN MovementItemFloat AS MIFloat_AmountDeferred
                                                ON MIFloat_AmountDeferred.MovementItemId = MovementItemOrder.Id
                                               AND MIFloat_AmountDeferred.DescId = zc_MIFloat_AmountDeferred()
                                    )

         SELECT row_number() OVER ()
            , MovementItem.Id                      AS MovementItemId
            , Object_Goods.Id                      AS GoodsId
            , Object_PartnerGoods.Id               AS PartnerGoodsId
            
            , Object_Juridical.Id                  AS JuridicalId
            , Object_Juridical.ValueData           AS JuridicalName
            , Object_Contract.Id                   AS ContractId
            , Object_Contract.ValueData            AS ContractName
            , MIString_Maker.ValueData             AS MakerName

            , MIDate_PartionGoods.ValueData        AS PartionGoodsDate
            , COALESCE(MovementItem.Amount,0)      AS Amount
            , MIFloat_MinimumLot.ValueData         AS MinimumLot
            , MIFloat_MCS.ValueData                AS MCS
            , MIFloat_Remains.ValueData            AS Remains
            , MIFloat_Income.ValueData             AS Income
            , MIFloat_Check.ValueData              AS CheckAmount
            , MIFloat_Send.ValueData               AS SendAmount
            , MIFloat_AmountDeferred.ValueData     AS AmountDeferred

            , COALESCE(MIBoolean_Close.ValueData, False)              AS isClose
            , COALESCE(MIBoolean_First.ValueData, False)              AS isFirst
            , COALESCE(MIBoolean_Second.ValueData, False)             AS isSecond
            , COALESCE(MIBoolean_TOP.ValueData, False)                AS isTOP
            , COALESCE(MIBoolean_UnitTOP.ValueData, False)            AS isUnitTOP
            , COALESCE(MIBoolean_MCSNotRecalc.ValueData, FALSE)       AS MCSNotRecalc
            , COALESCE(MIBoolean_MCSIsClose.ValueData, FALSE)         AS MCSIsClose

            , MovementItem.isErased

         FROM MovementItemOrder AS MovementItem
              LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId

              LEFT JOIN MovementItemLinkObject AS MILinkObject_Juridical 
                                               ON MILinkObject_Juridical.DescId = zc_MILinkObject_Juridical()
                                              AND MILinkObject_Juridical.MovementItemId = MovementItem.Id
              LEFT JOIN Object AS Object_Juridical ON Object_Juridical.Id = MILinkObject_Juridical.ObjectId AND Object_Juridical.DescId = zc_Object_Juridical()
              
              LEFT JOIN MovementItemLinkObject AS MILinkObject_Contract 
                                               ON MILinkObject_Contract.DescId = zc_MILinkObject_Contract()
                                              AND MILinkObject_Contract.MovementItemId = MovementItem.Id
              LEFT JOIN Object AS Object_Contract ON Object_Contract.Id = MILinkObject_Contract.ObjectId AND Object_Contract.DescId = zc_Object_Contract()
              
              LEFT JOIN MovementItemLinkObject AS MILinkObject_Goods 
                                               ON MILinkObject_Goods.DescId = zc_MILinkObject_Goods()
                                              AND MILinkObject_Goods.MovementItemId = MovementItem.Id
              LEFT JOIN Object AS Object_PartnerGoods ON Object_PartnerGoods.Id = MILinkObject_Goods.ObjectId AND Object_PartnerGoods.DescId = zc_Object_Goods()

              LEFT JOIN MovementItemDate AS MIDate_PartionGoods                                        
                                         ON MIDate_PartionGoods.DescId = zc_MIDate_PartionGoods()
                                        AND MIDate_PartionGoods.MovementItemId = MovementItem.Id

              LEFT JOIN tmpMIB_Close   AS MIBoolean_Close   ON MIBoolean_Close.MovementItemId   = MovementItem.Id
              LEFT JOIN tmpMIB_First   AS MIBoolean_First   ON MIBoolean_First.MovementItemId   = MovementItem.Id
              LEFT JOIN tmpMIB_Second  AS MIBoolean_Second  ON MIBoolean_Second.MovementItemId  = MovementItem.Id
              LEFT JOIN tmpMIB_TOP     AS MIBoolean_TOP     ON MIBoolean_TOP.MovementItemId     = MovementItem.Id
              LEFT JOIN tmpMIB_UnitTOP AS MIBoolean_UnitTOP ON MIBoolean_UnitTOP.MovementItemId = MovementItem.Id

              LEFT JOIN tmpMIB_MCSNotRecalc AS MIBoolean_MCSNotRecalc ON MIBoolean_MCSNotRecalc.MovementItemId = MovementItem.Id
              LEFT JOIN tmpMIB_MCSIsClose   AS MIBoolean_MCSIsClose   ON MIBoolean_MCSIsClose.MovementItemId   = MovementItem.Id
              LEFT JOIN tmpMIS_Maker        AS MIString_Maker         ON MIString_Maker.MovementItemId         = MovementItem.Id  
 
              LEFT JOIN tmpMIF_MinimumLot     AS MIFloat_MinimumLot     ON MIFloat_MinimumLot.MovementItemId     = MovementItem.Id
              LEFT JOIN tmpMIF_MCS            AS MIFloat_MCS            ON MIFloat_MCS.MovementItemId            = MovementItem.Id 
              LEFT JOIN tmpMIF_Remains        AS MIFloat_Remains        ON MIFloat_Remains.MovementItemId        = MovementItem.Id
              LEFT JOIN tmpMIF_Income         AS MIFloat_Income         ON MIFloat_Income.MovementItemId         = MovementItem.Id
              LEFT JOIN tmpMIF_Check          AS MIFloat_Check          ON MIFloat_Check.MovementItemId          = MovementItem.Id
              LEFT JOIN tmpMIF_Send           AS MIFloat_Send           ON MIFloat_Send.MovementItemId           = MovementItem.Id
              LEFT JOIN tmpMIF_AmountDeferred AS MIFloat_AmountDeferred ON MIFloat_AmountDeferred.MovementItemId = MovementItem.Id
;

END;
$BODY$
  LANGUAGE PLPGSQL VOLATILE;


/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 09.04.17         * �����������
 22.12.16         * add AmountDeferred
 04.08.16         *  
*/

-- ����
-- SELECT * FROM gpSelect_MovementItem_OrderInternal (inMovementId:= 25173, inShowAll:= TRUE, inIsErased:= FALSE, inSession:= '9818')
-- SELECT * FROM gpSelect_MovementItem_OrderInternal (inMovementId:= 25173, inShowAll:= FALSE, inIsErased:= FALSE, inSession:= '2')
-- SELECT lpCreateTempTable_OrderInternal_MI(inMovementId := 2158888, inObjectId := 4, inGoodsId := 0, inUserId := 3); SELECT * FROM _tmpMI;
