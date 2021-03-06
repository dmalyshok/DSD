-- Function: lpComplete_Movement_Tax()

DROP FUNCTION IF EXISTS lpComplete_Movement_Tax (Integer, Integer);

CREATE OR REPLACE FUNCTION lpComplete_Movement_Tax(
    IN inMovementId        Integer  , -- ���� ���������
    IN inUserId            Integer    -- ������������
)
 RETURNS VOID
AS
$BODY$
  DECLARE vbOperDate TDateTime;
  DECLARE vbObjectId Integer;
BEGIN
     -- ����������
     vbOperDate:= (SELECT Movement.OperDate FROM Movement WHERE Movement.Id = inMovementId);

     -- �����
     vbObjectId:= (SELECT MovementItem.ObjectId
                   FROM MovementItem
                        INNER JOIN Object AS Object_GoodsExternal ON Object_GoodsExternal.Id = MovementItem.ObjectId
                                                                 AND Object_GoodsExternal.DescId = zc_Object_GoodsExternal()
                        LEFT JOIN ObjectLink AS ObjectLink_GoodsExternal_Goods
                                             ON ObjectLink_GoodsExternal_Goods.ObjectId = Object_GoodsExternal.Id
                                            AND ObjectLink_GoodsExternal_Goods.DescId = zc_ObjectLink_GoodsExternal_Goods()
                        LEFT JOIN ObjectLink AS ObjectLink_GoodsExternal_GoodsKind
                                             ON ObjectLink_GoodsExternal_GoodsKind.ObjectId = Object_GoodsExternal.Id
                                            AND ObjectLink_GoodsExternal_GoodsKind.DescId = zc_ObjectLink_GoodsExternal_GoodsKind()
                   WHERE MovementItem.MovementId = inMovementId
                     AND MovementItem.isErased = FALSE
                     AND MovementItem.DescId = zc_MI_Master()
                     AND (COALESCE (ObjectLink_GoodsExternal_Goods.ChildObjectId, 0) = 0 OR COALESCE (ObjectLink_GoodsExternal_GoodsKind.ChildObjectId, 0) = 0)
                   LIMIT 1
                  );

     -- ��������
     IF vbObjectId > 0
     THEN
         RAISE EXCEPTION '������.��� ������ ����� <%> �� ��������� �������� <�����> �/��� <��� ������>.',  lfGet_Object_ValueData (vbObjectId);
     END IF;


     -- ������ zc_Object_GoodsExternal -> zc_Object_Goods and zc_Object_GoodsKind
     PERFORM lpInsertUpdate_MovementItem (MovementItem.Id, MovementItem.DescId, ObjectLink_GoodsExternal_Goods.ChildObjectId, MovementItem.MovementId, MovementItem.Amount, MovementItem.ParentId)
           , lpInsertUpdate_MovementItemLinkObject (zc_MILinkObject_GoodsKind(), MovementItem.Id, ObjectLink_GoodsExternal_GoodsKind.ChildObjectId)
     FROM MovementItem
          INNER JOIN Object AS Object_GoodsExternal ON Object_GoodsExternal.Id = MovementItem.ObjectId
                                                   AND Object_GoodsExternal.DescId = zc_Object_GoodsExternal()
          INNER JOIN ObjectLink AS ObjectLink_GoodsExternal_Goods
                                ON ObjectLink_GoodsExternal_Goods.ObjectId = Object_GoodsExternal.Id
                               AND ObjectLink_GoodsExternal_Goods.DescId = zc_ObjectLink_GoodsExternal_Goods()
                               AND ObjectLink_GoodsExternal_Goods.ChildObjectId > 0
          INNER JOIN ObjectLink AS ObjectLink_GoodsExternal_GoodsKind
                                ON ObjectLink_GoodsExternal_GoodsKind.ObjectId = Object_GoodsExternal.Id
                               AND ObjectLink_GoodsExternal_GoodsKind.DescId = zc_ObjectLink_GoodsExternal_GoodsKind()
                               AND ObjectLink_GoodsExternal_GoodsKind.ChildObjectId > 0
     WHERE MovementItem.MovementId = inMovementId
         AND MovementItem.isErased = FALSE
         AND MovementItem.DescId = zc_MI_Master()
    ;


     -- � �/� ��
     PERFORM lpInsertUpdate_MovementItemFloat (zc_MIFloat_NPP(), tmp.Id, tmp.LineNum)
     FROM (SELECT MovementItem.Id
                , CASE WHEN vbOperDate < '01.03.2016' AND 1=1
                            THEN ROW_NUMBER() OVER (ORDER BY MovementItem.Id)
                       ELSE ROW_NUMBER() OVER (ORDER BY Object_Goods.ValueData, Object_GoodsKind.ValueData, MovementItem.Id)
                  END AS LineNum
           FROM MovementItem
                LEFT JOIN Object AS Object_Goods ON Object_Goods.Id = MovementItem.ObjectId
                LEFT JOIN MovementItemLinkObject AS MILinkObject_GoodsKind
                                                 ON MILinkObject_GoodsKind.MovementItemId = MovementItem.Id
                                                AND MILinkObject_GoodsKind.DescId = zc_MILinkObject_GoodsKind()
                LEFT JOIN Object AS Object_GoodsKind ON Object_GoodsKind.Id = MILinkObject_GoodsKind.ObjectId
           WHERE MovementItem.MovementId = inMovementId
             AND MovementItem.DescId = zc_MI_Master()
             AND MovementItem.isErased = FALSE
          ) AS tmp
    ;


     -- ����������� ������ ������ ��������� + ��������� ��������
     PERFORM lpComplete_Movement (inMovementId := inMovementId
                                , inDescId     := zc_Movement_Tax()
                                , inUserId     := inUserId
                                 );
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.�.
 25.05.14                                        * add lpComplete_Movement
 10.05.14                                        * set lp
 10.05.14                                        * add lpInsert_MovementProtocol
 11.02.14                                                       *
*/

-- ����
-- SELECT * FROM lpComplete_Movement_Tax (inMovementId:= 10154, inUserId:= zfCalc_UserAdmin() :: Integer)
