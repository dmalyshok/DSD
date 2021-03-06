unit TransportService;

interface

uses
   AncestorEditDialog, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dsdGuides, cxDropDownEdit, cxCalendar, cxMaskEdit, cxButtonEdit, cxTextEdit,
  cxCurrencyEdit, Vcl.Controls, cxLabel, dsdDB, dsdAction, System.Classes,
  Vcl.ActnList, cxPropertiesStore, dsdAddOn, Vcl.StdCtrls, cxButtons,
  dxSkinsCore, dxSkinsDefaultPainters;

type
  TTransportServiceForm = class(TAncestorEditDialogForm)
    cxLabel1: TcxLabel;
    ���: TcxLabel;
    ceInvNumber: TcxCurrencyEdit;
    cxLabel3: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel67: TcxLabel;
    cxLabel5: TcxLabel;
    ceContractConditionKind: TcxButtonEdit;
    cePaidKind: TcxButtonEdit;
    ceRoute: TcxButtonEdit;
    ceInfoMoney: TcxButtonEdit;
    ceOperDate: TcxDateEdit;
    ceCar: TcxButtonEdit;
    cxLabel9: TcxLabel;
    ContractConditionKindGuides_Old: TdsdGuides;
    PaidKindGuides: TdsdGuides;
    RouteGuides: TdsdGuides;
    InfoMoneyGuides: TdsdGuides;
    CarGuides: TdsdGuides;
    ceJuridical: TcxButtonEdit;
    cxLabel6: TcxLabel;
    GuidesFiller: TGuidesFiller;
    ceContract: TcxButtonEdit;
    cxLabel8: TcxLabel;
    cxLabel10: TcxLabel;
    ceComment: TcxTextEdit;
    ContractGuides: TdsdGuides;
    cxLabel4: TcxLabel;
    ceDistance: TcxCurrencyEdit;
    cxLabel11: TcxLabel;
    cePrice: TcxCurrencyEdit;
    cxLabel12: TcxLabel;
    ceCountPoint: TcxCurrencyEdit;
    cxLabel13: TcxLabel;
    ceTrevelTime: TcxCurrencyEdit;
    ContractJuridicalGuides: TdsdGuides;
    cxLabel7: TcxLabel;
    ceUnit: TcxButtonEdit;
    UnitGuides: TdsdGuides;
    cxLabel14: TcxLabel;
    edStartRunPlan: TcxDateEdit;
    cxLabel15: TcxLabel;
    edStartRun: TcxDateEdit;
    cxLabel16: TcxLabel;
    ceWeightTransport: TcxCurrencyEdit;
    ContractConditionKindGuides: TdsdGuides;
    cxLabel17: TcxLabel;
    ceValue: TcxCurrencyEdit;
    cxLabel18: TcxLabel;
    ceSummAdd: TcxCurrencyEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
initialization
  RegisterClass(TTransportServiceForm);

end.
