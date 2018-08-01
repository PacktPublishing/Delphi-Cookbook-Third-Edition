object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TTS Client'
  ClientHeight = 96
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 72
    Height = 13
    Caption = 'Text to speach'
  end
  object btnSend: TButton
    Left = 8
    Top = 51
    Width = 97
    Height = 38
    Caption = 'Broadcast'
    Default = True
    TabOrder = 0
    OnClick = btnSendClick
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 266
    Height = 21
    TabOrder = 1
    Text = 'Hello World'
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 160
    Top = 40
  end
end
