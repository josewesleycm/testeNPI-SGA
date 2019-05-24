unit dm;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection;

type
  TdmPrincipal = class(TDataModule)
    conexao: TZConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmPrincipal: TdmPrincipal;

implementation

{$R *.dfm}

end.
