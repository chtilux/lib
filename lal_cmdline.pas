unit lal_cmdline;

interface

uses
  Classes;

type
  TParam = class(TObject)
  public
    param: string;
    arg: string;
  end;

  TCmdLineParams = class(TObject)
  private
    _items: TStrings;
  public
    constructor Create;
    destructor Destroy; override;
    property items: TStrings read _items;
    function get(const param: string): TParam;
  end;

function getCmdLineParams: TCmdLineParams;

implementation

uses
  Windows;

function getCmdLineParams: TCmdLineParams;
var
  i: integer;
  p: TParam;
begin
  Result := TCmdLineParams.Create;
  i := 1;
  while i < ParamCount do
  begin
    p := TParam.Create;
    p.param := ParamStr(i);
    Inc(i);
    if i <= ParamCount then
    begin
      p.arg := ParamStr(i);
      Inc(i);
    end;
    Result._items.AddObject(p.param,p);
  end;
end;

{ TCmdLineParams }

constructor TCmdLineParams.Create;
begin
  _items := TStringList.Create;
end;

destructor TCmdLineParams.Destroy;
var
  i: integer;
begin
  for i := 0 to _items.Count - 1 do
    TParam(_items.Objects[i]).Free;
  _items.Free;
  inherited;
end;

function TCmdLineParams.get(const param: string): TParam;
begin
  Result := nil;
  if _items.IndexOf(param) <> -1 then
    Result := TParam(_items.Objects[_items.IndexOf(param)]);
end;

end.
