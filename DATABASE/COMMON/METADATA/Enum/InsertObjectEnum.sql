-- ��������� �������
DO $$
BEGIN

   -- ��� ���� ���� ��� �������, �� Enum, �� �����
   IF NOT EXISTS (SELECT * FROM Object WHERE DescId = zc_Object_RateFuelKind())
   THEN
       PERFORM lpInsertUpdate_Object (0, zc_Object_RateFuelKind(), 1, '����');
   END IF;

   -- ��������� ����:
   -- zc_Enum_Role_Admin
   PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Role_Admin(), inDescId:= zc_Object_Role(), inCode:= lfGet_ObjectCode_byEnum ('zc_Enum_Role_Admin'), inName:= '���� ��������������', inEnumName:= 'zc_Enum_Role_Admin');
   -- zc_Enum_Role_Transport
   IF EXISTS (SELECT * FROM Object WHERE DescId = zc_Object_Role() AND ValueData = '���������-���� ����������')
   THEN
       PERFORM lpUpdate_Object_Enum_byCode (inCode   := (SELECT ObjectCode FROM Object WHERE DescId = zc_Object_Role() AND ValueData = '���������-���� ����������')
                                          , inDescId := zc_Object_Role()
                                          , inEnumName:= 'zc_Enum_Role_Transport');
   ELSE
       PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Role_Transport(), inDescId:= zc_Object_Role(), inCode:= lfGet_ObjectCode_byEnum ('zc_Enum_Role_Transport'), inName:= '���������-���� ����������', inEnumName:= 'zc_Enum_Role_Transport');
   END IF;
   -- zc_Enum_Role_Bread
   IF EXISTS (SELECT * FROM Object WHERE DescId = zc_Object_Role() AND ValueData = '����')
   THEN
       PERFORM lpUpdate_Object_Enum_byCode (inCode   := (SELECT ObjectCode FROM Object WHERE DescId = zc_Object_Role() AND ValueData = '����')
                                          , inDescId := zc_Object_Role()
                                          , inEnumName:= 'zc_Enum_Role_Bread');
   ELSE
       PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Role_Bread(), inDescId:= zc_Object_Role(), inCode:= lfGet_ObjectCode_byEnum ('zc_Enum_Role_Bread'), inName:= '����', inEnumName:= 'zc_Enum_Role_Bread');
   END IF;
   -- zc_Enum_Role_1107
   IF EXISTS (SELECT * FROM Object WHERE DescId = zc_Object_Role() AND ObjectCode = 1107)
   THEN
       PERFORM lpUpdate_Object_Enum_byCode (inCode   := 1107
                                          , inDescId := zc_Object_Role()
                                          , inEnumName:= 'zc_Enum_Role_1107');
   ELSE
       PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Role_1107(), inDescId:= zc_Object_Role(), inCode:= 1107, inName:= '���� + ����', inEnumName:= 'zc_Enum_Role_1107');
   END IF;

END $$;
/*
DO $$
DECLARE ioId integer;
BEGIN

   IF NOT EXISTS(SELECT * FROM OBJECT
   JOIN ObjectLink AS RoleRight_Role
     ON RoleRight_Role.descid = zc_ObjectLink_RoleRight_Role()
    AND RoleRight_Role.childobjectid = zc_Enum_Role_Admin()
    AND RoleRight_Role.objectid = OBJECT.id

   JOIN ObjectLink AS RoleRight_Process
     ON RoleRight_Process.descid = zc_ObjectLink_RoleRight_Process()
    AND RoleRight_Process.childobjectid = zc_Enum_Process_InsertUpdate_Object_User()
    AND RoleRight_Process.objectid = OBJECT.id
  WHERE OBJECT.descid = zc_Object_RoleRight()) THEN
     -- ������� ����� ���� ��������������
     ioId := lpInsertUpdate_Object(ioId, zc_Object_RoleRight(), 0, '');
     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_RoleRight_Role(), ioId, zc_Enum_Role_Admin());
     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_RoleRight_Process(), ioId, zc_Enum_Process_InsertUpdate_Object_User());
   END IF;

END $$;
*/
DO $$
DECLARE ioId integer;
DECLARE UserId integer;
BEGIN
   -- ������ �������� �������� ���������� ������ ��� �� ��������� �������� ����!!!
   SELECT Id INTO UserId FROM Object WHERE DescId = zc_Object_User() AND ValueData = '�����';

   IF COALESCE(UserId, 0) = 0 THEN
     -- ������� ��������������
     UserId := lpInsertUpdate_Object(0, zc_Object_User(), 0, '�����');

     PERFORM lpInsertUpdate_ObjectString(zc_ObjectString_User_Password(), UserId, '�����');
   END IF;

   IF NOT EXISTS(SELECT * FROM OBJECT

     JOIN ObjectLink AS UserRole_Role
       ON UserRole_Role.descid = zc_ObjectLink_UserRole_Role()
      AND UserRole_Role.childobjectid = zc_Enum_Role_Admin()
      AND UserRole_Role.objectid = OBJECT.id

     JOIN ObjectLink AS UserRole_User
       ON UserRole_User.descid = zc_ObjectLink_UserRole_User()
      AND UserRole_User.childobjectid = UserId
      AND UserRole_User.objectid = OBJECT.id
  WHERE OBJECT.descid = zc_Object_UserRole()) THEN

     -- ��������� ������������ � �����
     ioId := lpInsertUpdate_Object(ioId, zc_Object_UserRole(), 0, '');

     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_UserRole_Role(), ioId, zc_Enum_Role_Admin());

     PERFORM lpInsertUpdate_ObjectLink(zc_ObjectLink_UserRole_User(), ioId, UserId);
   END IF;
END $$;


DO $$
BEGIN

     -- !!! ������
     IF zc_Enum_Currency_Basis() IS NULL
     THEN IF EXISTS (SELECT Id FROM Object WHERE DescId = zc_Object_Currency() AND ObjectCode = 980)
          THEN PERFORM lpUpdate_Object_Enum_byCode (inCode:= 980,  inDescId:= zc_Object_Currency(), inEnumName:= 'zc_Enum_Currency_Basis');
          -- ELSE PERFORM lpInsertUpdate_Object_Enum (inId:=zc_Enum_Currency_Basis(),  inDescId:= zc_Object_Currency(), inCode:= 980, inName:= '���', inEnumName:= 'zc_Enum_Currency_Basis');
          END IF;
     END IF;
     


     -- !!! ���� �������� ��� ��������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleCount_10400(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 101, inName:= '���-��, ����������, � ����������', inEnumName:= 'zc_Enum_AnalyzerId_SaleCount_10400');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleCount_10500(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 102, inName:= '���-��, ����������, ������ �� ���', inEnumName:= 'zc_Enum_AnalyzerId_SaleCount_10500');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleCount_40200(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 103, inName:= '���-��, ����������, ������� � ����', inEnumName:= 'zc_Enum_AnalyzerId_SaleCount_40200');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleSumm_10400(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 111, inName:= '����� �/�, ����������, � ����������', inEnumName:= 'zc_Enum_AnalyzerId_SaleSumm_10400');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleSumm_10500(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 112, inName:= '����� �/�, ����������, ������ �� ���', inEnumName:= 'zc_Enum_AnalyzerId_SaleSumm_10500');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleSumm_40200(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 113, inName:= '����� �/�, ����������, ������� � ����', inEnumName:= 'zc_Enum_AnalyzerId_SaleSumm_40200');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleSumm_10100(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 121, inName:= '�����, ����������, � ����������', inEnumName:= 'zc_Enum_AnalyzerId_SaleSumm_10100');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleSumm_10200(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 122, inName:= '�����, ����������, ������� � �������� ������(�����)', inEnumName:= 'zc_Enum_AnalyzerId_SaleSumm_10200');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_SaleSumm_10300(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 123, inName:= '�����, ����������, ������ ��������������', inEnumName:= 'zc_Enum_AnalyzerId_SaleSumm_10300');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_ReturnInCount_10800(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 201, inName:= '���-��, �������, �� ����������', inEnumName:= 'zc_Enum_AnalyzerId_ReturnInCount_10800');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_ReturnInCount_40200(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 202, inName:= '���-��, �������, ������� � ����', inEnumName:= 'zc_Enum_AnalyzerId_ReturnInCount_40200');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_ReturnInSumm_10800(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 211, inName:= '����� �/�, �������, �� ���������� ', inEnumName:= 'zc_Enum_AnalyzerId_ReturnInSumm_10800');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_ReturnInSumm_40200(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 212, inName:= '����� �/�, �������, ������� � ����', inEnumName:= 'zc_Enum_AnalyzerId_ReturnInSumm_40200');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_ReturnInSumm_10700(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 221, inName:= '�����, �������, �� ����������', inEnumName:= 'zc_Enum_AnalyzerId_ReturnInSumm_10700');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_ReturnInSumm_10300(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 222, inName:= '�����, �������, ������ ��������������', inEnumName:= 'zc_Enum_AnalyzerId_ReturnInSumm_10300');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_LossCount_20200(), inDescId:= zc_Object_AnalyzerId(), inCode:= 301, inName:= '���-��, �������� ��� ����������/����������� �� ����', inEnumName:= 'zc_Enum_AnalyzerId_LossCount_20200');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AnalyzerId_LossSumm_20200(),  inDescId:= zc_Object_AnalyzerId(), inCode:= 302, inName:= '����� �/�, �������� ��� ����������/����������� �� ����', inEnumName:= 'zc_Enum_AnalyzerId_LossSumm_20200');

     -- !!! ����� ������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_PaidKind_FirstForm(),  inDescId:= zc_Object_PaidKind(), inCode:= 1, inName:= '��', inEnumName:= 'zc_Enum_PaidKind_FirstForm');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_PaidKind_SecondForm(), inDescId:= zc_Object_PaidKind(), inCode:= 2, inName:= '���', inEnumName:= 'zc_Enum_PaidKind_SecondForm');

     -- !!! ������� ����������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Status_UnComplete(), inDescId:= zc_Object_Status(), inCode:= zc_Enum_StatusCode_UnComplete(), inName:= '�� ��������', inEnumName:= 'zc_Enum_Status_UnComplete');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Status_Complete(), inDescId:= zc_Object_Status(), inCode:= zc_Enum_StatusCode_Complete(), inName:= '��������', inEnumName:= 'zc_Enum_Status_Complete');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Status_Erased(), inDescId:= zc_Object_Status(), inCode:= zc_Enum_StatusCode_Erased(), inName:= '������', inEnumName:= 'zc_Enum_Status_Erased');

     -- !!! ������� ���������� EDI
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_EDIStatus_ORDERS(), inDescId:= zc_Object_EDIStatus(), inCode:= zc_Enum_EDIStatus_ORDERS(), inName:= '�����', inEnumName:= 'zc_Enum_EDIStatus_ORDERS');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_EDIStatus_DESADV(), inDescId:= zc_Object_EDIStatus(), inCode:= zc_Enum_EDIStatus_DESADV(), inName:= '���������', inEnumName:= 'zc_Enum_EDIStatus_DESADV');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_EDIStatus_COMDOC(), inDescId:= zc_Object_EDIStatus(), inCode:= zc_Enum_EDIStatus_COMDOC(), inName:= '��������', inEnumName:= 'zc_Enum_EDIStatus_COMDOC');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_EDIStatus_DECLAR(), inDescId:= zc_Object_EDIStatus(), inCode:= zc_Enum_EDIStatus_DECLAR(), inName:= '���������', inEnumName:= 'zc_Enum_EDIStatus_DECLAR');
    
     -- !!! ��� ��������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContactPersonKind_CreateOrder(), inDescId:= zc_Object_ContactPersonKind(), inCode:= 1, inName:= '������������ �������', inEnumName:= 'zc_Enum_ContactPersonKind_CreateOrder');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContactPersonKind_CheckDocument(), inDescId:= zc_Object_ContactPersonKind(), inCode:= 2, inName:= '�������� ����������', inEnumName:= 'zc_Enum_ContactPersonKind_CheckDocument');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContactPersonKind_AktSverki(), inDescId:= zc_Object_ContactPersonKind(), inCode:= 3, inName:= '���� ������ � ���������� �����', inEnumName:= 'zc_Enum_ContactPersonKind_AktSverki');

     -- !!! ���� ������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AccountKind_Active(), inDescId:= zc_Object_AccountKind(), inCode:= 1, inName:= '��������', inEnumName:= 'zc_Enum_AccountKind_Active');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AccountKind_Passive(), inDescId:= zc_Object_AccountKind(), inCode:= 1, inName:= '���������', inEnumName:= 'zc_Enum_AccountKind_Passive');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_AccountKind_All(), inDescId:= zc_Object_AccountKind(), inCode:= 1, inName:= '�������/���������', inEnumName:= 'zc_Enum_AccountKind_All');

     -- !!! ���� ���������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_RouteKind_Internal(), inDescId:= zc_Object_RouteKind(), inCode:= 1, inName:= '�����', inEnumName:= 'zc_Enum_RouteKind_Internal');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_RouteKind_External(), inDescId:= zc_Object_RouteKind(), inCode:= 2, inName:= '��������', inEnumName:= 'zc_Enum_RouteKind_External');

     -- !!! ���� �������� �������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Work(),      inDescId:= zc_Object_WorkTimeKind(), inCode:= 1, inName:= '������� ����'  , inEnumName:= 'zc_Enum_WorkTimeKind_Work');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Holiday(),   inDescId:= zc_Object_WorkTimeKind(), inCode:= 2, inName:= '������'        , inEnumName:= 'zc_Enum_WorkTimeKind_Holiday');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Hospital(),  inDescId:= zc_Object_WorkTimeKind(), inCode:= 3, inName:= '����������'    , inEnumName:= 'zc_Enum_WorkTimeKind_Hospital');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Skip(),      inDescId:= zc_Object_WorkTimeKind(), inCode:= 4, inName:= '������'        , inEnumName:= 'zc_Enum_WorkTimeKind_Skip');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Trainee50(), inDescId:= zc_Object_WorkTimeKind(), inCode:= 5, inName:= '������50%'     , inEnumName:= 'zc_Enum_WorkTimeKind_Trainee50');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Trainee(),   inDescId:= zc_Object_WorkTimeKind(), inCode:= 6, inName:= '������'        , inEnumName:= 'zc_Enum_WorkTimeKind_Trainee');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Quit(),      inDescId:= zc_Object_WorkTimeKind(), inCode:= 7, inName:= '����������'    , inEnumName:= 'zc_Enum_WorkTimeKind_Quit');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_Trial(),     inDescId:= zc_Object_WorkTimeKind(), inCode:= 8, inName:= '������� �����' , inEnumName:= 'zc_Enum_WorkTimeKind_Trial');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_WorkTimeKind_DayOff(),    inDescId:= zc_Object_WorkTimeKind(), inCode:= 9, inName:= '��������'      , inEnumName:= 'zc_Enum_WorkTimeKind_DayOff');

     -- !!! ���� ������������ ���������� ���������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_Tax(),      		 inDescId:= zc_Object_DocumentTaxKind(), inCode:= 1, inName:= '���������', inEnumName:= 'zc_Enum_DocumentTaxKind_Tax');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_TaxSummaryJuridicalS(),  inDescId:= zc_Object_DocumentTaxKind(), inCode:= 2, inName:= '������� ��������� �� ��.�.(����������)', inEnumName:= 'zc_Enum_DocumentTaxKind_TaxSummaryJuridicalS');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_TaxSummaryJuridicalSR(), inDescId:= zc_Object_DocumentTaxKind(), inCode:= 3, inName:= '������� ��������� �� ��.�.(����������-��������)', inEnumName:= 'zc_Enum_DocumentTaxKind_TaxSummaryJuridicalSR');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_TaxSummaryPartnerS(), 	 inDescId:= zc_Object_DocumentTaxKind(), inCode:= 4, inName:= '������� ��������� �� �.�.(����������)', inEnumName:= 'zc_Enum_DocumentTaxKind_TaxSummaryPartnerS');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_TaxSummaryPartnerSR(), 	 inDescId:= zc_Object_DocumentTaxKind(), inCode:= 5, inName:= '������� ��������� �� �.�.(����������-��������)', inEnumName:= 'zc_Enum_DocumentTaxKind_TaxSummaryPartnerSR');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_Corrective(), 	 		inDescId:= zc_Object_DocumentTaxKind(), inCode:= 6, inName:= '�������������', inEnumName:= 'zc_Enum_DocumentTaxKind_Corrective');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalR(),  inDescId:= zc_Object_DocumentTaxKind(), inCode:= 7, inName:= '������� ������������� �� ��.�.(��������)' , inEnumName:= 'zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalR');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalSR(), inDescId:= zc_Object_DocumentTaxKind(), inCode:= 8, inName:= '������� ������������� �� ��.�.(����������-��������)' , inEnumName:= 'zc_Enum_DocumentTaxKind_CorrectiveSummaryJuridicalSR');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerR(),    inDescId:= zc_Object_DocumentTaxKind(), inCode:= 9, inName:= '������� ������������� �� �.�.(��������)' , inEnumName:= 'zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerR');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerSR(),   inDescId:= zc_Object_DocumentTaxKind(), inCode:= 10, inName:= '������� ������������� �� �.�.(����������-��������)' , inEnumName:= 'zc_Enum_DocumentTaxKind_CorrectiveSummaryPartnerSR');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_CorrectivePrice(),              inDescId:= zc_Object_DocumentTaxKind(), inCode:= 11, inName:= '�������������� ����', inEnumName:= 'zc_Enum_DocumentTaxKind_CorrectivePrice');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_DocumentTaxKind_Prepay(),                       inDescId:= zc_Object_DocumentTaxKind(), inCode:= 12, inName:= '����������', inEnumName:= 'zc_Enum_DocumentTaxKind_Prepay');

     -- !!! ���� ������� ����������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ModelServiceKind_DaySheetWorkTime(),   inDescId:= zc_Object_ModelServiceKind(), inCode:= 1, inName:= '�� ���� ������'         , inEnumName:= 'zc_Enum_ModelServiceKind_DaySheetWorkTime');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ModelServiceKind_MonthSheetWorkTime(), inDescId:= zc_Object_ModelServiceKind(), inCode:= 2, inName:= '�� ����� ������'        , inEnumName:= 'zc_Enum_ModelServiceKind_MonthSheetWorkTime');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ModelServiceKind_SatSheetWorkTime(),   inDescId:= zc_Object_ModelServiceKind(), inCode:= 3, inName:= '�� �������� ������'     , inEnumName:= 'zc_Enum_ModelServiceKind_SatSheetWorkTime');
   --  PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ModelServiceKind_MonthFundPay(),       inDescId:= zc_Object_ModelServiceKind(), inCode:= 4, inName:= '�� ����� ����/�������'  , inEnumName:= 'zc_Enum_ModelServiceKind_MonthFundPay');
   --  PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ModelServiceKind_TurnFundPay(),        inDescId:= zc_Object_ModelServiceKind(), inCode:= 5, inName:= '�� 1 ����� ����/�������', inEnumName:= 'zc_Enum_ModelServiceKind_TurnFundPay');

     -- !!! ���� ������ ������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_SelectKind_InWeight(),  inDescId:= zc_Object_SelectKind(), inCode:= 1, inName:= '���-�� ������ � ���������� � ���', inEnumName:= 'zc_Enum_SelectKind_InWeight');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_SelectKind_OutWeight(), inDescId:= zc_Object_SelectKind(), inCode:= 2, inName:= '���-�� ������ � ���������� � ���', inEnumName:= 'zc_Enum_SelectKind_OutWeight');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_SelectKind_InAmount(),  inDescId:= zc_Object_SelectKind(), inCode:= 3, inName:= '���-�� ������',                    inEnumName:= 'zc_Enum_SelectKind_InAmount');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_SelectKind_OutAmount(), inDescId:= zc_Object_SelectKind(), inCode:= 4, inName:= '���-�� ������',                    inEnumName:= 'zc_Enum_SelectKind_OutAmount');

     -- !!! ���� ���� ��� �������� ����������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_Month(),           inDescId:= zc_Object_StaffListSummKind(), inCode:= 1, inName:= '���� �� �����'                                           , inEnumName:= 'zc_Enum_StaffListSummKind_Month');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_Day(),             inDescId:= zc_Object_StaffListSummKind(), inCode:= 2, inName:= '������� �� 1 ���� �� ����'                               , inEnumName:= 'zc_Enum_StaffListSummKind_Day');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_Personal(),        inDescId:= zc_Object_StaffListSummKind(), inCode:= 3, inName:= '������� �� 1 ���� �� ��������'                           , inEnumName:= 'zc_Enum_StaffListSummKind_Personal');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_HoursPlan(),       inDescId:= zc_Object_StaffListSummKind(), inCode:= 4, inName:= '���� �� ����� ���� ����� (����������) � ����� �� ��������', inEnumName:= 'zc_Enum_StaffListSummKind_HoursPlan');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_HoursDay(),        inDescId:= zc_Object_StaffListSummKind(), inCode:= 5, inName:= '���� �� ���� ����� (���������) � ����� �� ��������'       , inEnumName:= 'zc_Enum_StaffListSummKind_HoursDay');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_HoursPlanConst(),  inDescId:= zc_Object_StaffListSummKind(), inCode:= 6, inName:= '���� ���������� ��� ���� ����� � ����� �� ��������'       , inEnumName:= 'zc_Enum_StaffListSummKind_HoursPlanConst');
     -- PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_HoursDayConst(),   inDescId:= zc_Object_StaffListSummKind(), inCode:= 7, inName:= '(�� ������������).���� ���������� ��� ���� ����� � ������� ��� �� ��������' , inEnumName:= 'zc_Enum_StaffListSummKind_HoursDayConst');
     -- PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_StaffListSummKind_WorkHours(),       inDescId:= zc_Object_StaffListSummKind(), inCode:= 11,inName:= '(�� ������������).���������� ������� ����� � ����'                          , inEnumName:= 'zc_Enum_StaffListSummKind_WorkHours');


     -- !!! ��������� ��������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractStateKind_Signed(), inDescId:= zc_Object_ContractStateKind(), inCode:= 1, inName:= '��������' , inEnumName:= 'zc_Enum_ContractStateKind_Signed');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractStateKind_UnSigned(), inDescId:= zc_Object_ContractStateKind(), inCode:= 2, inName:= '�� ��������' , inEnumName:= 'zc_Enum_ContractStateKind_UnSigned');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractStateKind_Close(), inDescId:= zc_Object_ContractStateKind(), inCode:= 3, inName:= '��������' , inEnumName:= 'zc_Enum_ContractStateKind_Close');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractStateKind_Partner(), inDescId:= zc_Object_ContractStateKind(), inCode:= 4, inName:= '� �����������' , inEnumName:= 'zc_Enum_ContractStateKind_Partner');
     
     -- !!! ���� ������� ���������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_ChangePercent()         , inDescId:= zc_Object_ContractConditionKind(), inCode:= 1,  inName:= '(-)% ������ (+)% �������'     , inEnumName:= 'zc_Enum_ContractConditionKind_ChangePercent');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_ChangePrice()           , inDescId:= zc_Object_ContractConditionKind(), inCode:= 2,  inName:= '������ � ����'                , inEnumName:= 'zc_Enum_ContractConditionKind_ChangePrice');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_DelayDayCalendar()      , inDescId:= zc_Object_ContractConditionKind(), inCode:= 3,  inName:= '�������� � ����������� ����'               , inEnumName:= 'zc_Enum_ContractConditionKind_DelayDayCalendar');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_DelayDayBank()          , inDescId:= zc_Object_ContractConditionKind(), inCode:= 4,  inName:= '�������� � ���������� ����'                , inEnumName:= 'zc_Enum_ContractConditionKind_DelayDayBank');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_DelayCreditLimit()      , inDescId:= zc_Object_ContractConditionKind(), inCode:= 5,  inName:= '�������� �������� ������'                  , inEnumName:= 'zc_Enum_ContractConditionKind_DelayCreditLimit');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_DelayPrepay()           , inDescId:= zc_Object_ContractConditionKind(), inCode:= 6,  inName:= '����������'                                , inEnumName:= 'zc_Enum_ContractConditionKind_DelayPrepay');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_CreditPercent()         , inDescId:= zc_Object_ContractConditionKind(), inCode:= 11,  inName:= '% �� �������'                      , inEnumName:= 'zc_Enum_ContractConditionKind_CreditPercent');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_CreditLimit()           , inDescId:= zc_Object_ContractConditionKind(), inCode:= 12,  inName:= '����� �������'                     , inEnumName:= 'zc_Enum_ContractConditionKind_CreditLimit');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_CreditPercentService()  , inDescId:= zc_Object_ContractConditionKind(), inCode:= 13,  inName:= '% �� ������/������������ �������'  , inEnumName:= 'zc_Enum_ContractConditionKind_CreditPercentService');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_CreditPercentReceived() , inDescId:= zc_Object_ContractConditionKind(), inCode:= 14,  inName:= '% �� ����� �� �������'             , inEnumName:= 'zc_Enum_ContractConditionKind_CreditPercentReceived');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusPercentSale()      , inDescId:= zc_Object_ContractConditionKind(), inCode:= 21, inName:= '% ������ �� ��������'         , inEnumName:= 'zc_Enum_ContractConditionKind_BonusPercentSale');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusPercentSaleReturn(), inDescId:= zc_Object_ContractConditionKind(), inCode:= 22, inName:= '% ������ �� ��������-�������' , inEnumName:= 'zc_Enum_ContractConditionKind_BonusPercentSaleReturn');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusPercentAccount()   , inDescId:= zc_Object_ContractConditionKind(), inCode:= 23, inName:= '% ������ �� ������'           , inEnumName:= 'zc_Enum_ContractConditionKind_BonusPercentAccount');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusMonthlyPayment()   , inDescId:= zc_Object_ContractConditionKind(), inCode:= 24, inName:= '����� - ����������� ������'   , inEnumName:= 'zc_Enum_ContractConditionKind_BonusMonthlyPayment');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusMonthlyPaymentAdv(), inDescId:= zc_Object_ContractConditionKind(), inCode:= 25, inName:= '������� - ����������� ������'   , inEnumName:= 'zc_Enum_ContractConditionKind_BonusMonthlyPaymentAdv');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusUpSaleSummPVAT()   , inDescId:= zc_Object_ContractConditionKind(), inCode:= 26, inName:= '������ �����,��� ���������� ����� ������ (�� ����� � ���)'   , inEnumName:= 'zc_Enum_ContractConditionKind_BonusUpSaleSummPVAT');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusUpSaleSummMVAT()   , inDescId:= zc_Object_ContractConditionKind(), inCode:= 27, inName:= '������ �����,��� ���������� ����� ������ (�� ����� ��� ���)' , inEnumName:= 'zc_Enum_ContractConditionKind_BonusUpSaleSummMVAT');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_BonusYearlyPayment()    , inDescId:= zc_Object_ContractConditionKind(), inCode:= 28, inName:= '������� ������'               , inEnumName:= 'zc_Enum_ContractConditionKind_BonusYearlyPayment');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_LimitReturn()           , inDescId:= zc_Object_ContractConditionKind(), inCode:= 29, inName:= '����������� �� ���������'     , inEnumName:= 'zc_Enum_ContractConditionKind_LimitReturn');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportTime1()    , inDescId:= zc_Object_ContractConditionKind(), inCode:= 101, inName:= '������ �� ����� (��� ����������� � �������������), ���/�'  , inEnumName:= 'zc_Enum_ContractConditionKind_TransportTime1');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportTime2()    , inDescId:= zc_Object_ContractConditionKind(), inCode:= 102, inName:= '������ �� ����� (� ������������ ��� ������������), ���/�'  , inEnumName:= 'zc_Enum_ContractConditionKind_TransportTime2');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportTime3()    , inDescId:= zc_Object_ContractConditionKind(), inCode:= 103, inName:= '������ �� ����� (��� ����������� ��� ������������), ���/�' , inEnumName:= 'zc_Enum_ContractConditionKind_TransportTime3');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportTime4()    , inDescId:= zc_Object_ContractConditionKind(), inCode:= 104, inName:= '������ �� ����� (� ������������ � �������������), ���/�'   , inEnumName:= 'zc_Enum_ContractConditionKind_TransportTime4');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportDistance() , inDescId:= zc_Object_ContractConditionKind(), inCode:= 105, inName:= '������ �� ������, ���/��'   , inEnumName:= 'zc_Enum_ContractConditionKind_TransportDistance');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportOneTrip()  , inDescId:= zc_Object_ContractConditionKind(), inCode:= 106, inName:= '������ �� ������� � ���� �������, ���'   , inEnumName:= 'zc_Enum_ContractConditionKind_TransportOneTrip');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportRoundTrip(), inDescId:= zc_Object_ContractConditionKind(), inCode:= 107, inName:= '������ �� ������� � ��� �������, ���'   , inEnumName:= 'zc_Enum_ContractConditionKind_TransportRoundTrip');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ContractConditionKind_TransportPoint()    , inDescId:= zc_Object_ContractConditionKind(), inCode:= 108, inName:= '������ �� �����, ���'   , inEnumName:= 'zc_Enum_ContractConditionKind_TransportPoint');


     -- !!! ���� ��������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ReceiptKind_Complete(),  inDescId:= zc_Object_ReceiptKind(), inCode:= 1, inName:= '����������', inEnumName:= 'zc_Enum_ReceiptKind_Complete');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ReceiptKind_Separate(), inDescId:= zc_Object_ReceiptKind(), inCode:= 2, inName:= '����������',  inEnumName:= 'zc_Enum_ReceiptKind_Separate');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ReceiptKind_CompleteEtalon(), inDescId:= zc_Object_ReceiptKind(), inCode:= 3, inName:= '���������� (���������)',inEnumName:= 'zc_Enum_ReceiptKind_CompleteEtalon');


     -- !!!
     -- !!! ���� �������
     -- !!!
     -- PERFORM lpUpdate_Object_Enum_byCode (inCode:= 1,  inDescId:= zc_Object_GoodsKind(), inEnumName:= 'zc_Enum_GoodsKind_Main');

     -- !!!
     -- !!! ������: 1-������� �������������� ������
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_10000');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_20000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_30000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_40000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_50000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_60000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_70000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_80000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 90000,  inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_90000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 100000, inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_100000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 110000, inDescId:= zc_Object_AccountGroup(), inEnumName:= 'zc_Enum_AccountGroup_110000');

     -- !!!
     -- !!! ������: 2-������� �������������� ������
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_10100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_10200');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20300,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20400,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20500,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20600,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20600');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20700,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20700');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20800,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20800');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20900,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_20900');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30150,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30150');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30300,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30400,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30500,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30600,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30600');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30700,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_30700');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_40100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_40200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40300,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_40300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40400,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_40400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40500,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_40500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40600,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_40600');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_60100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_60200');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70300,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70400,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70500,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70700,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70700');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70800,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70800');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70900,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_70900');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 71000,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_71000');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_80100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_80200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80400,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_80400');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 90100,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_90100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 90200,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_90200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 90300,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_90300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 90400,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_90400');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 100400,  inDescId:= zc_Object_AccountDirection(), inEnumName:= 'zc_Enum_AccountDirection_100400');

     -- !!!
     -- !!! ������: �������������� ����� (1+2+3 �������)
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10101, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_10101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10201, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_10201');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20901, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_20901');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30101, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_30101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30151, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_30151');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30201, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_30201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30202, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_30202');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30203, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_30203');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30204, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_30204');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30205, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_30205');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40101, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40201, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40301, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40301');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40302, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40302');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Account_40303(),  inDescId:= zc_Object_Account(), inCode:= 40303, inName:= '��������� ���� ��������', inEnumName:= 'zc_Enum_Account_40303');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40303, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40303');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40401, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40401');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_Account_40501(),  inDescId:= zc_Object_Account(), inCode:= 40501, inName:= '����� ��', inEnumName:= 'zc_Enum_Account_40501');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40501, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40501');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40601, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_40601');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50401, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_50401');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 100301, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_100301');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 100401, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_100401');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 110101, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_110101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 110201, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_110201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 110301, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_110301');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 110302, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_110302');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 110401, inDescId:= zc_Object_Account(), inEnumName:= 'zc_Enum_Account_110401');

     -- !!!
     -- !!! ��: 1-������� �������������� ������ ����������
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_10000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_20000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_30000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_40000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_50000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_60000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_70000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80000, inDescId:= zc_Object_InfoMoneyGroup(), inEnumName:= 'zc_Enum_InfoMoneyGroup_80000');

     -- !!!
     -- !!! ��: 2-������� �������������� ����������
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_10100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10200, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_10200');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20200, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20300, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20400, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20500, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20600, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20600');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20700, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20700');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20800, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20800');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20900, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_20900');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21000, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21150, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21150');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21200, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21300, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21400, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21500, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21600, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_21600');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_30100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30200, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_30200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30300, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_30300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30400, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_30400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30500, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_30500');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40200, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40200');
     -- PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40300, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40400, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40500, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40600, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40600');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40700, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40700');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40800, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40800');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40900, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_40900');

     -- PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_InfoMoneyDestination_41000(),  inDescId:= zc_Object_InfoMoneyDestination(), inCode:= 41000, inName:= '�������/������� ������', inEnumName:= 'zc_Enum_InfoMoneyDestination_41000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 41000, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_41000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 41100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_41100');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_50100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50200, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_50200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50300, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_50300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50400, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_50400');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70100, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_70100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70200, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_70200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70300, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_70300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70400, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_70400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70500, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_70500');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80300, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_80300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80500, inDescId:= zc_Object_InfoMoneyDestination(), inEnumName:= 'zc_Enum_InfoMoneyDestination_80500');

     -- !!!
     -- !!! ��: �������������� ������ ���������� (1+2+3 �������)
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10105, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_10105');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10201, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_10201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10202, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_10202');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10203, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_10203');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10204, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_10204');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20401, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_20401');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20801, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_20801');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20901, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_20901');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21001, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21001');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21101, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21151, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21151');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21201, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21419, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21419');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21501, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21501');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21502, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21502');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 21505, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_21505');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30101, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_30101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30102, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_30102');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30103, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_30103');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30201, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_30201');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40801, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_40801');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50201, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_50201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50202, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_50202');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60101, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_60101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60102, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_60102');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60103, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_60103');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70101, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70102, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70102');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70103, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70103');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70104, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70104');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70201, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70202, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70202');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70203, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70203');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70204, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_70204');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80301, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_80301');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80401, inDescId:= zc_Object_InfoMoney(), inEnumName:= 'zc_Enum_InfoMoney_80401');

     -- !!!
     -- !!! ����: 1-������� (������ ����)
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_10000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_20000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_30000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_40000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_50000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_60000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_70000');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80000, inDescId:= zc_Object_ProfitLossGroup(), inEnumName:= 'zc_Enum_ProfitLossGroup_80000');

     -- !!!
     -- !!! ����: 2-������� (��������� ���� - �����������)
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10400, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10500, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10700, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10700');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10800, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10800');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10900, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_10900');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 11100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_11100');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_20100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_20200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_20300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20400, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_20400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20500, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_20500');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20600, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_20600');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20700, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_20700');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_30100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_30200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_30300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 30400, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_30400');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_40100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_40200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_40300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40400, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_40400');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_50100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_50200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_50300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50400, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_50400');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50500, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_50500');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_60100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_60200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_60300');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_70100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70110, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_70110');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_70200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_70300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70400, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_70400');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80100, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_80100');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80200, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_80200');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80300, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_80300');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80400, inDescId:= zc_Object_ProfitLossDirection(), inEnumName:= 'zc_Enum_ProfitLossDirection_80400');

     -- !!!
     -- !!! ����: ������ (1+2+3 �������)
     -- !!!
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10101, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10102, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10102');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10201, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10201');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10202, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10202');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10301, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10301');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10302, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10302');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10401, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10401');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10402, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10402');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10501, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10501');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10502, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10502');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10701, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10701');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10702, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10702');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10801, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10801');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10802, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10802');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 10901, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_10901');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 11101, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_11101');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 20204, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_20204');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 40208, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_40208');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50101, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_50101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 50201, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_50201');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60101, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_60101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 60201, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_60201');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70101, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_70101');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70102, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_70102');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70103, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_70103');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70104, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_70104');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70111, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_70111');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70112, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_70112');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 70203, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_70203');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80103, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_80103');

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ProfitLoss_80105(),  inDescId:= zc_Object_ProfitLoss(), inCode:= 80105, inName:= '������� ��� �������/������� ������', inEnumName:= 'zc_Enum_ProfitLoss_80105');
     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80105, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_80105');

     PERFORM lpUpdate_Object_Enum_byCode (inCode:= 80301, inDescId:= zc_Object_ProfitLoss(), inEnumName:= 'zc_Enum_ProfitLoss_80301');

END $$;

DO $$
BEGIN

   --- !!! ���� �������� ������� �����������
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_ModelServiceKind_Comment(),  zc_Enum_ModelServiceKind_DaySheetWorkTime(),   '�������� ��� ������ �������������� ��� ������� ��� � ���� ���������� ���������� ��� ��� �� ������ �� ����');
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_ModelServiceKind_Comment(),  zc_Enum_ModelServiceKind_MonthSheetWorkTime(), '�������� ��� ������ �������������� ����� �� ����� � ���� ���������� ���������� ��� ���� ��� �� ������ �� �����');
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_ModelServiceKind_Comment(),  zc_Enum_ModelServiceKind_SatSheetWorkTime(),   '�������� ��� ������ �������������� ������ ��� ���� "�������" � ���� ���������� ���������� ��� ��� �� ������ �� ���� "�������"');

     --- !!! ���� �������� ������� �����������
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_Month(),         '1,2,3 �� �����.�� ����� ��� ����� ����� ���������(������������ � ��������� ���� ���� �� ���-�� �����) �� ���� ��� ������� � ������.');
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_Day(),           '1,2,3 �� �����.�� ���� ��� ����� ����� ���������(������������ � ��������� ���� ����� �� ���-�� �����) �� ���� ��� ������� � ������.');
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_Personal(),      '1,2,3 �� �����.�� ���� ��� ����� ����� ��������� ������� ��� ������� � ������.');
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_HoursPlan(),     '1-�����,2,3 �� �����.�� ����� ���������(���� ����=����/1-�����) ����� ����� ��������� �� ������� "���� �����"*"���� ����" ������� ��� ������� � ������.(�������� �����������-�������).');
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_HoursDay(),      '2-�����,1,3 �� �����.�� ����� ���������(���� ����=����/2-�����*�.��.)����� ����� ��������� �� ������� "���� �����"*"���� ����" ������� ��� ������� � ������.(�������� �����������-�������).');
     PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_HoursPlanConst(),'1,2,3 �� �����.�� ����� ��� ����� ����� ��������� (�������������� � ��������� ���� ����� ��������) ������� ��� ������� � ������.');
     -- PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_HoursDayConst(), '(�� ������������).�� ����� ��� ����� ����� ��������� � ��������� ����/����_�����*�.��. ������� ��� ������� � ������.');
     -- PERFORM lpInsertUpdate_ObjectString( zc_ObjectString_StaffListSummKind_Comment(), zc_Enum_StaffListSummKind_WorkHours(),     '(�� ������������).������������ ��� ������� ����� �� ���� ����� � ������� ��� �� ��������.');
     
     -- !!! ���� ���
     -- !!! ���� ���
--     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_NDSKind_Common(),  inDescId:= zc_Object_NDSKind(), inCode:= 1, inName:= '20% - ����� ���������', inEnumName:= 'zc_Enum_NDSKind_Common');
  --   PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_NDSKind_Medical(), inDescId:= zc_Object_NDSKind(), inCode:= 2, inName:= '7% - �����������', inEnumName:= 'zc_Enum_NDSKind_Medical');

    -- PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_NDSKind_NDS(), zc_Enum_NDSKind_Common(), 20);
     --PERFORM lpInsertUpdate_ObjectFloat (zc_ObjectFloat_NDSKind_NDS(), zc_Enum_NDSKind_Medical(), 7);

     -- !!! ���� �������
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_FileTypeKind_Excel(),  inDescId:= zc_Object_FileTypeKind(), inCode:= 1, inName:= 'Excel', inEnumName:= 'zc_Enum_FileTypeKind_Excel');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_FileTypeKind_DBF(), inDescId:= zc_Object_FileTypeKind(), inCode:= 2, inName:= 'DBF', inEnumName:= 'zc_Enum_FileTypeKind_DBF');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_FileTypeKind_MMO(), inDescId:= zc_Object_FileTypeKind(), inCode:= 3, inName:= 'MMO', inEnumName:= 'zc_Enum_FileTypeKind_MMO');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_FileTypeKind_ODBC(), inDescId:= zc_Object_FileTypeKind(), inCode:= 4, inName:= 'ODBC', inEnumName:= 'zc_Enum_FileTypeKind_ODBC');
     

     -- !!!
     -- !!! ���� ������
     -- !!!

     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ImportExportLinkType_UnitJuridical(),  inDescId:= zc_Object_ImportExportLinkType(), inCode:= 1, inName:= '����� ������������� ��� �����������', inEnumName:= 'zc_Enum_ImportExportLinkType_UnitJuridical');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ImportExportLinkType_UnitUnitId(),  inDescId:= zc_Object_ImportExportLinkType(), inCode:= 2, inName:= '����� ������������� �� ������ �������', inEnumName:= 'zc_Enum_ImportExportLinkType_UnitUnitId');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ImportExportLinkType_DefaultFileName(),  inDescId:= zc_Object_ImportExportLinkType(), inCode:= 3, inName:= '��� ����� �� ���������', inEnumName:= 'zc_Enum_ImportExportLinkType_DefaultFileName');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ImportExportLinkType_UnitEmailSign(),  inDescId:= zc_Object_ImportExportLinkType(), inCode:= 4, inName:= '������� ��� �������������', inEnumName:= 'zc_Enum_ImportExportLinkType_UnitEmailSign');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ImportExportLinkType_ClientEmailSubject(),  inDescId:= zc_Object_ImportExportLinkType(), inCode:= 5, inName:= '���� ������', inEnumName:= 'zc_Enum_ImportExportLinkType_ClientEmailSubject');
     PERFORM lpInsertUpdate_Object_Enum (inId:= zc_Enum_ImportExportLinkType_OldClientLink(),  inDescId:= zc_Object_ImportExportLinkType(), inCode:= 6, inName:= '����� ����������� �� ������ �������', inEnumName:= 'zc_Enum_ImportExportLinkType_OldClientLink');

END $$;


/*-------------------------------------------------------------------------------*/
/*
 ������� ����������: ����, �����
               ������� �.�.   ������ �.�.   ���������� �.�.   ������ �.
 13.11.14                                        * add zc_Enum_Currency_Basis
 30.08.14                                        * add zc_Enum_InfoMoney_60101
 23.08.14                                        * add ��
 04.08.14                                        * del zc_Enum_AccountDirection_70600 ���������� (������������)
 02.08.14                                        * add zc_Enum_AccountDirection_20...
 19.07.14                                        * change zc_Enum_Account_40302
 19.07.14                                        * del zc_Enum_AccountDirection_40500 and zc_Enum_Account_40501
 13.06.14                                        * add zc_Enum_Role_1107
 21.05.14                                        * add zc_Enum_DocumentTaxKind_Prepay
 21.05.14                                        * add zc_Enum_ContractConditionKind_DelayPrepay
 13.05.14                                        * add zc_Enum_ProfitLossDirection_70110 and zc_Enum_ProfitLoss_70111 and zc_Enum_ProfitLoss_70112
 07.05.14                                        * add zc_Enum_Role_Bread
 06.05.14                                        * add zc_Enum_InfoMoney_21419
 05.05.14                                        * del zc_Enum_ContractConditionKind_DelayDayCalendarSale and zc_Enum_ContractConditionKind_DelayDayBankSale
 04.05.14                                        * add zc_Enum_Account_40401 and zc_Enum_Account_40501
 04.05.14                                        * change zc_Enum_AccountDirection_40500
 30.04.14                                        * add zc_Enum_DocumentTaxKind_CorrectivePrice
 21.04.14                                        * add zc_Enum_ContractConditionKind_DelayCreditLimit
 19.04.14                                        * add zc_Enum_Account_110...
 17.04.14                                        * add zc_Enum_AccountGroup_110000
 16.04.14                                        * add zc_Enum_InfoMoney_30201
 08.04.14                                        * add zc_Enum_GoodsKind_Main
 21.03.14                                        * add zc_Enum_Account_3020... and zc_Enum_InfoMoney_20...
 09.03.14                                        * add zc_Enum_Account_50401
 21.02.14                                        * add zc_Enum_ContractConditionKind_LimitReturn
 09.02.14                                                       * add ���� ������������ ���������� ���������
 30.01.14                                        * add zc_Enum_ProfitLoss_80301
 25.01.14                                        * add zc_Enum_ContractConditionKind_...
 24.01.14                                        * add zc_Enum_InfoMoneyDestination_40900
 22.12.13                                        * add zc_Enum_InfoMoneyGroup_...
 22.12.13                                        * add zc_Enum_AccountDirection_40...
 19.12.13                                        * add del zc_Enum_ContractConditionKind_...
 30.11.13                                        * add del zc_Enum_StaffListSummKind_WorkHours and zc_Enum_StaffListSummKind_HoursDayConst
 28.11.13                                        * change comment
 28.11.13                                        * add zc_Enum_WorkTimeKind_Trainee50 and zc_Enum_WorkTimeKind_Quit and zc_Enum_WorkTimeKind_Trial
 19.11.13                                        * add zc_Enum_StaffListSummKind_HoursPlanConst and zc_Enum_StaffListSummKind_HoursDayConst
 18.11.13                                        * add zc_Enum_StaffListSummKind_HoursDay
 18.11.13                                        * replace zc_Enum_StaffListSummKind_RatioHours -> zc_Enum_StaffListSummKind_HoursPlan
 18.11.13                                        * replace zc_Enum_StaffListSummKind_Turn -> zc_Enum_StaffListSummKind_Day
 18.11.13                                        * replace zc_Enum_StaffListSummKind_MasterStaffListHours -> zc_Enum_StaffListSummKind_WorkHours
 09.11.13                                        * add zc_Enum_Role_Transport
 03.11.13                                        * rename zc_Enum_ProfitLoss_40209 -> zc_Enum_ProfitLoss_40208
 01.11.13                                        * add zc_Enum_Account_110101
 30.10.13         * add ���� ���� ��� �������� ����������
 07.10.13                                        * role...
 03.10.13                                        * add zc_Enum_InfoMoney_20901, zc_Enum_InfoMoney_30101
 01.10.13         * add ���� �������� ������� (6 ��)
 30.09.13                                        * add zc_Enum_InfoMoney_21201
 29.09.13                                        * add zc_Object_RateFuelKind
 27.09.13                                        * add zc_Enum_InfoMoney_20401
 26.09.13         * del zc_Enum_RateFuelKind_Summer, zc_Enum_RateFuelKind_Winter
 24.09.13         * add zc_Enum_RateFuelKind_Summer, zc_Enum_RateFuelKind_Winter, zc_Enum_RouteKind_Internal, zc_Enum_RouteKind_External
 21.09.13                                        * add zc_Enum_InfoMoney_80401
 15.09.13                                        * add zc_Enum_AccountDirection_20900 and zc_Enum_Account_20901
 07.09.13                                        * add zc_Enum_ProfitLossDirection_1... and zc_Enum_ProfitLossDirection_7...
 01.09.13                                        * add zc_Enum_ProfitLossDirection_4...
 26.08.13                                        * add ����
 25.08.13                                        * add zc_Enum_Account_100301
 21.08.13                        * add zc_Enum_Account_40101
 20.07.13                                        * add zc_Enum_AccountDirection_20400
 18.07.13                                        * add zc_Enum_AccountDirection_20500, 20600
 02.07.13                                        * add 1-������� �������������� ������
 01.07.13                                        * add 2-������� �������������� ����������
 28.06.13                                        *
*/
