*** Settings ***
Library     SeleniumLibrary
Resource    ../Keywords/Utils.robot
Library     OperatingSystem
Library    Process
Library    RPA.CSV

*** Variables ***
${createCaseBtn}    //button[@id='dashboard-create-link-button']
${dipChipCase}      //div[contains(text(),'DipChip')]
${passportCase}    //div[contains(text(),'Passport')]
${expandCaseTypeButton}    //body/div[@id='root']/div[1]/div[1]/div[5]/div[1]/form[1]/div[1]/div[1]/div[1]/div[2]/div[1]
${citizenIdField}    //input[@name="proprietor.insureds.fields.0.citizenId"]
${titleDropDownField}    //div[@class="reselect__indicator reselect__dropdown-indicator css-tlfecz-indicatorContainer"]
${firstNameField}    //input[@name="proprietor.insureds.fields.0.firstName"]
${middleNameField}    //input[@name="proprietor.insureds.fields.0.middleName"]
${lastNameField}    //input[@name="proprietor.insureds.fields.0.lastName"]
${dayOfBirthField}    //input[@id='react-select-4-input']
${monthOfBirthField}    //input[@id='react-select-5-input'] 
${yearOfBirthField}   //input[@id='react-select-6-input']
${phoneNoRadioBtn}    //input[@type='radio' and @name='proprietor.insureds.fields.0.notifyType' and @value='sms']
${emailRadioBtn}    //input[@type='radio' and @name='proprietor.insureds.fields.0.notifyType' and @value='email']
${phoneNoField}    //input[@name="proprietor.insureds.fields.0.phoneNumber"]
${emailField}     //input[@name="proprietor.insureds.fields.0.email"]
${confirmCreateCaseBtn}    //button[contains(text(),'send')]
${cancelCaseBtn}    //button[contains(text(),'cancel')] 
${confirmSentLinkBtn}      //*[@id="ok-button"]
${createNewRadio}    //input[@class="min-w-3.5 align-top mx-auto mt-1" and @type="radio" and @value="createNew"]
${reuseRadio}     //input[@class="min-w-3.5 align-top mx-auto mt-1" and @type="radio" and @value="reUse"]
${redoRadio}    //input[@class="min-w-3.5 align-top mx-auto mt-1" and @type="radio" and @value="reDo"]
${cancelRadio}     //input[@class="min-w-3.5 align-top mx-auto mt-1" and @type="radio" and @value="cancel"]
${confirmInDuplicateBtn}    //*[@id="root"]/div/div/div[5]/div[1]/div/div[5]/button
${dashBoardCSVMenuBtn}    //button[@id='dashboard-csv-menu-button']
${uploadCsvFileInput}    //input[@id='file-input']
${importCsvBtn}    //button[contains(text(), "Import client’s template")]
${confirmWording}    //p[@class="text-xs my-4 whitespace-pre text-left"]    
${confirmImportCsv}    //button[contains(text(),'confirm')]

*** Keywords ***
Verify Create Case Button
    Wait Until Element Is Visible    ${createCaseBtn}  

Click Create Case Button
    Run Until Keyword Succeed    Click Element    ${createCaseBtn}
    Run Until Keyword Succeed    Click Element    ${expandCaseTypeButton}
    Run Until Keyword Succeed    Click Element    ${dipChipCase} 

Input DipChip
    [Arguments]    ${citizenId}    ${citizenId2}    ${title}    ${firstName}    ${middleName}    ${lastName}    ${dayOfBirth}    ${monthOfBirth}    ${yearOfBirth} 
    Input Text    ${citizenIdField}    ${citizenId} 
    Input Text    ${citizenIdField}    ${citizenId2} 
    Run Until Keyword Succeed    Click Element    ${titleDropDownField}
    Run Until Keyword Succeed    Click Element    //div[contains(text(),'${title}')]
    Input Text    ${firstNameField}    ${firstName}
    Input Text    ${middleNameField}    ${middleName}
    Input Text    ${lastNameField}    ${lastName}  
    Input Text    ${dayOfBirthField}    ${dayOfBirth}
    Press Keys    ${dayOfBirthField}    ENTER
    Input Text    ${monthOfBirthField}    ${monthOfBirth}
    Press Keys    ${monthOfBirthField}   ENTER
    Input Text    ${yearOfBirthField}    ${yearOfBirth}     
    Press Keys    ${yearOfBirthField}    ENTER

Input Contact
    [Arguments]    ${contact}    ${contactInfo} 
    Run Keyword If    "${contact}" == "Phone No."
    ...        Input Phone Number    ${contactInfo} 
    ...    ELSE IF    "${contact}" == "Email"
    ...        Input Email    ${contactInfo}

Input Phone Number
    [Arguments]    ${phoneNo}
    Click Element    ${phoneNoRadioBtn} 
    Input Text    ${phoneNoField}    ${phoneNo}  

Input Email
    [Arguments]    ${email} 
    Click Element    ${emailRadioBtn}
    Input Text    ${emailField}     ${email}

Click Cancel Create Case Button
    Run Until Keyword Succeed    Click Element    ${cancelCaseBtn}

Click Confirm Create Case Button
    Wait Until Element Is Enabled    ${createCaseBtn}    
    Run Until Keyword Succeed    Click Element    ${confirmcreateCaseBtn}
    Run Until Keyword Succeed    Click Element    ${confirmSentLinkBtn}

Check The Duplicate Pop Up If Yes Click Cancel
    Sleep    2s
    ${element_duplicate_popup_exists}    Run Keyword And Return Status    Element Should Be Visible    ${cancelRadio}
    Run Keyword If    ${element_duplicate_popup_exists}    Select Cancel On Duplicate Pop Up
    ...    ELSE    Verify Create Case Button

Check The Duplicate Pop Up If Yes Click Create New
    Sleep    2s
    ${element_duplicate_popup_exists}    Run Keyword And Return Status    Element Should Be Visible    ${cancelRadio}
    Run Keyword If    ${element_duplicate_popup_exists}    Select Create New On Duplicate Pop Up
    ...    ELSE    Verify Create Case Button
    Sleep    5s

Select Cancel On Duplicate Pop Up
    Wait Until Page Contains Element    ${cancelRadio}      
    Click Element    ${cancelRadio} 
    Wait Until Element Is Enabled    ${confirmInDuplicateBtn}
    Click Element    ${confirmInDuplicateBtn}

Select Create New On Duplicate Pop Up
    Wait Until Page Contains Element    ${createNewRadio}      
    Click Element    ${createNewRadio} 
    Wait Until Element Is Enabled    ${confirmInDuplicateBtn}
    Click Element    ${confirmInDuplicateBtn}

Check The Case Detail After Create The Case
    [Arguments]    ${firstName}    ${middleName}    ${lastName} 
    ${NameRowOne}    Set Variable    //tbody/tr[1]/td[2]
    Wait Until Element Is Visible    ${NameRowOne}
    Log To Console    ${NameRowOne}

Click Create Case By CSV
    [Arguments]    ${validCaseNo}
    Wait Until Element Is Visible   ${dashBoardCSVMenuBtn}
    Click Element    ${dashBoardCSVMenuBtn}   

    Wait Until Element Is Visible    ${importCsvBtn}
    # Input Text   ${uploadCsvFileInput}    ${EXECDIR}/Resourses/TestData/csv/test1.csv
    Click Element    ${importCsvBtn}
    Choose File    ${uploadCsvFileInput}    ${EXECDIR}/Resourses/TestData/csv/test1.csv
    
    Wait Until Element Is Visible    ${confirmWording}
    ${text} =    Get Text    ${confirmWording}
    Log To Console    ${text}    
    Should Contain    ${text}    There are ${validCaseNo} valid cases.
    Should Contain    ${text}    Do you wish to proceed and import all of those successful case?
    Sleep    2s

Click Confirm To Import Case By CSV
    Wait Until Element Is Visible    ${confirmImportCsv}
    Click Element    ${confirmImportCsv}
    

Check The Duplicate Pop Up For Create Case By CSV If Yes Click Create New
    Sleep    2s
    ${element_duplicate_popup_exists}    Run Keyword And Return Status    Element Should Be Visible    ${cancelRadio}
    Run Keyword If    ${element_duplicate_popup_exists}    Click Create New On Duplicate Pop Up Create Case By CSV
    ...    ELSE    Verify Create Case Button

Click Create New On Duplicate Pop Up Create Case By CSV
    Wait Until Element Is Visible   ${cancelRadio}
    @{create_case_radio_buttons} =    Get WebElements    css:.max-h-52 tbody input[type="radio"][value="createNew"]
    FOR    ${radio_button}    IN    @{create_case_radio_buttons}
        Run Until Keyword Succeed    Click Element    ${radio_button}
    END 
    Wait Until Element Is Enabled    ${confirmImportCsv}
    Run Until Keyword Succeed    Click Element    ${confirmImportCsv} 
    Sleep    5s