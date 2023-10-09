*** Settings ***
Resource    ../Resourses/Imports.robot
Resource    ../Resourses/TestData/${env}/UserLogin.robot
Resource    ../Keywords/LoginKeyword.robot
Resource    ../Keywords/FilterKeyword.robot
Resource    ../Keywords/CreateCaseKeyword.robot
Resource    ../Keywords/CaseDetailKeyword.robot
Resource    ../Keywords/CaseListKeyword.robot

*** Test Cases ***
Test 01
    Open Browser And Sign In With Username And Password
    ...    ${clientAdminUsername1}
    ...    ${clientAdminPassword1}
    Skip The Patch Pop Up
    Create Case By CSV
    ...    5
    If Duplicate Then Click Create New CSV
    Check Data In The Table After Create Case By CSV
    ...    5
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
    If Duplicate Then Click Create New
    Check The Case Detail After Create The Case TT
    ...    จิดาภา ชินวัด โอบกิจกาจพล
    Filter The Case By Case Type
    ...    Dip Chip
    Check The Content In Case List Table
    ...    Dip Chip
    Click The First Case
    Download Case Detail
    ...    Dip Chip