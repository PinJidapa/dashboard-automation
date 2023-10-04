*** Settings ***
Resource    ../Keywords/Utils.robot
Library     SeleniumLibrary

*** Variables ***
${pathNotePopUpTH}    //div[contains(text(),'ฟีเจอร์ใหม่')]
${pathNotePopUpEN}    //div[contains(text(),'New update')]
${gotItButton}    //button[@id='ok-button']

*** Keywords ***
Check Path Note Pop Up
    Sleep    2s
    ${element_th_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpTH}
    ${element_en_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpEN}

    Run Keyword If    ${element_th_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    ...    ELSE IF    ${element_en_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    # Run Until Keyword Succeed    Click Element    ${gotItButton}

    Log To Console   ${element_th_exists}
    Log To Console   ${element_en_exists}