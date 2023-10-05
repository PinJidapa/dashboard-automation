*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/CommonPage.robot

*** Keywords ***
Skip The Patch Pop Up
    Check Path Note Pop Up

Filter The Case
    [Arguments]    ${searchInfo}    ${createAtDate}    ${createEndDate}    ${verifyAtDate}    ${verifyEndDate}
    Filter By Search    ${searchInfo}
    Filter By Created Date    ${createAtDate}    ${createEndDate}
    Filter By Verifydate Date    ${verifyAtDate}    ${verifyEndDate}   
    Click Confirm To Search
# Filter The Case 
#     [Arguments]    ${searchInfo}    ${createAtDate}    ${createEndDate}    ${verifyAtDate}    ${verifyEndDate}
#     User Search Filter    
#     ...    ${searchInfo}   
#     ...    ${createAtDate}    
#     ...    ${createEndDate}
#     ...    ${verifyAtDate}    
#     ...    ${verifyEndDate}

    