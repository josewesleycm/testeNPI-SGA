unit uRelCombustivel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmRelCombustivel = class(TForm)
    Button1: TButton;
    Button2: TButton;
    rgTipCombo: TRadioGroup;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelCombustivel: TfrmRelCombustivel;

implementation

uses dm, qRelCombustivel;

{$R *.dfm}

procedure TfrmRelCombustivel.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRelCombustivel.Button1Click(Sender: TObject);
begin
  qrpRelCombustivel := TqrpRelCombustivel.Create(Self);
  qrpRelCombustivel.Release;
  qrpRelCombustivel := nil;

end;

end.
