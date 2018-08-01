object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'System.Zip'
  ClientHeight = 296
  ClientWidth = 539
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    539
    296)
  PixelsPerInch = 96
  TextHeight = 13
  object btnZipUnZip: TButton
    Left = 8
    Top = 8
    Width = 249
    Height = 57
    Caption = 'Zip, Get Info and UnZip'
    TabOrder = 0
    OnClick = btnZipUnZipClick
  end
  object MemoSummary: TMemo
    Left = 8
    Top = 71
    Width = 523
    Height = 217
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
  end
end
