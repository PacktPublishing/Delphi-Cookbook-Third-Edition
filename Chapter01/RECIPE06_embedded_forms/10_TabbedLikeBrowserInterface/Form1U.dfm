inherited Form1: TForm1
  Caption = 'Orders'
  ExplicitWidth = 507
  ExplicitHeight = 362
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 32
    Width = 111
    Height = 13
    Caption = 'This is the Orders Form'
  end
  object Button1: TButton
    Left = 16
    Top = 72
    Width = 353
    Height = 81
    Hint = 'This is an Hint'
    Caption = 'This Button close the form and the tab in the TabControl'
    TabOrder = 0
    WordWrap = True
    OnClick = Button1Click
  end
end
