# Controle de Acesso a Menus com Lazarus

Aplicação de exemplo desenvolvida em Lazarus/Free Pascal para demonstrar o controle de acesso a itens de menu com base no nível do usuário autenticado.

O projeto utiliza MariaDB como banco de dados e ZeosLib para conexão. Ao iniciar, a aplicação autentica o usuário, consulta seu nível de acesso e habilita ou desabilita os itens do menu conforme as permissões cadastradas na tabela de controle.

<img src="./imagem.PNG" alt="Tela do projeto" width="50%">

## Funcionalidades

- Login de usuários com validação em banco de dados.
- Controle de permissões por nível de acesso.
- Habilitação e bloqueio automático dos itens do menu principal.
- Cadastro/sincronização dos itens de menu na tabela `crt_menu`.
- Tela para manutenção dos níveis exigidos por item de menu.
- Criação automática de usuário padrão quando a tabela de usuários estiver vazia.
- Configuração de usuário e senha do banco via arquivo `configura.ini`.

## Tecnologias Utilizadas

- Lazarus IDE
- Free Pascal
- MariaDB/MySQL
- ZeosLib
- RX Library

## Estrutura do Projeto

```text
.
├── ControleNivelMenu.lpi          # Projeto Lazarus principal
├── ControleNivelMenu.lpr          # Arquivo de inicialização da aplicação
├── uprincipal.pas/.lfm            # Tela principal e lógica de controle dos menus
├── ulogin.pas/.lfm                # Tela de login
├── univelmenu.pas/.lfm            # Tela de manutenção das permissões
├── script/
│   └── exemplo_controle_acesso_menu.sql
├── MariaDbDLL/
│   ├── x32/libmariadb.dll
│   └── x64/libmariadb.dll
├── configura.ini                  # Configuração local de conexão
└── imagem.PNG                     # Imagem demonstrativa do projeto
```

## Banco de Dados

O script de exemplo está disponível em:

```text
script/exemplo_controle_acesso_menu.sql
```

Ele cria a base de exemplo `exemplo_controle_acesso_menu` com as tabelas:

- `ctrl_usuario`: armazena usuários, senhas e níveis de acesso.
- `crt_menu`: armazena os itens do menu e o nível mínimo exigido para cada item.

Usuários de exemplo incluídos no script:

| Usuário | Senha | Nível |
| --- | --- | --- |
| admin | admin | 9 |
| gerente | 1234 | 2 |
| caixa | 1234 | 1 |

## Configuração

1. Instale o Lazarus e o Free Pascal.
2. Instale os pacotes necessários no Lazarus:
   - ZeosLib (`zcomponent`)
   - RX Library (`rxnew`)
3. Crie ou importe o banco MariaDB usando o script:

```sql
SOURCE script/exemplo_controle_acesso_menu.sql;
```

4. Verifique a conexão configurada no componente `TZConnection`:
   - Banco: `exemplo_controle_acesso_menu`
   - Porta: `3306`
   - Protocolo: `mariadb`

5. O Arquivo de configuração  `configura.ini` é geredo no primeiro acesso:

```ini
[Banco]
Usuario=seu_usuario
Senha=sua_senha
```

Caso o arquivo não exista, a aplicação solicita essas informações na primeira execução.

## Como Executar

1. Abra o arquivo `ControleNivelMenu.lpi` no Lazarus.
2. Compile o projeto.
3. Execute a aplicação.
4. Faça login com um dos usuários cadastrados.
5. Acesse `Usuarios > Permissões` para ajustar o nível mínimo exigido por item de menu.

## Como Funciona

Durante a abertura da tela principal, a aplicação percorre os itens do `MainMenu` e registra cada item na tabela `crt_menu`. Se o item já existir, sua descrição e ordem são atualizadas.

Após o login, o nível do usuário é comparado com o nível exigido para cada item de menu:

- se o nível do usuário for maior ou igual ao nível exigido, o item fica habilitado;
- se o nível do usuário for menor que o nível exigido, o item fica desabilitado.

Essa regra permite centralizar as permissões no banco de dados, sem alterar o código-fonte a cada mudança de acesso.

## Observações

- As DLLs do MariaDB estão separadas por arquitetura em `MariaDbDLL/x32` e `MariaDbDLL/x64`.
- O arquivo `Funcoes.txt` contém funções e estruturas utilizadas como referência no projeto original.
- As credenciais presentes no projeto são apenas para ambiente de exemplo. Em aplicações reais, evite versionar senhas e utilize uma estratégia segura para configuração de ambiente.

## Referências

- Autor do exemplo original: Daniel de Morais
- Canal: [Infocotidiano](https://www.youtube.com/user/infocotidiano/)
- Vídeos relacionados:
  - <https://youtu.be/qeXXtp9yjlY>
  - <https://youtu.be/VHY6GFd-MSY>

## ⚠️ Aviso Legal - Uso Educacional

**Este projeto é desenvolvido EXCLUSIVAMENTE para fins educacionais e de estudo.**

- O código é fornecido "como está", sem garantias de qualquer natureza.
- **NÃO NOS RESPONSABILIZAMOS** por:
  - Danos diretos ou indiretos decorrentes do uso do software.
  - Perda de dados, interrupção de negócios ou quaisquer prejuízos materiais.
  - Penalidades administrativas, cíveis ou criminais.
  - Mau uso, uso indevido ou aplicação em sistemas reais/produtivos.
- O usuário assume **TODA A RESPONSABILIDADE** pela adequação, segurança e conformidade legal (incluindo LGPD) ao utilizar este código.

**⚠️ IMPORTANTE:** Para uso em produção, APLICAR REGRAS LGPD, COMO UM EXEMPLO A CRIPTOGRAFIA DOS DADOS;