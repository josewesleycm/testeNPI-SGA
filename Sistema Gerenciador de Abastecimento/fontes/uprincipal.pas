unit uprincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TfrmPrincipal = class(TForm)
    mnPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    Movimentos1: TMenuItem;
    Relatrios1: TMenuItem;
    Tanques: TMenuItem;
    Bombas1: TMenuItem;
    N1: TMenuItem;
    Sair2: TMenuItem;
    PorCombustvel1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure TanquesClick(Sender: TObject);
    procedure Bombas1Click(Sender: TObject);
    procedure Movimentos1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PorCombustvel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses dm, uTanques, uBombas, uMovimentacao, uRelMovimentacao,
  uRelCombustivel;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  dmPrincipal := TdmPrincipal.Create(self);     //Instancia o DataModule
  with dmPrincipal.conexao do
    begin
      SQLHourGlass := True;    //Habilita o Cursor em cada transação no banco de dados
      LibraryLocation := ExtractFilePath(Application.ExeName)+'ntwdblib.dll';  //Seta a DLL para conexao do SQL
      Protocol := 'mssql';  //Protocolo do banco de dados sql server
      HostName := '.\SQLEXPRESS'; //Instancia do SQLServer
      User := '';  //Usuario do Banco de Dados
      Password:='';  //Senha do Usuário do banco
      Database:='db_sga';  //Nome do Banco de Dados
      Connected:=True;  //Faz a Conexão do Banco
    end;

end;

procedure TfrmPrincipal.Sair2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmPrincipal.TanquesClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmTanques,frmTanques);
    frmTanques.ShowModal;
  finally
    FreeAndNil(frmTanques);
  end;
end;

procedure TfrmPrincipal.Bombas1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmBomba,frmBomba);
    frmBomba.ShowModal;
  finally
    FreeAndNil(frmBomba);
  end;
end;

procedure TfrmPrincipal.Movimentos1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmMovimentacao,frmMovimentacao);
    frmMovimentacao.ShowModal;
  finally
    FreeAndNil(frmMovimentacao);
  end;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(dmPrincipal);
end;

procedure TfrmPrincipal.PorCombustvel1Click(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmRelCombustivel,frmRelCombustivel);
    frmRelCombustivel.ShowModal;
  finally
    FreeAndNil(frmRelCombustivel);
  end;
end;

end.
