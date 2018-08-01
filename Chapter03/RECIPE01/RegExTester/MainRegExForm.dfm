object RegExForm: TRegExForm
  Left = 0
  Top = 0
  Caption = 'Regular Expressions Tester'
  ClientHeight = 441
  ClientWidth = 827
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    827
    441)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 183
    Width = 26
    Height = 13
    Caption = 'Input'
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 13
    Caption = 'RegEx'
  end
  object Label3: TLabel
    Left = 8
    Top = 60
    Width = 43
    Height = 13
    Caption = 'Modifiers'
  end
  object Label4: TLabel
    Left = 472
    Top = 181
    Width = 35
    Height = 13
    Caption = 'Results'
  end
  object Label5: TLabel
    Left = 400
    Top = 60
    Width = 341
    Height = 13
    Caption = 
      'Sample RegEx (double click to set the selected one into the edit' +
      ' above)'
  end
  object Button1: TButton
    Left = 311
    Top = 200
    Width = 75
    Height = 54
    Caption = 'IsMatch'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edtRegEx: TEdit
    Left = 8
    Top = 25
    Width = 809
    Height = 29
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 8
    Top = 200
    Width = 297
    Height = 233
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object Memo2: TMemo
    Left = 472
    Top = 200
    Width = 345
    Height = 233
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object Button3: TButton
    Left = 311
    Top = 260
    Width = 75
    Height = 54
    Caption = 'Matches'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 392
    Top = 200
    Width = 75
    Height = 54
    Caption = 'Split'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 392
    Top = 260
    Width = 75
    Height = 54
    Caption = 'Replace'
    TabOrder = 6
    OnClick = Button5Click
  end
  object CheckListBox1: TCheckListBox
    Left = 8
    Top = 77
    Width = 378
    Height = 92
    Columns = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Items.Strings = (
      'roNone'
      'roIgnoreCase'
      'roMultiLine'
      'roExplicitCapture'
      'roCompiled'
      'roSingleLine'
      'roIgnorePatternSpace')
    ParentFont = False
    TabOrder = 7
  end
  object ListBox1: TListBox
    Left = 400
    Top = 77
    Width = 419
    Height = 92
    ItemHeight = 13
    Items.Strings = (
      '^daniele'
      '^[a-zA-Z]*$'
      '^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$'
      '[ ]?and[ ]?'
      
        '(?:[a-z0-9!#$%&'#39'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'#39'*+/=?^_`{|}~-]+' +
        ')*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x0' +
        '1-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9]' +
        ')?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9' +
        ']|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?' +
        '|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-' +
        '\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])'
      '[0-9]*')
    TabOrder = 8
    OnDblClick = ListBox1DblClick
  end
end
