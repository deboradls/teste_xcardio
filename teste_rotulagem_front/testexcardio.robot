*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Library    FakerLibrary    

*** Variables ***
${URL}      54.233.219.82
${BROWSER}  edge
${HASH}    658f2bb5-101a-47b0-b0d7-0e5d23212da1
${CRM}      041198
${CHECKBOX_ALEATORIO}       //div[@class="table-details"]//input[@type="checkbox"]
${NUM_CHECKBOXES}  12    #quantidade de checkbox aleatorios que deve marcar - Obs: pode acabar desmarcando alguns que já foram marcados
${SIM_NAO}        //div[@class='col-md-3']//input[@type='checkbox']
${GRAU_CERTEZA}     //div[@class='col-md-2']//select[@name='grau_certeza']
${PESQUISA}     //div[@class='button-success btn btn-success']
${ROTULAR}      //div[@class='button-success btn btn-success' and contains(., 'Rotular')]
${CONFIRMAR}        //div[@class='modal-footer']//button[@type='button' and contains(@class, 'button-success') and contains(., 'Confirmar')]
${OK}       //div[@class='modal-footer']//button[@type='button' and contains(., 'OK')]

*** Test Cases ***
Hush, CRM, Botão Pesquisa, Rotulagem e Salvar
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    id=hash    ${HASH}
    Input Text    id=crm     ${CRM}
    Sleep    3
    Click Button    ${PESQUISA}
    Sleep   8

    FOR    ${i}    IN RANGE   1   #adicionar uma quantidade de vezes que deseja rotular
        Wait Until Element Is Visible    ${ROTULAR}
        Click Button    ${ROTULAR}
        Sleep    2
        Select Random Checkboxes
        Sleep    2
        Select Random Checkbox in required    #risco cardiologico sim ou não
        Select Random Option From Dropdown    #grau de certeza 
        Click Save Button
        Sleep    5
        Wait Until Element Is Visible    ${CONFIRMAR}
        Click Confirm Button
        Click OK Button
        Sleep    2
        Wait Until Element Is Visible    ${OK}
        Click OK Button in New Registration
        Sleep    2
    END

    Close Browser

*** Keywords ***
Select Random Checkboxes 
    ${checkboxes}=    Get WebElements    ${CHECKBOX_ALEATORIO}

    ${int}=        FakerLibrary.Random Int    0    ${checkboxes}-1

    FOR    ${i}    IN RANGE    ${int}
        ${int2}=        FakerLibrary.Random Int    1    ${checkboxes}
        ${random_index}=   Click Element    ${checkboxes}[${int2}]
    END

Select Random Checkbox in required
    ${specific_div_checkboxes}=    Get WebElements    ${SIM_NAO}
    ${checkbox_count}=    Get Length    ${specific_div_checkboxes}
    Log    Found ${checkbox_count} checkboxes in required

    # Verifica se há pelo menos um checkbox na div específica
    Run Keyword If    ${checkbox_count} > 0    Select Random Checkbox From required    ${specific_div_checkboxes}    ${checkbox_count}
    Run Keyword If    ${checkbox_count} == 0    Log    No checkboxes found required
    ${boolean}=        FakerLibrary.Boolean 


Select Random Checkbox From required    
    [Arguments]    ${checkboxes}    ${checkbox_count}
    ${random_index}=    Evaluate    random.randint(0, ${checkbox_count} - 1)    modules=random
    ${checkbox}=    Get From List    ${checkboxes}    ${random_index}
    Log    Selected checkbox index: ${random_index}
    Wait Until Element Is Visible    ${checkbox}
    Click Element    ${checkbox}

Select Random Option From Dropdown
    ${dropdown}=    Get WebElement    ${GRAU_CERTEZA}
    ${options}=    Get WebElements    ${DROPDOWN}//option
    ${option_count}=    Get Length    ${options}
    Log    Found ${option_count} options in the dropdown

    # Verifica se há pelo menos uma opção
    Run Keyword If    ${option_count} > 1    Select Random Option From Dropdown List    ${options}    ${option_count}
    Run Keyword If    ${option_count} <= 1    Log    Not enough options found in the dropdown

Select Random Option From Dropdown List
    [Arguments]    ${options}    ${option_count}
    ${random_index}=    Evaluate    random.randint(1, ${option_count} - 1)    modules=random
    ${option}=    Get From List    ${options}    ${random_index}
    Log    Selected option index: ${random_index}
    Click Element    ${option}

Click Save Button
    ${save_button}=    Get WebElement    xpath=//div[@class='col-md-1 margin-button-save']//button[@type='button' and contains(@class, 'button-success')]
    Click Element    ${save_button}

Click Confirm Button
    ${confirm_button}=    Get WebElement    xpath=//div[@class='modal-footer']//button[@type='button' and contains(@class, 'button-success') and contains(., 'Confirmar')]
    Wait Until Element Is Visible    ${confirm_button}
    Click Element    ${confirm_button}

Click OK Button
    ${ok_button}=    Get WebElement    xpath=//div[@class='swal2-actions']//button[contains(@class, 'swal2-confirm') and contains(., 'OK')]
    Wait Until Element Is Visible    ${ok_button}
    Click Element    ${ok_button}

Click OK Button in New Registration
    ${new_registration_ok_button}=    Get WebElement    xpath=//div[@class='modal-footer']//button[@type='button' and contains(., 'OK')]
    Wait Until Element Is Visible    ${new_registration_ok_button}
    Click Element    ${new_registration_ok_button}