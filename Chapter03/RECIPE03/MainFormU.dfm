object MainForm: TMainForm
  Left = 293
  Top = 274
  BorderStyle = bsDialog
  Caption = 'System.NetEncoding RECIPE'
  ClientHeight = 246
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    709
    246)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 265
    Height = 233
    Caption = 'Download a binary stream as Base64'
    TabOrder = 0
    object Image1: TImage
      Left = 16
      Top = 55
      Width = 232
      Height = 162
      Center = True
    end
    object btnGetPhoto: TButton
      Left = 135
      Top = 26
      Width = 113
      Height = 25
      Caption = 'Get Photo'
      TabOrder = 0
      OnClick = btnGetPhotoClick
    end
    object EditPersonID: TEdit
      Left = 16
      Top = 28
      Width = 113
      Height = 21
      TabOrder = 1
      TextHint = 'Person ID'
    end
  end
  object GroupBox2: TGroupBox
    Left = 279
    Top = 8
    Width = 421
    Height = 233
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Get a list of person passing non ASCII param'
    TabOrder = 1
    object btnGetPeople: TButton
      Left = 295
      Top = 26
      Width = 113
      Height = 25
      Caption = 'Get List'
      TabOrder = 0
      OnClick = btnGetPeopleClick
    end
    object EditSearch: TEdit
      Left = 16
      Top = 28
      Width = 273
      Height = 21
      TabOrder = 1
      TextHint = 'Search text...'
    end
    object lbPeople: TListBox
      Left = 16
      Top = 57
      Width = 393
      Height = 160
      ItemHeight = 13
      TabOrder = 2
    end
  end
end
