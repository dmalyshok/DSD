unit PromoCodeDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AncestorDialog, Vcl.ActnList, dsdAction,
  cxClasses, cxPropertiesStore, dsdAddOn, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus,
  Vcl.StdCtrls, cxButtons, cxTextEdit, Vcl.ExtCtrls, dsdGuides, dsdDB,
  cxMaskEdit, cxButtonEdit, AncestorBase, dxSkinsCore, dxSkinsDefaultPainters, Data.DB;

type
  TPromoCodeDialogForm = class(TAncestorDialogForm)
    edPromoCode: TcxTextEdit;
    Label2: TLabel;
    spGet_PromoCode_by_GUID: TdsdStoredProc;
    procedure bbOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    function PromoCodeDialogExecute(var APromoCodeID: Integer; var APromoCodeGUID, APromoName: string;
                                    var APromoCodeChangePercent: currency): boolean;
  end;

  // �������� ����� �� ��� ��������� ������ ������ �� ���������
  function CheckIfGoodsIdInPromo(APromoCodeId, AGoodsId: integer): boolean;

implementation

{$R *.dfm}

function CheckIfGoodsIdInPromo(APromoCodeId, AGoodsId: integer): boolean;
var dsdCheckPromo: TdsdStoredProc;
begin
  dsdCheckPromo := TdsdStoredProc.Create(nil);
  try
    dsdCheckPromo.StoredProcName := 'gpGet_IsGoodsInPromo';
    dsdCheckPromo.OutputType := otResult;
    dsdCheckPromo.Params.Clear;
    dsdCheckPromo.Params.AddParam('inPromoCodeId',ftInteger,ptInput,APromoCodeId);
    dsdCheckPromo.Params.AddParam('inGoodsId',ftInteger,ptInput,AGoodsId);
    dsdCheckPromo.Params.AddParam('outResult',ftBoolean,ptOutput,Null);
    dsdCheckPromo.Execute(false,false);
    Result := dsdCheckPromo.ParamByName('outResult').Value;
  finally
    FreeAndNil(dsdCheckPromo);
  end;
end;

procedure TPromoCodeDialogForm.bbOkClick(Sender: TObject);
var lMsg:String;
begin
  if Length(trim(edPromoCode.Text)) = 8 then
  begin
    spGet_PromoCode_by_GUID.Execute;
    ModalResult := mrOk;
  end
  else
  begin
    ActiveControl := edPromoCode;
    ShowMessage ('������. �������� <��������> �� ����������. ����� ��������� ������ ���� 8 ��������');
  end;
end;

function TPromoCodeDialogForm.PromoCodeDialogExecute(var APromoCodeID: Integer; var APromoCodeGUID, APromoName: string;
                                                     var APromoCodeChangePercent: currency): boolean;
begin
  edPromoCode.Text:= APromoCodeGUID;
  Result := ShowModal = mrOK;
  if Result then
  begin
    APromoCodeID := FormParams.ParamByName('PromoCodeID').Value;
    APromoCodeGUID := FormParams.ParamByName('PromoCodeGUID').Value;
    APromoName := FormParams.ParamByName('PromoName').Value;
    APromoCodeChangePercent := FormParams.ParamByName('PromoCodeChangePercent').Value;
  end
  else
  begin
    APromoCodeID := 0;
    APromoCodeGUID := '';
    APromoName := '';
    APromoCodeChangePercent := 0;
  end;
end;

End.
