*** Settings ***
Library    Browser

*** Keywords ***
Validar Alerta de Sucesso
    [Arguments]    ${mensagem_esperada}
    Wait For Elements State    css=.alert-content    visible    timeout=5
    ${mensagem}    Get Text    css=.alert-content
    Should Be Equal As Strings    ${mensagem}    ${mensagem_esperada}

Validar Alerta de Erro
    [Arguments]    ${mensagem_esperada}
    Wait For Elements State    css=.alert-content    visible    timeout=5
    ${mensagem}    Get Text    css=.alert-content
    Should Be Equal As Strings    ${mensagem}    ${mensagem_esperada}
