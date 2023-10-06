*** Settings ***
Resource    ../Keywords/Utils.robot
Library     SeleniumLibrary
Library     pdfminer.pdfinterp
Library     pdfminer.converter
Library     pdfminer.layout
Library     OperatingSystem
Library     ../Scripts/Pdf2TextLibrary.py
Library     Pdf2TextLibrary

*** Variables ***
${caseDetailPdfBtn}    //div[contains(text(),'Case detail.pdf')]
${caseDetailBtn}    //div[contains(text(),'Case detail.zip')]
${sendlinkHistoryBtn}    //div[contains(text(),'Send link history.csv')]
${downloadPdfTag}    //div[contains(text(),'client_admin-EKYC-download')]
  # Replace with the directory where the files are stored

*** Keywords ***
Click Download Pdf Button
    Wait Until Element Is Visible    ${caseDetailPdfBtn}
    Click Element    ${caseDetailPdfBtn}
    Wait Until Element Is Visible    ${downloadPdfTag}
    Sleep    5s

Check The PDF File Is Exist
    [Arguments]    ${caseType}
    ${pdfFiles} =    List Files In Directory    ${EXECDIR}/assets/    pattern=*_${caseType}.pdf
    ${pdfFile} =    Get From List    ${pdfFiles}    0
    Run Keyword And Ignore Error   Wait Until Keyword Succeeds    1x    5s    File Should Exist    ${pdfFile}   

Click Download Case Detail Button
    Wait Until Element Is Visible    ${caseDetailBtn}
    Click Element    ${caseDetailBtn}  
    Sleep    5s

Check The Case Detail Zip File Is Exist
    ${summaryFiles} =    List Files In Directory    ${EXECDIR}/assets/    pattern=*_Summary.zip
    ${summaryFile} =    Get From List    ${summaryFiles}    0
    Run Keyword And Ignore Error    Wait Until Keyword Succeeds    1x    5s    File Should Exist    ${summaryFile}  
    # FOR    ${retry}    IN RANGE    2
    #     ${summaryFiles} =    List Files In Directory    ${EXECDIR}/assets/    pattern=*_Summary.zip
    #     ${summaryFile} =    Get From List    ${summaryFiles}    0
    #     Run Keyword And Ignore Error    File Should Exist    ${summaryFile}    10s
    #     Exit For Loop If    '${summaryFile}' != ''
    # END

Click Download Send Link History Button
    Wait Until Element Is Visible    ${sendlinkHistoryBtn}
    Click Element     ${sendlinkHistoryBtn}
    Sleep    5s

Check The Send Link Log Is Exist
    ${SendLinkLogFiles} =    List Files In Directory    ${EXECDIR}/assets/    pattern=*_Send_Link_Log.csv
    ${SendLinkLogFile} =    Get From List    ${SendLinkLogFiles}   0
    Run Keyword And Ignore Error    Wait Until Keyword Succeeds    1x    5s    File Should Exist    ${SendLinkLogFile}  
    # FOR    ${retry}    IN RANGE    2
    #     ${SendLinkLogFiles} =    List Files In Directory    ${EXECDIR}/assets/    pattern=*_Send_Link_Log.csv
    #     ${SendLinkLogFile} =    Get From List    ${SendLinkLogFiles}    0
    #     Run Keyword And Ignore Error    File Should Exist    ${SendLinkLogFile}    10s
    #     Exit For Loop If    '${SendLinkLogFile}' != ''
    # END