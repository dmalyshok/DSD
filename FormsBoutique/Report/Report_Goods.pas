unit Report_Goods;

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
  dsdGuides, cxButtonEdit, cxCurrencyEdit, Vcl.Menus, cxCheckBox, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  cxSplitter;

type
  TReport_GoodsForm = class(TAncestorReportForm)
    cxLabel3: TcxLabel;
    edPartionGoods: TcxButtonEdit;
    GuidesPartionGoods: TdsdGuides;
    LocationDescName: TcxGridDBColumn;
    LocationName: TcxGridDBColumn;
    GoodsCode: TcxGridDBColumn;
    GoodsName: TcxGridDBColumn;
    MovementDescName: TcxGridDBColumn;
    SummStart: TcxGridDBColumn;
    SummIn: TcxGridDBColumn;
    SummOut: TcxGridDBColumn;
    SummEnd: TcxGridDBColumn;
    InvNumber: TcxGridDBColumn;
    OperDate: TcxGridDBColumn;
    AmountStart: TcxGridDBColumn;
    clOperPrice: TcxGridDBColumn;
    actPrint: TdsdPrintAction;
    bbPrint: TdxBarButton;
    isActive: TcxGridDBColumn;
    MovementId: TcxGridDBColumn;
    isRemains: TcxGridDBColumn;
    cxLabel8: TcxLabel;
    edUnitGroup: TcxButtonEdit;
    GuidesUnit: TdsdGuides;
    cbGoodsSize: TcxCheckBox;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    getMovementForm: TdsdStoredProc;
    actGetForm: TdsdExecStoredProc;
    actOpenForm: TdsdOpenForm;
    actOpenDocument: TMultiAction;
    bbOpenDocument: TdxBarButton;
    FormParams: TdsdFormParams;
    cxLabel4: TcxLabel;
    edGoodsSize: TcxButtonEdit;
    GuidesGoodsSize: TdsdGuides;
    cbSumm_branch: TcxCheckBox;
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    dsdDBViewAddOn1: TdsdDBViewAddOn;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    PartionId: TcxGridDBColumn;
    actRefreshIsGoodsSize: TdsdDataSetRefresh;
    cbPartion: TcxCheckBox;
    cxLabel5: TcxLabel;
    edPartion: TcxButtonEdit;
    GuidesPartion: TdsdGuides;
    actRefreshIsPartion: TdsdDataSetRefresh;
    actRefreshIsPeriod: TdsdDataSetRefresh;
    cbPeriod: TcxCheckBox;
    InvNumberAll: TcxGridDBColumn;
    LocationDescName_by: TcxGridDBColumn;
    LocationCode_by: TcxGridDBColumn;
    LocationName_by: TcxGridDBColumn;
    OperPriceList: TcxGridDBColumn;
    PartnerName: TcxGridDBColumn;
    Amount: TcxGridDBColumn;
    UnitName: TcxGridDBColumn;
    Amount_PartionMI: TcxGridDBColumn;
    OperDate_PartionMI: TcxGridDBColumn;
    InvNumber_PartionMI: TcxGridDBColumn;
    actReport_CollationByPartner: TdsdOpenForm;
    bbReport_CollationByPartner: TdxBarButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
initialization
  RegisterClass(TReport_GoodsForm);

end.
