unit Report_CheckSP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB,
  cxDBData, cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dsdAddOn,
  ChoicePeriod, Vcl.Menus, dxBarExtItems, dxBar, cxClasses, dsdDB,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxLabel,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxPC, dsdGuides, cxButtonEdit, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinscxPCPainter, cxPCdxBarPopupMenu,
  dxSkinsdxBarPainter, cxCheckBox;

type
  TReport_CheckSPForm = class(TAncestorReportForm)
    dxBarButton1: TdxBarButton;
    IntenalSPName: TcxGridDBColumn;
    Amount: TcxGridDBColumn;
    actGet_UserUnit: TdsdExecStoredProc;
    actRefreshStart: TdsdDataSetRefresh;
    UnitName: TcxGridDBColumn;
    BrandSPName: TcxGridDBColumn;
    PriceSP: TcxGridDBColumn;
    actRefreshIsPartion: TdsdDataSetRefresh;
    CountSP: TcxGridDBColumn;
    ExecuteDialog: TExecuteDialog;
    bbExecuteDialog: TdxBarButton;
    actRefreshPartionPrice: TdsdDataSetRefresh;
    KindOutSPName: TcxGridDBColumn;
    actPrint: TdsdPrintAction;
    bbPrint: TdxBarButton;
    NumLine: TcxGridDBColumn;
    cxLabel3: TcxLabel;
    ceUnit: TcxButtonEdit;
    UnitGuides: TdsdGuides;
    cxLabel4: TcxLabel;
    edJuridical: TcxButtonEdit;
    JuridicalGuides: TdsdGuides;
    cxLabel5: TcxLabel;
    ceHospital: TcxButtonEdit;
    HospitalGuides: TdsdGuides;
    actPrint1: TdsdPrintAction;
    bbPrint1: TdxBarButton;
    OperDate: TcxGridDBColumn;
    InvNumberSP: TcxGridDBColumn;
    MedicSPName: TcxGridDBColumn;
    ContractName: TcxGridDBColumn;
    Contract_StartDate: TcxGridDBColumn;
    cbisInsert: TcxCheckBox;
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    actPrintInvoice: TdsdPrintAction;
    spSavePrintMovement: TdsdStoredProc;
    actSaveMovement: TdsdExecStoredProc;
    macPrintInvoice: TMultiAction;
    bbPrintInvoice: TdxBarButton;
    cxLabel8: TcxLabel;
    edInvoice: TcxTextEdit;
    cxLabel7: TcxLabel;
    edDateInvoice: TcxDateEdit;
    actGetReportNameSP: TdsdExecStoredProc;
    mactPrint_Pact: TMultiAction;
    actPrintPact: TdsdPrintAction;
    FormParams: TdsdFormParams;
    spGetReporNameSP: TdsdStoredProc;
    bbPrint_Pact: TdxBarButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report_CheckSPForm: TReport_CheckSPForm;

implementation

{$R *.dfm}

initialization

  RegisterClass(TReport_CheckSPForm)
end.
