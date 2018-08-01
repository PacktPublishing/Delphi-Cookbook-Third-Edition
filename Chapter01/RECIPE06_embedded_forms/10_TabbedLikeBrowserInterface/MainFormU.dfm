object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Tabbed BrowserLike Interface'
  ClientHeight = 438
  ClientWidth = 793
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 793
    Height = 41
    Align = alTop
    PopupMenu = PopupMenu1
    TabHeight = 50
    TabOrder = 0
    OnChange = TabControl1Change
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 793
    Height = 378
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 419
    Width = 793
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 100
      end>
  end
  object MainMenu1: TMainMenu
    Left = 224
    Top = 80
    object MenuProducts: TMenuItem
      Caption = '&Products'
      object MenuOrders: TMenuItem
        Caption = '&Orders'
        OnClick = MenuOrdersClick
      end
      object MenuSales: TMenuItem
        Caption = '&Sales'
        OnClick = MenuSalesClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MenuInvoices: TMenuItem
        Caption = '&Invoices'
        OnClick = MenuInvoicesClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 328
    Top = 88
    object Close1: TMenuItem
      Caption = '&Close'
      OnClick = Close1Click
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    OnHint = ApplicationEvents1Hint
    Left = 224
    Top = 152
  end
end
