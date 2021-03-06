unit CashInterface;

interface
type
   TPaidType = (ptMoney, ptCard);

   ICash = interface
     procedure SetAlwaysSold(Value: boolean);
     function GetAlwaysSold: boolean;

     function SoldCode(const GoodsCode: integer; const Amount: double; const Price: double = 0.00): boolean;
     function SoldFromPC(const GoodsCode: integer; const GoodsName: string; const Amount, Price, NDS: double): boolean; //������� � ����������
     function ProgrammingGoods(const GoodsCode: integer; const GoodsName: string; const Price, NDS: double): boolean;
     function ChangePrice(const GoodsCode: integer; const Price: double): boolean;
     function OpenReceipt(const isFiscal: boolean = true): boolean;
     function CloseReceipt: boolean;
     function CloseReceiptEx(out CheckId: String): boolean;
     function CashInputOutput(const Summa: double): boolean;
     function ClosureFiscal: boolean;
     function XReport: boolean;
     function TotalSumm(Summ: double; PaidType: TPaidType): boolean;
     function DeleteArticules(const GoodsCode: integer): boolean;
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
     property AlwaysSold: boolean read GetAlwaysSold write SetAlwaysSold;
   end;
implementation

end.
