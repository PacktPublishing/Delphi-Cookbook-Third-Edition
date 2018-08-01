object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'ZLIB Sample'
  ClientHeight = 64
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnCompress: TButton
    Left = 8
    Top = 7
    Width = 105
    Height = 49
    Caption = 'Compress'
    TabOrder = 0
    OnClick = btnCompressClick
  end
  object btnDeCompress: TButton
    Left = 119
    Top = 8
    Width = 98
    Height = 49
    Caption = 'Decompress'
    TabOrder = 1
    OnClick = btnDeCompressClick
  end
end
