*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/CommonPage.robot

*** Keywords ***
Skip The Patch Pop Up
    Check Path Note Pop Up

Filter Only ID Card No And Status And Case Type
    [Arguments]    ${searchInfo}    ${status}    ${caseType}   
    Filter By Search    ${searchInfo}
    Filter By Ekyc Status    ${status}
    Filter By Case Type    ${caseType} 
    Click Confirm To Search

Filter The Case
    [Arguments]    ${searchInfo}    ${createAtDate}    ${createEndDate}    ${verifyAtDate}    ${verifyEndDate}
    Filter By Search    ${searchInfo}
    Filter By Created Date    ${createAtDate}    ${createEndDate}
    Filter By Verifydate Date    ${verifyAtDate}    ${verifyEndDate}   
    Click Confirm To Search