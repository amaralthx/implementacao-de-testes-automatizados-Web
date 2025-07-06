*** Settings ***
Documentation    Ações de autenticação do usuário (cadastro, login e logout).
Library          Browser

*** Keywords ***

# Navegação
Acessar Página Inicial
    [Documentation]    Abre a página principal do Cinema App
    New Page    http://localhost:3002/

Ir Para Cadastro
    [Documentation]    Acessa a tela de cadastro a partir da página inicial
    Wait For Elements State    text=Cadastrar    visible    timeout=5
    Click    text=Cadastrar

Ir Para Login
    [Documentation]    Acessa diretamente a tela de login via URL
    Go To    http://localhost:3002/login
    Wait For Elements State    id=email    visible    timeout=5

# Cadastro
Preencher Formulário Cadastro
    [Documentation]    Preenche os campos do formulário de cadastro com dados válidos ou inválidos
    [Arguments]    ${user}
    Fill Text      id=name               ${user}[name]
    Fill Text      id=email              ${user}[email]
    Fill Text      id=password           ${user}[password]
    Fill Text      id=confirmPassword    ${user}[confirmPassword]
    Take Screenshot    filename=auth_01_form_cadastro.png

Submeter Cadastro
    [Documentation]    Clica no botão para submeter o cadastro
    Click    css=button[type=submit]
    Take Screenshot    filename=auth_02_submit_cadastro.png

# Login
Preencher Credenciais Login
    [Documentation]    Preenche as credenciais no formulário de login
    [Arguments]    ${email}    ${password}
    Wait For Elements State    id=email    visible    timeout=5
    Fill Text      id=email        ${email}
    Fill Text      id=password     ${password}
    Take Screenshot    filename=auth_03_credenciais_login.png

Submeter Login
    [Documentation]    Submete o login esperando sucesso (casos positivos)
    Click    css=.btn-primary.login-btn
    Wait For Elements State    css=.alert-content >> text=Login realizado com sucesso!    visible    timeout=5
    Take Screenshot    filename=auth_04_login_sucesso.png

Submeter Login Esperando Erro
    [Documentation]    Submete o login esperando falha (casos negativos como senha inválida)
    Click    css=.btn-primary.login-btn
    Wait For Elements State    css=.alert-content    visible    timeout=5
    Take Screenshot    filename=auth_04_login_erro.png

# Logout
Realizar Logout Inicial
    [Documentation]    Verifica se o botão de logout está visível e, se sim, realiza logout
    ${logout_visible}=    Run Keyword And Return Status    
    ...    Wait For Elements State    css=.btn-logout    visible    timeout=2
    Run Keyword If    ${logout_visible}    Click    css=.btn-logout
    Take Screenshot    filename=auth_05_logout_inicial.png

Fazer Logout Final
    [Documentation]    Realiza logout ao final do teste garantindo retorno à tela inicial
    Wait For Elements State    css=.btn-logout    visible    timeout=5
    Click    css=.btn-logout
    Wait For Elements State    text=Entrar    visible    timeout=5
    Take Screenshot    filename=auth_06_logout_final.png
