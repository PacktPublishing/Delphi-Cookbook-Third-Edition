object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Awesome registration form'
  ClientHeight = 401
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    361
    401)
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 48
    Top = 41
    Width = 273
    Height = 21
    Anchors = []
    EditLabel.Width = 47
    EditLabel.Height = 13
    EditLabel.Caption = 'Firstname'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 48
    Top = 108
    Width = 273
    Height = 21
    Anchors = []
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Lastname'
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 48
    Top = 172
    Width = 273
    Height = 21
    Anchors = []
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Email'
    TabOrder = 2
  end
  object LabeledEdit4: TLabeledEdit
    Left = 48
    Top = 237
    Width = 273
    Height = 21
    Anchors = []
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    TabOrder = 3
  end
  object btnRegister: TButton
    Left = 48
    Top = 304
    Width = 273
    Height = 65
    Anchors = []
    Caption = 'Register'
    TabOrder = 4
    OnClick = btnRegisterClick
  end
end
