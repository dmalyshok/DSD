CREATE OR REPLACE FUNCTION zc_MIContainer_Count() RETURNS integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementItemContainerDesc WHERE Code = 'zc_MIContainer_Count'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementItemContainerDesc(Code, ItemName)
  SELECT 'zc_MIContainer_Count', '�������������� ����' WHERE NOT EXISTS (SELECT * FROM MovementItemContainerDesc WHERE Code = 'zc_MIContainer_Count');

CREATE OR REPLACE FUNCTION zc_MIContainer_Summ() RETURNS integer AS $BODY$BEGIN RETURN (SELECT Id FROM MovementItemContainerDesc WHERE Code = 'zc_MIContainer_Summ'); END; $BODY$ LANGUAGE PLPGSQL IMMUTABLE;
INSERT INTO MovementItemContainerDesc(Code, ItemName)
  SELECT 'zc_MIContainer_Summ', '�������� ����' WHERE NOT EXISTS (SELECT * FROM MovementItemContainerDesc WHERE Code = 'zc_MIContainer_Summ');

/*-------------------------------------------------------------------------------
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.

 10.07.13                                        * rename to zc_MI...
 10.07.13                                        * ����� �����2 - Create and Insert
 07.07.13         * ����� �����
*/

