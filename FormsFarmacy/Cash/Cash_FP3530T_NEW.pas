unit Cash_FP3530T_NEW;

interface
uses Windows, CashInterface, DBTables, FP3141_TLB;
type
  TCashFP3530T_NEW = class(TInterfacedObject, ICash)
  private
    FAlwaysSold: boolean;
    FPrinter: IFiscPRN;
    procedure SetAlwaysSold(Value: boolean);
    function GetAlwaysSold: boolean;
  protected
    function SoldCode(const GoodsCode: integer; const Amount: double; const Price: double = 0.00): boolean;
    function SoldFromPC(const GoodsCode: integer; const GoodsName: string; const Amount, Price, NDS: double): boolean; //������� � ����������
    function ChangePrice(const GoodsCode: integer; const Price: double): boolean;
    function OpenReceipt(const isFiscal: boolean = true): boolean;
    function CloseReceipt: boolean;
    function CloseReceiptEx(out CheckId: String): boolean;
    function CashInputOutput(const Summa: double): boolean;
    function ProgrammingGoods(const GoodsCode: integer; const GoodsName: string; const Price, NDS: double): boolean;
    function ClosureFiscal: boolean;
    function TotalSumm(Summ: double; PaidType: TPaidType): boolean;
    function DeleteArticules(const GoodsCode: integer): boolean;
    function XReport: boolean;
    function GetLastErrorCode: integer;
    function GetArticulInfo(const GoodsCode: integer; var ArticulInfo: WideString): boolean;
    function PrintNotFiscalText(const PrintText: WideString): boolean;
    function PrintFiscalText(const PrintText: WideString): boolean;
    function SubTotal(isPrint, isDisplay: WordBool; Percent, Disc: Double): boolean;
    function PrintFiscalMemoryByNum(inStart, inEnd: Integer): boolean;
    function PrintFiscalMemoryByDate(inStart, inEnd: TDateTime): boolean;
    function PrintReportByDate(inStart, inEnd: TDateTime): boolean;
    function PrintReportByNum(inStart, inEnd: Integer): boolean;
    function FiscalNumber:String;
    procedure ClearArticulAttachment;
    procedure SetTime;
    procedure Anulirovt;
  public
    constructor Create;
  end;



implementation
uses Forms, SysUtils, Dialogs, Math, Variants, BDE, StrUtils, IniUtils, Log;

function �����������(k: string): boolean;
begin
  result := (k = '$0000') or (k = '');
  if result then
     exit;

  if (k='$0101') then begin ShowMessage('$0101 ������ ��������');  exit;  end; //257
  if (k='$0201') then begin ShowMessage('$0201 ������ RAM'); exit; end;    //
  if (k='$0301') then begin ShowMessage('$0301 ������ ����������� ����� ������ ��������'); exit; end; ///
  if (k='$0401') then begin ShowMessage('$0401 ������ flash ������');  exit; end;                      //
  if (k='$0501') then begin ShowMessage('$0501 ������ �������');  exit; end;                           //
  if (k='$0601') then begin ShowMessage('$0601 ������ �����');  exit; end;                             //
  if (k='$0701') then begin ShowMessage('$0701 ������ �������� ���������� ��������� �������');  exit; end; //
  if (k='$0002') then begin ShowMessage('$0002 ������������ ��� ����������');  exit; end; 	          //

   //0xNN03	������ ���� �������, ��� NN -���������� ����� ��������� ����
  if Copy(k, 3, 2) = '03'	then begin ShowMessage('������ ���� �������, ��� NN -���������� ����� ��������� ���� (' + Copy(k, 1, 2) + ')');  exit; end;
   //0xNN04	�������� ���� ������� �� ��������, ��� NN -���������� ����� ��������� ����
  if Copy(k, 3, 2) = '04'	then begin ShowMessage('�������� ���� ������� �� ��������, ��� NN -���������� ����� ��������� ���� (' + Copy(k, 1, 2) + ')');  exit; end;
   //0xXX05 ������ ��

  if (k='$0005')	then begin ShowMessage('$0005 ��� ���������� ����� ��� ������');   exit; end;  //
  if (k='$0105')	then begin ShowMessage('$0105 ������ ������ � ��');  exit; end;                //
  if (k='$0205')	then begin ShowMessage('$0205 ��������� ����� ������������');    exit; end;    //
  if (k='$0305')	then begin ShowMessage('$0305 ���� ��������� ������ � �� ����� �������, ��� ��, ��� �������� ����������');  exit; end; //
  if (k='$0405')	then begin ShowMessage('$0405 ������ �������� �� ������� �����');  exit; end; //
  if (k='$0505')	then begin ShowMessage('$0505 ���� ������ � ��');  exit; end; //
  if (k='$0605')	then begin ShowMessage('$0605 ���������� ������ ���������(������ ���������)');  exit; end; //
  if (k='$0705')	then begin ShowMessage('$0705 ���� �� � ���������� ������');  exit; end; //
  if (k='$0805')	then begin ShowMessage('$0805 ���� � ����� �� ���� ����������� � ������� ���������� ���������� ��������� ���');  exit; end; //
  if (k='$0905')	then begin ShowMessage('$0905 � ������ ����� ������ ����� ��� 24 ����');  exit; end; //
  if (k='$0A05')	then begin ShowMessage('$0A05 ���������� ��������������� �����');  exit; end; //
  if (k='$0B05')	then begin ShowMessage('$0B05 ������ � ������� ��������� ������');  exit; end; //
  if (k='$0006')	then begin ShowMessage('$0006 �������� ������');  exit; end; //
   //0xXX07 ������ ������
  if (k='$0007')	then begin ShowMessage('$0007 ������� � ������ ������ ������������ �����������');  exit; end; 	//
  if (k='$0107')	then begin ShowMessage('$0107 ������� � ������ ��������� ����� �����������');   exit; end; 	    //
  if (k='$0008')	then begin ShowMessage('$0008 ������������ ����������'); 	 exit; end;                         //
  if (k='$0009')	then begin ShowMessage('$0009 �� ��������'); 	 exit; end;                                     //
   //0xXX0A ������ ��� ������ � ����� �������
  if (k='$000A')	then begin ShowMessage('$000A ������������ ���������� ����� ��� ���������� �������');  exit; end; //
  if (k='$010A')	then begin ShowMessage('$010A ����� ������ ������ ���������'); 	 exit; end;                   //
  if (k='$020A')	then begin ShowMessage('$020A ������� � ������ ����� �� ������');  exit; end; 	                  //
  if (k='$030A')	then begin ShowMessage('$030A ������ �� ��������� ����');  exit; end; 	                          //
  if (k='$040A')	then begin ShowMessage('$040A �������/����� � ������ ����� ����������');  exit; end; 	          //
  if (k='$050A')	then begin ShowMessage('$050A ����������� ��������� ������');  exit; end; 	                      //
   //0��X0B ������ ��� ������ � �������� ������                                                     //
  if (k='$000B')	then begin ShowMessage('$000B �������� ��������� ���������');  exit; end; 	                      //
  if (k='$010B')	then begin ShowMessage('$010B ������������ ���������� ����� ��� ���������� �������');  exit; end; //
  if (k='$020B')	then begin ShowMessage('$020B ����������� ��� ������ �������');  exit; end; 	                  //
  if (k='$030B')	then begin ShowMessage('$030B ������������� �� ����� ���������� � ������ ��������');  exit; end;  //
  if (k='$040B')	then begin ShowMessage('$040B ������ �������� � ���� �� �������');  exit; end; 	                  //
  if (k='$050B')	then begin ShowMessage('$050B ������������������ �������� (�� ��������� ��������� ���� ��� ������� ������� � ��� �������)');  exit; end; //
  if (k='$060B')	then begin ShowMessage('$060B ������������ ������'); 	 exit; end;                               //
  if (k='$070B')	then begin ShowMessage('$070B ����� ���� ����������'); 	 exit; end;                               //
  if (k='$080B')	then begin ShowMessage('$080B ������������ ���������� ��� ���������� ��������'); 	 exit; end;   //
  if (k='$090B')	then begin ShowMessage('$090B ������ ����� ������ � ���� ���� ���������'); 	 exit; end;           //
  if (k='$0A0B')	then begin ShowMessage('$0A0B ������ ����� � ������ ����� ������ (� ������ ���� ����) ���������');  exit; end; 	//
  if (k='$0B0B')	then begin ShowMessage('$0B0B �������� ������ ����� �� �������');  exit; end; 	                                //
  if (k='$0C0B')	then begin ShowMessage('$0C0B ������������ ����� �� ����');  exit; end; 	                                    //
  if (k='$0D0B')	then begin ShowMessage('$0D0B ������������ �� �������');  exit; end; 	                                        //
  if (k='$0E0B')	then begin ShowMessage('$0E0B ����� �� ������� ������'); 	 exit; end;                                         //
  if (k='$000C')	then begin ShowMessage('$000C ������ ���������� ������');   exit; end; 	                                        //
  if (k='$010C')	then begin ShowMessage('$010C ������ �� ������� � ����� ������������');   exit; end;

  ShowMessage(k + ' ������������������� ������!!! ��������� � �������������')
end;

const

  Password = '000000';

{ TCashFP3530T_NEW }
constructor TCashFP3530T_NEW.Create;
begin
  inherited Create;
  FAlwaysSold:=false;
  FPrinter := CoFiscPrn.Create;
  FPrinter.SETCOMPORT[StrToInt(iniPortNumber), StrToInt(iniPortSpeed)];
  �����������(FPrinter.GETERROR);

end;

function TCashFP3530T_NEW.CloseReceipt: boolean;
begin
  result := false;
  FPrinter.CLOSECHECK[1, Password];
  result := �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.CloseReceiptEx(out CheckId: String): boolean;
begin
  result := false;
  CheckId := FPrinter.CLOSEFISKCHECK[1, Password];
  result := �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.GetAlwaysSold: boolean;
begin
  result:= FAlwaysSold;
end;

function TCashFP3530T_NEW.OpenReceipt(const isFiscal: boolean = true): boolean;
begin
  if isFiscal then
     FPrinter.OPENFISKCHECK[1, 1, 0, Password]
  else
     FPrinter.OPENCHECK[Password];
  result := �����������(FPrinter.GETERROR)
end;

procedure TCashFP3530T_NEW.SetAlwaysSold(Value: boolean);
begin
  FAlwaysSold:= Value
end;

procedure TCashFP3530T_NEW.SetTime;
begin
  FPrinter.SETDT[FormatDateTime('DDMMYYHHNN', Now), Password];
  �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.SoldCode(const GoodsCode: integer;
  const Amount: double; const Price: double = 0.00): boolean;
begin
  Logger.AddToLog(' SALE (GoodsCode := ' + IntToStr(GoodsCode) + ', Amount := ' + ReplaceStr(FormatFloat('0.000', Amount), FormatSettings.DecimalSeparator, '.') +
      ', Price := ' + ReplaceStr(FormatFloat('0.00', Price), FormatSettings.DecimalSeparator, '.') + ', Password := ' + Password);
  FPrinter.SALE[GoodsCode, ReplaceStr(FormatFloat('0.000', Amount), FormatSettings.DecimalSeparator, '.'), ReplaceStr(FormatFloat('0.00', Price), FormatSettings.DecimalSeparator, '.') , Password];
  result := �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.SoldFromPC(const GoodsCode: integer; const GoodsName: string; const Amount, Price, NDS: double): boolean;
var NDSType: char;
    CashCode: integer;
begin
  result := true;
  if FAlwaysSold then exit;

  ProgrammingGoods(GoodsCode, Copy(GoodsName, 1, 20) , Price, NDS);
  result := SoldCode(GoodsCode, Amount, Price);
end;

function TCashFP3530T_NEW.ProgrammingGoods(const GoodsCode: integer;
  const GoodsName: string; const Price, NDS: double): boolean;
var NDSType: Integer;
begin//  if NDS = 0 then NDSType := 1 .033.+else NDSType := 0;
  if NDS = 20 then NDSType := 0 else NDSType := 1;
  // ���������������� ��������
  Logger.AddToLog(' WRITEARTICLE (GoodsCode := ' + IntToStr(GoodsCode) +
                 ', GoodsName := ' + GoodsName +
                 ', NDSType := ' + IntToStr(NDSType) +
                 ', Password := ' + Password);
  FPrinter.WRITEARTICLE[GoodsCode, GoodsName, NDSType, 1, 1, '.', Password];

  result := �����������(FPrinter.GETERROR)
end;

procedure TCashFP3530T_NEW.Anulirovt;
begin
  FPrinter.ANULIROVT[0, Password];
  �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.CashInputOutput(const Summa: double): boolean;
begin
  FPrinter.MONEY[1, ReplaceStr(FormatFloat('0.00', Summa), FormatSettings.DecimalSeparator, '.'), Password];
  result := �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.TotalSumm(Summ: double; PaidType: TPaidType): boolean;
begin
  FPrinter.PAYMENT[integer(PaidType), ReplaceStr(FormatFloat('0.00', Summ), FormatSettings.DecimalSeparator, '.'), Password];
  result := �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.ClosureFiscal: boolean;
begin
  FPrinter.ZREPORT[Password];
  result := �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.DeleteArticules(const GoodsCode: integer): boolean;
begin
end;

function TCashFP3530T_NEW.FiscalNumber: String;
begin
  Result := FPrinter.FNUM[Password];
end;

function TCashFP3530T_NEW.XReport: boolean;
begin
  FPrinter.XREPORT[Password];
  result := �����������(FPrinter.GETERROR)
end;

function TCashFP3530T_NEW.ChangePrice(const GoodsCode: integer;
  const Price: double): boolean;
begin
end;

function TCashFP3530T_NEW.GetLastErrorCode: integer;
begin
  //result:= status
end;

function TCashFP3530T_NEW.GetArticulInfo(const GoodsCode: integer;
  var ArticulInfo: WideString): boolean;
var i: integer;
begin
end;

function TCashFP3530T_NEW.PrintNotFiscalText(
  const PrintText: WideString): boolean;
begin
end;

function TCashFP3530T_NEW.PrintFiscalText(
  const PrintText: WideString): boolean;
var APrintText: String;
begin

end;

function TCashFP3530T_NEW.SubTotal(isPrint, isDisplay: WordBool; Percent,
  Disc: Double): boolean;
begin
  FPrinter.PRNTOTAL[1, Password];
  result := �����������(FPrinter.GETERROR)
end;


function TCashFP3530T_NEW.PrintFiscalMemoryByDate(inStart,
  inEnd: TDateTime): boolean;
var StartStr, EndStr: string;
begin

end;

function TCashFP3530T_NEW.PrintFiscalMemoryByNum(inStart,
  inEnd: Integer): boolean;
begin

end;

function TCashFP3530T_NEW.PrintReportByDate(inStart,
  inEnd: TDateTime): boolean;
begin

end;

function TCashFP3530T_NEW.PrintReportByNum(inStart, inEnd: Integer): boolean;
begin

end;

procedure TCashFP3530T_NEW.ClearArticulAttachment;
begin
end;

end.


(*

int CALLBACK  PrintFiscalMemoryByNum(HWND hwnd,void (CALLBACK *Fn), LPARAM UI, LPSTR psw, int Start, int End)
������� ������ -
psw - ������ ��� ������ ������ (�������� 15)
Start - ��������� ����� Z-������ (4 �����)
End - �������� ����� Z-������ (4 �����)
�������� ������ - ���
� ������� ���� �������  ���������� ���������� �� ���������� ������ � Z-������� �� �������  (������ ������������� �����).



int CALLBACK  PrintFiscalMemoryByDate(HWND hwnd,void (CALLBACK *Fn), LPARAM UI, LPSTR psw, LPSTR Start,LPSTR End)
������� ������ -
psw - ������ ��� ������ ������ (�������� 15)
Start - ��������� ���� Z-������ (DDMMYY, �������� 100500)
End - �������� ���� Z-������ (DDMMYY)
� ������� ���� �������  ���������� ���������� �� ���������� ������ � Z-������� �� �����  (������ ������������� �����).


4Fh(79)
����������� ������������� ����� (�� ����) int
CALLBACK  PrintReportByDate(HWND hwnd,void (CALLBACK *Fn),LPARAM UI, LPSTR psw, LPSTR Start,LPSTR End)
������� ������ -
psw - ������ ��� ������ ������ (�������� 15)
Start - ��������� ���� - 6 ���� (DDMMYY)
End - �������� ���� - 6 ���� (DDMMYY)
�������� ������ - ���
� ������� ���� �������  ���������� ����������� ������������� ����� �� ��������� ������ �������.



int CALLBACK  PrintReportByNum(HWND hwnd,void (CALLBACK *Fn),LPARAM UI, LPSTR psw, int Start,int End)
������� ������ -
psw - ������ ��� ������ ������ (�������� 15)
Start - ��������� ����� Z-������ (4 �����)
End - �������� ����� Z-������ (4 �����)
�������� ������ - ���
� ������� ���� �������  ���������� ����������� ������������� ����� �� ��������� ���������� ������� Z-�������.






