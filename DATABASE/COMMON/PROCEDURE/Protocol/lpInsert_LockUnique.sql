-- ����� "������" �������� ������������, �.�. ������ ���������� �� ����� ���� �����

DROP FUNCTION IF EXISTS lpInsert_LockUnique (TVarChar, Integer);

CREATE OR REPLACE FUNCTION lpInsert_LockUnique(
    IN inKeyData      TVarChar,
    IN inUserId       Integer
)
RETURNS VOID
AS
$BODY$
BEGIN

     -- ��������
     IF TRIM (COALESCE (inKeyData, '' )) = ''
     THEN 
         RAISE EXCEPTION '������.�������� ���� � �������� ������������ - ������. <%>', inKeyData;
     END IF;

 
     -- �������� ���� ��� �����
     DELETE FROM LockUnique WHERE OperDate < CURRENT_DATE; -- - INTERVAL '1 DAY';


     -- ���� ������ ��������� - ������ ������������ �����������
     INSERT INTO LockUnique (KeyData, UserId, OperDate)
                     VALUES (inKeyData, inUserId, CURRENT_TIMESTAMP);
   
     EXCEPTION
              WHEN OTHERS THEN RAISE EXCEPTION '������.������� ������������ ��������� ������.��������� �������� ����� 1 ���.';

END;           
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsert_LockUnique (TVarChar, Integer) OWNER TO postgres;

/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 12.05.17                                        *
*/

-- ����
-- SELECT * FROM lpInsert_LockUnique (inKeyData:= '123', inUserId:= zfCalc_UserAdmin() :: Integer)
-- SELECT * FROM LockUnique WHERE KeyData like '%DC899%' ORDER BY OperDate DESC
-- SELECT * FROM LockUnique WHERE query like '%FETCH ALL%' AND query_start < CURRENT_TIMESTAMP - INTERVAL '45 SEC' ORDER BY OperDate DESC
