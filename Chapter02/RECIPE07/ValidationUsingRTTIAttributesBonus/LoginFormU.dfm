object LoginForm: TLoginForm
  Left = 0
  Top = 0
  Caption = 'Awesome Login Form Vol 2'
  ClientHeight = 339
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    274
    339)
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 24
    Top = 41
    Width = 225
    Height = 21
    Anchors = []
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'Email'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 24
    Top = 108
    Width = 225
    Height = 21
    Anchors = []
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnRegister: TButton
    Left = 24
    Top = 210
    Width = 225
    Height = 65
    Anchors = []
    Caption = 'Login'
    TabOrder = 2
    OnClick = btnRegisterClick
  end
end
