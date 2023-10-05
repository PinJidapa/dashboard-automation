*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/CaseDetailPage.robot

*** Keywords ***
Download Case Detail
    Click Download Pdf Button
    Check The PDF File Is Exist
    Click Download Case Detail Button
    Check The Case Detail Zip File Is Exist
    Click Download Send Link History Button
    Check The Send Link Log Is Exist