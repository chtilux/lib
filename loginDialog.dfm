object loginDlg: TloginDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'database login'
  ClientHeight = 202
  ClientWidth = 402
  Color = 10485760
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    402
    202)
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 385
    Height = 187
    Anchors = [akLeft, akTop, akRight, akBottom]
    Color = 16762052
    ParentBackground = False
    TabOrder = 0
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 383
      Height = 144
      Align = alTop
      ExplicitWidth = 519
    end
    object loginEdit: TEdit
      Left = 0
      Top = 162
      Width = 121
      Height = 22
      Color = clInfoBk
      TabOrder = 0
    end
    object passwordEdit: TEdit
      Left = 120
      Top = 162
      Width = 121
      Height = 22
      Color = clInfoBk
      TabOrder = 1
    end
    object databaseBox: TComboBox
      Left = 240
      Top = 162
      Width = 145
      Height = 24
      Style = csDropDownList
      Color = clInfoBk
      TabOrder = 2
      TabStop = False
    end
    object HeaderControl1: THeaderControl
      Left = 1
      Top = 145
      Width = 383
      Height = 17
      Sections = <>
    end
  end
end
