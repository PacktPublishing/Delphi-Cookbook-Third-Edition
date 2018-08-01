object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Task Dialogs'
  ClientHeight = 398
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnProgress: TButton
    Left = 24
    Top = 288
    Width = 177
    Height = 32
    Caption = '5. Start Task Dialog with progress'
    TabOrder = 0
    OnClick = btnProgressClick
  end
  object btnConfirm: TButton
    Left = 24
    Top = 216
    Width = 177
    Height = 32
    Caption = '4. Task Dialog (Confirm Removal)'
    TabOrder = 1
    OnClick = btnConfirmClick
  end
  object btnSimple: TButton
    Left = 24
    Top = 88
    Width = 177
    Height = 32
    Caption = '2. Simple dialog'
    TabOrder = 2
    OnClick = btnSimpleClick
  end
  object btnRadio: TButton
    Left = 24
    Top = 152
    Width = 177
    Height = 32
    Caption = '3. Radio Buttons'
    TabOrder = 3
    OnClick = btnRadioClick
  end
  object btnAPI: TButton
    Left = 24
    Top = 24
    Width = 177
    Height = 32
    Caption = '1. Simple API Version'
    TabOrder = 4
    OnClick = btnAPIClick
  end
  object btnCheckWinVer: TButton
    Left = 24
    Top = 347
    Width = 177
    Height = 25
    Caption = '6. Check Win Ver'
    TabOrder = 5
    OnClick = btnCheckWinVerClick
  end
  object tdProgress: TTaskDialog
    Buttons = <>
    Caption = 'Please wait'
    CommonButtons = [tcbCancel]
    ExpandButtonCaption = 'More'
    ExpandedText = 
      'A prime number (or a prime) is a natural number greater than 1 t' +
      'hat has no positive divisors other than 1 and itself.'
    Flags = [tfAllowDialogCancellation, tfShowProgressBar, tfCallbackTimer]
    FooterIcon = 3
    FooterText = 'Please wait while we are calculate prime numbers'
    RadioButtons = <>
    Text = 'Let'#39's calculate prime numbers up to 1000'
    Title = 'Calculating prime numbers...'
    VerificationText = 'Remember my choice'
    OnButtonClicked = tdProgressButtonClicked
    OnTimer = tdProgressTimer
    Left = 224
    Top = 280
  end
  object tdConfirm: TTaskDialog
    Buttons = <>
    RadioButtons = <>
    Left = 224
    Top = 216
  end
  object tdSimple: TTaskDialog
    Buttons = <>
    Caption = 'The question'
    CommonButtons = [tcbYes, tcbNo]
    DefaultButton = tcbYes
    ExpandButtonCaption = 'More information'
    ExpandedText = 
      'Yes, you have to decide something about this question... but I c' +
      'annot help you a lot'
    Flags = [tfUseHiconMain, tfUseHiconFooter, tfVerificationFlagChecked]
    FooterIcon = 4
    FooterText = 'This is an important question...'
    RadioButtons = <>
    Text = 'To be or not to be, this is the question. To be?'
    Title = 'William ask:'
    Left = 224
    Top = 88
  end
  object tdRadioButtons: TTaskDialog
    Buttons = <>
    Caption = 'The question'
    DefaultButton = tcbYes
    ExpandButtonCaption = 'More information'
    ExpandedText = 
      'Yes, you have to decide something about this question... but I c' +
      'annot help you a lot'
    Flags = [tfUseHiconMain, tfUseHiconFooter, tfVerificationFlagChecked]
    FooterIcon = 4
    FooterText = 'This is an important question...'
    RadioButtons = <
      item
        Caption = 'Yes, I want to buy this book'
      end
      item
        Caption = 'No, this book is awful'
      end
      item
        Caption = 'Maybe in the future'
      end>
    Text = 'Do you wanna buy "The Tragedy of Hamlet"?'
    Title = 'William ask:'
    Left = 224
    Top = 152
  end
end
