object frmBomba: TfrmBomba
  Left = 457
  Top = 301
  Width = 557
  Height = 343
  Caption = 'Bombas'
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
    Left = 51
    Top = 36
    Width = 61
    Height = 13
    Caption = 'C'#243'd. Bomba:'
  end
  object Label2: TLabel
    Left = 52
    Top = 63
    Width = 65
    Height = 13
    Caption = 'C'#243'd. Tanque:'
  end
  object Panel1: TPanel
    Left = 9
    Top = 240
    Width = 520
    Height = 49
    TabOrder = 1
    object dbNavega: TDBNavigator
      Left = 10
      Top = 12
      Width = 156
      Height = 25
      DataSource = dtsBomba
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 0
      OnClick = dbNavegaClick
    end
    object btn_inc: TButton
      Left = 172
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Inc'
      TabOrder = 1
      OnClick = btn_incClick
    end
    object btn_alt: TButton
      Left = 217
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Alt'
      TabOrder = 2
      OnClick = btn_altClick
    end
    object btn_exc: TButton
      Left = 259
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Exc'
      TabOrder = 3
      OnClick = btn_excClick
    end
    object btn_sal: TButton
      Left = 304
      Top = 12
      Width = 40
      Height = 25
      Caption = 'Sal'
      TabOrder = 4
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
  object edt_codbomba: TEdit
    Left = 144
    Top = 33
    Width = 34
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object edt_codtanque: TEdit
    Left = 145
    Top = 60
    Width = 34
    Height = 21
    TabOrder = 2
  end
  object dbgBomba: TDBGrid
    Left = 51
    Top = 102
    Width = 166
    Height = 120
    DataSource = dtsBomba
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Title.Caption = 'C'#243'd. Bomba'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Id_tanque'
        Title.Caption = 'C'#243'd. Tanque'
        Visible = True
      end>
  end
  object qryBomba: TZQuery
    Connection = dmPrincipal.conexao
    Active = True
    SQL.Strings = (
      'select * from bomba')
    Params = <>
    Left = 351
    Top = 27
    object qryBombaId: TIntegerField
      FieldName = 'Id'
      ReadOnly = True
    end
    object qryBombaId_tanque: TIntegerField
      FieldName = 'Id_tanque'
    end
  end
  object dtsBomba: TDataSource
    DataSet = qryBomba
    Left = 426
    Top = 27
  end
end
