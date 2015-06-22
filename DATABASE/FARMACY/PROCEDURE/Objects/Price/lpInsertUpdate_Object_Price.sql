 -- Function: lpComplete_Movement_Income (Integer, Integer)

DROP FUNCTION IF EXISTS lpInsertUpdate_Object_Price (Integer, Integer, TFloat, Integer);
DROP FUNCTION IF EXISTS lpInsertUpdate_Object_Price (Integer, Integer, TFloat, TDateTime, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_Object_Price(
    IN inGoodsId        Integer  , -- �� ������
    IN inUnitId         Integer,   -- �� �������������
    IN inPrice          tFloat,    -- ����
    IN inDate           TDateTime, -- ���� ���������
    IN inUserId         Integer    -- ������������
)
RETURNS VOID
AS
$BODY$
  DECLARE vbId Integer;
  DECLARE vbPrice_Value TFloat;
  DECLARE vbDateChange TDateTime;
BEGIN
  -- ���� ����� ������ ���� - ������� � ����� ����.-�����
  SELECT
    Id, price, DateChange INTO vbId, vbPrice_Value, vbDateChange
  from Object_Price_View
  Where
    GoodsId = inGoodsId
    AND
    UnitId = inUnitID;
  IF COALESCE(vbId,0)=0
  THEN
    -- ���������/�������� <������> �� ��
    vbId := lpInsertUpdate_Object (vbId, zc_Object_Price(), 0, '');

    -- ��������� ����� � <�����>
    PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Price_Goods(), vbId, inGoodsId);

    -- ��������� ����� � <�������������>
    PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_Price_Unit(), vbId, inUnitId);
  END IF;
  
  IF (vbDateChange is null or inDate >= vbDateChange)
  THEN
    IF COALESCE(vbPrice_Value,0) <> inPrice
	THEN
      -- ��������� ��-�� < ���� >
      PERFORM lpInsertUpdate_objectFloat(zc_ObjectFloat_Price_Value(), vbId, inPrice);
	END IF;

    -- ��������� ��-�� < ���� ��������� >
    PERFORM lpInsertUpdate_objectDate(zc_ObjectDate_Price_DateChange(), vbId, inDate);

    -- ��������� ��������
    PERFORM lpInsert_ObjectProtocol (vbId, inUserId);
  END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 11.02.14                        *
 05.02.14                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_Object_Price (inGoodsId := 1, inUnitId := 1, inPrice := 10.0, inUserId := 3)