*** Settings ***
Documentation       Test suite for the signup page
Library             Browser


*** Test Cases ***
Should be able to register a new dog walker
    ${name}=                 Set Variable    Adriana Nogueira
    ${email}=                Set Variable    adrianabnoliveira@gmail.com
    ${cpf}=                  Set Variable    00000014141
    ${cep}=                  Set Variable    04534011
    ${addressStreet}=        Set Variable    Rua Joaquim Floriano
    ${addressDistrict}=      Set Variable    Itaim Bibi
    ${addressCityUf}=        Set Variable    São Paulo/SP
    ${addressNumber}=        Set Variable    1000
    ${addressDetails}=       Set Variable    Apto 28

    Open Signup Page
    Fill Signup Form    ${name}    ${email}    ${cpf}    ${cep}    ${addressStreet}    ${addressDistrict}    ${addressCityUf}    ${addressNumber}    ${addressDetails}
    Submit Signup With Photo
    Submit signup form
    Popup should be    Recebemos o seu cadastro e em breve retornaremos o contato.


*** Keywords ***
Open Signup Page
    New Browser    browser=chromium    headless=False
    New Page    https://walkdog.vercel.app/signup
    Wait For Elements State    form h1    visible    5000
    Get Text    form h1    equals    Faça seu cadastro

Fill Signup Form
    [Arguments]    ${name}    ${email}    ${cpf}    ${cep}    ${addressStreet}    ${addressDistrict}    ${addressCityUf}    ${addressNumber}    ${addressDetails}

    Fill Text    css=input[name=name]             ${name}
    Fill Text    css=input[name=email]            ${email}
    Fill Text    css=input[name=cpf]              ${cpf}
    Fill Text    css=input[name=cep]              ${cep}
    Click    css=input[type=button][value$=CEP]

    Get Property    css=input[name=addressStreet]    value    equals    ${addressStreet}
    Get Property    css=input[name=addressDistrict]  value    equals    ${addressDistrict}
    Get Property    css=input[name=addressCityUf]    value    equals    ${addressCityUf}

    Fill Text    css=input[name=addressNumber]    ${addressNumber}
    Fill Text    css=input[name=addressDetails]   ${addressDetails}

Submit Signup With Photo
    Upload File By Selector    css=input[type=file]    ${EXECDIR}/toretto.jpg
 
Submit signup form
    Click    css=.button-register

Popup should be
    [Arguments]    ${expected_text}
    Wait For Elements State    css=.swal2-html-container    visible    5
    Get Text    css=.swal2-html-container    equals    ${expected_text}  
