object frmPrincipal: TfrmPrincipal
  Left = 369
  Top = 155
  Width = 793
  Height = 675
  BorderIcons = [biSystemMenu]
  Caption = 'Sistema Gerenciador de Abastecimento de Combust'#237'vel'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = mnPrincipal
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mnPrincipal: TMainMenu
    Left = 276
    Top = 138
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Tanques: TMenuItem
        Caption = 'Tanques'
        OnClick = TanquesClick
      end
      object Bombas1: TMenuItem
        Caption = 'Bombas'
        OnClick = Bombas1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair2: TMenuItem
        Caption = 'Sair'
        OnClick = Sair2Click
      end
    end
    object Movimentos1: TMenuItem
      Caption = 'Movimentos'
      OnClick = Movimentos1Click
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object PorCombustvel1: TMenuItem
        Caption = 'Por Combust'#237'vel'
        OnClick = PorCombustvel1Click
      end
    end
  end
end
