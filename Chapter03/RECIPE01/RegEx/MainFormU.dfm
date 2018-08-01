object RegExForm: TRegExForm
  Left = 0
  Top = 0
  Caption = 'RegEx Real Cases'
  ClientHeight = 163
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EditEMail: TEdit
    Left = 16
    Top = 72
    Width = 217
    Height = 21
    TabOrder = 2
    TextHint = 'Type your email'
  end
  object EditTaxCodeIT: TEdit
    Left = 16
    Top = 120
    Width = 217
    Height = 21
    TabOrder = 4
    TextHint = 'Type your italian tax code'
  end
  object EditIP: TEdit
    Left = 16
    Top = 24
    Width = 217
    Height = 21
    TabOrder = 0
    TextHint = 'Type an IP address'
  end
  object btnCheckEmail: TButton
    Left = 239
    Top = 70
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 3
    OnClick = btnCheckEmailClick
  end
  object btnCheckItalianTaxCode: TButton
    Left = 239
    Top = 118
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 5
    OnClick = btnCheckItalianTaxCodeClick
  end
  object btnCheckIP: TButton
    Left = 239
    Top = 22
    Width = 75
    Height = 25
    Caption = 'Check'
    TabOrder = 1
    OnClick = btnCheckIPClick
  end
end
