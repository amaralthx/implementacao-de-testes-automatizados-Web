*** Settings ***
Documentation    Base para todos os testes
Library          Browser
Resource         ./AuthPage.resource
Resource         ../components/Mongo.resource

*** Variables ***
${HEADLESS}      False

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=${HEADLESS}
    New Page       http://localhost:3002/