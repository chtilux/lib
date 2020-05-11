object getConnectionUserDlg: TgetConnectionUserDlg
  Left = 0
  Top = 0
  Caption = 'Connexion'
  ClientHeight = 217
  ClientWidth = 251
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    251
    217)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 235
    Height = 171
    Anchors = [akLeft, akTop, akRight, akBottom]
    ExplicitWidth = 370
    ExplicitHeight = 190
  end
  object Label1: TLabel
    Left = 47
    Top = 69
    Width = 55
    Height = 13
    Alignment = taRightJustify
    Caption = 'Utilisateur :'
  end
  object Label2: TLabel
    Left = 23
    Top = 96
    Width = 79
    Height = 13
    Alignment = taRightJustify
    Caption = 'Mode de passe :'
  end
  object Label3: TLabel
    Left = 15
    Top = 123
    Width = 87
    Height = 13
    Alignment = taRightJustify
    Caption = 'V'#233'rification mdp. :'
  end
  object userMessageLabel: TLabel
    Left = 21
    Top = 16
    Width = 208
    Height = 44
    AutoSize = False
    Caption = ' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 74
    Top = 150
    Width = 28
    Height = 13
    Alignment = taRightJustify
    Caption = 'R'#244'le :'
  end
  object okButton: TBitBtn
    Left = 58
    Top = 185
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 0
    OnClick = okButtonClick
  end
  object cancelButton: TBitBtn
    Left = 154
    Top = 185
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Annuler'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 1
  end
  object user: TEdit
    Left = 108
    Top = 66
    Width = 121
    Height = 21
    MaxLength = 8
    TabOrder = 2
  end
  object password: TEdit
    Left = 108
    Top = 93
    Width = 121
    Height = 21
    MaxLength = 8
    PasswordChar = '*'
    TabOrder = 3
  end
  object verify: TEdit
    Left = 108
    Top = 120
    Width = 121
    Height = 21
    Enabled = False
    MaxLength = 8
    PasswordChar = '*'
    TabOrder = 4
  end
  object seeBox: TCheckBox
    Left = 8
    Top = 193
    Width = 44
    Height = 17
    TabStop = False
    Anchors = [akLeft, akBottom]
    Caption = 'OO'
    TabOrder = 5
    OnClick = seeBoxClick
  end
  object role: TComboBox
    Left = 108
    Top = 147
    Width = 121
    Height = 21
    Enabled = False
    MaxLength = 8
    TabOrder = 6
  end
end
