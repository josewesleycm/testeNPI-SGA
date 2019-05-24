object frmMovimentacao: TfrmMovimentacao
  Left = 462
  Top = 242
  Width = 570
  Height = 417
  BorderIcons = [biSystemMenu]
  Caption = 'Movimenta'#231#227'o de Abastecimento'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 39
    Top = 48
    Width = 61
    Height = 13
    Caption = 'C'#243'd. Bomba:'
  end
  object Label3: TLabel
    Left = 39
    Top = 21
    Width = 80
    Height = 13
    Caption = 'C'#243'd. Movimento:'
  end
  object Label2: TLabel
    Left = 41
    Top = 77
    Width = 29
    Height = 13
    Caption = 'Data: '
  end
  object Label4: TLabel
    Left = 42
    Top = 105
    Width = 58
    Height = 13
    Caption = 'Quantidade:'
  end
  object Label5: TLabel
    Left = 45
    Top = 132
    Width = 27
    Height = 13
    Caption = 'Valor:'
  end
  object edt_codbomba: TEdit
    Left = 132
    Top = 45
    Width = 33
    Height = 21
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 15
    Top = 307
    Width = 519
    Height = 49
    TabOrder = 6
    object dbNavega: TDBNavigator
      Left = 9
      Top = 13
      Width = 156
      Height = 25
      DataSource = dtsMovimento
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 6
      OnClick = dbNavegaClick
    end
    object btn_inc: TButton
      Left = 171
      Top = 13
      Width = 40
      Height = 25
      Caption = 'Inc'
      TabOrder = 0
      OnClick = btn_incClick
    end
    object btn_alt: TButton
      Left = 216
      Top = 13
      Width = 40
      Height = 25
      Caption = 'Alt'
      TabOrder = 1
      OnClick = btn_altClick
    end
    object btn_exc: TButton
      Left = 258
      Top = 13
      Width = 40
      Height = 25
      Caption = 'Exc'
      TabOrder = 2
      OnClick = btn_excClick
    end
    object btn_sal: TButton
      Left = 303
      Top = 13
      Width = 40
      Height = 25
      Caption = 'Sal'
      TabOrder = 3
      OnClick = btn_salClick
    end
    object btn_can: TButton
      Left = 348
      Top = 13
      Width = 40
      Height = 25
      Caption = 'Can'
      TabOrder = 4
      OnClick = btn_canClick
    end
    object btn_sair: TButton
      Left = 468
      Top = 13
      Width = 40
      Height = 25
      Caption = 'Sair'
      TabOrder = 5
      OnClick = btn_sairClick
    end
  end
  object edt_codmovime: TEdit
    Left = 132
    Top = 18
    Width = 33
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object edt_datmovime: TMaskEdit
    Left = 132
    Top = 75
    Width = 73
    Height = 21
    EditMask = '!99/99/0000;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
  end
  object edt_qtdmovime: TMaskEdit
    Left = 132
    Top = 102
    Width = 76
    Height = 21
    TabOrder = 3
  end
  object edt_valmovime: TMaskEdit
    Left = 132
    Top = 129
    Width = 120
    Height = 21
    TabOrder = 4
  end
  object dbgMovimento: TDBGrid
    Left = 21
    Top = 171
    Width = 505
    Height = 120
    DataSource = dtsMovimento
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect]
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Title.Caption = 'C'#243'd. Movimento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Id_tanque'
        Title.Caption = 'C'#243'd. Tanque'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Id_bomba'
        Title.Caption = 'C'#243'd. Bomba'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dat_movim'
        Title.Caption = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor'
        Title.Caption = 'Valor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_incid'
        Title.Caption = 'Valor Incid.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'qtd'
        Title.Caption = 'Quantidade'
        Visible = True
      end>
  end
  object qryMovimento: TZQuery
    Connection = dmPrincipal.conexao
    SQL.Strings = (
      'select * from movimento')
    Params = <>
    Left = 351
    Top = 27
    object qryMovimentoId: TIntegerField
      FieldName = 'Id'
      ReadOnly = True
    end
    object qryMovimentoId_tanque: TIntegerField
      FieldName = 'Id_tanque'
    end
    object qryMovimentoId_bomba: TIntegerField
      FieldName = 'Id_bomba'
    end
    object qryMovimentodat_movim: TDateTimeField
      FieldName = 'dat_movim'
    end
    object qryMovimentovalor: TFloatField
      FieldName = 'valor'
      DisplayFormat = ',0.00;- ,0.00'
    end
    object qryMovimentovalor_incid: TFloatField
      FieldName = 'valor_incid'
      DisplayFormat = ',0.00;- ,0.00'
    end
    object qryMovimentoqtd: TFloatField
      FieldName = 'qtd'
      DisplayFormat = ',0.00;- ,0.00'
    end
  end
  object dtsMovimento: TDataSource
    DataSet = qryMovimento
    Left = 426
    Top = 27
  end
end
