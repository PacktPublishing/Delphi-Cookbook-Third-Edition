object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Control Arduino LED Blink'
  ClientHeight = 134
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 302
    Height = 40
    Caption = 'Arduino LED Blinking'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object blinkSwitch: TToggleSwitch
    Left = 344
    Top = 20
    Width = 75
    Height = 25
    TabOrder = 0
    OnClick = blinkSwitchClick
  end
  object btnSetup: TButton
    Left = 16
    Top = 80
    Width = 102
    Height = 25
    Caption = 'ComPort Setup'
    TabOrder = 1
    OnClick = btnSetupClick
  end
  object btnConnection: TButton
    Left = 124
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 2
    OnClick = btnConnectionClick
  end
  object ComPort1: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = True
    Left = 288
    Top = 56
  end
end
