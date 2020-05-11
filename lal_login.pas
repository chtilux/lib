unit lal_login;

interface

uses
  Classes;

type
  string31 = string[31];
  string08 = string[08];
  TRole = (dbrNone,dbrSuperuser,dbrManager,dbrReader);

  TLoginErrorCode = (lecNoLogin,lecClean,lecUnknown,lecWrongPassword,lecNoRight);
  TLogin = class
  private
    fUser: string31;
    fPassword: string08;
    fRole: TRole;
    fLoginErrorCode: TLoginErrorCode;
    procedure setPassword(const Value: string08);
    procedure setUser(const Value: string31);
  public
    constructor Create(const user, password: string); overload;
    constructor Create(const user, password: string; role: TRole); overload;
    constructor Create(const user, password: string; role: string); overload;

    class function roleToStr(role: TRole): string;
    class function strToRole(const role: string): TRole;

    property user: string31 read fUser write setUser;
    property password: string08 read fPassword write setPassword;
    property role: TRole read fRole write fRole default dbrNone;
    property loginErrorCode: TLoginErrorCode read fLoginErrorCode write fLoginErrorCode default lecNoLogin;
  end;

  function getRoles(items: TStrings): integer;

implementation


const
  strRoles: array[TRole] of string = ('','superuser','manager','reader');
var
  rolesList: TStrings;

{ TLogin }

constructor TLogin.Create(const user, password: string);
begin
  Self.user := user;
  Self.password := password;
  fRole := dbrNone;
end;

constructor TLogin.Create(const user, password: string; role: TRole);
begin
  Create(user,password);
  fRole := role;
end;

constructor TLogin.Create(const user, password: string; role: string);
begin
  Create(user,password,strToRole(role));
end;

class function TLogin.roleToStr(role: TRole): string;
begin
  Result := strRoles[role];
end;

procedure TLogin.setPassword(const Value: string08);
begin
  fPassword := Value;
end;

procedure TLogin.setUser(const Value: string31);
begin
  fUser := Value;
end;

class function TLogin.strToRole(const role: string): TRole;
begin
  try
    Result := TRole(rolesList.IndexOf(role));
  except
    Result := dbrNone;
  end;
end;

function getRoles(items: TStrings): integer;
var
  i: TRole;
begin
  items.BeginUpdate;
  try
    for i := Low(TRole) to High(TRole) do
      items.AddObject(rolesList[Ord(i)],TObject(i));
  finally
    items.EndUpdate;
  end;
  Result := items.Count;
end;

initialization
  rolesList := TStringList.Create;

finalization
  rolesList.Free;

end.
