*** Settings ***
Resource    ../Resourses/Imports.robot
Resource    ../Resourses/TestData/${env}/UserLogin.robot
Resource    ../Keywords/LoginKeyword.robot

*** Test Cases ***
Test 01
    Open Browser And Sign In With Username And Password
    ...    ${clientAdminUsername1}
    ...    ${clientAdminPassword1}