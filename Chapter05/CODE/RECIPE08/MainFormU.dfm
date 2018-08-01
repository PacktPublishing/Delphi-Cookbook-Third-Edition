object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 121
  ClientWidth = 241
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
  object btnStart: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 41
    Caption = 'Start parallel processing'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 64
    Top = 64
  end
end
