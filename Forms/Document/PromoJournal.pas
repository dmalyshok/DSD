unit PromoJournal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorJournal, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinscxPCPainter, cxPCdxBarPopupMenu, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, Data.DB, cxDBData, cxImageComboBox,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, dxSkinsdxBarPainter, dsdDB,
  dsdAddOn, ChoicePeriod, Vcl.Menus, dxBarExtItems, dxBar, cxClasses,
  Datasnap.DBClient, dsdAction, Vcl.ActnList, cxPropertiesStore, cxLabel,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.ExtCtrls, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGrid, cxPC, cxCurrencyEdit, cxCheckBox, dsdGuides, cxButtonEdit,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue;

type
  TPromoJournalForm = class(TAncestorJournalForm)
    PromoKindName: TcxGridDBColumn;
    PriceListName: TcxGridDBColumn;
    StartPromo: TcxGridDBColumn;
    EndPromo: TcxGridDBColumn;
    StartSale: TcxGridDBColumn;
    EndSale: TcxGridDBColumn;
    CostPromo: TcxGridDBColumn;
    UnitName: TcxGridDBColumn;
    Comment: TcxGridDBColumn;
    PersonalTradeName: TcxGridDBColumn;
    PersonalName: TcxGridDBColumn;
    dxBarButton1: TdxBarButton;
    spSelect_Movement_Promo_Print: TdsdStoredProc;
    PrintHead: TClientDataSet;
    actPrint: TdsdPrintAction;
    PartnerName: TcxGridDBColumn;
    PartnerDescName: TcxGridDBColumn;
    ContractName: TcxGridDBColumn;
    ContractTagName: TcxGridDBColumn;
    CommentMain: TcxGridDBColumn;
    spUpdate_Movement_Promo_Data: TdsdStoredProc;
    mactUpdate_Movement_Promo_Data: TMultiAction;
    actUpdate_Movement_Promo_Data: TdsdExecStoredProc;
    dxBarButton2: TdxBarButton;
    N13: TMenuItem;
    N14: TMenuItem;
    dsdDataSetRefresh1: TdsdDataSetRefresh;
    chbPeriodForOperDate: TcxCheckBox;
    actUpdate_Promo_Data_before: TdsdExecStoredProc;
    spUpdate_Movement_Promo_Data_before: TdsdStoredProc;
    spUpdate_Movement_Promo_Data_after: TdsdStoredProc;
    actUpdate_Promo_Data_after: TdsdExecStoredProc;
    mactUpdate_Movement_Promo_Data_all: TMultiAction;
    ChangePercentName: TcxGridDBColumn;
    ExecuteDialog: TExecuteDialog;
    EndReturn: TcxGridDBColumn;
    cxLabel27: TcxLabel;
    edJuridicalBasis: TcxButtonEdit;
    JuridicalBasisGuides: TdsdGuides;
    spGet_UserJuridicalBasis: TdsdStoredProc;
    actRefreshStart: TdsdDataSetRefresh;
    MonthPromo: TcxGridDBColumn;
    CheckDate: TcxGridDBColumn;
    spInsertUpdateMISign: TdsdStoredProc;
    spInsertUpdateMISign_No: TdsdStoredProc;
    actInsertUpdateMISign0: TdsdExecStoredProc;
    actInsertUpdateMISign1: TMultiAction;
    actInsertUpdateMISignList: TMultiAction;
    actInsertUpdateMISignNO: TdsdExecStoredProc;
    actInsertUpdateMISignNO1: TMultiAction;
    actInsertUpdateMISignNOList: TMultiAction;
    bbSignList: TdxBarButton;
    bbSignNOList: TdxBarButton;
    DayCount: TcxGridDBColumn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TPromoJournalForm);

end.
