object VCLForm: TVCLForm
  Left = 0
  Top = 0
  Caption = 'VCLForm'
  ClientHeight = 309
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 128
    Width = 127
    Height = 13
    Caption = 'Log from Firemonkey Form'
  end
  object btnCallFMX: TButton
    Left = 24
    Top = 16
    Width = 201
    Height = 73
    Caption = 'Call FireMonkey Form'
    TabOrder = 0
    OnClick = btnCallFMXClick
  end
  object ListBox1: TListBox
    Left = 24
    Top = 147
    Width = 201
    Height = 148
    ItemHeight = 13
    TabOrder = 1
  end
end
