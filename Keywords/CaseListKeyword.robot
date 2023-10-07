*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/CaseListPage.robot

*** Keywords ***
Check The Content In Case List Table
    [Arguments]    ${expected_status}
    Check Status in Every Row    ${expected_status}