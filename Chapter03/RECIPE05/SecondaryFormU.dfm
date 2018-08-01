object SecondaryForm: TSecondaryForm
  Left = 655
  Top = 266
  Caption = 'SecondaryForm'
  ClientHeight = 128
  ClientWidth = 302
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblText: TLabel
    Left = 0
    Top = 41
    Width = 302
    Height = 87
    Align = alClient
    Alignment = taCenter
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    ExplicitWidth = 18
    ExplicitHeight = 23
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 41
    Align = alTop
    TabOrder = 0
    object btnOpenForm: TButton
      Left = 8
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Open Another Form'
      TabOrder = 0
      OnClick = btnOpenFormClick
    end
  end
end
