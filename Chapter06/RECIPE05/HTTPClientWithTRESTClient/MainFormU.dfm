object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Sending POST data'
  ClientHeight = 165
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnSubmit: TButton
    Left = 190
    Top = 132
    Width = 75
    Height = 25
    Caption = 'Submit'
    TabOrder = 0
    OnClick = btnSubmitClick
  end
  object edtFirstName: TEdit
    Left = 24
    Top = 16
    Width = 241
    Height = 21
    TabOrder = 1
    TextHint = 'First name'
  end
  object edtLastName: TEdit
    Left = 24
    Top = 43
    Width = 241
    Height = 21
    TabOrder = 2
    TextHint = 'Last name'
  end
  object edtWorkPhone: TEdit
    Left = 24
    Top = 97
    Width = 113
    Height = 21
    TabOrder = 4
    TextHint = 'Work phone'
  end
  object edtMobilePhone: TEdit
    Left = 143
    Top = 97
    Width = 122
    Height = 21
    TabOrder = 5
    TextHint = 'Mobile phone'
  end
  object edtEmail: TEdit
    Left = 24
    Top = 70
    Width = 241
    Height = 21
    TabOrder = 3
    TextHint = 'email'
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    BaseURL = 'http://localhost:8080'
    Params = <>
    HandleRedirects = True
    Left = 40
    Top = 120
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Resource = 'saveperson'
    SynchronizedEvents = False
    Left = 128
    Top = 120
  end
end
