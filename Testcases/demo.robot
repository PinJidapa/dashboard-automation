*** Settings ***
Resource    ../Resourses/Imports.robot
Resource    ../Resourses/TestData/${env}/UserLogin.robot
Resource    ../Keywords/LoginKeyword.robot
Resource    ../Keywords/CommonKeyword.robot
Resource    ../Keywords/CreateCaseKeyword.robot
Resource    ../Resourses/Common/InsuredInfo.robot
Resource    ../Page/CommonPage.robot
Resource    ../Page/CaseDetailPage.robot

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
    Filter Only ID Card No And Status
    ...    2100300026833
    ...    verify
    Select The First Case
    # Click Download Pdf Button
    Sleep    10s
