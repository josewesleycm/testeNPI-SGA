program SGA;

uses
  Forms,
  uprincipal in 'uprincipal.pas' {frmPrincipal},
  dm in 'dm.pas' {dmPrincipal: TDataModule},
  uTanques in 'uTanques.pas' {frmTanques},
  uBombas in 'uBombas.pas' {frmBomba},
  uMovimentacao in 'uMovimentacao.pas' {frmMovimentacao},
  uRelMovimentacao in 'uRelMovimentacao.pas' {frmRelatorio},
  uRelCombustivel in 'uRelCombustivel.pas' {frmRelCombustivel},
  qRelCombustivel in 'qRelCombustivel.pas' {qrpRelCombustivel};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
