unit dsdActionUnit;

interface

uses VCL.ActnList, Forms, Classes, dsdDataSetWrapperUnit, FormUnit, DB;

type

  TDataSetAcionType = (acInsert, acUpdate);

  TdsdStoredProcItem = class(TCollectionItem)
  private
    FStoredProc: TdsdStoredProc;
  published
    property StoredProc: TdsdStoredProc read FStoredProc write FStoredProc;
  end;

  TdsdStoredProcList = class(TCollection)
  private
    function GetItem(Index: Integer): TdsdStoredProcItem;
    procedure SetItem(Index: Integer; const Value: TdsdStoredProcItem);
  public
    function Add: TdsdStoredProcItem;
    property Items[Index: Integer]: TdsdStoredProcItem read GetItem write SetItem; default;
  end;

  TdsdCustomDataSetAction = class(TCustomAction)
  private
    FStoredProcList: TdsdStoredProcList;
    function GetStoredProc: TdsdStoredProc;
    procedure SetStoredProc(const Value: TdsdStoredProc);
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property StoredProc: TdsdStoredProc read GetStoredProc write SetStoredProc;
    property StoredProcList: TdsdStoredProcList read FStoredProcList write FStoredProcList;
    property Caption;
    property Hint;
    property ShortCut;
  end;

  TdsdDataSetRefresh = class(TdsdCustomDataSetAction)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdsdExecStoredProc = class(TdsdCustomDataSetAction)

  end;

  IDataSetAction = interface
    procedure DataSetChanged;
  end;

  TdsdUpdateErased = class;

  TDataSetDataLink = class(TDataLink)
  private
    FAction: IDataSetAction;
  protected
    procedure DataSetChanged; override;
  public
    constructor Create(Action: IDataSetAction);
  end;

  TdsdUpdateErased = class(TdsdCustomDataSetAction, IDataSetAction)
  private
    FActionDataLink: TDataSetDataLink;
    FisSetErased: boolean;
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetisSetErased(const Value: boolean);
  public
    procedure DataSetChanged;
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property isSetErased: boolean read FisSetErased write SetisSetErased default true;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TdsdOpenForm = class(TCustomAction)
  private
    FParams: TdsdParams;
    FFormName: string;
    FisShowModal: boolean;
  protected
    procedure BeforeExecute(Form: TParentForm); virtual;
  public
    function Execute: boolean; override;
    constructor Create(AOwner: TComponent); override;
  published
    property Caption;
    property Hint;
    property ShortCut;
    property FormName: string read FFormName write FFormName;
    property GuiParams: TdsdParams read FParams write FParams;
    property isShowModal: boolean read FisShowModal write FisShowModal;
  end;

  // ������ ����� ��������� ��������� ������ TdsdOpenForm �� ������ �� �������������
  // � ��������� ������������ ����� ������� ����
  TdsdInsertUpdateAction = class (TdsdOpenForm, IDataSetAction)
  private
    FActionDataLink: TDataSetDataLink;
    FdsdDataSetRefresh: TdsdDataSetRefresh;
    FForm: TParentForm;
    FActionType: TDataSetAcionType;
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);
    function GetDataSource: TDataSource;
    procedure SetDataSource(const Value: TDataSource);
  protected
    procedure BeforeExecute(Form: TParentForm); override;
  public
    procedure DataSetChanged;
    constructor Create(AOwner: TComponent); override;
  published
    property ActionType: TDataSetAcionType read FActionType write FActionType default acInsert;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataSetRefresh: TdsdDataSetRefresh read FdsdDataSetRefresh write FdsdDataSetRefresh;
  end;


  TdsdFormClose = class(TCustomAction)
  public
    function Execute: boolean; override;
  end;

  procedure Register;

implementation

uses Windows, StorageUnit, SysUtils, CommonDataUnit, UtilConvert, FormStorageUnit;

procedure Register;
begin
  RegisterActions('DSDLib', [TdsdDataSetRefresh], TdsdDataSetRefresh);
  RegisterActions('DSDLib', [TdsdExecStoredProc], TdsdExecStoredProc);
  RegisterActions('DSDLib', [TdsdOpenForm], TdsdOpenForm);
  RegisterActions('DSDLib', [TdsdFormClose], TdsdFormClose);
  RegisterActions('DSDLib', [TdsdInsertUpdateAction], TdsdInsertUpdateAction);
  RegisterActions('DSDLib', [TdsdUpdateErased], TdsdUpdateErased);
end;

{ TdsdCustomDataSetAction }

constructor TdsdCustomDataSetAction.Create(AOwner: TComponent);
begin
  inherited;
  FStoredProcList := TdsdStoredProcList.Create(TdsdStoredProcItem);
end;

function TdsdCustomDataSetAction.Execute: boolean;
var i: integer;
begin
  result := true;
  for I := 0 to StoredProcList.Count - 1  do
      if Assigned(StoredProcList[i]) then
         StoredProcList[i].StoredProc.Execute
end;


function TdsdCustomDataSetAction.GetStoredProc: TdsdStoredProc;
begin
  if StoredProcList.Count > 0 then
     result := StoredProcList[0].StoredProc
  else
     result := nil
end;

procedure TdsdCustomDataSetAction.SetStoredProc(const Value: TdsdStoredProc);
begin
  // ���� ��������������� ���
  if Value <> nil then begin
     if StoredProcList.Count > 0 then
        StoredProcList[0].StoredProc := Value
     else
        StoredProcList.Add.StoredProc := Value;
  end
  else begin
    //���� �������� � NIL
    if StoredProcList.Count > 0 then
       StoredProcList.Delete(0);
  end;
end;

{ TdsdDataSetRefresh }

constructor TdsdDataSetRefresh.Create(AOwner: TComponent);
begin
  inherited;
  Caption := '����������';
  Hint:='�������� ������';
  ShortCut:=VK_F5
end;

{ TdsdOpenForm }

procedure TdsdOpenForm.BeforeExecute;
begin

end;

constructor TdsdOpenForm.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TdsdParams.Create(TdsdParam);
end;

function TdsdOpenForm.Execute: boolean;
var
  Form: TParentForm;
begin
  Form := TdsdFormStorageFactory.GetStorage.Load(FormName);
  BeforeExecute(Form);
  Form.Execute(FParams);
  if isShowModal then
     Form.ShowModal
  else
     Form.Show
end;

{ TdsdFormClose }

function TdsdFormClose.Execute: boolean;
begin
  if Owner is TForm then
     (Owner as TForm).Close;
end;

{ TdsdInsertUpdateAction }

procedure TdsdInsertUpdateAction.BeforeExecute;
begin
  // ������ � ����� CallBack �� ������� �������� �����
  Form.OnClose := OnFormClose;
  FForm := Form;
end;

constructor TdsdInsertUpdateAction.Create(AOwner: TComponent);
begin
  inherited;
  FActionDataLink := TDataSetDataLink.Create(Self);
end;

procedure TdsdInsertUpdateAction.DataSetChanged;
begin
  Enabled := false;
  if Assigned(DataSource) then
     if Assigned(DataSource.DataSet) then
        Enabled := (ActionType = acInsert) or (DataSource.DataSet.RecordCount <> 0)
end;

function TdsdInsertUpdateAction.GetDataSource: TDataSource;
begin
  result := FActionDataLink.DataSource
end;

procedure TdsdInsertUpdateAction.OnFormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  // ������� ���������� � ������ �������� ����� ���������� ��������� �����������.
  // ���������� � ����� ������ ���������� ������ � ������������������� � ���
  DataSetRefresh.Execute;
  if Assigned(DataSource) then
     if Assigned(DataSource.DataSet) then
        DataSource.DataSet.Locate('Id', FForm.Params.ParamByName('Id').Value, []);
end;

procedure TdsdInsertUpdateAction.SetDataSource(const Value: TDataSource);
begin
  FActionDataLink.DataSource := Value;
end;

{ TActionDataLink }

constructor TDataSetDataLink.Create(Action: IDataSetAction);
begin
  inherited Create;
  FAction := Action;
end;

procedure TDataSetDataLink.DataSetChanged;
begin
  inherited;
  if Assigned(FAction) then
     FAction.DataSetChanged;
end;

{ TdsdUpdateErased }

constructor TdsdUpdateErased.Create(AOwner: TComponent);
begin
  inherited;
  FActionDataLink := TDataSetDataLink.Create(Self);
  isSetErased := true;
end;

procedure TdsdUpdateErased.DataSetChanged;
begin
  Enabled := false;
  if Assigned(DataSource) then
     if Assigned(DataSource.DataSet) then
        if DataSource.DataSet.RecordCount = 0 then
           Enabled := false
        else
           if FisSetErased then
              Enabled := true
           else
              Enabled := false
end;

function TdsdUpdateErased.Execute: boolean;
begin

end;

function TdsdUpdateErased.GetDataSource: TDataSource;
begin
  result := FActionDataLink.DataSource
end;

procedure TdsdUpdateErased.SetDataSource(const Value: TDataSource);
begin
  FActionDataLink.DataSource := Value
end;

procedure TdsdUpdateErased.SetisSetErased(const Value: boolean);
begin
  FisSetErased := Value;
  if FisSetErased then
  begin
    Caption := '�������';
    Hint:='������� ������';
    ShortCut:=VK_DELETE
  end
  else
  begin
    Caption := '������������';
    Hint:='������������ ������';
  end;
end;

{ TdsdStoredProcList }

function TdsdStoredProcList.Add: TdsdStoredProcItem;
begin
  result := TdsdStoredProcItem(inherited Add)
end;

function TdsdStoredProcList.GetItem(Index: Integer): TdsdStoredProcItem;
begin
  Result := TdsdStoredProcItem(inherited GetItem(Index))
end;

procedure TdsdStoredProcList.SetItem(Index: Integer;
  const Value: TdsdStoredProcItem);
begin
  inherited SetItem(Index, Value);
end;

end.
