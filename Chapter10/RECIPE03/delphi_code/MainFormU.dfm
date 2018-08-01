object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Read data from Arduino'
  ClientHeight = 207
  ClientWidth = 452
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
  object redLedLabel: TLabel
    AlignWithMargins = True
    Left = 32
    Top = 16
    Width = 122
    Height = 40
    Caption = 'LED Red'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object greenLEDLabel: TLabel
    AlignWithMargins = True
    Left = 240
    Top = 16
    Width = 153
    Height = 40
    Caption = 'LED Green'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnSetup: TButton
    Left = 8
    Top = 174
    Width = 102
    Height = 25
    Caption = 'ComPort Setup'
    TabOrder = 0
    OnClick = btnSetupClick
  end
  object btnConnection: TButton
    Left = 124
    Top = 174
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 1
    OnClick = btnConnectionClick
  end
  object redLEDSwitch: TToggleSwitch
    Left = 64
    Top = 80
    Width = 72
    Height = 20
    ReadOnly = True
    TabOrder = 2
  end
  object greenLEDSwitch: TToggleSwitch
    Left = 280
    Top = 80
    Width = 72
    Height = 20
    ReadOnly = True
    TabOrder = 3
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
    OnRxChar = ComPort1RxChar
    Left = 328
    Top = 152
  end
end
