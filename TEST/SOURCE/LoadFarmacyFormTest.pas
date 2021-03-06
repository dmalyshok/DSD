unit LoadFarmacyFormTest;

interface

uses
  TestFramework, Forms;

type

  TLoadFormTest = class (TTestCase)
  private
    function GetForm(FormClass: string): TForm;
  protected
    // �������������� ������ ��� ������������
    procedure SetUp; override;
  published
    procedure MainFormTest;
    //procedure LoadCashFormTest;
    procedure LoadAccountFormTest;
    procedure LoadAdditionalGoodsFormTest;
    procedure LoadAlternativeGroupFormTest;
    procedure LoadArticleLossEditFormTest;
    procedure LoadArticleLossFormTest;
    procedure LoadAreaFormTest;
    procedure LoadBankFormTest;
    procedure LoadBankAccountFormTest;
    procedure LoadBankAccountDocumentFormTest;
    procedure LoadBankStatementFormTest;
    procedure LoadCalendarFormTest;
    procedure LoadCashRegisterFormTest;
    procedure LoadChangeIncomePaymentKindFormTest;
    procedure LoadChangeIncomePaymentFormTest;
    procedure LoadCheckFormTest;
    procedure LoadCheckDeferredFormTest;
    procedure LoadCheckVIPFormTest;
    procedure LoadConditionsKeepFormTest;
    procedure LoadContactPersonFormTest;
    procedure LoadContractFormTest;
    procedure LoadCurrencyFormTest;
    procedure LoadCreateOrderFromMCSFormTest;
    procedure LoadDefaultFormTest;
    procedure LoadDiscountFormTest;
    procedure LoadEnumFormTest;
    procedure LoadEmailFormTest;
    procedure LoadEmailSettingsFormTest;
    procedure LoadFiscalFormTest;
    procedure LoadGoodsGroupFormTest;
    procedure LoadGoodsFormTest;
    procedure LoadImportSettingsFormTest;
    procedure LoadImportTypeFormTest;
    procedure LoadIncomeFormTest;
    procedure LoadInfoMoneyGroupFormTest;
    procedure LoadInfoMoneyDestinationFormTest;
    procedure LoadInfoMoneyFormTest;
    procedure LoadInventoryFormTest;
    procedure LoadInvoiceFormTest;
    procedure LoadJuridicalFormTest;
    procedure LoadJuridicalAreaFormTest;
    procedure LoadLoadFormTest;
    procedure LoadLossDebtFormTest;
    procedure LoadLossFormTest;
    procedure LoadMakerFormTest;
    procedure LoadMargineCategory;
    procedure LoadMarginCategoryMovement;
    procedure LoadMarginReport;
    procedure LoadMeasureFormTest;
    procedure LoadMemberFormTest;
    procedure LoadMemberIncomeCheckFormTest;
    procedure LoadKindFormTest;
    procedure LoadOrderSheduleFormTest;
    procedure LoadOrderInternalFormTest;
    procedure LoadOrderExternalFormTest;
    procedure LoadObjectUnionFormTest;
    procedure LoadOverFormTest;
    procedure LoadOverSettingsFormTest;
    procedure LoadPaidKindFormTest;
    procedure LoadPaidTypeFormTest;
    procedure LoadPartnerMedicalFormTest;
    procedure LoadPaymentFormTest;
    procedure LoadPersonalFormTest;
    procedure LoadPersonalGroupFormTest;
    procedure LoadPositionEducationFormTest;
    procedure LoadPriceListFormTest;
    procedure LoadPriceFormTest;
    procedure LoadProfitLossFormTest;
    procedure LoadProfitLossGroupFormTest;
    procedure LoadProfitLossDirectionFormTest;
    procedure LoadPromoFormTest;
    procedure LoadPromoCodeFormTest;
    procedure LoadPromoUnitFormTest;
    procedure LoadProvinceCityFormTest;
    procedure LoadReasonDifferencesFormTest;
    procedure LoadReportPromoParamsFormTest;
    procedure LoadReportSoldParamsFormTest;
    procedure LoadReportFormTest;
    procedure LoadReportForSiteTest;
    procedure LoadReportUploadFormTest;
    procedure LoadRepriceFormTest;
    procedure LoadRetailFormTest;
    procedure LoadReturnTypeFormTest;
    procedure LoadReturnOutFormTest;
    procedure LoadSaleFormTest;
    procedure LoadServiceFormTest;
    procedure LoadSendFormTest;
    procedure LoadSendOnPriceFormTest;
    procedure LoadSPObjectFormTest;
    procedure LoadSPKindFormTest;
    procedure LoadSheetWorkTimeFormTest;
    procedure LoadUnitFormTest;
    procedure LoadUnionFormTest;
    procedure FormTest;
  end;

implementation

uses CommonData, Storage, FormStorage, Classes, Authentication, SysUtils,
     cxPropertiesStore, cxStorage, DBClient, dsdDB, ActionTest, MainForm,
     UtilConst;

{ TLoadFormTest }

procedure TLoadFormTest.FormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TTestForm'));
  TdsdFormStorageFactory.GetStorage.Load('TTestForm');
end;

function TLoadFormTest.GetForm(FormClass: string): TForm;
begin
  if GetClass(FormClass) = nil then
     raise Exception.Create('�� ��������������� �����: ' + FormClass);
  Application.CreateForm(TComponentClass(GetClass(FormClass)), Result);
end;

procedure TLoadFormTest.LoadDefaultFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSetUserDefaultsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSetUserDefaultsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDefaultsKeyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDefaultsKeyForm');
end;


procedure TLoadFormTest.LoadDiscountFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternalEditForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternal_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternal_ObjectForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternalToolsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternalToolsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternalToolsEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternalToolsEditForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternalTools_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternalTools_ObjectForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternalJuridicalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternalJuridicalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountExternalJuridicalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountExternalJuridicalEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBarCodeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBarCodeForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBarCodeEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBarCodeEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountCardForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountCardForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDiscountCardEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDiscountCardEditForm');
end;

procedure TLoadFormTest.LoadAccountFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountGroup_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountGroup_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountGroupEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountDirectionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountDirectionForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountDirection_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountDirection_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountDirectionEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountDirectionEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccount_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccount_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAccountEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAccountEditForm');
end;

procedure TLoadFormTest.LoadBankFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankEditForm');
end;

procedure TLoadFormTest.LoadAreaFormTest;
begin
  // �������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAreaForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAreaForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAreaEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAreaEditForm');
end;


procedure TLoadFormTest.LoadBankStatementFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankStatementJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankStatementJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankStatementForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankStatementForm');
end;

procedure TLoadFormTest.LoadBankAccountDocumentFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccountJournalFarmacyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccountJournalFarmacyForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccountMovementFarmacyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccountMovementFarmacyForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccountJournalFarmacyDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccountJournalFarmacyDialogForm');
end;

procedure TLoadFormTest.LoadBankAccountFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccountForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccountForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccount_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccount_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBankAccountEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBankAccountEditForm');
end;

//procedure TLoadFormTest.LoadCashFormTest;
//begin
//  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMainCashForm'));
//  TdsdFormStorageFactory.GetStorage.Load('TMainCashForm');
//end;

procedure TLoadFormTest.LoadCashRegisterFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCashRegisterForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCashRegisterForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCashRegisterEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCashRegisterEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCashRegisterKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCashRegisterKindForm');
end;

procedure TLoadFormTest.LoadCalendarFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCalendarForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCalendarForm');
end;

procedure TLoadFormTest.LoadCheckFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheckJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheckJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheckJournalUserForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheckJournalUserForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheckForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheckForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheckPrintDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheckPrintDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TDataTimeDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TDataTimeDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheck_SPEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheck_SPEditForm');
end;

procedure TLoadFormTest.LoadConditionsKeepFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TConditionsKeepForm'));
  TdsdFormStorageFactory.GetStorage.Load('TConditionsKeepForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TConditionsKeepEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TConditionsKeepEditForm');
end;

procedure TLoadFormTest.LoadContactPersonFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContactPersonForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContactPersonForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContactPersonEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContactPersonEditForm');
  //  ��� ��������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContactPersonKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContactPersonKindForm');
  //��� � !!!Enum!!!
  //TdsdFormStorageFactory.GetStorage.Save(GetForm('TContactPersonKindEditForm'));
  //TdsdFormStorageFactory.GetStorage.Load('TContactPersonKindEditForm');
end;

procedure TLoadFormTest.LoadContractFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContractForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContractForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContractEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContractEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TContract_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TContract_ObjectForm');
end;

procedure TLoadFormTest.LoadCreateOrderFromMCSFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCreateOrderFromMCSForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCreateOrderFromMCSForm');
end;

procedure TLoadFormTest.LoadCurrencyFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCurrencyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCurrencyForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCurrencyEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCurrencyEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCurrency_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCurrency_ObjectForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCurrencyValue_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCurrencyValue_ObjectForm');

end;

procedure TLoadFormTest.LoadFiscalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TFiscalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TFiscalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TFiscalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TFiscalEditForm');
end;

procedure TLoadFormTest.LoadGoodsFormTest;
begin
{
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsRetailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsRetailForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsRetailDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsRetailDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoods_BarCodeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoods_BarCodeForm');
  //exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsAllForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsAllForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsAllRetailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsAllRetailForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsAllJuridicalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsAllJuridicalForm');
  //exit;
  }
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsPartnerCodeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsPartnerCodeForm');
  {
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsPartnerCodeMasterForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsPartnerCodeMasterForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoods_NDS_diffForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoods_NDS_diffForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsMainForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsMainForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsMainEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsMainEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsLiteForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsLiteForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsMainLiteForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsMainLiteForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPartionGoodsChoiceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPartionGoodsChoiceForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsAllForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsAllForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsAllRetailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsAllRetailForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsAllJuridicalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsAllJuridicalForm');
  }
end;

procedure TLoadFormTest.LoadMemberFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMember_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMember_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberEditForm');
end;

 procedure TLoadFormTest.LoadMemberIncomeCheckFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberIncomeCheckForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberIncomeCheckForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberIncomeCheckEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberIncomeCheckEditForm');
end;

procedure TLoadFormTest.LoadMakerFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMakerForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMakerForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMakerEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMakerEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCountryForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCountryForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCountryEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCountryEditForm');
end;

procedure TLoadFormTest.LoadMargineCategory;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategoryItemHistoryForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategoryItemHistoryForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategoryForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategoryForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategoryItemForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategoryItemForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategoryLinkForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategoryLinkForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategory_CrossForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategory_CrossForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategory_CrossDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategory_CrossDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategory_TotalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategory_TotalForm');

end;

procedure TLoadFormTest.LoadMarginCategoryMovement;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategory_MovementForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategory_MovementForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginCategoryJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginCategoryJournalForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_SAMP_AnalysisDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_SAMP_AnalysisDialogForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_SAMP_AnalysisForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_SAMP_AnalysisForm');
end;

procedure TLoadFormTest.LoadMarginReport;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginReportForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginReportForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMarginReportItemForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMarginReportItemForm');
end;

procedure TLoadFormTest.LoadMeasureFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMeasureForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMeasureForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMeasureEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMeasureEditForm');
end;

procedure TLoadFormTest.LoadKindFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TWorkTimeKind_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TWorkTimeKind_ObjectForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TWorkTimeKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TWorkTimeKindForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TConfirmedKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TConfirmedKindForm');

end;

procedure TLoadFormTest.LoadGoodsGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsGroupEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsGroup_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsGroup_ObjectForm');
end;

procedure TLoadFormTest.LoadLoadFormTest;
begin
 //exit;
 {
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceListLoadForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceListLoadForm');
   }
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceListItemsLoadForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceListItemsLoadForm');
  {
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMovementLoadForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMovenentLoadForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMovementItemsLoadForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMovementItemsLoadForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TChoiceGoodsFromPriceListForm'));
  TdsdFormStorageFactory.GetStorage.Load('TChoiceGoodsFromPriceListForm');
  exit;

  // ����� ����� ������ �� ���� ����
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TChoiceGoodsFromRemainsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TChoiceGoodsFromRemainsForm');

  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TColorForm'));
  TdsdFormStorageFactory.GetStorage.Load('TColorForm');

  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsBarCodeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsBarCodeForm');
  }
end;

procedure TLoadFormTest.LoadLossDebtFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TLossDebtForm'));
  TdsdFormStorageFactory.GetStorage.Load('TLossDebtForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TLossDebtJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TLossDebtJournalForm');
end;

procedure TLoadFormTest.LoadReasonDifferencesFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReasonDifferencesForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReasonDifferencesForm');
end;

procedure TLoadFormTest.LoadReportFormTest;
begin
{
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsRemainsCurrentForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRReport_GoodsRemainsCurrentForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsRemainsCurrentDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRReport_GoodsRemainsCurrentDialogForm');
  exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Check_UKTZEDDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Check_UKTZEDDialogForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Check_UKTZEDForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Check_UKTZEDForm');
  //exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MinPrice_byPromoDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MinPrice_byPromoDialogForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MinPrice_byPromoForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MinPrice_byPromoForm');
 // exit;

  // ������� ������ (ID ������ ������ ����)
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsRemains_AnotherRetailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsRemains_AnotherRetailForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Movement_AnotherRetailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Movement_AnotherRetailForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementIncome_byPromoDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementIncome_byPromoDialogForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementIncome_byPromoForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementIncome_byPromoForm');
  //exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportMovementCheckGrowthAndFallingForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportMovementCheckGrowthAndFallingForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportMovementCheckGrowthAndFallingDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportMovementCheckGrowthAndFallingDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Check_RatingForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Check_RatingForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Check_RatingDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Check_RatingDialogForm');
  //exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_OverOrderForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_OverOrderForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_OverOrderDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_OverOrderDialogForm');
  //exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Check_AssortmentForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Check_AssortmentdForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Check_AssortmentDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Check_AssortmentDialogForm');
  //exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementPriceListForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementPriceListForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementPriceList_DialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementPriceList_DialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_BadmForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_BadmForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnit_byReportBadmForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnit_byReportBadmForm');
  exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MinPrice_onGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MinPrice_onGoodsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MinPrice_onGoodsDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MinPrice_onGoodsDialogForm');
  exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_CheckPromoForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_CheckPromoForm');


  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_PeriodDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_PeriodDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_PromoDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_PromoDialogForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheck_PromoForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheck_PromoForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementIncome_PromoForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementIncome_PromoForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsRemainsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsRemainsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsRemainsDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsRemainsDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheckErrorForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheckErrorForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheckErrorDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheckErrorDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Payment_PlanForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Payment_PlanForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Payment_PlanDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Payment_PlanDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheck_UnLiquidForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheck_UnLiquidForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheck_UnLiquidDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheck_UnLiquidDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportOrderGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportOrderGoodsForm');

  // ����� ������������� ��������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_RemainsOverGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_RemainsOverGoodsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_RemainsOverGoodsDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_RemainsOverGoodsDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_RemainsOverGoods_ToForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_RemainsOverGoods_ToForm');
  exit;

  //����� ������ �� �����
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementIncomeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementIncomeForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementIncomeDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementIncomeDialogForm');

   //����� ������ �� ����� ��� ����������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementIncomeFarmForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementIncomeFarmForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementIncomeFarmDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementIncomeFarmDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_BalanceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_BalanceForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_JuridicalSoldForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_JuridicalSoldForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_JuridicalCollationForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_JuridicalCollationForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsPartionMoveForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsPartionMoveForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsPartionMoveDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsPartionMoveDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheck_CrossForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheck_CrossForm');
  exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsRemainsLightForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRReport_GoodsRemainsLightForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsRemainsLightDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRReport_GoodsRemainsLightDialogForm');
  //exit;
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportMovementCheckLightForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportMovementCheckLightForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementChecLightDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementChecLightDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportMovementCheckForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportMovementCheckForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheckDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheckDialogForm');

  // ��� ����������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportMovementCheckFarmForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportMovementCheckFarmForm');
  
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheckFarmDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheckFarmDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsPartionHistoryForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsPartionHistoryForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsPartionHistoryDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsPartionHistoryDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_SoldForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_SoldForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Sold_DayForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Sold_DayForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Sold_DayUserForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Sold_DayUserForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Movement_ByPartionGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Movement_ByPartionGoodsForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_WageForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_WageForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_WageDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_WageDialogForm');

  //����� ����������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_ProfitForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_ProfitForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_ProfitDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_ProfitDialogForm');
  }
  // ������� ��� �� ������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_CheckMiddle_DetailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_CheckMiddle_DetailForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_CheckMiddle_DetailDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_CheckMiddle_DetailDialogForm');
  {
  // ������� ���
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportMovementCheckMiddleForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportMovementCheckMiddleForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_MovementCheckMiddleDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_MovementCheckMiddleDialogForm');
  {
  //����� ������� �����������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_PriceInterventionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_PriceInterventionForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_PriceInterventionDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_PriceInterventionDialogForm');
  //����� ������� �����������2
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_PriceIntervention2Form'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_PriceIntervention2Form');

  // ����� ������������� ��������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_RemainsOverGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_RemainsOverGoodsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_RemainsOverGoodsDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_RemainsOverGoodsDialogForm');
   }
end;

procedure TLoadFormTest.LoadReportForSiteTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsOnUnit_ForSiteForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsOnUnit_ForSiteForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_GoodsOnUnit_ForSiteDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_GoodsOnUnit_ForSiteDialogForm');
end;

procedure TLoadFormTest.LoadReportSoldParamsFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportSoldParamsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportSoldParamsForm');
end;

procedure TLoadFormTest.LoadReportPromoParamsFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReportPromoParamsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReportPromoParamsForm');
end;

procedure TLoadFormTest.LoadReportUploadFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_UploadBaDMForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_UploadBaDMForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_UploadOptimaForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_UploadOptimaForm');
end;

procedure TLoadFormTest.LoadRepriceFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRepriceJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRepriceJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRepriceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRepriceForm');
end;

procedure TLoadFormTest.LoadRetailFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRetailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRetailForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRetailEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRetailEditForm');
end;

procedure TLoadFormTest.LoadReturnOutFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReturnOutForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReturnOutForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReturnOutJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReturnOutJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReturnOutPartnerDataDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReturnOutPartnerDataDialogForm');
end;

procedure TLoadFormTest.LoadReturnTypeFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReturnTypeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReturnTypeForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReturnTypeEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReturnTypeEditForm');
end;

procedure TLoadFormTest.LoadJuridicalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalCorporateForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalCorporateForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalEditForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridical_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridical_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPartnerCodeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPartnerCodeForm');
end;

procedure TLoadFormTest.LoadJuridicalAreaFormTest;
begin
  // ������� �����������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalAreaForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalAreaForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalAreaEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalAreaEditForm');
end;

procedure TLoadFormTest.LoadImportTypeFormTest;
begin
  //���� �������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TImportTypeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TImportTypeForm');
end;

procedure TLoadFormTest.LoadImportSettingsFormTest;
begin
  //��������� �������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TImportSettingsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TImportSettingsForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TImportGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TImportGroupForm');
end;

procedure TLoadFormTest.LoadUnitFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnitTreeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnitTreeForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnitEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnitEditForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnit_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnit_ObjectForm');

  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnit_JuridicalAreaForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnit_JuridicalAreaForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnitForFarmacyCashForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnitForFarmacyCashForm');
end;

procedure TLoadFormTest.LoadUnionFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridical_Unit_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridical_Unit_ObjectForm');
end;

procedure TLoadFormTest.LoadEnumFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TNDSKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TNDSKindForm');
  // ���� ������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TFileTypeKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TFileTypeKindForm');
  // ���� �������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderKindForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderKindEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderKindEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TEmailToolsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TEmailToolsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TEmailKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TEmailKindForm');

end;

procedure TLoadFormTest.LoadEmailSettingsFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TEmailSettingsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TEmailSettingsForm');
end;

procedure TLoadFormTest.LoadEmailFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TEmailForm'));
  TdsdFormStorageFactory.GetStorage.Load('TEmailForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TEmailEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TEmailEditForm');
end;

procedure TLoadFormTest.LoadProfitLossGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossGroup_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossGroup_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossGroupEditForm');
end;

procedure TLoadFormTest.LoadProfitLossDirectionFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossDirectionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossDirectionForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossDirection_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossDirection_ObjectForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossDirectionEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossDirectionEditForm');
end;

procedure TLoadFormTest.LoadProfitLossFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLoss_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLoss_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProfitLossEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProfitLossEditForm');
end;

procedure TLoadFormTest.LoadPromoFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoForm');
end;

 procedure TLoadFormTest.LoadPromoCodeFormTest;
begin
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_Check_byPromoCodeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_Check_byPromoCodeForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoCodeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoCodeForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoCodeEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoCodeEditForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoCodeMovementForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoCodeMovementForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoCodeJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoCodeJournalForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoCodeSignDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoCodeSignDialogForm')
end;
procedure TLoadFormTest.LoadPromoUnitFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoUnitJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoUnitJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPromoUnitForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPromoUnitForm');
end;

procedure TLoadFormTest.LoadProvinceCityFormTest;
begin
  // ���������� � ���������� ������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProvinceCityForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProvinceCityForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProvinceCityEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProvinceCityEditForm');
end;

procedure TLoadFormTest.MainFormTest;
var ActionDataSet: TClientDataSet;
    StoredProc: TdsdStoredProc;
    i: integer;
    Action: ActionTest.TAction;
begin
  // ����� �� ��������� ���������� Action
  // �������� ��� Action �� ����
  ActionDataSet := TClientDataSet.Create(nil);
  StoredProc := TdsdStoredProc.Create(nil);
  MainFormInstance := TMainForm.Create(nil);
  Action := ActionTest.TAction.Create;
  try
    StoredProc.DataSet := ActionDataSet;
    StoredProc.StoredProcName := 'gpSelect_Object_Action';
    StoredProc.Execute;
    // ������� ���, ��� ���
    with MainFormInstance.ActionList do
      for I := 0 to ActionCount - 1 do
          if not ActionDataSet.Locate('Name', Actions[i].Name, []) then
             Action.InsertUpdateAction(0, 0, Actions[i].Name);
  finally
    Action.Free;
    StoredProc.Free;
    ActionDataSet.Free;
    MainFormInstance.Free;
  end;
end;

procedure TLoadFormTest.SetUp;
begin
  inherited;
  TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', gc_AdminPassword, gc_User);
end;

procedure TLoadFormTest.LoadOrderSheduleFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderSheduleForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderSheduleForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderSheduleEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderSheduleEditForm');
end;

procedure TLoadFormTest.LoadOrderInternalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderInternalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderInternalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderInternalLiteForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderInternalLiteForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderInternalJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderInternalJournalForm');
end;

procedure TLoadFormTest.LoadObjectUnionFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMoneyPlace_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMoneyPlace_ObjectForm');
end;

procedure TLoadFormTest.LoadOrderExternalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderExternalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderExternalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderExternalJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderExternalJournalForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOrderExternalJournalChoiceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOrderExternalJournalChoiceForm');
end;

procedure TLoadFormTest.LoadInfoMoneyGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyGroup_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyGroup_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyGroupEditForm');
end;


procedure TLoadFormTest.LoadInventoryFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInventoryJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInventoryJournalForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInventoryForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInventoryForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInventoryPartionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInventoryPartionForm');
end;

procedure TLoadFormTest.LoadInvoiceFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInvoiceJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInvoiceJournalForm');
end;

procedure TLoadFormTest.LoadLossFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TLossJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TLossJournalForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TLossForm'));
  TdsdFormStorageFactory.GetStorage.Load('TLossForm');
end;

procedure TLoadFormTest.LoadArticleLossFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TArticleLossForm'));
  TdsdFormStorageFactory.GetStorage.Load('TArticleLossForm');
end;

procedure TLoadFormTest.LoadArticleLossEditFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TArticleLossEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TArticleLossEditForm');
end;

procedure TLoadFormTest.LoadInfoMoneyDestinationFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyDestinationForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyDestinationForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyDestination_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyDestination_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyDestinationEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyDestinationEditForm');
end;

procedure TLoadFormTest.LoadInfoMoneyFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoney_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoney_ObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TInfoMoneyEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TInfoMoneyEditForm');
end;

procedure TLoadFormTest.LoadIncomeFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomeForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomeJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomeJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomePharmacyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomePharmacyForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomePharmacyJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomePharmacyJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomeJournalChoiceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomeJournalChoiceForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncome_AmountTroubleForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncome_AmountTroubleForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomePartnerDataDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomePartnerDataDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIncomeCheckDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIncomeCheckDialogForm');
end;

procedure TLoadFormTest.LoadAdditionalGoodsFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAdditionalGoodsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAdditionalGoodsForm');
end;

procedure TLoadFormTest.LoadPriceFormTest;
begin

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMCSForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMCSForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMCS_LiteForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMCS_LiteForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRecalcMCS_DialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRecalcMCS_DialogForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceHistoryForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceHistoryForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceOnDateForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceOnDateForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceDialogForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceGoodsDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceGoodsDialogForm');

end;

procedure TLoadFormTest.LoadAlternativeGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TAlternativeGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TAlternativeGroupForm');
end;

procedure TLoadFormTest.LoadCheckVIPFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheckVIPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheckVIPForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheckVIP_ErrorForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheckVIP_ErrorForm');
end;

procedure TLoadFormTest.LoadOverFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOverJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOverJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOverForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOverForm');
end;

procedure TLoadFormTest.LoadOverSettingsFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOverSettingsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOverSettingsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TOverSettingsEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TOverSettingsEditForm');
end;

procedure TLoadFormTest.LoadPaidKindFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPaidKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPaidKindForm');
end;

procedure TLoadFormTest.LoadPaidTypeFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPaidTypeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPaidTypeForm');
end;

 procedure TLoadFormTest.LoadPartnerMedicalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPartnerMedical_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPartnerMedical_ObjectForm');
  //
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPartnerMedicalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPartnerMedicalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPartnerMedicalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPartnerMedicalEditForm');
end;

procedure TLoadFormTest.LoadPaymentFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPaymentJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPaymentJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPaymentForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPaymentForm');
end;

procedure TLoadFormTest.LoadPersonalFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPersonalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPersonalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPersonalEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPersonalEditForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPersonal_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPersonal_ObjectForm');
end;

procedure TLoadFormTest.LoadPersonalGroupFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPersonalGroupForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPersonalGroupForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPersonalGroupEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPersonalGroupEditForm');
end;

procedure TLoadFormTest.LoadPositionEducationFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPositionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPositionForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPositionEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPositionEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TEducationForm'));
  TdsdFormStorageFactory.GetStorage.Load('TEducationForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TEducationEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TEducationEditForm');
end;


procedure TLoadFormTest.LoadChangeIncomePaymentFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TChangeIncomePaymentJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TChangeIncomePaymentJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TChangeIncomePaymentForm'));
  TdsdFormStorageFactory.GetStorage.Load('TChangeIncomePaymentForm');
end;

procedure TLoadFormTest.LoadChangeIncomePaymentKindFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TChangeIncomePaymentKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TChangeIncomePaymentKindForm');
end;

procedure TLoadFormTest.LoadCheckDeferredFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TCheckDeferredForm'));
  TdsdFormStorageFactory.GetStorage.Load('TCheckDeferredForm');
end;

procedure TLoadFormTest.LoadPriceListFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceListForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceListForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceListJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceListJournalForm');
end;

procedure TLoadFormTest.LoadSaleFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSaleJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSaleJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSaleForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSaleForm');
end;

procedure TLoadFormTest.LoadSendFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSendJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSendJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSendForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSendForm');
  // ������ ��������� ���� ����������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceBySendDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceBySendDialogForm');
end;

procedure TLoadFormTest.LoadSendOnPriceFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSendOnPriceJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSendOnPriceJournalForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSendOnPriceForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSendOnPriceForm');
end;

procedure TLoadFormTest.LoadSheetWorkTimeFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSheetWorkTimeJournalForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSheetWorkTimeJournalForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSheetWorkTimeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSheetWorkTimeForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSheetWorkTimeAddRecordForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSheetWorkTimeAddRecordForm');

end;
procedure TLoadFormTest.LoadSPKindFormTest;
begin
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TSPKindForm'));
  TdsdFormStorageFactory.GetStorage.Load('TSPKindForm');
end;

procedure TLoadFormTest.LoadSPObjectFormTest;
begin
  {
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMedicSP_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMedicSP_ObjectForm');
  exit;

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMedicSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMedicSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMedicSPEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMedicSPEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMemberSPEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMemberSPEditForm');
  exit;
  }
  // ����� ������ �� ������������� 1303
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_SaleSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_SaleSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_SaleSPDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_SaleSPDialogForm');
  {exit;
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGroupMemberSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGroupMemberSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGroupMemberSPEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGroupMemberSPEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TKindOutSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TKindOutSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TKindOutSPEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TKindOutSPEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBrandSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBrandSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TBrandSPEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TBrandSPEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIntenalSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIntenalSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TIntenalSPEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TIntenalSPEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsSP_ObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsSP_ObjectForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TGoodsSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TGoodsSPForm');
  exit;
  }
  // ����� �� �������� ������ ���. �������
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_CheckSPForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_CheckSPForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TReport_CheckSPDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TReport_CheckSPDialogForm');

end;

procedure TLoadFormTest.LoadServiceFormTest;
begin
  {
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TFormsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TFormsForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TObjectDescForm'));
  TdsdFormStorageFactory.GetStorage.Load('TObjectDescForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TObjectForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRoleForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRoleForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRoleEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRoleEditForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TRoleUnionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TRoleUnionForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUnionDescForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUnionDescForm');
   }
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUserForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUserForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUserEditForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUserEditForm');
  exit;
  {
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUserKeyForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUserKeyForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TLoadObjectForm'));
  TdsdFormStorageFactory.GetStorage.Load('TLoadObjectForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceGroupSettingsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceGroupSettingsForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPriceGroupSettingsTopForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPriceGroupSettingsTopForm');
  }
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TJuridicalSettingsForm'));
  TdsdFormStorageFactory.GetStorage.Load('TJuridicalSettingsForm');
  exit;
  {
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TActionForm'));
  TdsdFormStorageFactory.GetStorage.Load('TActionForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TUserProtocolForm'));
  TdsdFormStorageFactory.GetStorage.Load('TUserProtocolForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProcessForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProcessForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TProtocolForm'));
  TdsdFormStorageFactory.GetStorage.Load('TProtocolForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMovementProtocolForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMovementProtocolForm');
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMovementItemProtocolForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMovementItemProtocolForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TImportExportLinkForm'));
  TdsdFormStorageFactory.GetStorage.Load('TImportExportLinkForm');
  exit;
  TdsdFormStorageFactory.GetStorage.Save(GetForm('TImportExportLinkTypeForm'));
  TdsdFormStorageFactory.GetStorage.Load('TImportExportLinkTypeForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMovementItemContainerForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMovementItemContainerForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMovementDescDataForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMovementDescDataForm');


  TdsdFormStorageFactory.GetStorage.Save(GetForm('TMovement_PeriodDialogForm'));
  TdsdFormStorageFactory.GetStorage.Load('TMovement_PeriodDialogForm');


  TdsdFormStorageFactory.GetStorage.Save(GetForm('TStatusForm'));
  TdsdFormStorageFactory.GetStorage.Load('TStatusForm');

  TdsdFormStorageFactory.GetStorage.Save(GetForm('TPeriodCloseForm'));
  TdsdFormStorageFactory.GetStorage.Load('TPeriodCloseForm');
  }
end;


initialization
  TestFramework.RegisterTest('�������� ����', TLoadFormTest.Suite);


end.
