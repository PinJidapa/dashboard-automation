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

Filter The Case By Search And Current Month Create Date And Current Verify Date
    [Arguments]    ${searchInfo}    ${createAtDate}    ${createEndDate}    ${verifyAtDate}    ${verifyEndDate}
    Filter By Search    ${searchInfo}
    Filter By Created Date    ${createAtDate}    ${createEndDate}
    Filter By Verify Date    ${verifyAtDate}    ${verifyEndDate}   
    Click Confirm To Search
    #Choose Saturday, October 14th, 2023

Filter The Case By Search And Previous Month Create Date And Verify Date
    [Arguments]    ${searchInfo}    ${createAtDate}    ${createEndDate}    ${verifyAtDate}    ${verifyEndDate}
    Filter By Search    ${searchInfo}
    Click At Filter To Open Calendar
    Click Previous Month Button
    Filter By Created Date    ${createAtDate}    ${createEndDate}
    Click At Filter To Open Calendar
    Filter By Verify Date    ${verifyAtDate}    ${verifyEndDate}   
    Click Confirm To Search
    
    #Choose Saturday, October 14th, 2023
    # Choose Friday, September 1st, 2023
    # Choose Friday, September 8th, 2023