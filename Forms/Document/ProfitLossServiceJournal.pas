unit ProfitLossServiceJournal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorJournal, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxPCdxBarPopupMenu, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, Data.DB, cxDBData,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dsdAddOn, ChoicePeriod,
  dxBarExtItems, dxBar, cxClasses, dsdDB, Datasnap.DBClient, dsdAction,
  Vcl.ActnList, cxPropertiesStore, cxLabel, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxPC,
  cxCheckBox, cxImageComboBox, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, dxSkinsdxBarPainter, Vcl.Menus, cxCurrencyEdit,
  cxButtonEdit, dsdGuides;

type
  TProfitLossServiceJournalForm = class(TAncestorJournalForm)
    colAmountOut: TcxGridDBColumn;
    clInfoMoneyCode: TcxGridDBColumn;
    clInfoMoneyGroupName: TcxGridDBColumn;
    clInfoMoneyDestinationName: TcxGridDBColumn;
    clComment: TcxGridDBColumn;
    clContractInvNumber: TcxGridDBColumn;
    clJuridicalCode: TcxGridDBColumn;
    clContractConditionKindName: TcxGridDBColumn;
    N13: TMenuItem;
    actReCompleteAll: TdsdExecStoredProc;
    spMovementReCompleteAll: TdsdStoredProc;
    bbReCompleteAll: TdxBarButton;
    clBonusKindName: TcxGridDBColumn;
    clisLoad: TcxGridDBColumn;
    clContractMasterInvNumber: TcxGridDBColumn;
    clContractChildInvNumber: TcxGridDBColumn;
    BonusValue: TcxGridDBColumn;
    AmountPartner: TcxGridDBColumn;
    Summ: TcxGridDBColumn;
    JuridicalCode_Child: TcxGridDBColumn;
    JuridicalName_Child: TcxGridDBColumn;
    OKPO_Child: TcxGridDBColumn;
    ExecuteDialog: TExecuteDialog;
    cxLabel27: TcxLabel;
    edJuridicalBasis: TcxButtonEdit;
    JuridicalBasisGuides: TdsdGuides;
    spGet_UserJuridicalBasis: TdsdStoredProc;
    actRefreshStart: TdsdDataSetRefresh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TProfitLossServiceJournalForm);

end.
