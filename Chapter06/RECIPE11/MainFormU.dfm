object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 446
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    731
    446)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSendPostRequest: TButton
    Left = 8
    Top = 8
    Width = 233
    Height = 25
    Caption = 'Send POST request with parameters'
    TabOrder = 0
    OnClick = btnSendPostRequestClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 88
    Width = 715
    Height = 160
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    TabOrder = 1
  end
  object mmCertInfo: TMemo
    Left = 0
    Top = 254
    Width = 731
    Height = 192
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    ExplicitTop = 160
  end
  object btnGetPost: TButton
    Left = 8
    Top = 39
    Width = 233
    Height = 25
    Caption = 'Send GET request to an HTTPS server'
    TabOrder = 3
    OnClick = btnGetPostClick
  end
  object btnPost: TButton
    Left = 247
    Top = 39
    Width = 322
    Height = 25
    Caption = 'Send POST request with body request to an HTTPS server'
    TabOrder = 4
    OnClick = btnPostClick
  end
  object NetHTTPClient1: TNetHTTPClient
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    OnValidateServerCertificate = NetHTTPClient1ValidateServerCertificate
    Left = 64
    Top = 72
  end
end
