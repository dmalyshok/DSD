unit CashJournalUser;

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
  dxSkinscxPCPainter, dxSkinsdxBarPainter, Vcl.Menus, cxCurrencyEdit, dsdGuides,
  cxButtonEdit;

type
  TCashJournalUserForm = class(TAncestorJournalForm)
    AmountOut: TcxGridDBColumn;
    InfoMoneyCode: TcxGridDBColumn;
    InfoMoneyGroupName: TcxGridDBColumn;
    InfoMoneyDestinationName: TcxGridDBColumn;
    Comment: TcxGridDBColumn;
    ContractInvNumber: TcxGridDBColumn;
    MoneyPlaceCode: TcxGridDBColumn;
    ceCash: TcxButtonEdit;
    cxLabel3: TcxLabel;
    CashGuides: TdsdGuides;
    InfoMoneyName_all: TcxGridDBColumn;
    MemberName: TcxGridDBColumn;
    PositionName: TcxGridDBColumn;
    ItemName: TcxGridDBColumn;
    actReport_CashUser: TdsdOpenForm;
    bbReport_CashUser: TdxBarButton;
    OKPO: TcxGridDBColumn;
    isLoad: TcxGridDBColumn;
    PartionMovementName: TcxGridDBColumn;
    ExecuteDialog: TExecuteDialog;
    PersonalServiceListCode: TcxGridDBColumn;
    PersonalServiceListName: TcxGridDBColumn;
    cxLabel15: TcxLabel;
    ceCurrency: TcxButtonEdit;
    CurrencyGuides: TdsdGuides;
    cxLabel27: TcxLabel;
    edJuridicalBasis: TcxButtonEdit;
    JuridicalBasisGuides: TdsdGuides;
    spGet_UserJuridicalBasis: TdsdStoredProc;
    actRefreshStart: TdsdDataSetRefresh;
    UnitName_Mobile: TcxGridDBColumn;
    PositionName_Mobile: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TCashJournalUserForm);

end.
