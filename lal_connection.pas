unit lal_connection;

interface

uses
  ZConnection, Classes;

type
  TTransactionProcedure = procedure of object;

  TLalConnection = class(TComponent)
  private
    _cnx: TZConnection;
    function getDatabaseOwner: string;

  public
    constructor Create(AOwner: TComponent; cnx: TZConnection); reintroduce; overload;
    constructor Create(cnx: TZConnection); reintroduce; overload;
    destructor Destroy; override;

    function get: TZConnection;

    procedure startTransaction;
    procedure commit;
    procedure rollback;
    procedure execTrans(proc: TTransactionProcedure);

    property owner: string read getDatabaseOwner;
  end;

implementation

uses
  ZDataset;

{ TLalConnection }

procedure TLalConnection.commit;
begin
  if Assigned(_cnx) and (_cnx.InTransaction) then
    _cnx.Commit;
end;

constructor TLalConnection.Create(cnx: TZConnection);
begin
  _cnx := cnx;
end;

constructor TLalConnection.Create(AOwner: TComponent; cnx: TZConnection);
begin
  Create(cnx);
  inherited Create(AOwner);
end;

destructor TLalConnection.Destroy;
begin
  _cnx.Connected := False;
  inherited;
end;

procedure TLalConnection.execTrans(proc: TTransactionProcedure);
begin
  startTransaction;
  try
    proc;
    commit;
  except
    rollback;
    raise
  end;
end;

function TLalConnection.get: TZConnection;
begin
  Result := _cnx;
end;

function TLalConnection.getDatabaseOwner: string;
begin
  with TZReadOnlyQuery.Create(nil) do
  begin
    try
      Connection := _cnx;
      SQL.Add('select distinct rdb$owner_name'
             +' from rdb$relations'
             +' where rdb$system_flag = 1');
      try
        Open;
        Result := Fields[0].AsString;
      except
        Result := 'Exception !';
      end;
      Close;
    finally
      Free;
    end;
  end;
end;

procedure TLalConnection.rollback;
begin
  if not _cnx.Connected then _cnx.Connect;
  if Assigned(_cnx) and (_cnx.InTransaction) then
  begin
    _cnx.Rollback;
  end;
end;

procedure TLalConnection.startTransaction;
begin
  if not _cnx.Connected then _cnx.Connect;
  if Assigned(_cnx) and not(_cnx.InTransaction) then
  begin
    _cnx.StartTransaction;
  end;
end;

end.

