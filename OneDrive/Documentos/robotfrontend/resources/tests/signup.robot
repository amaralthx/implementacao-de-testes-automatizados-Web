*** Settings ***
Documentation    Testes E2E de cadastro e login de usuário
Resource         ../pages/base.resource
Resource         ../pages/AuthPage.resource
Resource         ../components/Mongo.resource
Resource         ../pages/ProfilePage.resource
Resource         ../components/common.resource

*** Variables ***
${EMAIL}    thais@yahoo.com
${SENHA}    pwd123

*** Keywords ***
Remover Usuário Existente
    [Arguments]    ${email}
    ${user_existe}    Obter usuário por email    ${email}
    Run Keyword If    $user_existe is not $None    Remover usuário por email    ${email}

*** Test Cases ***

Cadastro e Login com Sucesso
    [Tags]    smoke    critical    e2e    CT-001
    Start Session
    Remover Usuário Existente    ${EMAIL}

    ${usuario}    Create Dictionary
    ...    name=Thaís Amaral
    ...    email=${EMAIL}
    ...    password=${SENHA}
    ...    confirmPassword=${SENHA}

    Ir Para Cadastro
    Preencher Formulário Cadastro    ${usuario}
    Submeter Cadastro
    Wait For Elements State    css=.alert-content    visible    timeout=5
    ${msg}    Get Text    css=.alert-content
    Should Be Equal As Strings    ${msg}    Conta criada com sucesso!
    Take Screenshot    filename=CT-001_01_cadastro_sucesso.png

    ${db_user}    Obter usuário por email    ${usuario}[email]
    Should Not Be Equal    ${db_user}    ${None}

    Realizar Logout Inicial
    Sleep    2s

    Preencher Credenciais Login    ${EMAIL}    ${SENHA}
    Submeter Login
    Wait For Elements State    css=.alert-content    visible    timeout=5
    ${msg_login}    Get Text    css=.alert-content
    Should Be Equal As Strings    ${msg_login}    Login realizado com sucesso!
    Take Screenshot    filename=CT-001_02_login_sucesso.png

    Fazer Logout Final
    Take Screenshot    filename=CT-001_03_logout_final.png
    Close Browser

Bloquear Cadastro com Email Já Existente
    [Tags]    regression    negative    CT-002
    Start Session

    ${usuario}    Create Dictionary
    ...    name=Thaís Amaral
    ...    email=${EMAIL}
    ...    password=${SENHA}
    ...    confirmPassword=${SENHA}

    Ir Para Cadastro
    Preencher Formulário Cadastro    ${usuario}
    Submeter Cadastro
    Wait For Elements State    css=.alert-content    visible    timeout=5
    ${erro}    Get Text    css=.alert-content
    Should Be Equal As Strings    ${erro}    User already exists
    Take Screenshot    filename=CT-002_erro_usuario_existente.png
    Close Browser

Atualização de Nome no Perfil
    [Tags]    regression    profile    CT-004
    Start Session

    # Login inicial
    Ir Para Login
    Preencher Credenciais Login    ${EMAIL}    ${SENHA}
    Submeter Login

    # Validação do login
    Wait For Elements State    css=.alert-content    visible    timeout=10
    ${msg_login_1}    Get Text    css=.alert-content
    Should Be Equal As Strings    ${msg_login_1}    Login realizado com sucesso!

    # Acessar perfil e atualizar nome
    Acessar Página de Perfil
    Editar Nome do Usuário    Thaís QA Amaral
    Validar Mensagem de Campo Alterado
    Salvar Alterações no Perfil
    Validar Popup de Sucesso no Perfil
    Fechar Modal de Sucesso
    Fazer Logout Final

    # Login novamente para validar se o nome persistiu
    Ir Para Login
    Preencher Credenciais Login    ${EMAIL}    ${SENHA}
    Submeter Login

    # Validação do login novamente
    Wait For Elements State    css=.alert-content    visible    timeout=10
    ${msg_login_2}    Get Text    css=.alert-content
    Should Be Equal As Strings    ${msg_login_2}    Login realizado com sucesso!

    # Validação do nome persistido no perfil
    Validar Nome Atualizado no Perfil    Thaís QA Amaral
    Sleep    3

    Fazer Logout Final
    Close Browser

Não Cadastrar com Senha Fraca
    [Tags]    negative    CT-003
    Start Session

    ${usuario}    Create Dictionary
    ...    name=Usuário Senha Fraca
    ...    email=senha@fraca.com
    ...    password=123
    ...    confirmPassword=123

    Ir Para Cadastro
    Preencher Formulário Cadastro    ${usuario}
    Submeter Cadastro
    Validar Alerta de Erro    Validation failed
    Close Browser
