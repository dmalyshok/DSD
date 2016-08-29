-- Function: lpInsertFind_Object_PartionGoods (Integer, Integer, Integer, TVarChar, TDateTime)

DROP FUNCTION IF EXISTS lpInsertFind_Object_PartionGoods (Integer, Integer, Integer, TVarChar, TDateTime, TFloat);

CREATE OR REPLACE FUNCTION lpInsertFind_Object_PartionGoods(
    IN inUnitId         Integer   , -- *������������� �������������
    IN inStorageId      Integer   , -- *����� ��������
    IN inInvNumber      TVarChar  , -- *����������� �����
    IN inOperDate       TDateTime   -- *���� ����� � ������������
)
  RETURNS Integer AS
$BODY$
   DECLARE vbPartionGoodsId Integer;
BEGIN
     -- � ���� ������ ������ �� �����
     -- + �����������, ���� ���� ����� �� �����
     IF 1 = 1 OR (COALESCE (inUnitId_Partion, 0) = 0 AND COALESCE (inGoodsId, 0) = 0)
     THEN
         -- RETURN (80132); -- !!!������ ������!!!
         RETURN (0);
     END IF;


     RAISE EXCEPTION '������.���� �� �����������.';

     -- ��������
     IF inUnitId_Partion IS NULL
     THEN
         RAISE EXCEPTION '������.�� ���������� <���������������>.';
     END IF;
     -- ��������
     IF inGoodsId IS NULL
     THEN
         RAISE EXCEPTION 'lpInsertFind_Object_PartionGoods: inGoodsId IS NULL';
     END IF;

     -- ������ ��������
     IF COALESCE (inInvNumber, '') = ''
     THEN
         inInvNumber:= '0';
     END IF;
     -- ������ ��������
     IF inOperDate IN (zc_DateStart(), zc_DateEnd())
     THEN
         inOperDate:= NULL;
     END IF;


     IF COALESCE (inStorageId, 0) = 0
     THEN 
         IF inOperDate IS NULL
         THEN 
             -- ������� �� ��-���: ����� + ���� �����������=NULL + ����������� ����� + ����� ����� + ����� ��������=NULL
             vbPartionGoodsId:= (SELECT ObjectLink_Goods.ObjectId
                                 FROM ObjectLink AS ObjectLink_Goods
                                      INNER JOIN ObjectDate ON ObjectDate.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectDate.DescId = zc_ObjectDate_PartionGoods_Value()
                                                           AND ObjectDate.ValueData IS NULL
                                      INNER JOIN Object ON Object.Id = ObjectLink_Goods.ObjectId
                                                       AND Object.ValueData = inInvNumber
                                      INNER JOIN ObjectLink AS ObjectLink_Unit
                                                            ON ObjectLink_Unit.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Unit.DescId = zc_ObjectLink_PartionGoods_Unit()
                                                           AND ObjectLink_Unit.ChildObjectId = inUnitId_Partion
                                      INNER JOIN ObjectLink AS ObjectLink_Storage
                                                            ON ObjectLink_Storage.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Storage.DescId = zc_ObjectLink_PartionGoods_Storage()
                                                           AND ObjectLink_Storage.ChildObjectId IS NULL
                                 WHERE ObjectLink_Goods.ChildObjectId = inGoodsId
                                   AND ObjectLink_Goods.DescId = zc_ObjectLink_PartionGoods_Goods()
                                );
         ELSE
             -- ������� �� ��-���: ����� + ���� ����������� + ����������� ����� + ����� ����� + ����� ��������=NULL
             vbPartionGoodsId:= (SELECT ObjectLink_Goods.ObjectId
                                 FROM ObjectLink AS ObjectLink_Goods
                                      INNER JOIN ObjectDate ON ObjectDate.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectDate.DescId = zc_ObjectDate_PartionGoods_Value()
                                                           AND ObjectDate.ValueData = inOperDate
                                      INNER JOIN Object ON Object.Id = ObjectLink_Goods.ObjectId
                                                       AND Object.ValueData = inInvNumber
                                      INNER JOIN ObjectLink AS ObjectLink_Unit
                                                            ON ObjectLink_Unit.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Unit.DescId = zc_ObjectLink_PartionGoods_Unit()
                                                           AND ObjectLink_Unit.ChildObjectId = inUnitId_Partion
                                      INNER JOIN ObjectLink AS ObjectLink_Storage
                                                            ON ObjectLink_Storage.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Storage.DescId = zc_ObjectLink_PartionGoods_Storage()
                                                           AND ObjectLink_Storage.ChildObjectId IS NULL
                                 WHERE ObjectLink_Goods.ChildObjectId = inGoodsId
                                   AND ObjectLink_Goods.DescId = zc_ObjectLink_PartionGoods_Goods()
                                );
         END IF;
     ELSE 
         IF inOperDate IS NULL
         THEN 
             -- ������� �� ��-���: ����� + ���� �����������=NULL + ����������� ����� + ����� ����� + ����� ��������
             vbPartionGoodsId:= (SELECT ObjectLink_Goods.ObjectId
                                 FROM ObjectLink AS ObjectLink_Goods
                                      INNER JOIN ObjectDate ON ObjectDate.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectDate.DescId = zc_ObjectDate_PartionGoods_Value()
                                                           AND ObjectDate.ValueData IS NULL
                                      INNER JOIN Object ON Object.Id = ObjectLink_Goods.ObjectId
                                                       AND Object.ValueData = inInvNumber
                                      INNER JOIN ObjectLink AS ObjectLink_Unit
                                                            ON ObjectLink_Unit.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Unit.DescId = zc_ObjectLink_PartionGoods_Unit()
                                                           AND ObjectLink_Unit.ChildObjectId = inUnitId_Partion
                                      INNER JOIN ObjectLink AS ObjectLink_Storage
                                                            ON ObjectLink_Storage.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Storage.DescId = zc_ObjectLink_PartionGoods_Storage()
                                                           AND ObjectLink_Storage.ChildObjectId = inStorageId
                                 WHERE ObjectLink_Goods.ChildObjectId = inGoodsId
                                   AND ObjectLink_Goods.DescId = zc_ObjectLink_PartionGoods_Goods()
                                );
         ELSE
             -- ������� �� ��-���: ����� + ���� ����������� + ����������� ����� + ����� ����� + ����� ��������
             vbPartionGoodsId:= (SELECT ObjectLink_Goods.ObjectId
                                 FROM ObjectLink AS ObjectLink_Goods
                                      INNER JOIN ObjectDate ON ObjectDate.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectDate.DescId = zc_ObjectDate_PartionGoods_Value()
                                                           AND ObjectDate.ValueData = inOperDate
                                      INNER JOIN Object ON Object.Id = ObjectLink_Goods.ObjectId
                                                       AND Object.ValueData = inInvNumber
                                      INNER JOIN ObjectLink AS ObjectLink_Unit
                                                            ON ObjectLink_Unit.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Unit.DescId = zc_ObjectLink_PartionGoods_Unit()
                                                           AND ObjectLink_Unit.ChildObjectId = inUnitId_Partion
                                      INNER JOIN ObjectLink AS ObjectLink_Storage
                                                            ON ObjectLink_Storage.ObjectId = ObjectLink_Goods.ObjectId
                                                           AND ObjectLink_Storage.DescId = zc_ObjectLink_PartionGoods_Storage()
                                                           AND ObjectLink_Storage.ChildObjectId = inStorageId
                                 WHERE ObjectLink_Goods.ChildObjectId = inGoodsId
                                   AND ObjectLink_Goods.DescId = zc_ObjectLink_PartionGoods_Goods()
                                );
         END IF;
     END IF;

     -- ���� �� �����
     IF COALESCE (vbPartionGoodsId, 0) = 0
     THEN
         -- ��������� <����������� �����>
         vbPartionGoodsId := lpInsertUpdate_Object (vbPartionGoodsId, zc_Object_PartionGoods(), 0, inInvNumber);

         -- ��������� <�������������(��� ����)>
         PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_PartionGoods_Unit(), vbPartionGoodsId, inUnitId_Partion);
         -- ��������� <�����>
         PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_PartionGoods_Goods(), vbPartionGoodsId, inGoodsId);
         -- ��������� <����� ��������>
         PERFORM lpInsertUpdate_ObjectLink (zc_ObjectLink_PartionGoods_Storage(), vbPartionGoodsId, CASE WHEN inStorageId = 0 THEN NULL ELSE inStorageId END);

         -- ��������� <���� �����������>
         PERFORM lpInsertUpdate_ObjectDate (zc_ObjectDate_PartionGoods_Value(), vbPartionGoodsId, inOperDate);
         -- ��������� <����>
         PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_PartionGoods_Price(), vbPartionGoodsId, inPrice);
     END IF;

     -- ���������� ��������
     RETURN (vbPartionGoodsId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertFind_Object_PartionGoods (Integer, Integer, Integer, TVarChar, TDateTime, TFloat) OWNER TO postgres;


/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 26.07.14                                        *
*/

-- ����
-- SELECT * FROM lpInsertFind_Object_PartionGoods ();
