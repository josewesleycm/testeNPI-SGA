unit uTanques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Grids, DBGrids, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmTanques = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edt_codtanque: TEdit;
    Panel1: TPanel;
    rg_tipcomb: TRadioGroup;
    dbNavega: TDBNavigator;
    btn_inc: TButton;
    btn_alt: TButton;
    btn_exc: TButton;
    btn_sal: TButton;
    btn_can: TButton;
    btn_sair: TButton;
    dbgTanque: TDBGrid;
    qryTanque: TZQuery;
    dtsTanque: TDataSource;
    qryTanqueId: TIntegerField;
    qryTanquetipo_comb: TStringField;
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
  private
    { Private declarations }
    procedure ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can: TButton; dbNavega: TDBNavigator; Flag: Boolean);
    function Excluir: Boolean;
    function Salvar: Boolean;
  public
    { Public declarations }
  end;

var
  frmTanques: TfrmTanques;
  TipoSalvar: String;

implementation

uses dm;

{$R *.dfm}

procedure TfrmTanques.FormCreate(Sender: TObject);
begin
  qryTanque.Connection := dmPrincipal.conexao;
  dtsTanque.DataSet := qryTanque;
  dbgTanque.DataSource := dtsTanque;
  dbNavega.DataSource := dtsTanque;
end;

procedure TfrmTanques.ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can: TButton; dbNavega: TDBNavigator; Flag: Boolean);
begin
  btn_inc.Enabled  := Flag;
  btn_alt.Enabled  := Flag;
  btn_exc.Enabled  := Flag;
  btn_sal.Enabled  := not(Flag);
  btn_can.Enabled  := not(Flag);
  dbNavega.Enabled := Flag;
end;

procedure TfrmTanques.btn_sairClick(Sender: TObject);
begin
  Close;
end;

// incluir
procedure TfrmTanques.btn_incClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,false);

  edt_codtanque.Text := '';
  rg_tipcomb.itemindex := -1;

  TipoSalvar := 'I';

  dbgTanque.Refresh;
end;

// alterar
procedure TfrmTanques.btn_altClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,false);

  TipoSalvar := 'A';
end;

// excluir
procedure TfrmTanques.btn_excClick(Sender: TObject);
begin
  if Excluir then
    ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

// salvar
procedure TfrmTanques.btn_salClick(Sender: TObject);
begin
  if Salvar then
    begin
      ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);

      dbgTanque.Refresh;

      if TipoSalvar = 'I' then
        edt_codtanque.Text := qryTanque.fieldbyname('Id').AsString;
    end;      
end;

// cancelar
procedure TfrmTanques.btn_canClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

procedure TfrmTanques.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryTanque.Close;
end;

procedure TfrmTanques.FormShow(Sender: TObject);
begin
  if qryTanque.SQL.Text <> EmptyStr then
  begin
    qryTanque.Open;

    edt_codtanque.Text := qryTanque.fieldbyname('Id').AsString;

    if qryTanque.fieldbyname('tipo_comb').AsString = 'G' then
      rg_tipcomb.itemindex := 0
    else
      rg_tipcomb.itemindex := 1;
  end;

  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

function TfrmTanques.Excluir: Boolean;
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
    Qry.SQL.Add('DELETE FROM tanque WHERE Id = :Id');
    Qry.ParamByName('Id').AsInteger := qryTanque.fieldbyname('Id').AsInteger;

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

function TfrmTanques.Salvar: Boolean;
var Qry:TZQuery;
    id:Integer;
begin
  try
    Result := true;

    Qry:=TZQuery.Create(nil);
    Qry.Connection:= dmPrincipal.conexao;
    Qry.SQL.Clear;

    if TipoSalvar = 'I' then
      Qry.SQL.Add('INSERT INTO tanque (tipo_comb) values (:tipo_comb)')
    else
      begin
        id := qryTanque.fieldbyname('Id').AsInteger;
        Qry.SQL.Add('update tanque set tipo_comb = :tipo_comb where id = :id')
      end;

    if rg_tipcomb.itemindex = 0 then
      Qry.ParamByName('tipo_comb').AsString := 'G'
    else
      Qry.ParamByName('tipo_comb').AsString := 'D';

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

procedure TfrmTanques.dbNavegaClick(Sender: TObject; Button: TNavigateBtn);
begin
  if qryTanque.SQL.Text <> EmptyStr then
  begin
    qryTanque.Open;

    edt_codtanque.Text := qryTanque.fieldbyname('Id').AsString;

    if qryTanque.fieldbyname('tipo_comb').AsString = 'G' then
      rg_tipcomb.itemindex := 0
    else
      rg_tipcomb.itemindex := 1;
  end;
end;

end.

