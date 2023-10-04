*** Settings ***
Library           SeleniumLibrary
Resource    ../Keywords/Utils.robot
Library     OperatingSystem

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

*** Keywords ***
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
    Run Until Keyword Succeed    Click Element    ${ConfirmcreateCaseBtn}