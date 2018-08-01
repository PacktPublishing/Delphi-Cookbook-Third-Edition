object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Streams, Writers and Readers'
  ClientHeight = 220
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    484
    220)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 201
    Width = 478
    Height = 16
    Align = alBottom
    Caption = 
      'WARNING: TEncoding.Default is ANSI on MS Windows but UTF8 on POS' +
      'IX systems'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 473
  end
  object Label2: TLabel
    Left = 8
    Top = 60
    Width = 31
    Height = 13
    Caption = 'Label2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnWriteFile: TButton
    Left = 8
    Top = 8
    Width = 113
    Height = 49
    Caption = 'btnWriteFile'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnWriteFileClick
  end
  object btnReadFile: TButton
    Left = 127
    Top = 8
    Width = 113
    Height = 49
    Caption = 'btnReadFile'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnReadFileClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 79
    Width = 468
    Height = 119
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object RadioGroup1: TRadioGroup
    Left = 246
    Top = 8
    Width = 230
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Current Encoding'
    Columns = 2
    TabOrder = 3
  end
end
