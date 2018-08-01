object MainForm: TMainForm
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight]
  BorderIcons = [biSystemMenu]
  Caption = 'Safe Queue'
  ClientHeight = 270
  ClientWidth = 150
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    150
    270)
  PixelsPerInch = 96
  TextHeight = 13
  object btnStartStop: TButton
    Left = 8
    Top = 9
    Width = 137
    Height = 40
    Caption = 'Start/Stop'
    TabOrder = 0
    WordWrap = True
    OnClick = btnStartStopClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 55
    Width = 136
    Height = 207
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Consolas'
    Font.Style = []
    ItemHeight = 22
    ParentFont = False
    TabOrder = 1
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 32
    Top = 112
  end
end
