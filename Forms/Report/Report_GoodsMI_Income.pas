unit Report_GoodsMI_Income;

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
  dsdGuides, cxButtonEdit, cxCurrencyEdit, Vcl.Menus, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TReport_GoodsMI_IncomeForm = class(TAncestorReportForm)
    TradeMarkName: TcxGridDBColumn;
    GoodsGroupName: TcxGridDBColumn;
    GoodsCode: TcxGridDBColumn;
    GoodsName: TcxGridDBColumn;
    Summ: TcxGridDBColumn;
    Amount_Weight: TcxGridDBColumn;
    cxLabel4: TcxLabel;
    edGoodsGroup: TcxButtonEdit;
    GoodsGroupGuides: TdsdGuides;
    FormParams: TdsdFormParams;
    Amount_Sh: TcxGridDBColumn;
    edInDescName: TcxTextEdit;
    AmountPartner_Weight: TcxGridDBColumn;
    AmountPartner_Sh: TcxGridDBColumn;
    GoodsKindName: TcxGridDBColumn;
    PaidKindName: TcxGridDBColumn;
    FuelKindName: TcxGridDBColumn;
    cxLabel3: TcxLabel;
    edUnit: TcxButtonEdit;
    UnitGuides: TdsdGuides;
    cxLabel5: TcxLabel;
    edUnitGroup: TcxButtonEdit;
    GuidesUnitGroup: TdsdGuides;
    cxLabel6: TcxLabel;
    edPaidKind: TcxButtonEdit;
    PaidKindGuides: TdsdGuides;
    ExecuteDialog: TExecuteDialog;
    bb: TdxBarButton;
    cxLabel7: TcxLabel;
    edJuridical: TcxButtonEdit;
    JuridicalGuides: TdsdGuides;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
initialization
  RegisterClass(TReport_GoodsMI_IncomeForm);

end.
