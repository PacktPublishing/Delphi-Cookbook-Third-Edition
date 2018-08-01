object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'TTask'
  ClientHeight = 217
  ClientWidth = 343
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    343
    217)
  PixelsPerInch = 96
  TextHeight = 13
  object mmLog: TMemo
    Left = 86
    Top = 8
    Width = 249
    Height = 201
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 0
  end
  object btnExceptionDef: TButton
    Left = 8
    Top = 90
    Width = 72
    Height = 35
    Caption = 'Exceptions (Default)'
    TabOrder = 1
    WordWrap = True
    OnClick = btnExceptionDefClick
  end
  object btnRESTRequest: TButton
    Left = 8
    Top = 131
    Width = 72
    Height = 35
    Caption = 'REST Call'
    TabOrder = 2
    OnClick = btnRESTRequestClick
  end
  object btnSimple: TButton
    Left = 8
    Top = 8
    Width = 72
    Height = 35
    Caption = 'Simple'
    TabOrder = 3
    OnClick = btnSimpleClick
  end
  object btnWithException: TButton
    Left = 8
    Top = 49
    Width = 72
    Height = 35
    Caption = 'Exceptions'
    TabOrder = 4
    OnClick = btnWithExceptionClick
  end
end
