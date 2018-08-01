object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Delphi Cookbook'
  ClientHeight = 230
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -30
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 36
  object Label1: TLabel
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 227
    Height = 29
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Alignment = taCenter
    Caption = 'Set duration [min]'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 193
  end
  object lblMinutes: TLabel
    Left = 0
    Top = 137
    Width = 231
    Height = 29
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Alignment = taCenter
    Caption = '--'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 18
  end
  object btnSetMinutes: TButton
    AlignWithMargins = True
    Left = 2
    Top = 168
    Width = 227
    Height = 60
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    Caption = 'Start speech'
    TabOrder = 0
    WordWrap = True
    OnClick = btnSetMinutesClick
  end
  object seMinutes: TSpinEdit
    Left = 70
    Top = 49
    Width = 97
    Height = 46
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object tmrTime: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmrTimeTimer
    Left = 184
    Top = 40
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'presenter.base'
    Group = 'com.danieles.presenters'
    Actions = <>
    Resources = <
      item
        Name = 'time'
        IsPublic = True
      end>
    OnResourceReceived = TetheringAppProfile1ResourceReceived
    Left = 160
    Top = 96
  end
  object TetheringManager1: TTetheringManager
    OnPairedFromLocal = TetheringManager1PairedFromLocal
    Text = 'TetheringManager1'
    AllowedAdapters = 'Network'
    Left = 48
    Top = 96
  end
end
