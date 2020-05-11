unit loginDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TloginDlg = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    loginEdit: TEdit;
    passwordEdit: TEdit;
    databaseBox: TComboBox;
    HeaderControl1: THeaderControl;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    constructor Create(AOwner: TComponent; const data: string); reintroduce;
  end;


implementation

{$R *.dfm}

uses
  lal_utils;

constructor TloginDlg.Create(AOwner: TComponent; const data: string);
var
  sr: TSearchRec;
begin
  inherited Create(AOwner);
  databaseBox.Items.BeginUpdate;
  try
    if FindFirst(IncludeTrailingBackslash(data) +'*.fdb', faArchive, sr) = 0 then
    begin
      repeat
        databaseBox.Items.Add(Lowercase(ChangeFileExt(sr.Name, '')));
      until FindNext(sr) <> 0;
    end;
    FindClose(sr);
  finally
    databaseBox.Items.EndUpdate;
  end;
end;

procedure TloginDlg.FormCreate(Sender: TObject);
begin
  Caption := ChangeFileExt(ExtractFileName(Application.ExeName),'')
           + ' '
           + GetAppVersion;

  loginEdit.Top :=  Succ(Succ(Image1.Height+HeaderControl1.Height));
  passwordEdit.Top := loginEdit.Top;
  passwordEdit.Left := Succ(loginEdit.Left + loginEdit.Width);
  databaseBox.Top := loginEdit.Top;
  databaseBox.Left := Succ(passwordEdit.Left + passwordEdit.Width);
  with HeaderControl1 do
  begin
    with Sections.Add do
    begin
      Width := loginEdit.Width;
      Text  := 'login';
    end;
    with Sections.Add do
    begin
      Width := passwordEdit.Width;
      Text  := 'mot de passe'
    end;
    with Sections.Add do
    begin
      Width := ClientWidth - (Sections[0].Width+Sections[1].Width);
      Text  := 'base de données';
    end;
  end;
end;

procedure TloginDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN : begin
      if (Screen.ActiveControl is TEdit) then
        Perform(WM_NEXTDLGCTL,0,0);
    end;

    VK_ESCAPE : begin
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TloginDlg.FormShow(Sender: TObject);
begin
  loginEdit.SetFocus;
end;

end.
