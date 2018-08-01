object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TMonitor'
  ClientHeight = 340
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    244
    340)
  PixelsPerInch = 96
  TextHeight = 23
  object btnStart: TButton
    Left = 8
    Top = 8
    Width = 227
    Height = 61
    Caption = 'Multiple writes on a shared file'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    WordWrap = True
    OnClick = btnStartClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 75
    Width = 227
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Consolas'
    Font.Style = []
    ItemHeight = 22
    ParentFont = False
    TabOrder = 1
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 136
    Top = 192
  end
end
