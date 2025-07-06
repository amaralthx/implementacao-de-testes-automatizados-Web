*** Settings ***
Documentation     Ações relacionadas à edição de perfil do usuário
Library           Browser

*** Keywords ***
Acessar Página de Perfil
    [Documentation]    Navega até a página de perfil do usuário.
    Wait For Elements State    css=a[href="/profile"]    visible    timeout=5
    Click    css=a[href="/profile"]
    Wait For Elements State    id=name    visible    timeout=5
    Take Screenshot    filename=perfil_01_tela_perfil_aberta.png

Editar Nome do Usuário
    [Arguments]    ${novo_nome}
    [Documentation]    Altera o campo "Nome Completo" para um novo valor.
    Fill Text    id=name    ${novo_nome}
    Take Screenshot    filename=perfil_02_nome_alterado.png

Validar Mensagem de Campo Alterado
    [Documentation]    Valida a mensagem informando que o campo foi alterado, aguardando confirmação.
    Wait For Elements State    css=.changed-field    visible    timeout=5
    ${mensagem}    Get Text    css=.changed-field
    Should Be Equal As Strings    ${mensagem}    Campo alterado. Clique em Salvar para confirmar.
    Take Screenshot    filename=perfil_03_mensagem_campo_alterado.png

Salvar Alterações no Perfil
    [Documentation]    Clica no botão "Salvar alterações" no formulário de perfil.
    Click    css=button[type="submit"]
    Take Screenshot    filename=perfil_04_botao_salvar.png

Validar Popup de Sucesso no Perfil
    [Documentation]    Valida o modal de sucesso após atualização do perfil.
    Wait For Elements State    text=Sucesso!    visible    timeout=5
    Wait For Elements State    text=Perfil atualizado com sucesso    visible    timeout=5
    Take Screenshot    filename=perfil_05_popup_sucesso.png

Fechar Modal de Sucesso
    [Documentation]    Fecha o modal de sucesso clicando no botão "OK".
    Click    text=OK
    Wait For Elements State    css=.success-modal-overlay    hidden    timeout=5
    Take Screenshot    filename=perfil_06_modal_fechado.png

Validar Nome Atualizado no Perfil
    [Arguments]    ${nome_esperado}
    [Documentation]    Acessa a página de perfil e valida se o nome está persistido corretamente.
    Acessar Página de Perfil
    ${nome_atual}    Get Property    id=name    value
    Should Be Equal As Strings    ${nome_atual}    ${nome_esperado}
    Take Screenshot    filename=perfil_07_nome_validado.png

