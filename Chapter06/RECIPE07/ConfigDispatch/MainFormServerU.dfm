object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'ConfigDispatcher'
  ClientHeight = 279
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    299
    279)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 165
    Width = 127
    Height = 13
    Caption = 'Configuration requests log'
  end
  object Label2: TLabel
    Left = 8
    Top = 86
    Width = 25
    Height = 13
    Caption = 'App2'
  end
  object Label3: TLabel
    Left = 8
    Top = 6
    Width = 25
    Height = 13
    Caption = 'App1'
  end
  object MemoConfigApp1: TMemo
    Left = 8
    Top = 25
    Width = 283
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'Database=employee'
      'Server=localhost')
    TabOrder = 0
  end
  object MemoConfigApp2: TMemo
    Left = 8
    Top = 105
    Width = 283
    Height = 46
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'Database=erpdb'
      'Server=192.168.3.4')
    TabOrder = 1
  end
  object MemoLog: TMemo
    Left = 8
    Top = 184
    Width = 283
    Height = 87
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
  end
  object IdUDPServer1: TIdUDPServer
    Active = True
    BroadcastEnabled = True
    Bindings = <>
    DefaultPort = 8888
    OnUDPRead = IdUDPServer1UDPRead
    Left = 200
    Top = 56
  end
end
