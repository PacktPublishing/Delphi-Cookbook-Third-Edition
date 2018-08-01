object MainForm: TMainForm
  Left = 43
  Top = 236
  Caption = 'TMessageManager SAMPLE'
  ClientHeight = 120
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    338
    120)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOpen: TButton
    Left = 8
    Top = 8
    Width = 137
    Height = 25
    Caption = 'Open a secondary form'
    TabOrder = 0
    OnClick = btnOpenClick
  end
  object memText: TMemo
    Left = 8
    Top = 39
    Width = 322
    Height = 73
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    OnChange = memTextChange
  end
end
