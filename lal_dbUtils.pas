unit lal_dbUtils;

interface

uses
  lal_connection, ZDataset, Classes, ZConnection, ZDbcIntfs, DBGrids, System.Contnrs;

type
  TDatabaseConnectionMode = (dcmNull,dcmCreate,dcmLoad);

function getROQuery(cnx: TZConnection; AOwner: TComponent): TZReadOnlyQuery; overload;

function getROQuery(cnx: TLalConnection; AOwner: TComponent = nil): TZReadOnlyQuery; overload;
function getROQuery(cnx: TLalConnection; contnrs: TObjectList): TZReadOnlyQuery;     overload;
function getQuery(cnx: TLalConnection; AOwner: TComponent = nil): TZQuery;
procedure freeROQuerys(querys: array of TZReadOnlyQuery);
function tableExists(cnx: TLalConnection; const tableName: string): boolean;
function tableColumnExists(cnx: TLalConnection; const tableName, columnName: string): boolean;
function PKExists(cnx: TlalConnection; const tableName: string): boolean;
function indexExists(cnx: TlalConnection; const indexName: string): boolean;
procedure emptyTable(cnx: TLalConnection; const tableName: string);
procedure dropTable(cnx: TLalConnection; const tableName: string);
procedure cloneAsTempTable(cnx: TLalConnection; const tableName, tempName: string);
procedure addTempTable(cnx: TLalConnection; const tableName: string);
procedure dropTempTables(cnx: TLalConnection);

function createDatabase(cnx: TZConnection;const databaseName: string): TDatabaseConnectionMode;
//function createDatabase(cnx: TZConnection;
//                        const _user, _password, _protocol,
//                        _clientCodePage, _libraryLocation,
//                        _database, _dialect,
//                        _pageSize: string;
//                        _transactionIsolationLevel: integer): TDatabaseConnectionMode; overload;

function connectDatabase(cnx: TZConnection;const databaseName: string): TDatabaseConnectionMode; overload;
function connectDatabase(cnx: TZConnection;const databaseName,user,password: string): TDatabaseConnectionMode; overload;
function connectDatabase(cnx: TZConnection;
                        const _user, _password, _protocol,
                        _clientCodePage, _libraryLocation,
                        _database, _dialect,
                        _pageSize: string;
                        _transactionIsolationLevel: TZTransactIsolationLevel;
                        _loginPromt: Boolean = False): TDatabaseConnectionMode; overload;
function loadDatabase(cnx: TZConnection;const databaseName: string): TDatabaseConnectionMode;
procedure runSQLScript(cnx: TZConnection; const filename: string);
procedure orderByColumn(q: TZQuery; Column: TColumn; const zorder: string = ''); overload;
procedure orderByColumn(q: TZReadOnlyQuery; Column: TColumn; const zorder: string = ''); overload;

implementation

uses
  SysUtils, DB, ZSQLProcessor, lal_fbUtils, ZAbstractConnection;

//function createFirebird25Database(cnx: TZConnection;const databaseName,user,password: string): TDatabaseConnectionMode; forward;

function getROQuery(cnx: TZConnection; AOwner: TComponent): TZReadOnlyQuery;
begin
  if cnx = nil then
    raise Exception.Create('getROQuery.cnx is nil');
  Result := TZReadOnlyQuery.Create(AOwner);
  Result.Connection := TZConnection(cnx);
end;

function getROQuery(cnx: TLalConnection; AOwner: TComponent): TZReadOnlyQuery;
begin
  Result := getROQuery(cnx.get,AOwner);
end;

function getROQuery(cnx: TLalConnection; contnrs: TObjectList): TZReadOnlyQuery;     overload;
begin
  Result := getROQuery(cnx);
  contnrs.Add(Result);
end;

function getQuery(cnx: TLalConnection; AOwner: TComponent): TZQuery;
begin
  if cnx = nil then
    raise Exception.Create('getROQuery.cnx is nil');
  Result := TZQuery.Create(AOwner);
  Result.Connection := cnx.get;
end;

procedure freeROQuerys(querys: array of TZReadOnlyQuery);
var
  i: integer;
begin
  for i := Low(querys) to High(querys) do
  begin
    if (Assigned(querys[i])) and (querys[i].Active) then
      querys[i].Close;
    FreeAndNil(querys[i]);
  end;
end;

function tableExists(cnx: TLalConnection; const tableName: string): boolean;
begin
  with getROQuery(cnx) do
  begin
    try
      SQL.Add('SELECT 1 FROM rdb$relations WHERE lower(rdb$relation_name) = ' + QuotedStr(Lowercase(tableName)));
      Open;
      Result := Fields[0].AsString = '1';
      Close;
    finally
      Free;
    end;
  end;
end;

function tableColumnExists(cnx: TLalConnection; const tableName, columnName: string): boolean;
begin
  with getROQuery(cnx) do
  begin
    try
      SQL.Add('SELECT 1 FROM rdb$relation_fields'
             +' WHERE LOWER(rdb$relation_name) = ' + tableName.ToLower.QuotedString
             +'   AND LOWER(rdb$field_name) = ' + columnName.ToLower.QuotedString);
      Open;
      Result := Fields[0].AsString = '1';
      Close;
    finally
      Free;
    end;
  end;
end;
function PKExists(cnx: TlalConnection; const tableName: string): boolean;
begin
  with getROQuery(cnx) do
  begin
    try
      SQL.Add('SELECT 1 FROM rdb$relation_constraints'
             +' WHERE LOWER(rdb$relation_name) = ' + tableName.ToLower.QuotedString
             +'   AND LOWER(rdb$constraint_type) = ' + 'primary key'.QuotedString);
      Open;
      Result := Fields[0].AsString = '1';
      Close;
    finally
      Free;
    end;
  end;
end;

function indexExists(cnx: TlalConnection; const indexName: string): boolean;
begin
  with getROQuery(cnx) do
  begin
    try
      SQL.Add('SELECT 1 FROM rdb$indices WHERE lower(rdb$index_name) = ' + QuotedStr(Lowercase(indexName)));
      Open;
      Result := Fields[0].AsString = '1';
      Close;
    finally
      Free;
    end;
  end;
end;

procedure emptyTable(cnx: TLalConnection; const tableName: string);
begin
  if tableExists(cnx, tableName) then
  begin
    with getROQuery(cnx) do
    begin
      try
        SQL.Add('DELETE FROM ' + tablename);
        ExecSQL;
      finally
        Free;
      end;
    end;
  end;
end;

procedure dropTable(cnx: TLalConnection; const tableName: string);
begin
  if tableExists(cnx, tableName) then
  begin
    with getROQuery(cnx) do
    begin
      try
        SQL.Add('DROP TABLE ' + tablename);
        ExecSQL;
      finally
        Free;
      end;
    end;
  end;
end;

procedure cloneAsTempTable(cnx: TLalConnection; const tableName, tempName: string);
var
  tbl: TZTable;
  i: integer;
  f: TField;
  s: string;
begin
  dropTable(cnx, tempName);
  tbl := TZTable.Create(nil);
  try
    tbl.Connection := cnx.get;
    tbl.TableName := tableName;
    tbl.Open;
    tbl.FieldDefs.Update;
    for i := 0 to tbl.fields.Count - 1 do
    begin
      case tbl.Fields[i].DataType of
        ftString,ftWideString: begin
          f := TStringField(tbl.Fields[i]);
          s := s
              +','
              +f.FieldName
              +' VARCHAR('+IntToStr(f.Size)+')';
          if f.Required then
            s := s + ' NOT NULL';
        end;

        ftSmallint, ftInteger, ftWord: begin
          f := TIntegerField(tbl.Fields[i]);
          s := s
              +','
              +f.FieldName
              +' INTEGER';
          if f.Required then
            s := s + ' NOT NULL';
        end;
        ftFloat,ftCurrency: begin
          f := TFloatField(tbl.Fields[i]);
          s := s
              +','
              +f.FieldName
              +' DECIMAL('
              +IntToStr(TFloatField(f).Precision)
              +',2)';
          if f.Required then
            s := s + ' NOT NULL';
        end;

        ftDate: begin
          f := TDateTimeField(tbl.Fields[i]);
          s := s
              +','
              +f.FieldName
              +' DATE';
          if f.Required then
            s := s + ' NOT NULL';
        end;

        ftDateTime: begin
          f := TDateTimeField(tbl.Fields[i]);
          s := s
              +','
              +f.FieldName
              +' DATETIME';
          if f.Required then
            s := s + ' NOT NULL';
        end;
      end;
    end;
    tbl.Close;
    Delete(s,1,1);
      s := Format('CREATE TABLE %s (%s)', [tempName, s]);
  finally
    tbl.Free;
  end;

  with getROQuery(cnx) do
  begin
    try
      SQL.Add(s);
      ExecSQL;
    finally
      Free;
    end;
  end;
  addTempTable(cnx,tempName);
end;

procedure addTempTable(cnx: TLalConnection; const tableName: string);
var
  z: TZReadOnlyQuery;
begin
  z := getROQuery(cnx);
  try
    if not tableExists(cnx,'tempTables') then
    begin
      z.SQL.Add('create table tempTables ('
               +'  tableName varchar(16) not null'
               +' ,primary key(tableName))');
      z.ExecSQL;
      z.SQL.Clear;
    end;
    z.SQL.Add('insert into tempTables (tableName) values (:tableName)');
    z.Params[0].AsString := tableName;
    z.ExecSQL;
  finally
    z.Free;
  end;
end;

procedure dropTempTables(cnx: TLalConnection);
var
  z: TZReadOnlyQuery;
begin
  z := getROQuery(cnx);
  try
    if tableExists(cnx,'tempTables') then
    begin
      cnx.startTransaction;
      try
        z.SQL.Add('select tableName from tempTables');
        z.Open;
        while not z.Eof do
        begin
          dropTable(cnx, z.Fields[0].AsString);
          z.Next;
        end;
        z.Close;
        z.SQL.Clear;
        z.SQL.Add('delete from tempTables where 1=1');
        z.ExecSQL;
        cnx.commit;
      except
        cnx.rollback;
      end;
    end;
  finally
    z.Free;
  end;
end;

//function createDatabase(cnx: TZConnection;
//                        const _user, _password, _protocol,
//                        _clientCodePage, _libraryLocation,
//                        _database, _dialect,
//                        _pageSize: string;
//                        _transactionIsolationLevel: integer): TDatabaseConnectionMode; overload;
//begin
//  Result := createFB25Database(cnx,_database,_user,_password);
////  Result := dcmNull;
////  with cnx do
////  begin
////    if Connected then
////      Disconnect;
////    LoginPrompt := (_user = '') or (_password = '');
////    User := _user;
////    Password := _password;
////    Protocol := _protocol;
////    ClientCodepage := _clientCodePage;
////    LibraryLocation := _libraryLocation;
////    Database := _database;
////    if not FileExists(Database) then
////    begin
////      with properties do
////      begin
////        BeginUpdate;
////        try
////          Clear;
////          Values['dialect'] := _dialect;
////          Values['CreateNewDatabase'] := 'CREATE DATABASE ' + QuotedStr(database)
////                                        +' USER ' + QuotedStr(User)
////                                        +' PASSWORD ' + QuotedStr(Password)
////                                        +' PAGE_SIZE ' + _pageSize + ' DEFAULT CHARACTER SET ' + ClientCodePage;
////        finally
////          EndUpdate;
////        end;
////      end;
////    end;
////    Connect;
////    properties.Delete(properties.IndexOfName('CreateNewDatabase'));
////    try TransactIsolationLevel := ZDbcIntfs.tiReadCommitted; except end;
////  end;
////  Result := dcmCreate;
//end;

function connectDatabase(cnx: TZConnection;
                        const _user, _password, _protocol,
                        _clientCodePage, _libraryLocation,
                        _database, _dialect,
                        _pageSize: string;
                        _transactionIsolationLevel: TZTransactIsolationLevel;
                        _loginPromt: Boolean): TDatabaseConnectionMode; overload;
begin
  Result := loadFB25Database(cnx,_user,_password,_protocol,_clientCodePage,_libraryLocation,_database,_dialect,_pagesize,_transactionIsolationLevel);
//  with cnx do
//  begin
//    if Connected then Connected := False;
//    User := _user;
//    Password := _password;
//    Protocol := _protocol;
//    ClientCodepage := _clientCodePage;
//    LibraryLocation := _libraryLocation;
//    Database := _database;
//    LoginPrompt := (_user = '') or (_password = '');
////    try
//      Connect;
////    except
////      LoginPrompt := True;
////      Connect;
////    end;
//    try TransactIsolationLevel := ZDbcIntfs.tiReadCommitted; except end;
//  end;
//  Result := dcmLoad;
end;

function loadDatabase(cnx: TZConnection;const databaseName: string): TDatabaseConnectionMode;
begin
  Result := connectDatabase(cnx,databaseName);
end;

function connectDatabase(cnx: TZConnection;const databaseName: string): TDatabaseConnectionMode; overload;
begin
  try
    Result := loadFB25Database(cnx,databaseName,'sysdba','scraps','');
  except
    Result := loadFB25Database(cnx,databaseName,'sysdba','masterkey','');
  end;

//  try
//    Result := connectdatabase(cnx, 'SYSDBA', 'scraps', 'firebird-2.5', 'ISO8859_1', 'fbClient.dll', databasename, '3', '8192', 1);
//  except
//    Result := connectdatabase(cnx, 'SYSDBA', 'masterkey', 'firebird-2.5', 'ISO8859_1', 'fbClient.dll', databasename, '3', '8192', 1);
//  end;
end;

function connectDatabase(cnx: TZConnection;const databaseName,user,password: string): TDatabaseConnectionMode; overload;
begin
  Result := loadFB25Database(cnx, databaseName, user, password, '');
//  Result := connectdatabase(cnx, user, password, 'firebird-2.5', 'ISO8859_1', 'fbClient.dll', databasename, '3', '8192', 1);
end;

function createDatabase(cnx: TZConnection;const databaseName: string): TDatabaseConnectionMode; overload;
begin
  try
    Result := createFB25Database(cnx,databaseName,'sysdba','scraps');
  except
    Result := createFB25Database(cnx,databaseName,'sysdba','masterkey');
  end;
  cnx.Connected := False;
end;

//function createFirebird25Database(cnx: TZConnection;const databaseName,user,password: string): TDatabaseConnectionMode;
//begin
//  Result := createDatabase(cnx, user, password, 'firebird-2.5', 'ISO8859_1', 'fbClient.dll', databasename, '3', '8192', 1);
//end;

procedure runSQLScript(cnx: TZConnection; const filename: string);
begin
  with TZSQLProcessor.Create(nil) do
  begin
    try
      Connection := cnx;
      LoadFromFile(filename);
      Execute;
    finally
      Free;
    end;
  end;
end;

procedure orderByColumn(q: TZQuery; Column: TColumn; const zorder: string);
var
  orderBy: string;
  s: string;
  i: integer;
begin
  s := Trim(q.SQL.Text);
  i := Pos('order by',Lowercase(s));
  if i > 0 then
  begin
    orderBy := Copy(s,i, Length(s)-i+1);
    s := Copy(s, 1, i-1);
    s := s + ' order by ' + Column.FieldName + ' ' + zorder;
    try
      q.DisableControls;
      q.Close;
      try
        q.SQL.Clear;
        q.SQL.Add(s);
        q.Open;
      except
        q.SQL.Clear;
        q.SQL.Add(orderBy);
        q.Open;
      end;
    finally
      q.EnableControls;
      if not q.Active then q.Open;
    end;
  end;
end;

procedure orderByColumn(q: TZReadOnlyQuery; Column: TColumn; const zorder: string); overload;
var
  orderBy: string;
  s: string;
  i: integer;
begin
  s := Trim(q.SQL.Text);
  i := Pos('order by',Lowercase(s));
  if i > 0 then
  begin
    orderBy := Copy(s,i, Length(s)-i+1);
    s := Copy(s, 1, i-1);
    s := s + ' order by ' + Column.FieldName + ' ' + zorder;
    try
      q.DisableControls;
      q.Close;
      try
        q.SQL.Clear;
        q.SQL.Add(s);
        q.Open;
      except
        q.SQL.Clear;
        q.SQL.Add(orderBy);
        q.Open;
      end;
    finally
      q.EnableControls;
      if not q.Active then q.Open;
    end;
  end;
end;
end.
