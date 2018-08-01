object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Style Chooser'
  ClientHeight = 382
  ClientWidth = 489
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
  object Bevel1: TBevel
    Left = 175
    Top = 8
    Width = 306
    Height = 366
  end
  object lbl: TLabel
    Left = 8
    Top = 8
    Width = 144
    Height = 26
    Caption = 'Select a style to apply among the already loaded styles'
    WordWrap = True
  end
  object Label1: TLabel
    Left = 8
    Top = 296
    Width = 135
    Height = 26
    Caption = 'Or pick a style file using the following button'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 360
    Top = 29
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 48
    Width = 153
    Height = 185
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 336
    Width = 153
    Height = 25
    Caption = 'Load a VCL Style from disk'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 48
    Top = 239
    Width = 113
    Height = 25
    Caption = 'Apply Selected Style'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 192
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 3
  end
  object Button4: TButton
    Left = 273
    Top = 17
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
  end
  object ListBox2: TListBox
    Left = 192
    Top = 48
    Width = 156
    Height = 137
    ItemHeight = 13
    TabOrder = 5
  end
  object ComboBox1: TComboBox
    Left = 360
    Top = 48
    Width = 113
    Height = 21
    TabOrder = 6
    Text = 'ComboBox1'
  end
  object CheckBox1: TCheckBox
    Left = 360
    Top = 89
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 7
  end
  object CheckBox2: TCheckBox
    Left = 360
    Top = 112
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 8
  end
  object Edit1: TEdit
    Left = 192
    Top = 191
    Width = 156
    Height = 21
    TabOrder = 9
    Text = 'Edit1'
  end
  object StringGrid1: TStringGrid
    Left = 192
    Top = 218
    Width = 281
    Height = 143
    TabOrder = 10
  end
  object OpenDialog1: TOpenDialog
    Filter = 'VCL Styles|*.vsf'
    InitialDir = '..\..'
    Options = [ofEnableSizing]
    Left = 24
    Top = 256
  end
end
