unit IniUtils;

interface

function GetIniFile(out AIniFileName: String):boolean;

function GetValue(const ASection,AParamName,ADefault: String): String;

//���������� ��� ��������� ��������;
function iniCashType:String;
//���������� � ��������� �����
function iniCashID: Integer;
//���������� SoldParalel
function iniSoldParallel:Boolean;
//���������� ���� ��������� ��������
function iniPortNumber:String;
//���������� �������� �����
function iniPortSpeed:String;
//���������� ���� � ��������� ���� ������
function iniLocalDataBaseHead: String;
function iniLocalDataBaseBody: String;
function iniLocalDataBaseDiff: String;
//���������� ��� ������
function iniLocalUnitNameGet: string;
function iniLocalUnitNameSave(AFarmacyName: string): string;
//���������� GUID
function iniLocalGUIDGet: string;
function iniLocalGUIDSave(AGUID: string): string;

function iniCashSerialNumber: String;
//���������� ����� ��������� ������ ��� FP320
function iniTaxGroup7:Integer;

var gUnitName, gUserName, gPassValue: string;
var gUnitId : Integer;
var isMainForm_OLD : Boolean;

implementation

uses
  iniFiles, Classes, SysUtils, Forms, vcl.Dialogs;
const
  FileName: String = '\DEFAULTS.INI';
  LocalDBNameHead: String = 'FarmacyCashHead.dbf';
  LocalDBNameBody: String = 'FarmacyCashBody.dbf';
  LocalDBNameDiff: String = 'FarmacyCashDiff.dbf';



function GetIniFile(out AIniFileName: String):boolean;
var
  dir: string;
  f: TIniFile;
Begin
  result := False;
  dir := ExtractFilePath(Application.exeName)+'ini';
  if not DirectoryExists(dir) AND not ForceDirectories(dir) then
  Begin
    ShowMessage('������������ �� ����� �������� ������ � ����� ��������.'+#13+
                 '���������� ������ ��������� ����������.'+#13+
                 '�������� ��������������.');
    exit;
  End;
  if not FileExists(dir + FileName) then
  Begin
    f := TiniFile.Create(dir + FileName);
    try
      try
        AIniFileName := dir + FileName;
        F.WriteString('Common','SoldParallel','false');
        F.WriteString('Common','LocalDataBaseHead',ExtractFilePath(Application.ExeName)+LocalDBNameHead);
        F.WriteString('Common','LocalDataBaseBody',ExtractFilePath(Application.ExeName)+LocalDBNameBody);
        F.WriteString('Common','LocalDataBaseDiff',ExtractFilePath(Application.ExeName)+LocalDBNameDiff);
        F.WriteString('TSoldWithCompMainForm','CashType','FP3530T_NEW');
        F.WriteString('TSoldWithCompMainForm','CashId','0');
        F.WriteString('TSoldWithCompMainForm','PortNumber','1');
        F.WriteString('TSoldWithCompMainForm','PortSpeed','19200');
      Except
        ShowMessage('������������ �� ����� �������� ������ � ����� ��������. ���������� ������ ��������� ����������. �������� ��������������.');
        exit;
      end;
    finally
      f.Free;
    end;
  End
  else
    AIniFileName := dir+FileName;
  result := True;
End;

function GetValue(const ASection,AParamName,ADefault: String): String;
var
  ini: TiniFile;
  IniFileName : String;
Begin
  if not GetIniFile(IniFileName) then
  Begin
    Result := '';
    exit;
  End;
  ini := TiniFile.Create(IniFileName);
  Result := ini.ReadString(ASection,AParamName,ADefault);
  ini.Free;
End;

function iniCashType:String;
begin
  Result := GetValue('TSoldWithCompMainForm','CashType','FP3530T_NEW');
end;

function iniCashID: Integer;
Begin
  if not TryStrToInt(GetValue('TSoldWithCompMainForm','CashId','0'),Result) then
    Result := 0;
End;

function iniSoldParallel:Boolean;
Begin
  Result := GetValue('Common','SoldParallel','false') = 'true';
End;

function iniPortNumber:String;
begin
  Result := GetValue('TSoldWithCompMainForm','PortNumber','1');
end;

function iniPortSpeed:String;
begin
  Result := GetValue('TSoldWithCompMainForm','PortSpeed','19200');
end;

//���������� ���� � ��������� ���� ������
function iniLocalDataBaseHead: String;
var
  f: TIniFile;
begin
  Result := GetValue('Common','LocalDataBaseHead','');
  if Result = '' then
  Begin
    Result := ExtractFilePath(Application.ExeName)+LocalDBNameHead;
    f := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ini\'+FileName);
    try
      f.WriteString('Common','LocalDataBaseHead',Result);
    finally
      f.Free;
    end;
  End;
end;

function iniLocalDataBaseBody: String;
var
  f: TIniFile;
begin
  Result := GetValue('Common','LocalDataBaseBody','');
  if Result = '' then
  Begin
    Result := ExtractFilePath(Application.ExeName)+LocalDBNameBody;
    f := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ini\'+FileName);
    try
      f.WriteString('Common','LocalDataBaseBody',Result);
    finally
      f.Free;
    end;
  End;
end;

function iniLocalDataBaseDiff: String;
var
  f: TIniFile;
begin
  Result := GetValue('Common','LocalDataBaseDiff','');
  if Result = '' then
  Begin
    Result := ExtractFilePath(Application.ExeName)+LocalDBNameDiff;
    f := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ini\'+FileName);
    try
      f.WriteString('Common','LocalDataBaseDiff',Result);
    finally
      f.Free;
    end;
  End;
end;

function iniLocalUnitNameGet: string;
begin
  Result := GetValue('Common','FarmacyName', '');
end;

function iniLocalUnitNameSave(AFarmacyName: string): string;
var
  f: TIniFile;
begin
  Result := GetValue('Common','FarmacyName', '');
  if Result = '' then
  Begin
    Result := AFarmacyName;
    f := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ini\'+FileName);
    try
      f.WriteString('Common','FarmacyName',Result);
    finally
      f.Free;
    end;
  End;
end;

function iniLocalGUIDGet: string;
begin
  Result := GetValue('Common','CashSessionGUID', '');
end;

function iniLocalGUIDSave(AGUID: string): string;
var
  f: TIniFile;
begin
  Result := GetValue('Common','CashSessionGUID', '');
  if Result = '' then
  Begin
    Result := AGUID;
    f := TIniFile.Create(ExtractFilePath(Application.ExeName)+'ini\'+FileName);
    try
      f.WriteString('Common','CashSessionGUID',Result);
    finally
      f.Free;
    end;
  End;
end;


function iniCashSerialNumber: String;
begin
  Result := GetValue('TSoldWithCompMainForm','FP320SERIAL','');
End;

//���������� ����� ��������� ������ ��� FP320 7%
function iniTaxGroup7:Integer;
var
  s: String;
begin
  S := GetValue('TSoldWithCompMainForm','FP320_TAX7','1');
  if not tryStrToInt(S,Result) then
    Result := 1;
End;

end.
