unit dsdGuides;

interface

uses Classes, Controls;

type

  TAccessControl = class(Controls.TWinControl)
  public
    property OnDblClick;
  end;

  // ��������� �������� �� �������������. �������� �������� �� ��������� ���������� ��� ����
  TdsdGuides = class(TComponent)
  private
    FFormName: string;
    FLookupControl: TWinControl;
    FKey: String;
    FTextValue: String;
    FPositionDataSet: string;
    function GetKey: String;
    function GetTextValue: String;
    procedure SetKey(const Value: String);
    procedure SetTextValue(const Value: String);
    procedure SetLookupControl(const Value: TWinControl);
    procedure OpenGuides;
    procedure OnDblClick(Sender: TObject);
    procedure OnButtonClick(Sender: TObject; AButtonIndex: Integer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    // �������� ��������� ����� ������ �������� �� �����������
    procedure AfterChoice(AKey, ATextValue: string);
  published
    property Key: String read GetKey write SetKey;
    property TextValue: String read GetTextValue write SetTextValue;
    property LookupControl: TWinControl read FLookupControl write SetLookupControl;
    property FormName: string read FFormName write FFormName;
    property PositionDataSet: string read FPositionDataSet write FPositionDataSet;
  end;

  procedure Register;

implementation

uses cxDBLookupComboBox, cxButtonEdit, Variants, ParentForm, FormStorage, DB, dsdDB,
     SysUtils;

procedure Register;
begin
   RegisterComponents('DSDComponent', [TdsdGuides]);
end;

{ TdsdGuides }

procedure TdsdGuides.AfterChoice(AKey, ATextValue: string);
begin
  // �������� ��������� �� ���� ����. ���
  Key := AKey;
  TextValue := ATextValue;
end;

constructor TdsdGuides.Create(AOwner: TComponent);
begin
  inherited;
  PositionDataSet := 'ClientDataSet';
end;

function TdsdGuides.GetKey: String;
begin
  FKey := '';
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then
        // �������� ������ �� �������
        if VarisNull((LookupControl as TcxLookupComboBox).EditValue) then
           Result := '0'
        else
           Result := (LookupControl as TcxLookupComboBox).EditValue;
  end;
end;

function TdsdGuides.GetTextValue: String;
begin
  result := FTextValue
end;

procedure TdsdGuides.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FLookupControl) then
     FLookupControl := nil;
end;

procedure TdsdGuides.OnButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  OnDblClick(Sender);
end;

procedure TdsdGuides.OnDblClick(Sender: TObject);
begin
  OpenGuides;
end;

procedure TdsdGuides.OpenGuides;
var
  Form: TParentForm;
  DataSet: TDataSet;
begin
  Form := TdsdFormStorageFactory.GetStorage.Load(FormName);
  // ������� �����
  Form.Execute(Self, nil);
  // ������������������ �� ���� ����
  DataSet := Form.FindComponent(PositionDataSet) as TDataSet;
  if not Assigned(DataSet) then
     raise Exception.Create('�� ��������� ����������� �������� PositionDataSet ��� ����� ' + FormName);
  if Key <> '' then
     DataSet.Locate('Id', Key, []);
  Form.Show;
end;

procedure TdsdGuides.SetKey(const Value: String);
begin
  if Value = '' then
     FKey := '0'
  else
     FKey := Value;
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then
        (LookupControl as TcxLookupComboBox).EditValue := FKey
  end;
end;

procedure TdsdGuides.SetLookupControl(const Value: TWinControl);
begin
  FLookupControl := Value;
  TAccessControl(FLookupControl).OnDblClick := OnDblClick;
  if FLookupControl is TcxButtonEdit then
     (LookupControl as TcxButtonEdit).Properties.OnButtonClick := OnButtonClick;
end;

procedure TdsdGuides.SetTextValue(const Value: String);
begin
  FTextValue := Value;
  if Assigned(LookupControl) then begin
     if LookupControl is TcxLookupComboBox then
        (LookupControl as TcxLookupComboBox).Text := Value;
     if LookupControl is TcxButtonEdit then
        (LookupControl as TcxButtonEdit).Text := Value;
  end;
end;

initialization
  RegisterClass(TdsdGuides);

end.


