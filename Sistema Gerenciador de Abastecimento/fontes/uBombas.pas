unit uBombas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Grids, DBGrids, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmBomba = class(TForm)
    Label1: TLabel;
    edt_codbomba: TEdit;
    Panel1: TPanel;
    Label2: TLabel;
    edt_codtanque: TEdit;
    dbgBomba: TDBGrid;
    dbNavega: TDBNavigator;
    btn_inc: TButton;
    btn_alt: TButton;
    btn_exc: TButton;
    btn_sal: TButton;
    btn_can: TButton;
    btn_sair: TButton;
    qryBomba: TZQuery;
    dtsBomba: TDataSource;
    qryBombaId: TIntegerField;
    qryBombaId_tanque: TIntegerField;
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
  frmBomba: TfrmBomba;
  TipoSalvar: String;

implementation

uses dm;

{$R *.dfm}

procedure TfrmBomba.FormCreate(Sender: TObject);
begin
  qryBomba.Connection := dmPrincipal.conexao;
  dtsBomba.DataSet    := qryBomba;
  dbgBomba.DataSource := dtsBomba;
  dbNavega.DataSource := dtsBomba;
end;

procedure TfrmBomba.ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can: TButton; dbNavega: TDBNavigator; Flag: Boolean);
begin
  btn_inc.Enabled  := Flag;
  btn_alt.Enabled  := Flag;
  btn_exc.Enabled  := Flag;
  btn_sal.Enabled  := not(Flag);
  btn_can.Enabled  := not(Flag);
  dbNavega.Enabled := Flag;
end;

procedure TfrmBomba.btn_sairClick(Sender: TObject);
begin
  Close;
end;

// incluir
procedure TfrmBomba.btn_incClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,false);

  edt_codbomba.Text  := '';
  edt_codtanque.Text := '';

  TipoSalvar := 'I';

  dbgBomba.Refresh;
end;

// alterar
procedure TfrmBomba.btn_altClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,false);

  TipoSalvar := 'A';
end;

// excluir
procedure TfrmBomba.btn_excClick(Sender: TObject);
begin
  if Excluir then
    ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

// salvar
procedure TfrmBomba.btn_salClick(Sender: TObject);
begin
  if Salvar then
    begin
      ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);

      dbgBomba.Refresh;

      if TipoSalvar = 'I' then
        edt_codtanque.Text := qryBomba.fieldbyname('Id').AsString;
    end;
end;

// cancelar
procedure TfrmBomba.btn_canClick(Sender: TObject);
begin
  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

procedure TfrmBomba.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryBomba.Close;
end;

procedure TfrmBomba.FormShow(Sender: TObject);
begin
  if qryBomba.SQL.Text <> EmptyStr then
  begin
    qryBomba.Open;

    edt_codbomba.Text  := qryBomba.fieldbyname('Id').AsString;
    edt_codtanque.Text := qryBomba.fieldbyname('Id_tanque').AsString;
  end;

  ControlarBotoes(btn_inc,btn_alt,btn_exc,btn_sal,btn_can,dbNavega,true);
end;

function TfrmBomba.Excluir: Boolean;
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
    Qry.ParamByName('Id').AsInteger := qryBomba.fieldbyname('Id').AsInteger;

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

function TfrmBomba.Salvar: Boolean;
var Qry:TZQuery;
    id:Integer;
begin
  try
    Result := true;

    Qry:=TZQuery.Create(nil);
    Qry.Connection:= dmPrincipal.conexao;
    Qry.SQL.Clear;

    if TipoSalvar = 'I' then
      Qry.SQL.Add('INSERT INTO bomba (id_tanque) values (:id_tanque)')
    else
      begin
        id := qryBomba.fieldbyname('Id').AsInteger;
        Qry.SQL.Add('update bomba set id_tanque = :id_tanque where id = :id')
      end;

    Qry.ParamByName('id_tanque').AsInteger := strtoint(edt_codtanque.Text);

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

procedure TfrmBomba.dbNavegaClick(Sender: TObject; Button: TNavigateBtn);
begin
  if qryBomba.SQL.Text <> EmptyStr then
  begin
    qryBomba.Open;

    edt_codbomba.Text  := qryBomba.fieldbyname('Id').AsString;
    edt_codtanque.Text := qryBomba.fieldbyname('Id_tanque').AsString;
  end;
end;


end.
