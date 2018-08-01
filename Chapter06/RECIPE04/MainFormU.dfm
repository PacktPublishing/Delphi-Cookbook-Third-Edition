object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Objects to JSON and back'
  ClientHeight = 284
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 57
    Align = alTop
    TabOrder = 0
    object btnListToJSONArray: TButton
      AlignWithMargins = True
      Left = 315
      Top = 4
      Width = 157
      Height = 49
      Align = alLeft
      Caption = '3) ObjectList to JSON array'
      TabOrder = 0
      OnClick = btnListToJSONArrayClick
    end
    object btnObjToJSON: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 156
      Height = 49
      Align = alLeft
      Caption = '1) Object to JSON object'
      TabOrder = 1
      OnClick = btnObjToJSONClick
    end
    object btnJSONtoObject: TButton
      AlignWithMargins = True
      Left = 166
      Top = 4
      Width = 143
      Height = 49
      Align = alLeft
      Caption = '2) JSONObject to Object'
      TabOrder = 2
      OnClick = btnJSONtoObjectClick
    end
    object btnJSONArrayToList: TButton
      AlignWithMargins = True
      Left = 478
      Top = 4
      Width = 143
      Height = 49
      Align = alLeft
      Caption = '4) JSONArray to ObjectList'
      TabOrder = 3
      OnClick = btnJSONArrayToListClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 624
    Height = 227
    Align = alClient
    TabOrder = 1
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 622
      Height = 225
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Consolas'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
