object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 366
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mmNames: TMemo
    Left = 0
    Top = 37
    Width = 129
    Height = 329
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'MSFT'
      'AAPL'
      'GOOGL'
      'STM')
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 662
    Height = 37
    Align = alTop
    TabOrder = 1
    object Button3: TButton
      Left = 135
      Top = 6
      Width = 138
      Height = 25
      Caption = 'Start Monitor Quotes'
      TabOrder = 0
      OnClick = Button3Click
    end
    object edtStock: TEdit
      Left = 8
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '100'
    end
  end
  object lbResults: TListBox
    Left = 129
    Top = 37
    Width = 533
    Height = 329
    Align = alClient
    Anchors = [akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Consolas'
    Font.Style = []
    ItemHeight = 32
    ParentFont = False
    TabOrder = 2
    ExplicitWidth = 288
  end
  object Timer1: TTimer
    Interval = 200
    OnTimer = Timer1Timer
    Left = 32
    Top = 192
  end
end
