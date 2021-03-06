-- Function: gpInsert_MI_Inventory()

DROP FUNCTION IF EXISTS gpInsert_MI_Inventory (Integer, TVarChar, TFloat, TVarChar);

CREATE OR REPLACE FUNCTION gpInsert_MI_Inventory(
    IN inMovementId          Integer   , -- ���� ������� <�������� ��������������>
    IN inBarCode             TVarChar  , -- �������� ������
    IN inAmountUser          TFloat    , -- ���������� ���.������������
    IN inSession             TVarChar    -- ������ ������������
)
RETURNS VOID
AS
$BODY$
   DECLARE vbUserId Integer;
   DECLARE vbUnitId Integer;   
   DECLARE vbGoodsId Integer;
   DECLARE vbObjectId Integer;
   DECLARE vbId Integer;
   DECLARE vbOperDate TDateTime; 
   DECLARE vbPrice TFloat;
   DECLARE vbAmount TFloat;  
   DECLARE vbCountUser TFloat;
BEGIN
    -- �������� ���� ������������ �� ����� ���������
    vbUserId := lpCheckRight (inSession, zc_Enum_Process_InsertUpdate_MI_Inventory());
	
    --���������� ������������� � ���� ���������
    SELECT DATE_TRUNC ('DAY', Movement.OperDate)
         , MLO_Unit.ObjectId
    INTO vbOperDate, vbUnitId
    FROM Movement
        INNER JOIN MovementLinkObject AS MLO_Unit
                                      ON MLO_Unit.MovementId = Movement.Id
                                     AND MLO_Unit.DescId = zc_MovementLinkObject_Unit()
    WHERE Movement.Id = inMovementId;
               
    -- !!! - ������������ <�������� ����>!!!
    vbObjectId:= (SELECT ObjectLink_Juridical_Retail.ChildObjectId
                  FROM ObjectLink AS ObjectLink_Unit_Juridical
                       INNER JOIN ObjectLink AS ObjectLink_Juridical_Retail
                                             ON ObjectLink_Juridical_Retail.ObjectId = ObjectLink_Unit_Juridical.ChildObjectId
                                            AND ObjectLink_Juridical_Retail.DescId = zc_ObjectLink_Juridical_Retail()
                  WHERE ObjectLink_Unit_Juridical.ObjectId = vbUnitId
                    AND ObjectLink_Unit_Juridical.DescId = zc_ObjectLink_Unit_Juridical()
                 ); 
    
    --���������� ����� �� ��������� 
    vbGoodsId := (SELECT ObjectLink_Child.ChildObjectId
                  FROM (SELECT zfConvert_StringToNumber (SUBSTR (inBarCode, 4, 13-4)) AS GoodsId) AS tmp
                       LEFT JOIN ObjectLink AS ObjectLink_Main
                              ON ObjectLink_Main.ChildObjectId = tmp.GoodsId    --ObjectLink_Main.ObjectId = ObjectLink_Child.ObjectId
                             AND ObjectLink_Main.DescId = zc_ObjectLink_LinkGoods_GoodsMain()
                       LEFT JOIN ObjectLink AS ObjectLink_Child 
                              ON ObjectLink_Child.ObjectId = ObjectLink_Main.ObjectId
                             AND ObjectLink_Child.DescId = zc_ObjectLink_LinkGoods_Goods()
                       -- ����� � �������� ���� ��� ...
                       INNER JOIN ObjectLink AS ObjectLink_Goods_Retail
                               ON ObjectLink_Goods_Retail.ObjectId = ObjectLink_Child.ChildObjectId
                              AND ObjectLink_Goods_Retail.DescId = zc_ObjectLink_Goods_Object()
                              AND ObjectLink_Goods_Retail.ChildObjectId = vbObjectId
                       /*INNER JOIN Object AS Object_GoodsObject
                                 ON Object_GoodsObject.Id = ObjectLink_Goods_Retail.ChildObjectId
                                AND COALESCE (Object_GoodsObject.DescId, 0) = zc_Object_Retail()*/
                  );    
    
    --���������� �� ������
    vbId := (SELECT MovementItem.Id
             FROM MovementItem 
             WHERE MovementItem.MovementId = inMovementId
               AND MovementItem.DescId = zc_MI_Master()
               AND MovementItem.ObjectId = vbGoodsId);

           
    -- ����� ���������� ����� ���-�� (��������� ���-�� �� ���� ������������� + �������)
    -- � ���-�� �������������, �������������� �������
    SELECT SUM (tmp.Amount) AS  Amount
         , (Count (tmp.Num) + 1) :: TFloat AS CountUser
    INTO vbAmount, vbCountUser
    FROM (SELECT MovementItem.Amount        AS Amount
               , CAST (ROW_NUMBER() OVER (PARTITION BY MovementItem.ObjectId ORDER BY MovementItem.ObjectId, MIDate_Insert.ValueData DESC) AS Integer) AS Num
          FROM MovementItem
               LEFT JOIN MovementItemDate AS MIDate_Insert
                                          ON MIDate_Insert.MovementItemId = MovementItem.Id
                                         AND MIDate_Insert.DescId = zc_MIDate_Insert()
          WHERE MovementItem.ParentId = vbId
            AND MovementItem.DescId     = zc_MI_Child()
            AND MovementItem.isErased  = FALSE 
            AND MovementItem.ObjectId  <> vbUserId
           ) AS tmp
    WHERE tmp.Num = 1;

    vbAmount := COALESCE (inAmountUser,0) + COALESCE (vbAmount, 0);
    -- ���������� ����
    vbPrice := (SELECT ROUND(Price_Value.ValueData,2)::TFloat
                FROM ObjectLink AS Price_Unit
                       INNER JOIN ObjectLink AS Price_Goods
                                             ON Price_Goods.ObjectId = Price_Unit.ObjectId
                                            AND Price_Goods.DescId = zc_ObjectLink_Price_Goods()
                                            AND Price_Goods.ChildObjectId = vbGoodsId             
                       LEFT JOIN ObjectFloat AS Price_Value
                                             ON Price_Value.ObjectId = Price_Unit.ObjectId
                                            AND Price_Value.DescId = zc_ObjectFloat_Price_Value()                                            
                WHERE Price_Unit.ChildObjectId = vbUnitId
                  AND Price_Unit.DescId = zc_ObjectLink_Price_Unit());   
    
    -- ����������� ����� �� ������
    --outSumm := (vbAmount * vbPrice)::TFloat;
    
    -- ���������
    vbId:= lpInsertUpdate_MovementItem_Inventory (ioId                 := COALESCE(vbId,0)
                                                , inMovementId         := inMovementId
                                                , inGoodsId            := vbGoodsId
                                                , inAmount             := vbAmount
                                                , inPrice              := vbPrice
                                                , inSumm               := (vbAmount * vbPrice)::TFloat --outSumm
                                                , inComment            := '' ::TVarChar
                                                , inUserId             := vbUserId) AS tmp;

    -- ���������� ����������� �������
    IF COALESCE(vbId,0) <> 0 
    THEN 
        PERFORM lpInsertUpdate_MI_Inventory_Child(inId                 := 0
                                                , inMovementId         := inMovementId
                                                , inParentId           := vbId
                                                , inAmountUser         := inAmountUser
                                                , inUserId             := vbUserId
                                                  );
    END IF;

    --

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.   ��������� �.�.
 01.03.17         *
*/

-- ����
-- SELECT * FROM gpInsert_MI_Inventory (ioId:= 0, inMovementId:= 0, inGoodsId:= 1, outAmount:= 0, inSession:= '2')
-- SELECT * FROM gpInsert_MI_Inventory (ioId := 58062345 , inMovementId := 3497252 , inGoodsId := 337 , outAmount := 1 , vbPrice := 0 , inComment := '' ,  inSession := '3');
