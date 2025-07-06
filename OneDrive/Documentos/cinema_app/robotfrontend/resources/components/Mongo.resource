*** Settings ***
Library    ${EXECDIR}/libs/database.py

*** Keywords ***
Remover usuário por email
    [Arguments]    ${email}
    ${result}    Delete User    ${email}
    Should Be True    ${result}    Falha ao remover usuário ${email}

Obter usuário por email
    [Arguments]    ${email}
    ${user}    Get User    ${email}
    RETURN    ${user}