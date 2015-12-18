unit Report_Tara;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorReport, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxContainer, Vcl.ComCtrls,
  dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdAddOn, ChoicePeriod, Vcl.Menus,
  dxBarExtItems, dxBar, cxClasses, dsdDB, Datasnap.DBClient, dsdAction,
  Vcl.ActnList, cxPropertiesStore, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  dsdGuides, cxButtonEdit, cxCheckBox;

type
  TReport_TaraForm = class(TAncestorReportForm)
    chkWithSupplier: TcxCheckBox;
    chbWithBayer: TcxCheckBox;
    chbWithPlace: TcxCheckBox;
    chbWithBranch: TcxCheckBox;
    cxLabel3: TcxLabel;
    edObject: TcxButtonEdit;
    cxLabel4: TcxLabel;
    edGoods: TcxButtonEdit;
    ObjectGuides: TdsdGuides;
    GoodsGuides: TdsdGuides;
    colGoodsCode: TcxGridDBColumn;
    colGoodsName: TcxGridDBColumn;
    colGoodsGroupCode: TcxGridDBColumn;
    colGoodsGroupName: TcxGridDBColumn;
    colObjectCode: TcxGridDBColumn;
    colObjectName: TcxGridDBColumn;
    colObjectDescName: TcxGridDBColumn;
    colObjectType: TcxGridDBColumn;
    colBranchName: TcxGridDBColumn;
    colJuridicalName: TcxGridDBColumn;
    colRetailName: TcxGridDBColumn;
    colRemainsInActive: TcxGridDBColumn;
    colRemainsInPassive: TcxGridDBColumn;
    colRemainsIn: TcxGridDBColumn;
    colAmountIn: TcxGridDBColumn;
    colAmountOut: TcxGridDBColumn;
    colAmountInventory: TcxGridDBColumn;
    colRemainsOutActive: TcxGridDBColumn;
    colRemainsOutPassive: TcxGridDBColumn;
    colRemainsOut: TcxGridDBColumn;
    ExecuteDialog: TExecuteDialog;
    dxBarButton1: TdxBarButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report_TaraForm: TReport_TaraForm;

implementation

{$R *.dfm}

initialization
  registerClass(TReport_TaraForm);

end.