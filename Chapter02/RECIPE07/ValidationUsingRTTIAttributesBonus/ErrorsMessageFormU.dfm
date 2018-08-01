object ErrorsMessageForm: TErrorsMessageForm
  Left = 0
  Top = 0
  Caption = 'ErrorsMessageForm'
  ClientHeight = 252
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 588
    Height = 20
    Align = alTop
    Caption = 'Oooh it seems that something went wrong with registration form:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 467
  end
  object Memo1: TMemo
    Left = 0
    Top = 20
    Width = 588
    Height = 232
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 16
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    ExplicitTop = 26
  end
end
