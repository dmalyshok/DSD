unit Income;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDocument, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxCurrencyEdit, dsdAddOn,
  dsdAction, cxCheckBox, dsdGuides, dsdDB, Vcl.Menus, dxBarExtItems, dxBar,
  cxClasses, Datasnap.DBClient, Vcl.ActnList, cxPropertiesStore, cxButtonEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, cxTextEdit, Vcl.ExtCtrls,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, cxPC, dxBarBuiltInMenu, cxNavigator, cxImageComboBox,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinscxPCPainter, dxSkinsdxBarPainter,
  cxCalc;

type
  TIncomeForm = class(TAncestorDocumentForm)
    cxLabel3: TcxLabel;
    edFrom: TcxButtonEdit;
    edTo: TcxButtonEdit;
    cxLabel4: TcxLabel;
    GuidesFrom: TdsdGuides;
    GuidesTo: TdsdGuides;
    colCode: TcxGridDBColumn;
    colName: TcxGridDBColumn;
    colAmount: TcxGridDBColumn;
    actGoodsKindChoice: TOpenChoiceForm;
    spSelectPrint: TdsdStoredProc;
    N2: TMenuItem;
    N3: TMenuItem;
    RefreshDispatcher: TRefreshDispatcher;
    actRefreshPrice: TdsdDataSetRefresh;
    PrintHeaderCDS: TClientDataSet;
    bbPrintTax: TdxBarButton;
    PrintItemsCDS: TClientDataSet;
    bbTax: TdxBarButton;
    bbPrintTax_Client: TdxBarButton;
    bbPrint_Bill: TdxBarButton;
    PrintItemsSverkaCDS: TClientDataSet;
    colSumm: TcxGridDBColumn;
    edPriceWithVAT: TcxCheckBox;
    cxLabel10: TcxLabel;
    edNDSKind: TcxButtonEdit;
    NDSKindGuides: TdsdGuides;
    colPrice: TcxGridDBColumn;
    colPartnerGoodsCode: TcxGridDBColumn;
    colPartnerGoodsName: TcxGridDBColumn;
    ContractGuides: TdsdGuides;
    cxLabel5: TcxLabel;
    edContract: TcxButtonEdit;
    edPaymentDate: TcxDateEdit;
    cxLabel6: TcxLabel;
    colExpirationDate: TcxGridDBColumn;
    ceTotalSummMVAT: TcxCurrencyEdit;
    ceTotalSummPVAT: TcxCurrencyEdit;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    colPartitionGoods: TcxGridDBColumn;
    colMakerName: TcxGridDBColumn;
    actRefreshGoodsCode: TdsdExecStoredProc;
    bbRefreshGoodsCode: TdxBarButton;
    spIncome_GoodsId: TdsdStoredProc;
    colFEA: TcxGridDBColumn;
    colMeasure: TcxGridDBColumn;
    spCalculateSalePrice: TdsdStoredProc;
    actCalculateSalePrice: TdsdExecStoredProc;
    bbCalculateSalePrice: TdxBarButton;
    colSalePrice: TcxGridDBColumn;
    colSaleSumm: TcxGridDBColumn;
    colPercent: TcxGridDBColumn;
    colPriceWithVAT: TcxGridDBColumn;
    cxLabel9: TcxLabel;
    edPointNumber: TcxTextEdit;
    cxLabel11: TcxLabel;
    edPointDate: TcxDateEdit;
    cbFarmacyShow: TcxCheckBox;
    cxLabel12: TcxLabel;
    colDublePriceColour: TcxGridDBColumn;
    colSertificatNumber: TcxGridDBColumn;
    colSertificatStart: TcxGridDBColumn;
    colSertificatEnd: TcxGridDBColumn;
    colWarningColor: TcxGridDBColumn;
    colAVGIncomePrice: TcxGridDBColumn;
    colAVGIncomePriceWarning: TcxGridDBColumn;
    cxLabel13: TcxLabel;
    edJuridical: TcxButtonEdit;
    GuidesJuridical: TdsdGuides;
    colAmountManual: TcxGridDBColumn;
    colReasonDifferencesName: TcxGridDBColumn;
    colAmountDiff: TcxGridDBColumn;
    spUpdate_MovementItem_Income_AmountManual: TdsdStoredProc;
    ceCorrBonus: TcxCurrencyEdit;
    cxLabel14: TcxLabel;
    cxLabel16: TcxLabel;
    ceCorrOther: TcxCurrencyEdit;
    chbIsPay: TcxCheckBox;
    ��DateLastPay: TcxDateEdit;
    cxLabel17: TcxLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DataModul;

initialization
  RegisterClass(TIncomeForm);

end.
