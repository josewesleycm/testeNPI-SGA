object frmTanques: TfrmTanques
  Left = 484
  Top = 261
  Width = 552
  Height = 355
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de Tanques'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 78
    Top = 27
    Width = 65
    Height = 13
    Caption = 'C'#243'd. Tanque:'
  end
  object Label2: TLabel
    Left = 78
    Top = 60
    Width = 86
    Height = 13
    Caption = 'Tipo Combust'#237'vel:'
  end
  object Panel1: TPanel
    Left = 9
    Top = 253
    Width = 520
    Height = 49
    TabOrder = 3
    object dbNavega: TDBNavigator
      Left = 10
      Top = 12
      Width = 156
      Height = 25
      DataSource = dtsTanque
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 4
      OnClick = dbNavegaClick
    end
    object btn_inc: TButton
      Left = 172
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Inc'
      TabOrder = 3
      OnClick = btn_incClick
    end
    object btn_alt: TButton
      Left = 217
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Alt'
      TabOrder = 0
      OnClick = btn_altClick
    end
    object btn_exc: TButton
      Left = 259
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Exc'
      TabOrder = 1
      OnClick = btn_excClick
    end
    object btn_sal: TButton
      Left = 304
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Sal'
      TabOrder = 2
      OnClick = btn_salClick
    end
    object btn_can: TButton
      Left = 349
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Can'
      TabOrder = 5
      OnClick = btn_canClick
    end
    object btn_sair: TButton
      Left = 469
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Sair'
      TabOrder = 6
      OnClick = btn_sairClick
    end
  end
  object edt_codtanque: TEdit
    Left = 171
    Top = 24
    Width = 34
    Height = 21
    Enabled = False
    MaxLength = 2
    TabOrder = 0
  end
  object rg_tipcomb: TRadioGroup
    Left = 171
    Top = 54
    Width = 88
    Height = 52
    Caption = 'Combust'#237'vel'
    Items.Strings = (
      'Gasolina'
      'Diesel')
    TabOrder = 1
  end
  object dbgTanque: TDBGrid
    Left = 81
    Top = 117
    Width = 178
    Height = 120
    DataSource = dtsTanque
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tipo_comb'
        Title.Caption = 'T. Combust'#237'vel'
        Visible = True
      end>
  end
  object qryTanque: TZQuery
    Connection = dmPrincipal.conexao
    SQL.Strings = (
      'select * from tanque')
    Params = <>
    Left = 351
    Top = 27
    object qryTanqueId: TIntegerField
      FieldName = 'Id'
      ReadOnly = True
    end
    object qryTanquetipo_comb: TStringField
      FieldName = 'tipo_comb'
      Size = 1
    end
  end
  object dtsTanque: TDataSource
    DataSet = qryTanque
    Left = 426
    Top = 27
  end
end
