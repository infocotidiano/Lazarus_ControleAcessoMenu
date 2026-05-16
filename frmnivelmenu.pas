unit frmNivelMenu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, ZDataset;

type

  { TForm1 }

  TForm1 = class(TForm)
    dsMENU: TDataSource;
    DBGrid1: TDBGrid;
    qrMENU: TZQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  qrMENU.sql.Clear;
  qrMENU.sql.Text:='select * from crt_menu '+
                   'order by indice';
  qrMENU.Open;

end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  qrMENU.Close;
end;

end.

