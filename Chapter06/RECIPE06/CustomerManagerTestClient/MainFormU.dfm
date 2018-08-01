object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Simple REST Client'
  ClientHeight = 401
  ClientWidth = 837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 60
    Width = 831
    Height = 230
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Memo2: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 296
    Width = 831
    Height = 102
    Align = alBottom
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 14
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 837
    Height = 57
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 2
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 129
      Height = 40
      Caption = 'GET PEOPLE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 143
      Top = 8
      Width = 122
      Height = 40
      Caption = 'GET PEOPLE/{id}'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 271
      Top = 8
      Width = 122
      Height = 40
      Caption = 'POST PEOPLE'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 399
      Top = 8
      Width = 122
      Height = 40
      Caption = 'PUT PEOPLE/{id}'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 527
      Top = 8
      Width = 122
      Height = 40
      Caption = 'DELETE PEOPLE/{id}'
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 655
      Top = 8
      Width = 122
      Height = 40
      Caption = 'POST SEARCHES'
      TabOrder = 5
      OnClick = Button6Click
    end
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    BaseURL = 'http://localhost:8080'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 208
    Top = 80
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    SynchronizedEvents = False
    Left = 272
    Top = 80
  end
end
