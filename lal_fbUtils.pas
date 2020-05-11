unit lal_fbUtils;

interface

uses
  ZConnection, Classes, lal_dbUtils, ZDbcIntfs;

{ database creation }
function createFB25Database(cnx: TZConnection; const databaseName, user, password: string): TDatabaseConnectionMode;
{ database connection }
function loadFB25Database(cnx: TZConnection; const databaseName, user, password, role: string): TDatabaseConnectionMode; overload;
function loadFB25Database(cnx: TZConnection;
                          const _user, _password, _protocol,
                          _clientCodePage, _libraryLocation,
                          _database, _dialect,
                          _pageSize: string;
                          _transactionIsolationLevel: TZTransactIsolationLevel): TDatabaseConnectionMode; overload;
function getFB25Owner(cnx: TZConnection): string;
{ user managment }
procedure createFB25User(cnx: TZConnection; const user, password, role: string);
procedure alterFB25User(cnx: TZConnection; const user, password, role: string);
function userFB25Exists(cnx: TZConnection; const user: string): boolean;
function isUserFB25Role(cnx: TZConnection; const user, role: string): boolean;
{ helpers }
procedure listFB25Users(cnx: TZConnection; list: TStrings);
procedure listFB25Roles(cnx: TZConnection; list: TStrings);
procedure listFB25UsersRole(cnx: TZConnection; list: TStrings);

implementation

uses
  ZDataset, SysUtils, getConnectionUserDialog, Controls, Dialogs, UITypes;

procedure defaultParams(cnx: TZConnection);
begin
  with cnx do
  begin
    HostName := 'localhost';
    User := 'sysdba';
    Protocol := 'firebird-2.5';
    LibraryLocation := 'fbclient.dll';
    LoginPrompt := True;
  end;
end;

function internalCreateDatabase(cnx: TZConnection;const _user, _password, _protocol,_clientCodePage, _libraryLocation,_database, _dialect,_pageSize: string;_transactionIsolationLevel: TZTransactIsolationLevel): TDatabaseConnectionMode;
var
  z: TZConnection;
  i: integer;
begin
  with cnx do
  begin
    if Connected then
      Disconnect;
    LoginPrompt := (_user = '') or (_password = '');
    User := _user;
    Password := _password;
    Protocol := _protocol;
    ClientCodepage := _clientCodePage;
    LibraryLocation := _libraryLocation;
    Database := _database;
    if not FileExists(Database) then
    begin
      with properties do
      begin
        BeginUpdate;
        try
          Clear;
          Values['dialect'] := _dialect;
          Values['CreateNewDatabase'] := 'CREATE DATABASE ' + QuotedStr(database)
                                        +' USER ' + QuotedStr(_user)
                                        +' PASSWORD ' + QuotedStr(_password)
                                        +' PAGE_SIZE ' + _pageSize + ' DEFAULT CHARACTER SET ' + ClientCodePage;
        finally
          EndUpdate;
        end;
      end;
    end;

    try
      Connect;
    except
      on E:Exception do
      begin
        if Pos('SQL Error: Your user name and password are not defined',E.Message) > 0 then
        begin
          if MessageDlg('Sélectionnez une base de données existante et connectez-vous comme administrateur', mtInformation, [mbOk, mbCancel], 0) = mrOk then
          begin
            // créer une connexion avec sysdba
            z := TZConnection.Create(nil);
            try
              defaultParams(z);
              with TOpenDialog.Create(nil) do
              begin
                try
                  Filter := 'Firebird databases|*.fdb';
                  FilterIndex := 1;
                  if Execute then
                  begin
                    z.Database := Filename;
                  end;
                finally
                  Free;
                end;
              end;
              z.Connect;
              createFB25User(z,_user,_password,'');
              z.Disconnect;
            finally
              z.Free;
            end;
            try
              Connect;
            finally
              i := properties.IndexOfName('CreateNewDatabase');
              properties.Delete(i);
            end;
          end;
        end;
      end;
    end;
    i := properties.IndexOfName('CreateNewDatabase');
    if i > -1 then
      properties.Delete(i);
    try TransactIsolationLevel := ZDbcIntfs.tiReadCommitted; except end;
  end;
  Result := dcmCreate;
end;

function connectDatabase(cnx: TZConnection;
                        const _user, _password, _protocol,
                        _clientCodePage, _libraryLocation,
                        _database, _dialect,
                        _pageSize: string;
                        _transactionIsolationLevel: TZTransactIsolationLevel;
                        const role: string): TDatabaseConnectionMode;
begin
  with cnx do
  begin
    if Connected then Connected := False;
    User := _user;
    Password := _password;
    Protocol := _protocol;
    ClientCodepage := _clientCodePage;
    LibraryLocation := _libraryLocation;
    Database := _database;
    LoginPrompt := (_user = '') or (_password = '');
    try
      Connect;
    except
      Password := 'masterkey';
      try
        Connect;
      except
        LoginPrompt := True;
        Connect;
      end;
    end;
    try TransactIsolationLevel := _transactionIsolationLevel; except end;
  end;
  Result := dcmLoad;
end;

function createFB25Database(cnx: TZConnection; const databaseName, user, password: string): TDatabaseConnectionMode;
var
  f: TgetConnectionUserDlg;
  _user,
  _password: string;
begin
  { pour la création d'une base de données, on demande le login/password
    du propriétaire de la base }
  f := TgetConnectionUserDlg.Create(nil, nil, False);
  try
    f.user.Text := user;
    f.password.Text := password;
    f.userMessage := 'Saisir le login et mot de passe du propriétaire de la base de données';
    if f.ShowModal = mrOk then
    begin
      _user := f.user.Text;
      _password := f.password.Text;
    end;
  finally
    f.Free;
  end;
  Result := internalCreateDatabase(cnx, _user, _password, 'firebird-2.5', 'ISO8859_1', 'fbClient.dll', databasename, '3', '8192', ZDbcIntfs.tiReadCommitted);
end;

function loadFB25Database(cnx: TZConnection; const databaseName, user, password, role: string): TDatabaseConnectionMode;
begin
  Result := connectDatabase(cnx, user, password, 'firebird-2.5', 'ISO8859_1', 'fbClient.dll', databasename, '3', '8192', tiReadCommitted, role);
end;

function loadFB25Database(cnx: TZConnection;
                          const _user, _password, _protocol,
                          _clientCodePage, _libraryLocation,
                          _database, _dialect,
                          _pageSize: string;
                          _transactionIsolationLevel: TZTransactIsolationLevel): TDatabaseConnectionMode; overload;
begin
  with cnx do
  begin
    if Connected then Connected := False;
    User := _user;
    Password := _password;
    Protocol := _protocol;
    ClientCodepage := _clientCodePage;
    LibraryLocation := _libraryLocation;
    Database := _database;
    LoginPrompt := (_user = '') or (_password = '');
    try
      Connect;
    except
      Password := 'masterkey';
      try
        Connect;
      except
        LoginPrompt := True;
        Connect;
      end;
    end;
    try TransactIsolationLevel := ZDbcIntfs.tiReadCommitted; except end;
  end;
  Result := dcmLoad;
end;

function getFB25Owner(cnx: TZConnection): string;
begin
  with TZReadOnlyQuery.Create(nil) do
  begin
    Connection := cnx;
    try
      SQL.Add('select distinct rdb$owner_name'
             +' from rdb$relations'
             +' where rdb$system_flag = 1');
      Open;
      Result := Fields[0].AsString;
      Close;
    finally
      Free;
    end;
  end;
end;

function userFB25Exists(cnx: TZConnection; const user: string): boolean;
begin
  with TZReadOnlyQuery.Create(nil) do
  begin
    Connection := cnx;
    try
      SQL.Add('select count(distinct rdb$user)'
             +' from rdb$user_privileges'
             +' where UPPER(user) = ' + QuotedStr(Uppercase(user)));
      Open;
      Result := Fields[0].AsInteger > 0;
      Close;
    finally
      Free;
    end;
  end;
end;

procedure listFB25Users(cnx: TZConnection; list: TStrings);
begin
  list.BeginUpdate;
  try
    list.Clear;
    with TZReadOnlyQuery.Create(nil) do
    begin
      Connection := cnx;
      try
        SQL.Add('select distinct rdb$user'
               +' from rdb$user_privileges'
               +' order by 1');
        Open;
        while not Eof do
        begin
          list.Add(Fields[0].AsString);
          Next;
        end;
        Close;
      finally
        Free;
      end;
    end;
  finally
    list.EndUpdate;
  end;
end;

procedure listFB25Roles(cnx: TZConnection; list: TStrings);
begin
  list.BeginUpdate;
  try
    list.Clear;
    with TZReadOnlyQuery.Create(nil) do
    begin
      Connection := cnx;
      try
        SQL.Add('select distinct rdb$role_name'
               +' from rdb$roles'
//               +' where rdb$role_name not starting with ''RDB$'''
               +' order by 1');
        Open;
        while not Eof do
        begin
          list.Add(Fields[0].AsString);
          Next;
        end;
        Close;
      finally
        Free;
      end;
    end;
  finally
    list.EndUpdate;
  end;
end;

procedure listFB25UsersRole(cnx: TZConnection; list: TStrings);
begin
  list.BeginUpdate;
  try
    list.Clear;
    with TZReadOnlyQuery.Create(nil) do
    begin
      Connection := cnx;
      try
        SQL.Add('select u.rdb$user,u.rdb$relation_name'
               +' from rdb$user_privileges u'
               +' where u.rdb$privilege = ''M'''
               +' order by 1,2');
        Open;
        while not Eof do
        begin
          list.Add(Format('%s : %s', [Fields[0].AsString,Fields[1].AsString]));
          Next;
        end;
        Close;
      finally
        Free;
      end;
    end;
  finally
    list.EndUpdate;
  end;
end;

procedure createFB25User(cnx: TZConnection; const user, password, role: string);
begin
  if not userFB25Exists(cnx,user) then
  begin
    with TZReadOnlyQuery.Create(nil) do
    begin
      Connection := cnx;
      try
        SQL.Add(Format('create user %s password %s',[user,QuotedStr(password)]));
        cnx.StartTransaction;
        try
          ExecSQL;
          if role <> '' then
          begin
            SQL.Clear;
            sql.Add(Format('grant %s to %s',[role,user]));
            ExecSQL;
          end;
          cnx.Commit;
        except
          cnx.Rollback;
          raise;
        end;
      finally
        Free;
      end;
    end;
  end
  else
    alterFB25User(cnx,user,password,role);
end;

procedure alterFB25User(cnx: TZConnection; const user, password, role: string);
begin
  if userFB25Exists(cnx,user) then
  begin
    with TZReadOnlyQuery.Create(nil) do
    begin
      Connection := cnx;
      try
        SQL.Add(Format('alter user %s password %s',[user,QuotedStr(password)]));
        if role <> '' then
          SQL.Add(Format('grant %s role',[role]));
        ExecSQL;
        cnx.Commit;
      finally
        Free;
      end;
    end;
  end
  else
    createFB25User(cnx,user,password,role);
end;

function isUserFB25Role(cnx: TZConnection; const user, role: string): boolean;
begin
  Result := False;
  with TZReadOnlyQuery.Create(nil) do
  begin
    Connection := cnx;
    try
      SQL.Add('select ');
      Open;
      Close;
    finally
      Free;
    end;
  end;
end;

end.
