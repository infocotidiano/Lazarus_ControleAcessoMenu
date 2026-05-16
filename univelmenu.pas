unit uNivelMenu;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ZDataset;

type

  { Tfrm_nivelmenu }

  Tfrm_nivelmenu = class(TForm)
    dsMENU: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    qrMENU: TZQuery;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frm_nivelmenu: Tfrm_nivelmenu;

implementation

{$R *.lfm}

{ Tfrm_nivelmenu }

procedure Tfrm_nivelmenu.FormCreate(Sender: TObject);
begin
  qrMENU.sql.Clear;
  qrMENU.sql.Text:='select * from crt_menu '+
                   'order by indice';
  qrMENU.Open;

end;

procedure Tfrm_nivelmenu.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  qrMENU.Close;
end;

end.

