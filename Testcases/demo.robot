*** Settings ***
Resource    ../Resourses/Imports.robot
Resource    ../Resourses/TestData/${env}/UserLogin.robot
Resource    ../Keywords/LoginKeyword.robot
Resource    ../Keywords/CommonKeyword.robot
Resource    ../Keywords/CreateCaseKeyword.robot
Resource    ../Page/CommonPage.robot
Resource    ../Page/CaseDetailPage.robot
Resource    ../Keywords/CaseDetailKeyword.robot
Resource    ../Keywords/CaseListKeyword.robot
Resource    ../Page/CreateCasePage.robot

*** Test Cases ***
Test 01
    Open Browser And Sign In With Username And Password
    ...    ${clientAdminUsername1}
    ...    ${clientAdminPassword1}
    Skip The Patch Pop Up
    Input DipChip Case Detail
    ...    7843275804481   
    ...    7843275804481    
    ...    Mr. (juvenile)
    ...    จิดาภา
    ...    ชินวัด
    ...    โอบกิจกาจพล
    ...    2
    ...    April
    ...    1999
    Input Contact Information And Confirm Button  
    ...    Phone No.
    ...    0619926554
    If Duplicate Then Click Cancel
    # Check The Case Detail After Create The Case
    # ...    จิดาภา
    # ...    ชินวัด
    # ...    โอบกิจกาจพล
    Filter The Case By Case Type
    ...    Dip Chip
    Check The Content In Case List Table
    ...    Dip Chip
    Create Case By CSV
    ...    5
    Click Cancel On Duplicate Pop Up Create Case By CSV
    Select The First Case
    Download Case Detail
    ...    Dip Chip