-- Function: lpInsertUpdate_ContainerCount_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer)

DROP FUNCTION IF EXISTS lpInsertUpdate_ContainerCount_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer, Integer, Integer);

CREATE OR REPLACE FUNCTION lpInsertUpdate_ContainerCount_Goods (
    IN inOperDate               TDateTime, 
    IN inUnitId                 Integer , 
    IN inCarId                  Integer , 
    IN inMemberId               Integer , 
    IN inInfoMoneyDestinationId Integer , 
    IN inGoodsId                Integer , 
    IN inGoodsKindId            Integer , 
    IN inIsPartionCount         Boolean , 
    IN inPartionGoodsId         Integer , 
    IN inAssetId                Integer , 
    IN inBranchId               Integer , -- ��� ��������� ����� ��� �������
    IN inAccountId              Integer   -- ��� ��������� ����� ��� "����� � ���� / ����������� �����"
)
  RETURNS Integer
AS
$BODY$
   DECLARE vbContainerId Integer;
BEGIN

     -- 70000 ����������: ����������� ���������� + ����������� ������ + ������������ ���������� + ����������� �������������
     IF inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_70100(), zc_Enum_InfoMoneyDestination_70200(), zc_Enum_InfoMoneyDestination_70300(), zc_Enum_InfoMoneyDestination_70400()
                                    )
    AND inPartionGoodsId <> 0
     THEN
         -- !!!��������!!!
         inAccountId:= 0;

                           -- 0)����� ��� �� 1)�������������  2)������ ������ 3)�������� �������� (��� �������� ��������� �� ��� ���)
                           -- 0)����� ��� �� 1)���. ���� (��) 2)������ ������ 3)�������� �������� (��� �������� ��������� �� ��� ���)
                           -- 0)����� ��� �� 1)����������     2)������ ������ 3)�������� �������� (��� �������� ��������� �� ��� ���)
          vbContainerId := lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN inCarId <> 0 THEN zc_ContainerLinkObject_Car() WHEN inMemberId <> 0 THEN zc_ContainerLinkObject_Member() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN inCarId <> 0 THEN inCarId                      WHEN inMemberId <> 0 THEN inMemberId                      ELSE CASE WHEN inUnitId <> 0 THEN inUnitId ELSE zc_Juridical_Basis() END END
                                                 , inDescId_2          := zc_ContainerLinkObject_PartionGoods()
                                                 , inObjectId_2        := inPartionGoodsId
                                                 , inDescId_3          := zc_ContainerLinkObject_AssetTo()
                                                 , inObjectId_3        := inAssetId
                                                  );

     ELSE
     -- 10100 ������ �����
     IF inInfoMoneyDestinationId = zc_Enum_InfoMoneyDestination_10100()
          -- 0)����� 1)������������� 2)!������ ������! 3)��� ������ - �� ������ 4)���� - �� ������
          -- 0)����� 1)���. ���� (��) 2)!������ ������! 3)��� ������ - �� ������ 4)���� - �� ������
     THEN vbContainerId := lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := zc_ContainerLinkObject_PartionGoods()
                                                 , inObjectId_1        := inPartionGoodsId -- CASE WHEN inIsPartionCount THEN inPartionGoodsId ELSE 0 END
                                                 , inDescId_2          := CASE WHEN COALESCE (inMemberId, 0) <> 0 THEN zc_ContainerLinkObject_Member() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_2        := CASE WHEN COALESCE (inMemberId, 0) <> 0 THEN inMemberId                      ELSE CASE WHEN inUnitId <> 0 THEN inUnitId ELSE zc_Juridical_Basis() END END
                                                 , inDescId_3          := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN zc_ContainerLinkObject_Account() ELSE NULL END
                                                 , inObjectId_3        := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN inAccountId ELSE NULL END
                                                 , inDescId_4          := CASE WHEN COALESCE (inGoodsKindId, 0) IN (0, zc_GoodsKind_Basis()) THEN NULL ELSE zc_ContainerLinkObject_GoodsKind() END
                                                 , inObjectId_4        := CASE WHEN COALESCE (inGoodsKindId, 0) IN (0, zc_GoodsKind_Basis()) THEN NULL ELSE inGoodsKindId END
                                                  );
     ELSE
     -- 20400 ��� + 70000 ����������: ����������� ���������� + ����������� ������ + ������������ ���������� + ����������� �������������
     IF inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20400()
                                   , zc_Enum_InfoMoneyDestination_70100(), zc_Enum_InfoMoneyDestination_70200(), zc_Enum_InfoMoneyDestination_70300(), zc_Enum_InfoMoneyDestination_70400()
                                    )
                           -- 0)����� 1)������������� 2)�������� ��������(��� �������� ��������� ���)
                           -- 0)����� 1)���. ���� (��) 2)�������� ��������(��� �������� ��������� ���)
     THEN vbContainerId := lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN inCarId <> 0 THEN zc_ContainerLinkObject_Car() WHEN inMemberId <> 0 THEN zc_ContainerLinkObject_Member() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN inCarId <> 0 THEN inCarId                      WHEN inMemberId <> 0 THEN inMemberId                      ELSE CASE WHEN inUnitId <> 0 THEN inUnitId ELSE zc_Juridical_Basis() END END
                                                 , inDescId_2          := zc_ContainerLinkObject_AssetTo()
                                                 , inObjectId_2        := inAssetId
                                                 , inDescId_3          := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN zc_ContainerLinkObject_Account() ELSE NULL END
                                                 , inObjectId_3        := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN inAccountId ELSE NULL END
                                                  );
     ELSE
     -- 20100 �������� � �������
     IF inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20100())
                           -- 0)����� 1)���������� / ���.����(��) / ������������� 2)�������� ��������(��� �������� ��������� ���) 3) ������
     THEN vbContainerId := lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN inCarId <> 0 THEN zc_ContainerLinkObject_Car() WHEN inMemberId <> 0 THEN zc_ContainerLinkObject_Member() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN inCarId <> 0 THEN inCarId                      WHEN inMemberId <> 0 THEN inMemberId                      ELSE CASE WHEN inUnitId <> 0 THEN inUnitId ELSE zc_Juridical_Basis() END END
                                                 , inDescId_2          := zc_ContainerLinkObject_AssetTo()
                                                 , inObjectId_2        := inAssetId
                                                 , inDescId_3          := CASE WHEN inMemberId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                 , inObjectId_3        := CASE WHEN inMemberId <> 0 THEN inPartionGoodsId                      ELSE NULL END
                                                 , inDescId_4          := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN zc_ContainerLinkObject_Account() ELSE NULL END
                                                 , inObjectId_4        := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN inAccountId ELSE NULL END
                                                  );
     ELSE
     -- 20200 ������ ��� + 20300 ����
     IF inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20200(), zc_Enum_InfoMoneyDestination_20300())
          -- 0)����� 1)���������� / ������������� 2)���. ����(��) 3)!������ ������!
     THEN vbContainerId := lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN inCarId <> 0 THEN zc_ContainerLinkObject_Car() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN inCarId <> 0 THEN inCarId                      ELSE COALESCE (inUnitId, 0)        END
                                                 , inDescId_2          := zc_ContainerLinkObject_Member()
                                                 , inObjectId_2        := inMemberId
                                                 , inDescId_3          := zc_ContainerLinkObject_PartionGoods()
                                                 , inObjectId_3        := inPartionGoodsId
                                                 , inDescId_4          := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN zc_ContainerLinkObject_Account() ELSE NULL END
                                                 , inObjectId_4        := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN inAccountId ELSE NULL END
                                                  );
     ELSE
     -- 20700 ������ + 20900 ���� + 30100 ��������� + 30200 ������ �����
     IF inInfoMoneyDestinationId IN (zc_Enum_InfoMoneyDestination_20700(), zc_Enum_InfoMoneyDestination_20900(), zc_Enum_InfoMoneyDestination_30100(), zc_Enum_InfoMoneyDestination_30200())
          -- 0)����� 1)�������������  2)��� ������ 3)!!!������ ������!!!
          -- 0)����� 1)���. ���� (��) 2)��� ������ 3)!!!������ ������!!!
     THEN vbContainerId := lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN COALESCE (inMemberId, 0) <> 0 THEN zc_ContainerLinkObject_Member() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN COALESCE (inMemberId, 0) <> 0 THEN inMemberId                      ELSE CASE WHEN inUnitId <> 0 THEN inUnitId ELSE zc_Juridical_Basis() END END
                                                 , inDescId_2          := zc_ContainerLinkObject_GoodsKind()
                                                 , inObjectId_2        := CASE WHEN COALESCE (inBranchId, 0) IN (0
                                                                                                               , zc_Branch_Basis()
                                                                                                               , 8374   -- !!!+ ������ ������!!!    select * from Object where ObjectCode=4 and DescId = zc_Object_Branch()
                                                                                                               , 8376   -- !!!+ ������ ����!!!      select * from Object where ObjectCode=6 and DescId = zc_Object_Branch()
                                                                                                               , 18342  -- !!!+ ������ ��������!!!  select * from Object where ObjectCode=10 and DescId = zc_Object_Branch()
                                                                                                               , 301310 -- !!!+ ������ ���������!!! select * from Object where ObjectCode=11 and DescId = zc_Object_Branch()
                                                                                                                )
                                                                                    THEN inGoodsKindId
                                                                               WHEN inOperDate >= '01.11.2015' AND inBranchId IN (
                                                                                                                 8381 -- ������ �������
                                                                                                               , 8377 -- ������ ��.���
                                                                                                               , 8375 -- ������ �������� (����������)
                                                                                                               , 8373 -- ������ �������� (������)
                                                                                                               -- , 8379 -- ������ ����
                                                                                                                )
                                                                                    THEN inGoodsKindId
                                                                               WHEN inOperDate >= '01.01.2016' AND inBranchId IN (
                                                                                                                 8379 -- ������ ����
                                                                                                                )
                                                                                    THEN inGoodsKindId
                                                                               ELSE 0
                                                                          END 
                                                 , inDescId_3          := CASE WHEN inPartionGoodsId <> 0 THEN zc_ContainerLinkObject_PartionGoods() ELSE NULL END
                                                 , inObjectId_3        := CASE WHEN inPartionGoodsId <> 0 THEN inPartionGoodsId ELSE NULL END
                                                 , inDescId_4          := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN zc_ContainerLinkObject_Account() ELSE NULL END
                                                 , inObjectId_4        := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN inAccountId ELSE NULL END
                                                  );
     -- !!!Other!!!
          -- 0)����� 1)�������������
          -- 0)����� 1)���. ���� (��)
     ELSE vbContainerId := lpInsertFind_Container (inContainerDescId   := zc_Container_Count()
                                                 , inParentId          := NULL
                                                 , inObjectId          := inGoodsId
                                                 , inJuridicalId_basis := NULL
                                                 , inBusinessId        := NULL
                                                 , inObjectCostDescId  := NULL
                                                 , inObjectCostId      := NULL
                                                 , inDescId_1          := CASE WHEN COALESCE (inMemberId, 0) <> 0 THEN zc_ContainerLinkObject_Member() ELSE zc_ContainerLinkObject_Unit() END
                                                 , inObjectId_1        := CASE WHEN COALESCE (inMemberId, 0) <> 0 THEN inMemberId                      ELSE CASE WHEN inUnitId <> 0 THEN inUnitId ELSE zc_Juridical_Basis() END END
                                                 , inDescId_2          := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN zc_ContainerLinkObject_Account() ELSE NULL END
                                                 , inObjectId_2        := CASE WHEN COALESCE (inAccountId, 0) <> 0 THEN inAccountId ELSE NULL END
                                                   );
     END IF;
     END IF;
     END IF;
     END IF;
     END IF;
     END IF;

     -- ���������� ��������
     RETURN (vbContainerId);

END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION lpInsertUpdate_ContainerCount_Goods (TDateTime, Integer, Integer, Integer, Integer, Integer, Integer, Boolean, Integer, Integer, Integer, Integer) OWNER TO postgres;

/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.
 20.11.14                                        * add inAccountId
 08.11.14                                        * add !!!+ ������ ���������!!
 17.08.14                                        * add inPartionGoodsId always
 27.07.14                                        * add ����
 18.03.14                                        * add zc_Enum_InfoMoneyDestination_30200
 21.12.13                                        * Personal -> Member
 11.10.13                                        * add zc_Enum_InfoMoneyDestination_20400
 30.09.13                                        * add inCarId
 19.09.13                                        * sort by optimize
 17.09.13                                        * CASE -> IF
 16.09.13                                        *
*/

-- ����
-- SELECT * FROM lpInsertUpdate_ContainerCount_Goods ()