unit getConnectionUserDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TgetConnectionUserDlg = class(TForm)
    Bevel1: TBevel;
    okButton: TBitBtn;
    cancelButton: TBitBtn;
    Label1: TLabel;
    user: TEdit;
    Label2: TLabel;
    password: TEdit;
    Label3: TLabel;
    verify: TEdit;
    seeBox: TCheckBox;
    userMessageLabel: TLabel;
    Label4: TLabel;
    role: TComboBox;
    procedure okButtonClick(Sender: TObject);
    procedure seeBoxClick(Sender: TObject);
  private
    procedure setUserMessage(const Value: string);
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; roles: TStrings; const onlyLogin: boolean = True); reintroduce; overload;
    property userMessage: string write setUserMessage;
  end;

implementation

{$R *.dfm}

uses
  UITypes;

{ TgetConnectionUserDlg }

constructor TgetConnectionUserDlg.Create(AOwner: TComponent; roles: TStrings;
  const onlyLogin: boolean);
begin
  inherited Create(AOwner);
  verify.Enabled := not onlyLogin;
  if roles <> nil then
    role.Items.Assign(roles);
end;

procedure TgetConnectionUserDlg.okButtonClick(Sender: TObject);
begin
  if verify.Enabled and (password.Text <> verify.Text) then
  begin
    MessageDlg('Le mot de passe de vérification est différent du mot de passe !', mtWarning, [mbOk], 0);
    Abort;
  end;
  ModalResult := mrOk;
end;

procedure TgetConnectionUserDlg.seeBoxClick(Sender: TObject);
const
  see: array[Boolean] of char = ('*',#0);
begin
  password.PasswordChar := see[seeBox.Checked];
  verify.PasswordChar := password.PasswordChar;
end;

procedure TgetConnectionUserDlg.setUserMessage(const Value: string);
begin
  userMessageLabel.Caption := Value;
end;

end.
