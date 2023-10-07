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
${ekycStatus}    //body/div[@id='root']/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/div[1]/div[3]/div[1]/div[1]/div[1]/div[2]/div[4]/div[2]/div[1]/div[1]
${inprogressStatus}    //div[@class='text-info w-full']//span[@class='capitalize font-semibold text-xs' and text()='in progress']
${firstCase}    //table[@class='table-compact w-full']//tbody/tr[1]
${verifyOption}    //li/div[contains(@class, 'text-success')]
${caseTypeDropDown}    xpath://input[@placeholder="Choose case type"]
${previousMonthBtn}      xpath=//button[@aria-label="Previous Month"] 
${nextMonthBtn}      xpath=//button[@aria-label="Next Month"]
*** Keywords ***
Check Path Note Pop Up
    Sleep    2s
    ${element_th_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpTH}
    ${element_en_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpEN}

    Run Keyword If    ${element_th_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    ...    ELSE IF    ${element_en_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    ...    ELSE    Verify The Search Button    

Click Filter Icon
    Wait Until Element Is Visible   ${filterButton}    10s
    Click Element    ${filterButton}

Verify The Search Button
    Wait Until Element Is Visible    ${filterButton}

Filter By Search
    [Arguments]    ${searchInfo}
    Input Text    ${searchField}    ${searchInfo}

Click At Filter To Open Calendar
    Click Element     ${createAtField}

Filter By Created Date
    [Arguments]    ${createAtDate}    ${createEndDate}    
    Click Element    xpath=//div[@aria-label="${createAtDate}"]
    Click Element    xpath=//div[@aria-label="${createEndDate}"] 

Filter By Verify Date
    [Arguments]    ${verifyAtDate}    ${verifyEndDate}
    Click Element    xpath=//div[@aria-label="${verifyAtDate}"]
    Click Element    xpath=//div[@aria-label="${verifyEndDate}"]

Click Confirm To Search
    Click Element    ${searchFilterBtn}   

Filter By Ekyc Status
    [Arguments]    ${status}
    Click Element    ${ekycStatus} 
    Wait Until Element Is Visible    ${inprogressStatus}
    IF    "${status}"== "verify"
    ...        Click Element    ${verifyOption}
    ...    ELSE    Click Element    //div[@class='text-info w-full']//span[@class='capitalize font-semibold text-xs' and text()='${status}']

Filter By Case Type
    [Arguments]    ${caseType}
    Wait Until Element Is Visible    ${caseTypeDropDown}
    Click Element    ${caseTypeDropDown}   
    Click Element    //p[contains(text(),'${caseType}')] 

Select The First Case
    Wait Until Element Is Visible    ${firstCase}
    Click Element    ${firstCase}

Click Previous Month Button
    Click Element    ${previousMonthBtn}
    