unit TaxMovementItemTest;

interface

uses dbMovementItemTest, dbTest;

type

  TTaxMovementItemTest = class(TdbTest)
  protected
    procedure SetUp; override;
    // ���������� ������ ��� ������������
    procedure TearDown; override;
  published
    // �������� ��������� �� ������������ ����������
    procedure ProcedureLoad; virtual;
    procedure Test; virtual;
  end;

  TTaxMovementItem = class(TMovementItemTest)
  private
    function InsertDefault: integer; override;
  public
    function InsertUpdateTaxMovementItem
      (Id, MovementId, GoodsId: Integer; Amount, Price, CountForPrice: double; GoodsKindId: Integer): integer;
    constructor Create; override;
  end;

implementation

uses UtilConst, Db, SysUtils, PersonalTest, dbMovementTest, UnitsTest,
     Storage, Authentication, TestFramework, CommonData, dbObjectTest,
     Variants,TaxTest;

{ TTaxMovementItemTest }

procedure TTaxMovementItemTest.ProcedureLoad;
begin
  ScriptDirectory := ProcedurePath + 'MovementItem\Tax\';
  inherited;
  ScriptDirectory := ProcedurePath + 'Movement\Tax\';
  inherited;
end;

procedure TTaxMovementItemTest.SetUp;
begin
  inherited;
  TAuthentication.CheckLogin(TStorageFactory.GetStorage, '�����', '�����', gc_User);
end;

procedure TTaxMovementItemTest.TearDown;
begin
  inherited;
  if Assigned(InsertedIdMovementItemList) then
     with TMovementItemTest.Create do
       while InsertedIdMovementItemList.Count > 0 do
          Delete(StrToInt(InsertedIdMovementItemList[0]));

  if Assigned(InsertedIdMovementList) then
     with TMovementTest.Create do
       while InsertedIdMovementList.Count > 0 do
          Delete(StrToInt(InsertedIdMovementList[0]));

  if Assigned(InsertedIdObjectList) then
     with TObjectTest.Create do
       while InsertedIdObjectList.Count > 0 do
          Delete(StrToInt(InsertedIdObjectList[0]));
end;

function TTaxMovementItem.InsertDefault: integer;
var Id, MovementId, GoodsId: Integer;
    Amount, AmountPartner, Price, CountForPrice,
    HeadCount: double;
    PartionGoods:String;
    GoodsKindId, AssetId: Integer;
begin
  Id:=0;
  MovementId:= TTax.Create.GetDefault;
  GoodsId:=TGoodsTest.Create.GetDefault;
  Amount:=10;
  AmountPartner:=11;
  Price:=2.34;
  CountForPrice:=1;
  HeadCount:=5;
  PartionGoods:='';
  GoodsKindId:=0;
  AssetId:=0;
  //
  result := InsertUpdateTaxMovementItem(Id, MovementId, GoodsId, Amount, Price, CountForPrice, GoodsKindId);
end;

procedure TTaxMovementItemTest.Test;
var TaxMovementItem: TTaxMovementItem;
    Id: Integer;
begin
  inherited;
  // ������� ��������
  TaxMovementItem := TTaxMovementItem.Create;
  Id := TaxMovementItem.InsertDefault;
  // �������� ���������
  try
  // ��������������
  finally
    TaxMovementItem.Delete(Id);
  end;


end;

{ TTaxMovementItem }

constructor TTaxMovementItem.Create;
begin
  inherited;
  spInsertUpdate := 'gpInsertUpdate_MovementItem_Tax';
end;

function TTaxMovementItem.InsertUpdateTaxMovementItem
 (Id, MovementId, GoodsId: Integer; Amount, Price, CountForPrice: double; GoodsKindId: Integer): integer;
begin
  FParams.Clear;
  FParams.AddParam('ioId', ftInteger, ptInputOutput, Id);
  FParams.AddParam('inMovementId', ftInteger, ptInput, MovementId);
  FParams.AddParam('inGoodsId', ftInteger, ptInput, GoodsId);
  FParams.AddParam('inAmount', ftFloat, ptInput, Amount);
  FParams.AddParam('inPrice', ftFloat, ptInput, Price);
  FParams.AddParam('ioCountForPrice', ftFloat, ptInput, CountForPrice);
  FParams.AddParam('inGoodsKindId', ftInteger, ptInput, GoodsKindId);
  result := InsertUpdate(FParams);
end;

initialization
  TestFramework.RegisterTest('������ ����������', TTaxMovementItemTest.Suite);

end.

