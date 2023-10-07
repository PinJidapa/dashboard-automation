*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/CreateCasePage.robot

*** Keywords ***
Input DipChip Case Detail
    [Arguments]    ${citizenId}    ${citizenId2}    ${title}    ${firstName}    ${middleName}    ${lastName}    ${dayOfBirth}    ${monthOfBirth}    ${yearOfBirth}
    Click Create Case Button
    Input DipChip    
    ...    ${citizenId}    
    ...    ${citizenId2}    
    ...    ${title}    
    ...    ${firstName}    
    ...    ${middleName}    
    ...    ${lastName}
    ...    ${dayOfBirth}    
    ...    ${monthOfBirth}    
    ...    ${yearOfBirth}

Input Contact Information And Confirm Button
    [Arguments]     ${contact}    ${contactInfo}  
    Input Contact   ${contact}    ${contactInfo}
    Click Confirm Create Case Button

If Duplicate Then Click Cancel
    Check The Duplicate Pop Up If Yes Click Cancel

Create Case By CSV
    [Arguments]    ${validCaseNo}
    Click Create Case By CSV    ${validCaseNo}
    Click Confirm To Import Case By CSV    
