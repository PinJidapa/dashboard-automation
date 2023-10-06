*** Settings ***
Resource    ../Resourses/Imports.robot
Resource    ../Resourses/TestData/${env}/UserLogin.robot
Resource    ../Keywords/LoginKeyword.robot
Resource    ../Keywords/CommonKeyword.robot
Resource    ../Keywords/CreateCaseKeyword.robot
Resource    ../Page/CommonPage.robot
Resource    ../Page/CaseDetailPage.robot
Resource    ../Keywords/CaseDetailKeyword.robot

*** Variables ***
# ${Mrjuvenile}    //div[contains(text(),'Mr. (juvenile)')]
# ${Msjuvenile}     //div[contains(text(),'Ms. (juvenile)')]
# ${title}    //div[contains(text(),'${titleName}')]

*** Test Cases ***
Test 01
    Open Browser And Sign In With Username And Password
    ...    ${clientAdminUsername1}
    ...    ${clientAdminPassword1}
    Skip The Patch Pop Up
    # Input DipChip Case Detail
    # ...    7843275804481   
    # ...    7843275804481    
    # ...    Mr. (juvenile)
    # ...    จิดาภา
    # ...    ชินวัด
    # ...    โอบกิจกาจพล
    # ...    2
    # ...    April
    # ...    1999
    # Input Contact Information And Confirm Button  
    # ...    Phone No.
    # ...    0619926554
    # If Duplicate Then Click Cancel
    Filter The Case By Search And Previous Month Create Date And Verify Date
    ...    2100300026833
    ...    Choose Friday, September 1st, 2023
    ...    Choose Friday, September 8th, 2023
    ...    Choose Saturday, October 14th, 2023
    ...    Choose Friday, October 13th, 2023
    Select The First Case
    Download Case Detail