-- Function: lpInsertFind_ObjectCost

-- DROP FUNCTION lpInsertFind_ObjectCost (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertFind_ObjectCost(
    IN inObjectCostDescId        Integer               , -- DescId ��� <������� �/�>
    IN inDescId_1                Integer  DEFAULT NULL , -- DescId ��� 1-�� ���������
    IN inObjectId_1              Integer  DEFAULT NULL , -- ObjectId ��� 1-�� ���������
    IN inDescId_2                Integer  DEFAULT NULL , -- DescId ��� 2-�� ���������
    IN inObjectId_2              Integer  DEFAULT NULL , -- ObjectId ��� 2-�� ���������
    IN inDescId_3                Integer  DEFAULT NULL , -- DescId ��� 3-�� ���������
    IN inObjectId_3              Integer  DEFAULT NULL , -- ObjectId ��� 3-�� ���������
    IN inDescId_4                Integer  DEFAULT NULL , -- DescId ��� 4-�� ���������
    IN inObjectId_4              Integer  DEFAULT NULL , -- ObjectId ��� 4-�� ���������
    IN inDescId_5                Integer  DEFAULT NULL , -- DescId ��� 5-�� ���������
    IN inObjectId_5              Integer  DEFAULT NULL , -- ObjectId ��� 5-�� ���������
    IN inDescId_6                Integer  DEFAULT NULL , -- DescId ��� 6-�� ���������
    IN inObjectId_6              Integer  DEFAULT NULL , -- ObjectId ��� 6-�� ���������
    IN inDescId_7                Integer  DEFAULT NULL , -- DescId ��� 7-�� ���������
    IN inObjectId_7              Integer  DEFAULT NULL , -- ObjectId ��� 7-�� ���������
    IN inDescId_8                Integer  DEFAULT NULL , -- DescId ��� 8-�� ���������
    IN inObjectId_8              Integer  DEFAULT NULL , -- ObjectId ��� 8-�� ���������
    IN inDescId_9                Integer  DEFAULT NULL , -- DescId ��� 9-�� ���������
    IN inObjectId_9              Integer  DEFAULT NULL , -- ObjectId ��� 9-�� ���������
    IN inDescId_10               Integer  DEFAULT NULL , -- DescId ��� 10-�� ���������
    IN inObjectId_10             Integer  DEFAULT NULL   -- ObjectId ��� 10-�� ���������
)
  RETURNS Integer AS
$BODY$
  DECLARE vbObjectCostId Integer;
BEGIN

     BEGIN

     -- �������
     IF inDescId_10 IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_4 ON ObjectCostLink_4.ObjectId           = inObjectId_4
                                                                      AND ObjectCostLink_4.DescId             = inDescId_4
                                                                      AND ObjectCostLink_4.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_4.ObjectCostId       = ObjectCostLink_3.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_5 ON ObjectCostLink_5.ObjectId           = inObjectId_5
                                                                      AND ObjectCostLink_5.DescId             = inDescId_5
                                                                      AND ObjectCostLink_5.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_5.ObjectCostId       = ObjectCostLink_4.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_6 ON ObjectCostLink_6.ObjectId           = inObjectId_6
                                                                      AND ObjectCostLink_6.DescId             = inDescId_6
                                                                      AND ObjectCostLink_6.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_6.ObjectCostId       = ObjectCostLink_5.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_7 ON ObjectCostLink_7.ObjectId           = inObjectId_7
                                                                      AND ObjectCostLink_7.DescId             = inDescId_7
                                                                      AND ObjectCostLink_7.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_7.ObjectCostId       = ObjectCostLink_6.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_8 ON ObjectCostLink_8.ObjectId           = inObjectId_8
                                                                      AND ObjectCostLink_8.DescId             = inDescId_8
                                                                      AND ObjectCostLink_8.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_8.ObjectCostId       = ObjectCostLink_7.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_9 ON ObjectCostLink_9.ObjectId           = inObjectId_9
                                                                      AND ObjectCostLink_9.DescId             = inDescId_9
                                                                      AND ObjectCostLink_9.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_9.ObjectCostId       = ObjectCostLink_8.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_10 ON ObjectCostLink_10.ObjectId         = inObjectId_10
                                                                       AND ObjectCostLink_10.DescId           = inDescId_10
                                                                       AND ObjectCostLink_10.ObjectCostDescId = inObjectCostDescId
                                                                       AND ObjectCostLink_10.ObjectCostId     = ObjectCostLink_9.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_9  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_4 ON ObjectCostLink_4.ObjectId           = inObjectId_4
                                                                      AND ObjectCostLink_4.DescId             = inDescId_4
                                                                      AND ObjectCostLink_4.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_4.ObjectCostId       = ObjectCostLink_3.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_5 ON ObjectCostLink_5.ObjectId           = inObjectId_5
                                                                      AND ObjectCostLink_5.DescId             = inDescId_5
                                                                      AND ObjectCostLink_5.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_5.ObjectCostId       = ObjectCostLink_4.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_6 ON ObjectCostLink_6.ObjectId           = inObjectId_6
                                                                      AND ObjectCostLink_6.DescId             = inDescId_6
                                                                      AND ObjectCostLink_6.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_6.ObjectCostId       = ObjectCostLink_5.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_7 ON ObjectCostLink_7.ObjectId           = inObjectId_7
                                                                      AND ObjectCostLink_7.DescId             = inDescId_7
                                                                      AND ObjectCostLink_7.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_7.ObjectCostId       = ObjectCostLink_6.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_8 ON ObjectCostLink_8.ObjectId           = inObjectId_8
                                                                      AND ObjectCostLink_8.DescId             = inDescId_8
                                                                      AND ObjectCostLink_8.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_8.ObjectCostId       = ObjectCostLink_7.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_9 ON ObjectCostLink_9.ObjectId           = inObjectId_9
                                                                      AND ObjectCostLink_9.DescId             = inDescId_9
                                                                      AND ObjectCostLink_9.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_9.ObjectCostId       = ObjectCostLink_8.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_8  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_4 ON ObjectCostLink_4.ObjectId           = inObjectId_4
                                                                      AND ObjectCostLink_4.DescId             = inDescId_4
                                                                      AND ObjectCostLink_4.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_4.ObjectCostId       = ObjectCostLink_3.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_5 ON ObjectCostLink_5.ObjectId           = inObjectId_5
                                                                      AND ObjectCostLink_5.DescId             = inDescId_5
                                                                      AND ObjectCostLink_5.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_5.ObjectCostId       = ObjectCostLink_4.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_6 ON ObjectCostLink_6.ObjectId           = inObjectId_6
                                                                      AND ObjectCostLink_6.DescId             = inDescId_6
                                                                      AND ObjectCostLink_6.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_6.ObjectCostId       = ObjectCostLink_5.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_7 ON ObjectCostLink_7.ObjectId           = inObjectId_7
                                                                      AND ObjectCostLink_7.DescId             = inDescId_7
                                                                      AND ObjectCostLink_7.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_7.ObjectCostId       = ObjectCostLink_6.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_8 ON ObjectCostLink_8.ObjectId           = inObjectId_8
                                                                      AND ObjectCostLink_8.DescId             = inDescId_8
                                                                      AND ObjectCostLink_8.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_8.ObjectCostId       = ObjectCostLink_7.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_7  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_4 ON ObjectCostLink_4.ObjectId           = inObjectId_4
                                                                      AND ObjectCostLink_4.DescId             = inDescId_4
                                                                      AND ObjectCostLink_4.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_4.ObjectCostId       = ObjectCostLink_3.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_5 ON ObjectCostLink_5.ObjectId           = inObjectId_5
                                                                      AND ObjectCostLink_5.DescId             = inDescId_5
                                                                      AND ObjectCostLink_5.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_5.ObjectCostId       = ObjectCostLink_4.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_6 ON ObjectCostLink_6.ObjectId           = inObjectId_6
                                                                      AND ObjectCostLink_6.DescId             = inDescId_6
                                                                      AND ObjectCostLink_6.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_6.ObjectCostId       = ObjectCostLink_5.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_7 ON ObjectCostLink_7.ObjectId           = inObjectId_7
                                                                      AND ObjectCostLink_7.DescId             = inDescId_7
                                                                      AND ObjectCostLink_7.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_7.ObjectCostId       = ObjectCostLink_6.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_6  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_4 ON ObjectCostLink_4.ObjectId           = inObjectId_4
                                                                      AND ObjectCostLink_4.DescId             = inDescId_4
                                                                      AND ObjectCostLink_4.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_4.ObjectCostId       = ObjectCostLink_3.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_5 ON ObjectCostLink_5.ObjectId           = inObjectId_5
                                                                      AND ObjectCostLink_5.DescId             = inDescId_5
                                                                      AND ObjectCostLink_5.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_5.ObjectCostId       = ObjectCostLink_4.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_6 ON ObjectCostLink_6.ObjectId           = inObjectId_6
                                                                      AND ObjectCostLink_6.DescId             = inDescId_6
                                                                      AND ObjectCostLink_6.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_6.ObjectCostId       = ObjectCostLink_5.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_5  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_4 ON ObjectCostLink_4.ObjectId           = inObjectId_4
                                                                      AND ObjectCostLink_4.DescId             = inDescId_4
                                                                      AND ObjectCostLink_4.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_4.ObjectCostId       = ObjectCostLink_3.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_5 ON ObjectCostLink_5.ObjectId           = inObjectId_5
                                                                      AND ObjectCostLink_5.DescId             = inDescId_5
                                                                      AND ObjectCostLink_5.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_5.ObjectCostId       = ObjectCostLink_4.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_4  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_4 ON ObjectCostLink_4.ObjectId           = inObjectId_4
                                                                      AND ObjectCostLink_4.DescId             = inDescId_4
                                                                      AND ObjectCostLink_4.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_4.ObjectCostId       = ObjectCostLink_3.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_3  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                               JOIN ObjectCostLink AS ObjectCostLink_3 ON ObjectCostLink_3.ObjectId           = inObjectId_3
                                                                      AND ObjectCostLink_3.DescId             = inDescId_3
                                                                      AND ObjectCostLink_3.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_3.ObjectCostId       = ObjectCostLink_2.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_2  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                               JOIN ObjectCostLink AS ObjectCostLink_2 ON ObjectCostLink_2.ObjectId           = inObjectId_2
                                                                      AND ObjectCostLink_2.DescId             = inDescId_2
                                                                      AND ObjectCostLink_2.ObjectCostDescId   = inObjectCostDescId
                                                                      AND ObjectCostLink_2.ObjectCostId       = ObjectCostLink_1.ObjectCostId
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     ELSE
     IF inDescId_1  IS NOT NULL
     THEN
         vbObjectCostId:=(SELECT ObjectCostLink_1.ObjectCostId
                          FROM ObjectCostLink AS ObjectCostLink_1
                           WHERE ObjectCostLink_1.ObjectId = inObjectId_1
                             AND ObjectCostLink_1.DescId = inDescId_1
                             AND ObjectCostLink_1.ObjectCostDescId = inObjectCostDescId
                          );
     END IF; -- 1
     END IF; -- 2
     END IF; -- 3
     END IF; -- 4
     END IF; -- 5
     END IF; -- 6
     END IF; -- 7
     END IF; -- 8
     END IF; -- 9
     END IF; -- 10

     EXCEPTION
              WHEN invalid_row_count_in_limit_clause
              THEN RAISE EXCEPTION '������ lpInsertFind_ObjectCost : inObjectCostDescId = "%", inDescId_1 = "%", inObjectId_1 = "%", inDescId_2 = "%", inObjectId_2 = "%", inDescId_3 = "%", inObjectId_3 = "%", inDescId_4 = "%", inObjectId_4 = "%", inDescId_5 = "%", inObjectId_5 = "%", inDescId_6 = "%", inObjectId_6 = "%", inDescId_7 = "%", inObjectId_7 = "%", inDescId_8 = "%", inObjectId_8 = "%", inDescId_9 = "%", inObjectId_9 = "%", inDescId_10 = "%", inObjectId_10 = "%"', inObjectCostDescId, inDescId_1, inObjectId_1, inDescId_2, inObjectId_2, inDescId_3, inObjectId_3, inDescId_4, inObjectId_4, inDescId_5, inObjectId_5, inDescId_6, inObjectId_6, inDescId_7, inObjectId_7, inDescId_8, inObjectId_8, inDescId_9, inObjectId_9, inDescId_10, inObjectId_10;
     END;

     -- ���� �� �����, ���������
     IF COALESCE (vbObjectCostId, 0) = 0
     THEN
         -- ������� ����������
         DELETE FROM _tmpObjectCost;

         -- ���������
         INSERT INTO _tmpObjectCost (DescId, ObjectId)
            SELECT inDescId_1, inObjectId_1 WHERE inDescId_1 <> 0
           UNION ALL
            SELECT inDescId_2, inObjectId_2 WHERE inDescId_2 <> 0
           UNION ALL
            SELECT inDescId_3, inObjectId_3 WHERE inDescId_3 <> 0
           UNION ALL
            SELECT inDescId_4, inObjectId_4 WHERE inDescId_4 <> 0
           UNION ALL
            SELECT inDescId_5, inObjectId_5 WHERE inDescId_5 <> 0
           UNION ALL
            SELECT inDescId_6, inObjectId_6 WHERE inDescId_6 <> 0
           UNION ALL
            SELECT inDescId_7, inObjectId_7 WHERE inDescId_7 <> 0
           UNION ALL
            SELECT inDescId_8, inObjectId_8 WHERE inDescId_8 <> 0
           UNION ALL
            SELECT inDescId_9, inObjectId_9 WHERE inDescId_9 <> 0
           UNION ALL
            SELECT inDescId_10, inObjectId_10 WHERE inDescId_10 <> 0
         ;

         -- ���������� ����� ObjectCostId
         SELECT NEXTVAL ('objectcost_id_seq') INTO vbObjectCostId;

         -- �������� ���������
         INSERT INTO ObjectCostLink (DescId, ObjectCostDescId, ObjectCostId, ObjectId)
            SELECT DescId, inObjectCostDescId, vbObjectCostId, ObjectId FROM _tmpObjectCost;

     END IF;  

     -- ���������� ��������
     RETURN (vbObjectCostId);


END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertFind_ObjectCost (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer) OWNER TO postgres;

  
/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 18.07.13                                        * optimize
 10.07.13                                        *
*/

-- ����
/*
CREATE TEMP TABLE _tmpObjectCost (DescId Integer, ObjectId Integer) ON COMMIT DROP;
SELECT * FROM lpInsertFind_ObjectCost (inObjectCostDescId:= zc_ObjectCost_Basis()
                                     , inDescId_1   := zc_ObjectCostLink_Unit()
                                     , inObjectId_1 := 21720
                                     , inDescId_2   := zc_ObjectCostLink_Goods()
                                     , inObjectId_2 := 4341
                                     , inDescId_3   := NULL
                                     , inObjectId_3 := NULL
                                     , inDescId_4   := zc_ObjectCostLink_InfoMoney()
                                     , inObjectId_4 := 23463
                                     , inDescId_5   := zc_ObjectCostLink_InfoMoneyDetail()
                                     , inObjectId_5 := 23463
                                     , inDescId_6:= NULL, inObjectId_6:=NULL, inDescId_7:= NULL, inObjectId_7:=NULL, inDescId_8:= NULL, inObjectId_8:=NULL, inDescId_9:= NULL, inObjectId_9:=NULL, inDescId_10:= NULL, inObjectId_10:=NULL
                                     )
*/
