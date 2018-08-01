object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 282
  ClientWidth = 687
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
    Left = 16
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 144
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
  end
  object Button4: TButton
    Left = 144
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 3
  end
  object Button5: TButton
    Left = 16
    Top = 200
    Width = 145
    Height = 68
    Caption = 'Set Captions for some Buttons'
    TabOrder = 4
    WordWrap = True
    OnClick = Button5Click
  end
  object Edit1: TEdit
    Left = 264
    Top = 18
    Width = 89
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 378
    Top = 18
    Width = 89
    Height = 21
    TabOrder = 6
    Text = 'Edit2'
  end
  object Edit3: TEdit
    Left = 264
    Top = 66
    Width = 89
    Height = 21
    TabOrder = 7
    Text = 'Edit3'
  end
  object Edit4: TEdit
    Left = 378
    Top = 66
    Width = 89
    Height = 21
    TabOrder = 8
    Text = 'Edit4'
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 120
    Width = 203
    Height = 21
    TabOrder = 9
    Text = 'ComboBox1'
  end
  object ComboBox2: TComboBox
    Left = 264
    Top = 120
    Width = 203
    Height = 21
    TabOrder = 10
    Text = 'ComboBox2'
  end
  object Button6: TButton
    Left = 176
    Top = 200
    Width = 145
    Height = 68
    Caption = 'Disable all controls but TButtons'
    TabOrder = 11
    WordWrap = True
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 336
    Top = 200
    Width = 145
    Height = 68
    Caption = 'Set Font.Name for some controls'
    TabOrder = 12
    WordWrap = True
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 496
    Top = 200
    Width = 145
    Height = 68
    Caption = 'Set color to red'
    TabOrder = 13
    WordWrap = True
    OnClick = Button8Click
  end
end
