*** Settings ***
Resource    ../Keywords/Utils.robot
Library     SeleniumLibrary

*** Variables ***
${pathNotePopUpTH}    //div[contains(text(),'ฟีเจอร์ใหม่')]
${pathNotePopUpEN}    //div[contains(text(),'New update')]
${gotItButton}    //button[@id='ok-button']
${filterButton}    //body/div[@id='root']/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[3]/div[1]/button[1]/div[1]
${searchField}    xpath://input[@placeholder="Type something"]
${createAtField}    //input[@id="verification.createdAt"]
${verifyAtField}    //input[@id="verification.verifiedAt"]
${searchFilterBtn}    //*[@id="dashboard-filter-search-button"]
*** Keywords ***
Check Path Note Pop Up
    Sleep    2s
    ${element_th_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpTH}
    ${element_en_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpEN}

    Run Keyword If    ${element_th_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    ...    ELSE IF    ${element_en_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    ...    ELSE    Verify The Search Button    

Verify The Search Button
    Wait Until Element Is Visible    ${filterButton}  
Filter By Search
    [Arguments]    ${searchInfo}
    Wait Until Element Is Visible   ${filterButton}    10s
    Click Element    ${filterButton}    
    Input Text    ${searchField}    ${searchInfo}

Filter By Created Date
    [Arguments]    ${createAtDate}    ${createEndDate}    
    Click Element     ${createAtField}
    Click Element    xpath=//div[@aria-label="${createAtDate}"]
    Click Element    xpath=//div[@aria-label="${createEndDate}"] 

Filter By Verifydate Date
    [Arguments]    ${verifyAtDate}    ${verifyEndDate}
    Click Element    ${verifyAtField} 
    Click Element    xpath=//div[@aria-label="${verifyAtDate}"]
    Click Element    xpath=//div[@aria-label="${verifyEndDate}"]

Click Confirm To Search
    Click Element    ${searchFilterBtn}   
