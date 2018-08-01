object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'GUI Version'
  ClientHeight = 179
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnStart: TButton
    Left = 24
    Top = 24
    Width = 121
    Height = 49
    Caption = 'btnStart'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 151
    Top = 24
    Width = 121
    Height = 49
    Caption = 'btnStop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object btnPause: TButton
    Left = 24
    Top = 104
    Width = 121
    Height = 49
    Caption = 'btnPause'
    TabOrder = 2
    OnClick = btnPauseClick
  end
  object btnContinue: TButton
    Left = 151
    Top = 104
    Width = 121
    Height = 49
    Caption = 'btnContinue'
    TabOrder = 3
    OnClick = btnContinueClick
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 136
    Top = 72
  end
end
