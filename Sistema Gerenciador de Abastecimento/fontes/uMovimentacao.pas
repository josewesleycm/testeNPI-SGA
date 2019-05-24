unit uMovimentacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Mask, StdCtrls, DBCtrls, ExtCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmMovimentacao = class(TForm)
    Label1: TLabel;
    edt_codbomba: TEdit;
    Panel1: TPanel;
    dbNavega: TDBNavigator;
    btn_inc: TButton;
    btn_alt: TButton;
    btn_exc: TButton;
    btn_sal: TButton;
    btn_can: TButton;
    btn_sair: TButton;
    Label3: TLabel;
    edt_codmovime: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edt_datmovime: TMaskEdit;
    edt_qtdmovime: TMaskEdit;
    edt_valmovime: TMaskEdit;
    dbgMovimento: TDBGrid;
    qryMovimento: TZQuery;
    dtsMovimento: TDataSource;
    qryMovimentoId: TIntegerField;
    qryMovimentoId_tanque: TIntegerField;
    qryMovimentoId_bomba: TIntegerField;
    qryMovimentovalor: TFloatField;
    qryMovimentovalor_incid: TFloatField;
    qryMovimentodat_movim: TDateTimeField;
    procedure FormCreate(Sender: TObject);
    procedure btn_sairClick(Sender: TObject);
    procedure btn_incClick(Sender: TObject);
    procedure btn_altClick(Sender: TObject);
    procedure btn_excClick(Sender: TObject);
    procedure btn_salClick(Sender: TObject);
    procedure btn_canClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbNavegaClick(Sender: TObject; Button: TNavigateBtn);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can: TButton; dbNavega: TDBNavigator; Flag: Boolean);
    function Selecionar(id: Integer): Integer;
    function Excluir: Boolean;
    function Salvar: Boolean;
  public
    { Public declarations }
  end;

var
  frmMovimentacao: TfrmMovimentacao;
  TipoSalvar: String;

implementation

uses dm;

{$R *.dfm}

procedure TfrmMovimentacao.FormCreate(Sender: TObject);
begin
  qryMovimento.Connection := dmPrincipal.conexao;
  dtsMovimento.DataSet    := qryMovimento;
  dbgMovimento.DataSource := dtsMovimento;
  dbNavega.DataSource     := dtsMovimento;
end;

procedure TfrmMovimentacao.ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can: TButton; dbNavega: TDBNavigator; Flag: Boolean);
begin
  btn_inc.Enabled  := Flag;
  btn_alt.Enabled  := Flag;
  btn_exc.Enabled  := Flag;
  btn_sal.Enabled  := not(Flag);
  btn_can.Enabled  := not(Flag);
  dbNavega.Enabled := Flag;
end;

procedure TfrmMovimentacao.btn_sairClick(Sender: TObject);
begin
  Close;
end;

// incluir
procedure TfrmMovimentacao.btn_incClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,false);

  edt_codmovime.Text := '';
  edt_codbomba.Text  := '';
  edt_datmovime.Text := '';
  edt_qtdmovime.Text := '';
  edt_valmovime.Text := '';

  TipoSalvar := 'I';

  dbgMovimento.Refresh;
end;

// alterar
procedure TfrmMovimentacao.btn_altClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,false);

  TipoSalvar := 'A';
end;

// excluir
procedure TfrmMovimentacao.btn_excClick(Sender: TObject);
begin
  if Excluir then
    ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

// salvar
procedure TfrmMovimentacao.btn_salClick(Sender: TObject);
begin
  if Salvar then
    begin
      ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);

      dbgMovimento.Refresh;

      if TipoSalvar = 'I' then
        edt_codmovime.Text := qryMovimento.fieldbyname('Id').AsString;
    end;
end;

// cancelar
procedure TfrmMovimentacao.btn_canClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

procedure TfrmMovimentacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryMovimento.Close;
end;

procedure TfrmMovimentacao.FormShow(Sender: TObject);
begin
  if qryMovimento.SQL.Text <> EmptyStr then
  begin
    qryMovimento.Open;

    edt_codmovime.Text := qryMovimento.fieldbyname('Id').AsString;
    edt_codbomba.Text  := qryMovimento.fieldbyname('Id_bomba').AsString;
    edt_datmovime.text := qryMovimento.fieldbyname('dat_movim').AsString;
    edt_valmovime.text := qryMovimento.fieldbyname('valor').AsString;
    edt_qtdmovime.text := qryMovimento.fieldbyname('qtd').AsString;
  end;

  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

function TfrmMovimentacao.Excluir: Boolean;
var Qry:TZQuery;
begin
  if MessageDlg('Deseja excluir? ',mtConfirmation,[mbYes, mbNo],0)=mrNo then
    begin
      Result := false;
      abort;
    end;

  try
    Result := true;
    Qry := TZQuery.Create(nil);
    Qry.Connection := dmPrincipal.Conexao;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM bomba WHERE Id = :Id');
    Qry.ParamByName('Id').AsInteger := qryMovimento.fieldbyname('Id').AsInteger;

    Try
      dmPrincipal.Conexao.StartTransaction;
      Qry.ExecSQL;
      dmPrincipal.Conexao.Commit;
    Except
      dmPrincipal.Conexao.Rollback;
      Result := false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

function TfrmMovimentacao.Salvar: Boolean;
var Qry:TZQuery;
    id:Integer;
begin
  try
    Result := true;

    Qry:=TZQuery.Create(nil);
    Qry.Connection:= dmPrincipal.conexao;
    Qry.SQL.Clear;

    if TipoSalvar = 'I' then
      Qry.SQL.Add('INSERT INTO movimento (id_tanque,id_bomba,dat_movim,valor,valor_incid,qtd) values (:id_tanque,:id_bomba,:dat_movim,:valor,:valor_incid,:qtd)')
    else
      begin
        id := qryMovimento.fieldbyname('Id').AsInteger;
        Qry.SQL.Add('update movimento set id_tanque = :id_tanque, ' +
                                        ' id_bomba = :id_bomba, ' +
                                        ' dat_movim =   :dat_movim, ' +
                                        ' valor =       :valor, ' +
                                        ' valor_incid = :valor_incid, ' +
                                        ' qtd =         :qtd ' +
                    ' where id = :id')
      end;

    Qry.ParamByName('id_tanque').AsInteger := Selecionar(strtoint(edt_codbomba.Text));
    Qry.ParamByName('id_bomba').AsInteger  := strtoint(edt_codbomba.Text);
    Qry.ParamByName('dat_movim').AsDate    := strtodate(edt_datmovime.text);
    Qry.ParamByName('valor').AsFloat       := strtofloat(edt_valmovime.text);
    Qry.ParamByName('valor_incid').AsFloat := strtofloat(edt_valmovime.text) * 0.13;
    Qry.ParamByName('qtd').AsInteger       := strtoint(edt_qtdmovime.text);

    Try
      dmPrincipal.conexao.StartTransaction;
      Qry.ExecSQL;
      dmPrincipal.conexao.Commit;
    Except
      dmPrincipal.conexao.Rollback;
      Result:=false;
    End;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);
  end;
end;

procedure TfrmMovimentacao.dbNavegaClick(Sender: TObject; Button: TNavigateBtn);
begin
  if qryMovimento.SQL.Text <> EmptyStr then
    begin
      qryMovimento.Open;

      edt_codmovime.Text := qryMovimento.fieldbyname('Id').AsString;
      edt_codbomba.Text  := qryMovimento.fieldbyname('Id_bomba').AsString;
      edt_datmovime.text := qryMovimento.fieldbyname('dat_movim').AsString;
      edt_valmovime.text := qryMovimento.fieldbyname('valor').AsString;
      edt_qtdmovime.text := qryMovimento.fieldbyname('qtd').AsString;
    end;
end;

function TfrmMovimentacao.Selecionar(id: Integer): Integer;
var Qry2:TZQuery;
begin
  try
    Qry2:=TZQuery.Create(nil);
    Qry2.Connection := dmPrincipal.Conexao;
    Qry2.SQL.Clear;
    Qry2.SQL.Add('SELECT id_tanque from bomba where Id = :Id');
    Qry2.ParamByName('Id').AsInteger := id;

    Try
      Qry2.Open;

      Result := Qry2.FieldByName('Id_tanque').AsInteger;
    Except
      Result := 0;
    End;

  finally
    if Assigned(Qry2) then
       FreeAndNil(Qry2);
  end;
end;

procedure TfrmMovimentacao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      key := #0;

      SelectNext(ActiveControl,true,true);
    end;
end;

end.
