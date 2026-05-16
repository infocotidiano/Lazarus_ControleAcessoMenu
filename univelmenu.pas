{ ****************************************************************************** }
{ ***                   SISTEMA DE CONTROLE DE ACESSO A MENUS                 *** }
{ ****************************************************************************** }
{ *** Projeto    : Controle de Acesso a Menus com Lazarus                     *** }
{ *** Descrição  : Aplicação para demonstrar o controle de itens de menu      *** }
{ ***              com base no nível de acesso do usuário autenticado.        *** }
{ ***              Utiliza MariaDB, ZeosLib e RX Library.                     *** }
{ ***                                                                         *** }
{ *** Autor      : Daniel de Morais                                           *** }
{ *** Canal      : Infocotidiano                                              *** }
{ ***                                                                         *** }
{ *** Data Criação    : Junho de 2020                                         *** }
{ *** Versão Inicial  : 1.0                                                   *** }
{ *** Fontes/Referências:                                                     *** }
{ ***   - Vídeo 1 : https://youtu.be/qeXXtp9yjlY                              *** }
{ ***   - Vídeo 2 : https://youtu.be/VHY6GFd-MSY                              *** }
{ ***   - Canal   : https://www.youtube.com/user/infocotidiano/               *** }
{ ***                                                                         *** }
{ *** FINALIDADE: Exclusivamente educativa e de estudos                       *** }
{ *** ISENÇÃO: Não nos responsabilizamos por mau uso ou penalidades           *** }
{ *** RESPONSABILIDADE: É integralmente do usuário                            *** }
{ *** EM PRODUÇÃO: APLICAR REGRAS LGPD,COMO EXEMPLO CRIPTOGRAFIA DOS DADOS.   *** }
{ ***                                                                         *** }
{ ******************************************************************************* }
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

