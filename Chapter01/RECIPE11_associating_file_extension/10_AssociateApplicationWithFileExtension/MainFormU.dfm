object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Register File Type'
  ClientHeight = 176
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 332
    Height = 135
    Align = alClient
    BorderStyle = bsNone
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 332
    Height = 41
    Align = alTop
    TabOrder = 1
    object btnRegister: TButton
      Left = 8
      Top = 10
      Width = 113
      Height = 25
      Caption = 'Register File Type'
      TabOrder = 0
      OnClick = btnRegisterClick
    end
    object btnUnRegister: TButton
      Left = 127
      Top = 10
      Width = 114
      Height = 25
      Caption = 'Unregister File Type'
      TabOrder = 1
      OnClick = btnUnRegisterClick
    end
  end
end
