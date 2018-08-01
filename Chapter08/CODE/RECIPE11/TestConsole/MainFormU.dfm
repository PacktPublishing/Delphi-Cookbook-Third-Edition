object TestConsoleForm: TTestConsoleForm
  Left = 0
  Top = 0
  Caption = 'SMS Test Console'
  ClientHeight = 392
  ClientWidth = 728
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 584
    Top = 30
    Width = 129
    Height = 25
    Caption = 'Push SMS'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 88
    Width = 728
    Height = 304
    Align = alBottom
    TabOrder = 1
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 32
    Width = 121
    Height = 21
    EditLabel.Width = 84
    EditLabel.Height = 13
    EditLabel.Caption = 'Recipient Number'
    TabOrder = 2
  end
  object LabeledEdit2: TLabeledEdit
    Left = 152
    Top = 32
    Width = 417
    Height = 21
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'SMS Text'
    TabOrder = 3
  end
end
