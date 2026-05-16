unit uprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  ulogin, ZConnection, ZDataset, ZSqlUpdate, IniFiles;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    btnMudaNivel: TButton;
    Button1: TButton;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    conexao: TZConnection;
    ZQuery1: TZQuery;
    ZUpdateSQL1: TZUpdateSQL;
    procedure btnMudaNivelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure conexaoBeforeConnect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
  private
    function ArquivoConfiguracao: string;
    procedure CriaDBmenu;
    procedure GarantirConfiguracao;
    procedure LerConfiguracaoConexao;
    procedure verificaTabelaUsuarioEstaVazia;
    procedure adicionaUsuarioPadrao;
    procedure telaLogin;
    procedure incluiDB(cNOME, cDESCRICAO: string; nNIVEL, nINDICE: integer);
    function RetornaNIVEL(cNOME: string): integer;
  public
    procedure protegemenu(nNIVEL: integer);

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uNivelMenu;


  {$R *.lfm}

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  CriaDBmenu;
  telaLogin;
end;

procedure TfrmPrincipal.MenuItem24Click(Sender: TObject);
begin

end;

procedure TfrmPrincipal.MenuItem25Click(Sender: TObject);
begin
  frm_nivelmenu := Tfrm_nivelmenu.Create(self);
  try
    frm_nivelmenu.ShowModal;
  finally
    FreeAndNil(frm_nivelmenu);
  end;

end;

procedure TfrmPrincipal.btnMudaNivelClick(Sender: TObject);
var
  cNIVEL: string;
begin
  InputQuery('Controle de Menu', 'Informe o nível do Usuario', cNIVEL);
  protegemenu(StrToIntDef(cNIVEL, 1));
end;

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  telaLogin;
end;

procedure TfrmPrincipal.conexaoBeforeConnect(Sender: TObject);
var
  LPathDLL, cArquivoDLL: string;
begin
  LPathDLL := ExtractFilePath(ParamStr(0));
  {$ifdef CPU32}
      cArquivoDLL := LPathDLL+ '\MariaDbDLL\x32\libmariadb.dll';
  {$endif}
  {$ifdef CPU64}
      cArquivoDLL :=LPathDLL+ '\MariaDbDLL\x64\libmariadb.dll';
  {$endif}

  if FileExists(cArquivoDLL) then
    Conexao.LibraryLocation := cArquivoDLL
  else
    raise Exception.Create('Erro ao lozalizar DLL ' + sLineBreak + cArquivoDLL);

  LerConfiguracaoConexao;

end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  GarantirConfiguracao;
  try
    conexao.Connect;
  except
    raise Exception.Create('Erro ao conectar com o banco de dados !');
  end;
  verificaTabelaUsuarioEstaVazia;

end;

procedure TfrmPrincipal.CriaDBmenu;
// varre os itens do menu e chama a funcao para inclusao no banco de dados/
var
  nITEM, nPRINCIPAL, nIndice: integer;
begin
  nIndice := 0;
  for nPRINCIPAL := 0 to MainMenu1.Items.Count - 1 do
  begin
    incluiDB(MainMenu1.Items[nPRINCIPAL].Name,
      MainMenu1.Items[nPRINCIPAL].Caption,
      1,
      nIndice);
    nIndice := nIndice + 1;
    for nITEM := 0 to MainMenu1.Items[nPRINCIPAL].Count - 1 do
    begin
      incluiDB(MainMenu1.Items[nPRINCIPAL].Items[nITEM].Name,
        '   --' + MainMenu1.Items[nPRINCIPAL].Items[nITEM].Caption,
        1,
        nIndice);
      nIndice := nIndice + 1;
    end;
  end;
end;

procedure TfrmPrincipal.verificaTabelaUsuarioEstaVazia;
var
  qrUsuario: TZQuery;
begin
  // Faz a inclusão/atualizacao dos itens do menu na base.
  // Se o nome existir, atualiza a descricao
  qrUsuario := TZQuery.Create(self);
  qrUsuario.Connection := conexao;
  //verifica se ja existe usuario
  qrUsuario.SQL.Clear;
  qrUsuario.sql.Text := 'select * from ctrl_usuario limit 1';
  try
    qrUsuario.Open;
    if qrUsuario.RecordCount <= 0 then
      adicionaUsuarioPadrao;
  except
    on e: Exception do
    begin
      ShowMessage('Erro ao verificar se existe usuario na tabela ' +
        sLineBreak + e.Message + sLineBreak + e.ClassName);
    end;
  end;
  if Assigned(qrUsuario) then
    FreeAndNil(qrUsuario);

end;

procedure TfrmPrincipal.adicionaUsuarioPadrao;
var
  qrTMP: TZQuery;
begin
  qrTMP := TZQuery.Create(self);
  qrTMP.Connection := conexao;
  qrTMP.SQL.Clear;
  qrTMP.sql.Add('insert into ctrl_usuario values (:cUsuario,:cSenha,:nNivel)');
  qrTMP.ParamByName('cUsuario').AsString := 'admin';
  qrTMP.ParamByName('cSenha').AsString := 'admin';
  qrTMP.ParamByName('nNIVEL').AsInteger := 9;
  try
    qrTMP.ExecSQL;
    ShowMessage('Adicionado usuario padão:' + sLineBreak +
      'Usuario: admin' + sLineBreak + 'Senha: admin' + sLineBreak + 'NIvel: 9');
  except
    on e: Exception do
    begin
      ShowMessage('Erro ao incluir usuario padrão ' + sLineBreak +
        e.Message + sLineBreak + e.ClassName);
    end;
  end;

  if Assigned(qrTMP) then
    FreeAndNil(qrTMP);

end;

procedure TfrmPrincipal.telaLogin;
begin
  frmTelalogin := TfrmTelalogin.Create(self);
  try
    if frmTelalogin.ShowModal <> mrYes then
    begin
      Application.Terminate;
    end;
  finally
    FreeAndNil(frmTelalogin);
  end;

end;

procedure TfrmPrincipal.incluiDB(cNOME, cDESCRICAO: string; nNIVEL, nINDICE: integer);
var
  qrTMP: TZQuery;
begin
  // Faz a inclusão/atualizacao dos itens do menu na base.
  // Se o nome existir, atualiza a descricao
  qrTMP := TZQuery.Create(self);
  qrTMP.Connection := conexao;
  qrTMP.sql.Add('INSERT INTO crt_menu (nome, descricao, nivel, indice)');
  qrTMP.sql.Add('VALUES(:cNOME, :cDESCRICAO, :nNIVEL, :nINDICE ) ON');
  qrTMP.sql.Add('DUPLICATE KEY UPDATE descricao = :cDESCRICAO, indice = :nINDICE');
  qrTMP.ParamByName('cNOME').AsString := cNOME;
  qrTMP.ParamByName('cDESCRICAO').AsString := cDESCRICAO;
  qrTMP.ParamByName('nNIVEL').AsInteger := nNIVEL;
  qrTMP.ParamByName('nINDICE').AsInteger := nINDICE;
  try
    qrTMP.ExecSQL;
  except
    on e: Exception do
    begin
      ShowMessage('Erro ao atualizar a tebela crt_menu ' + sLineBreak +
        e.Message + sLineBreak + e.ClassName);
    end;
  end;
  if Assigned(qrTMP) then
    FreeAndNil(qrTMP);
end;


procedure TfrmPrincipal.protegemenu(nNIVEL: integer);
// Carrega o menu inteiro, durante o carregamento
// verifica o nivel do usuario, se o nivel do usuario
// for menor ou igual ao permitido na base de menu, ele exibe ou nao
var
  nITEM, nPRINCIPAL: integer;
begin
  for nPRINCIPAL := 0 to MainMenu1.Items.Count - 1 do
  begin
    if nNIVEL >= RetornaNIVEL(MainMenu1.Items[nPRINCIPAL].Name) then
      MainMenu1.Items[nPRINCIPAL].Enabled := True
    else
      MainMenu1.Items[nPRINCIPAL].Enabled := False;
    for nITEM := 0 to MainMenu1.Items[nPRINCIPAL].Count - 1 do
    begin
      if nNIVEL >= RetornaNIVEL(MainMenu1.Items[nPRINCIPAL].Items[nITEM].Name) then
        MainMenu1.Items[nPRINCIPAL].Items[nITEM].Enabled := True
      else
        MainMenu1.Items[nPRINCIPAL].Items[nITEM].Enabled := False;
    end;
  end;

end;

function TfrmPrincipal.RetornaNIVEL(cNOME: string): integer;
  // realiza a pesquisa de nivel, se encontrar o nome
  // retorna o nivel cadastrado.
var
  qrTMP: TZQuery;
  nNIVEL: integer;
begin
  qrTMP := TZQuery.Create(self);
  qrTMP.Connection := conexao;
  qrTMP.sql.Add('select * from crt_menu where nome = :cNOME');
  qrTMP.ParamByName('cNOME').AsString := cNOME;
  qrTMP.Open;
  if qrTMP.RecordCount > 0 then
    nNIVEL := qrTMP.FieldByName('NIVEL').Value
  else
    nNIVEL := 1;
  FreeAndNil(qrTMP);
  Result := nNIVEL;
end;

function TfrmPrincipal.ArquivoConfiguracao: string;
begin
  Result := ExtractFilePath(ParamStr(0)) + 'configura.ini';
end;

procedure TfrmPrincipal.GarantirConfiguracao;
var
  Ini: TIniFile;
  Usuario, Senha: string;
begin
  if FileExists(ArquivoConfiguracao) then
    Exit;

  Usuario := InputBox('Configuracao do banco', 'Usuario:', conexao.User);
  Senha := InputBox('Configuracao do banco', 'Senha:', conexao.Password);

  Ini := TIniFile.Create(ArquivoConfiguracao);
  try
    Ini.WriteString('Banco', 'Usuario', Usuario);
    Ini.WriteString('Banco', 'Senha', Senha);
  finally
    Ini.Free;
  end;
end;

procedure TfrmPrincipal.LerConfiguracaoConexao;
var
  Ini: TIniFile;
begin
  GarantirConfiguracao;

  Ini := TIniFile.Create(ArquivoConfiguracao);
  try
    conexao.User := Ini.ReadString('Banco', 'Usuario', conexao.User);
    conexao.Password := Ini.ReadString('Banco', 'Senha', conexao.Password);
  finally
    Ini.Free;
  end;
end;



end.
