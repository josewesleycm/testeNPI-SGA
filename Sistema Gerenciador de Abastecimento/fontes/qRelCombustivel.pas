unit qRelCombustivel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TqrpRelCombustivel = class(TForm)
    QuickRep1: TQuickRep;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    PageFooterBand1: TQRBand;
    PageHeaderBand1: TQRBand;
    QRLabel2: TQRLabel;
    QRSysData1: TQRSysData;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel1: TQRLabel;
    qryRelCombustivel: TZQuery;
    qryRelCombustivelid_tanque: TIntegerField;
    qryRelCombustiveltipo_comb: TStringField;
    qryRelCombustivelid_bomba: TIntegerField;
    qryRelCombustiveldat_movim: TDateTimeField;
    qryRelCombustivelvalor: TFloatField;
    qryRelCombustivelvalor_incid: TFloatField;
    qryRelCombustivelqtd: TFloatField;
    QRGroup1: TQRGroup;
    QRBand1: TQRBand;
    QRLabel12: TQRLabel;
    QRExpr1: TQRExpr;
    QRExpr2: TQRExpr;
    SummaryBand1: TQRBand;
    QRLabel13: TQRLabel;
    QRExpr5: TQRExpr;
    QRExpr6: TQRExpr;
    QRBand2: TQRBand;
    QRLabel11: TQRLabel;
    QRSysData2: TQRSysData;
    QRShape1: TQRShape;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  qrpRelCombustivel: TqrpRelCombustivel;

implementation

uses uRelCombustivel, dm;

{$R *.dfm}

procedure TqrpRelCombustivel.FormCreate(Sender: TObject);
begin
  qryRelCombustivel.Connection := dmPrincipal.conexao;
  qryRelCombustivel.Close;
  qryRelCombustivel.SQL.Clear;
  qryRelCombustivel.SQL.Add('select a.id_tanque,b.tipo_comb,a.id_bomba,a.dat_movim,a.valor,a.valor_incid,a.qtd ');
  qryRelCombustivel.SQL.Add('from movimento a, tanque b ');
  qryRelCombustivel.SQL.Add('where a.id_tanque=b.id ');

  if frmRelCombustivel.rgTipCombo.itemindex < 2 then
    begin
      qryRelCombustivel.SQL.Add('and b.tipo_comb = :tipo_comb ');

      if frmRelCombustivel.rgTipCombo.itemindex = 0 then
        qryRelCombustivel.ParamByName('tipo_comb').AsString := 'G'
      else
        qryRelCombustivel.ParamByName('tipo_comb').AsString := 'D'
    end;

  qryRelCombustivel.SQL.Add('order by b.tipo_comb ');

  Try
    qryRelCombustivel.Open;

    QuickRep1.Preview;
  Finally
    //qrpRelCombustivel.Release;
    //qrpRelCombustivel := nil; 
  End;

end;

end.
