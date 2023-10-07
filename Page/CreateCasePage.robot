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
${table_locator}    //table[@class='table-compact w-full']

*** Keywords ***
Read and Parse CSV
    ${file_contents} =    Get File    /Users/pinpinn/dashboard-automation/Resourses/TestData/csv/test1.csv
    
    # Split the file contents into lines
    ${lines} =    Split To Lines    ${file_contents}
    
    # Iterate over the lines and split them into a list of values
    FOR    ${line}    IN    @{lines}
        ${values} =    Split String    ${line}    ,
        # Extract values from the list based on column index
        ${case_type_code}    Set Variable    ${values[0]}
        ${citizen_id}    Set Variable    ${values[1]}
        ${title_code}    Set Variable    ${values[2]}
        ${first_name}    Set Variable    ${values[3]}
        ${last_name}    Set Variable    ${values[4]}
        ${date_of_birth}    Set Variable    ${values[5]}
        ${phone_number}    Set Variable    ${values[6]}
        ${email}    Set Variable    ${values[7]}
        ${proprietor_type}    Set Variable    ${values[8]}
        ${notify_type}    Set Variable    ${values[9]}
        
        # Do something with the extracted values
        Log    Last Name: ${title_code}
        Log To Console    ${title_code}
    END



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

Select Cancel On Duplicate Pop Up
    Wait Until Page Contains Element    ${cancelRadio}      
    Click Element    ${cancelRadio} 
    Wait Until Element Is Enabled    ${confirmInDuplicateBtn}
    Click Element    ${confirmInDuplicateBtn}

Check The Case Detail After Create The Case
    [Arguments]    ${firstName}    ${middleName}    ${lastName} 
    ${NameRowOne}    Set Variable    //tbody/tr[1]/td[2]
    Wait Until Element Is Visible    ${NameRowOne}
    Should Contain    ${NameRowOne}    ${firstName}     
    Should Contain    ${NameRowOne}    ${middleName}
    Should Contain    ${NameRowOne}    ${lastName}

Click Create Case By CSV
    [Arguments]    ${validCaseNo}
    Wait Until Element Is Visible   ${dashBoardCSVMenuBtn}
    Click Element    ${dashBoardCSVMenuBtn}   

    Wait Until Element Is Visible    ${importCsvBtn}
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


Check The Duplicate Pop Up For Create Case By CSV If Yes Click Cancel
    Sleep    2s
    ${element_duplicate_popup_exists}    Run Keyword And Return Status    Element Should Be Visible    ${cancelRadio}
    Run Keyword If    ${element_duplicate_popup_exists}    Click Cancel On Duplicate Pop Up Create Case By CSV
    ...    ELSE    Verify Create Case Button


Click Cancel On Duplicate Pop Up Create Case By CSV
    Wait Until Element Is Visible   ${cancelRadio}
    @{cancel_radio_buttons} =    Get WebElements    ${cancelRadio}
    FOR    ${radio_button}    IN    @{cancel_radio_buttons}
        Click Element    ${radio_button}
    END 
    Wait Until Element Is Enabled    ${confirmImportCsv}
    Click Element    ${confirmImportCsv}



    # ${result} =    Run Process    osascript    /Users/pinpinn/dashboard-automation/Scripts/close_finder_dialog.scpt
    # Should Be Equal    ${result.rc}    0
    
    # Run Process    osascript    ../Scripts/close_finder_dialog.scpt
    # Log To Console    AppleScript Execution Result: ${result.stdout} (Exit Code: ${result.rc})
    # Sleep    2s
    # Choose File    ${uploadCsvFileInput}    ${EXECDIR}/Resourses/TestData/csv/test1.csv
    # ${fileInput} =    Execute JavaScript    return document.querySelector("input[type='file']")
    # Log To Console   ${fileInput} 
    # Choose File    ${fileInput}    ${EXECDIR}/Resourses/TestData/csv/test1.csv