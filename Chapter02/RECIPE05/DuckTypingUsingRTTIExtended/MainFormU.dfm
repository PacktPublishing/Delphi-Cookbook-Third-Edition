object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 307
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    474
    307)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 32
    Top = 128
    Width = 75
    Height = 22
  end
  object Edit1: TEdit
    Left = 32
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 184
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit3: TEdit
    Left = 184
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 8
    Top = 251
    Width = 121
    Height = 50
    Anchors = [akLeft, akBottom]
    Caption = 'Set All Captions'
    TabOrder = 3
    WordWrap = True
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 135
    Top = 251
    Width = 106
    Height = 50
    Anchors = [akLeft, akBottom]
    Caption = 'Text property Where Name Edit*'
    TabOrder = 4
    WordWrap = True
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 247
    Top = 251
    Width = 106
    Height = 50
    Anchors = [akLeft, akBottom]
    Caption = 'All TEdit color RED'
    TabOrder = 5
    WordWrap = True
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 32
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 6
  end
  object ComboBox1: TComboBox
    Left = 184
    Top = 112
    Width = 145
    Height = 21
    TabOrder = 7
    Text = 'ComboBox1'
  end
  object ComboBox2: TComboBox
    Left = 184
    Top = 152
    Width = 145
    Height = 21
    TabOrder = 8
    Text = 'ComboBox1'
  end
  object Button5: TButton
    Left = 359
    Top = 251
    Width = 106
    Height = 50
    Anchors = [akLeft, akBottom]
    Caption = 'All TComboBox'
    TabOrder = 9
    WordWrap = True
    OnClick = Button5Click
  end
end
