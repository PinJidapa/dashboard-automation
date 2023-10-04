*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/CreateCasePage.robot

*** Keywords ***
Input DipChip Case Detail
    [Arguments]    ${citizenId}    ${citizenId2}    ${titleEN}    ${firstName}    ${middleName}    ${lastName}    ${dayOfBirth}    ${monthOfBirth}    ${yearOfBirth}
    Click Create Case Button
    Input DipChip    
    ...    ${citizenId}    
    ...    ${citizenId2}    
    ...    ${titleEN}    
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