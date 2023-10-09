*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/CaseListPage.robot

*** Keywords ***
Skip The Patch Pop Up
    Check Path Note Pop Up

Check The Content In Case List Table
    [Arguments]    ${expected_status}
    Check Status in Every Row    ${expected_status}

Check Data In The Table After Create Case By CSV
    [Arguments]    ${CaseCreateByCsvNo}
    Read CSV File And Validate The Data In Table    ${CaseCreateByCsvNo}

Click The First Case
    Select The First Case

Check Data In The Table After Create Case
    [Arguments]    ${expectFullName}
    Check The Case After Create The Case    ${expectFullName}