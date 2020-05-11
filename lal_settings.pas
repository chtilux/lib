unit lal_settings;

interface

uses
  SysUtils, ZDataset, ZAbstractRODataset, DB, lal_connection;

type

  EDictionnary = Exception;
  TDictionnary = class(TObject)
  private
    FKey,
    FCode: string;
    pvDic: TZQuery;
    procedure setCode(const Value: string);
    procedure setKey(const Value: string);
    procedure Close;
    procedure checkKey;
    function Read(const key, code: string): Boolean; overload;

  protected
    procedure doCheckKey; virtual;

  public
    constructor Create(cnx: TLalConnection); virtual;
    destructor Destroy; override;
    function Read(const key, code, field: string): string; overload;
    procedure Write(const key, code, field, value: string);
    property Key: string read FKey write setKey;
    property Code: string read FCode write setCode;
  end;

  TSettings = class(TObject)
  private
    pvDic: TDictionnary;
  protected
    procedure DoRead; virtual; abstract;
    procedure DoWrite; virtual; abstract;
  public
    constructor Create(cnx: TLalConnection); virtual;
    destructor Destroy; override;
    procedure Read; overload;
    procedure Write; overload;
    function Read(const key, code, field: string): string; overload;
    function Read(const key, code, field, default: string): string; overload;
    procedure Write(const key, code, field, value: string); overload;
  end;


implementation

{ TSettings }

constructor TSettings.Create(cnx: TLalConnection);
begin
  inherited Create;
  pvDic := TDictionnary.Create(cnx);
end;

destructor TSettings.Destroy;
begin
  pvDic.Free;
  inherited;
end;

function TSettings.Read(const key, code, field, default: string): string;
begin
  Result := Read(key,code,field);
  if Result = '' then
    Result := default;
end;

function TSettings.Read(const key, code, field: string): string;
begin
  Result := pvDic.Read(key,code,field);
end;

procedure TSettings.Read;
begin
  doRead;
end;

procedure TSettings.Write;
begin
  DoWrite;
end;

procedure TSettings.Write(const key, code, field, value: string);
begin
  pvDic.Write(key,code,field,value);
end;

{ TDictionnary }

procedure TDictionnary.checkKey;
begin
  doCheckKey;
end;

procedure TDictionnary.Close;
begin
  if pvDic.Active then
    pvDic.Close;
end;

constructor TDictionnary.Create(cnx: TLalConnection);
begin
  pvDic := TZQuery.Create(nil);
  pvDic.Connection := cnx.get;
  pvDic.SQL.Add('SELECT cledic,coddic,libdic,pardc1,pardc2,pardc3,pardc4'
               +'      ,pardc5,pardc6,pardc7,pardc8,pardc9'
               +' FROM dictionnaire'
               +' WHERE cledic = :cledic'
               +'   AND coddic = :coddic');
  pvDic.Prepare;
end;

destructor TDictionnary.Destroy;
begin
  Close;
  pvDic.Free;
  inherited;
end;

procedure TDictionnary.doCheckKey;
begin
  if (Key = '') or (Code = '') then
    raise EDictionnary.Create('Key/Code fails !');
end;

function TDictionnary.Read(const key, code, field: string): string;
var
  f: TField;
begin
  Result := '';
  Self.Key := key;
  Self.Code := code;
  if Read(key,code) then
  begin
    f := pvDic.FindField(field);
    if f <> nil then
      Result := f.AsString;
  end;
end;

function TDictionnary.Read(const key, code: string): Boolean;
begin
  Close;
  CheckKey;
  pvDic.Params[0].AsString := key;
  pvDic.Params[1].AsString := code;
  pvDic.Open;
  Result := not pvDic.Eof;
end;

procedure TDictionnary.setCode(const Value: string);
begin
  if FCode <> Value then
  begin
    FCode := Value;
    Close;
  end;
end;

procedure TDictionnary.setKey(const Value: string);
begin
  if FKey <> Value then
  begin
    FKey := Value;
    Close;
  end;
end;

procedure TDictionnary.Write(const key, code, field, value: string);
begin
  with TZReadOnlyQuery.Create(nil) do
  begin
    try
      Connection := pvDic.Connection;
      SQL.Add(Format('UPDATE OR INSERT INTO dictionnaire (cledic,coddic,%s)'
                    +' VALUES (%s,%s,%s)',[field,key.QuotedString,code.QuotedString,value.QuotedString]));
      ExecSQL;
    finally
      Free;
    end;
  end;
end;

end.
