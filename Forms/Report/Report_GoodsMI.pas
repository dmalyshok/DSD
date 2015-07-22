unit Report_GoodsMI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxContainer, Vcl.ComCtrls,
  dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdAddOn, ChoicePeriod,
  dxBarExtItems, dxBar, cxClasses, dsdDB, Datasnap.DBClient, dsdAction,
  Vcl.ActnList, cxPropertiesStore, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  dsdGuides, cxButtonEdit, cxCurrencyEdit, Vcl.Menus;

type
  TReport_GoodsMIForm = class(TAncestorReportForm)
    clTradeMarkName: TcxGridDBColumn;
    clGoodsGroupName: TcxGridDBColumn;
    clGoodsCode: TcxGridDBColumn;
    clGoodsName: TcxGridDBColumn;
    clSummPartner_calc: TcxGridDBColumn;
    clAmount_Weight: TcxGridDBColumn;
    cxLabel4: TcxLabel;
    edGoodsGroup: TcxButtonEdit;
    GoodsGroupGuides: TdsdGuides;
    FormParams: TdsdFormParams;
    clAmount_Sh: TcxGridDBColumn;
    edInDescName: TcxTextEdit;
    clAmountPartner_Weight: TcxGridDBColumn;
    clAmountPartner_Sh: TcxGridDBColumn;
    clGoodsKindName: TcxGridDBColumn;
    clSummPartner: TcxGridDBColumn;
    clAmountChangePercent_Sh: TcxGridDBColumn;
    clAmountChangePercent_Weight: TcxGridDBColumn;
    clMeasureName: TcxGridDBColumn;
    cxLabel3: TcxLabel;
    UnitGuides: TdsdGuides;
    edUnit: TcxButtonEdit;
    cxLabel6: TcxLabel;
    edJuridical: TcxButtonEdit;
    cxLabel7: TcxLabel;
    ceInfoMoney: TcxButtonEdit;
    cxLabel5: TcxLabel;
    edPaidKind: TcxButtonEdit;
    InfoMoneyGuides: TdsdGuides;
    PaidKindGuides: TdsdGuides;
    JuridicalGuides: TdsdGuides;
    Amount_10500_Weight: TcxGridDBColumn;
    Amount_10500_Sh: TcxGridDBColumn;
    Amount_40200_Weight: TcxGridDBColumn;
    Amount_40200_Sh: TcxGridDBColumn;
    SummPartner_10200: TcxGridDBColumn;
    SummPartner_10300: TcxGridDBColumn;
    SummDiff: TcxGridDBColumn;
    actPrint: TdsdPrintAction;
    actPrintByGoods: TdsdPrintAction;
    bbPrint: TdxBarButton;
    bbPrintByGoods: TdxBarButton;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    cxLabel8: TcxLabel;
    edUnitGroup: TcxButtonEdit;
    GuidesUnitGroup: TdsdGuides;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
initialization
  RegisterClass(TReport_GoodsMIForm);

end.
