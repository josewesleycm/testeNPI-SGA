object frmRelCombustivel: TfrmRelCombustivel
  Left = 573
  Top = 403
  Width = 256
  Height = 197
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio por Combust'#237'vel'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Imprimir'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 129
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 1
    OnClick = Button2Click
  end
  object rgTipCombo: TRadioGroup
    Left = 24
    Top = 21
    Width = 185
    Height = 82
    Caption = 'Cmbust'#237'vel'
    ItemIndex = 0
    Items.Strings = (
      'Gasolina'
      'Diesel'
      'Todos')
    TabOrder = 2
  end
end
