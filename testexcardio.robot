*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${URL}      #adicionar url na hora do teste
${BROWSER}  Firefox
${HASH}    #adicionar hash na hora do teste
${CRM}      #adicionar crm na hora do teste
${NUM_CHECKBOXES}  12

*** Test Cases ***
Hush, CRM, Botão Pesquisa, Rotulagem e Salvar
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text    id=hash    ${HASH}
    Input Text    id=crm     ${CRM}
    Sleep    3
    Click Button    xpath=//button[@class='button-success btn btn-success']
    Sleep   8

    FOR    ${i}    IN RANGE    5    #adicionar uma quantidade de vezes que deseja rotular
        Wait Until Element Is Visible    xpath=//button[@class='button-success btn btn-success' and contains(., 'Rotular')]
        Click Button    xpath=//button[@class='button-success btn btn-success' and contains(., 'Rotular')]
        Sleep    2
        Select Random Checkboxes
        Sleep    2
        Select Random Checkbox in required    #risco cardiologico sim ou não
        Select Random Option From Dropdown    #grau de certeza 
        Click Save Button
        Sleep    5
        Wait Until Element Is Visible    xpath=//div[@class='modal-footer']//button[@type='button' and contains(@class, 'button-success') and contains(., 'Confirmar')]
        Click Confirm Button
        Sleep    2
        Click OK Button
        Sleep    2
        Wait Until Element Is Visible    xpath=//div[@class='modal-footer']//button[@type='button' and contains(., 'OK')]
        Click OK Button in New Registration
        Sleep    2
    END

    Close Browser

*** Keywords ***
Select Random Checkboxes 
    ${checkboxes}=    Get WebElements    xpath=//div[@class="table-details"]//input[@type="checkbox"]
    ${checkbox_count}=    Get Length    ${checkboxes}
    Log    Found ${checkbox_count} checkboxes

    # Verifica se há pelo menos um checkbox
    Run Keyword If    ${checkbox_count} > 0    Select Random Checkboxes From List    ${checkboxes}    ${checkbox_count}
    Run Keyword If    ${checkbox_count} == 0    Log    No checkboxes found

Select Random Checkboxes From List
    [Arguments]    ${checkboxes}    ${checkbox_count}
    ${num_to_select}=    Evaluate    min(${checkbox_count}, ${NUM_CHECKBOXES})
    ${selected_indexes}=    Create List

    FOR    ${i}    IN RANGE    ${num_to_select}
        ${random_index}=    Evaluate    random.randint(0, ${checkbox_count} - 1)    modules=random
        Run Keyword If    '${random_index}' not in ${selected_indexes}    Append To List    ${selected_indexes}    ${random_index}
    END

    Log    Selected indexes: ${selected_indexes}

    FOR    ${index}    IN    @{selected_indexes}
        ${checkbox}=    Get From List    ${checkboxes}    ${index}
        Wait Until Element Is Visible    ${checkbox}
        Run Keyword If    ${checkbox}    Click Element    ${checkbox}
    END

Select Random Checkbox in required
    ${specific_div_checkboxes}=    Get WebElements    xpath=//div[@class='col-md-3']//input[@type='checkbox']
    ${checkbox_count}=    Get Length    ${specific_div_checkboxes}
    Log    Found ${checkbox_count} checkboxes in required

    # Verifica se há pelo menos um checkbox na div específica
    Run Keyword If    ${checkbox_count} > 0    Select Random Checkbox From required    ${specific_div_checkboxes}    ${checkbox_count}
    Run Keyword If    ${checkbox_count} == 0    Log    No checkboxes found required

Select Random Checkbox From required    
    [Arguments]    ${checkboxes}    ${checkbox_count}
    ${random_index}=    Evaluate    random.randint(0, ${checkbox_count} - 1)    modules=random
    ${checkbox}=    Get From List    ${checkboxes}    ${random_index}
    Log    Selected checkbox index: ${random_index}
    Wait Until Element Is Visible    ${checkbox}
    Click Element    ${checkbox}

Select Random Option From Dropdown
    ${dropdown}=    Get WebElement    xpath=//div[@class='col-md-2']//select[@name='grau_certeza']
    ${options}=    Get WebElements    xpath=//div[@class='col-md-2']//select[@name='grau_certeza']//option
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