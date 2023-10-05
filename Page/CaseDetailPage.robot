*** Settings ***
Resource    ../Keywords/Utils.robot
Library     SeleniumLibrary
Library     pdfminer.pdfinterp
Library     pdfminer.converter
Library     pdfminer.layout
Library     OperatingSystem
Library     PyPDF2
Library     ../Scripts/Pdf2TextLibrary.py
Library     Pdf2TextLibrary

*** Variables ***
${caseDetailPdfBtn}    //div[contains(text(),'Case detail.pdf')]
${caseDetailBtn}    //div[contains(text(),'Case detail.zip')]
${sendlinkHistoryBtn}    //div[contains(text(),'Send link history.csv')]

*** Keywords ***


Example Test
# open downloaded PDF and read data from PDF${file_name} List Files in directory ${EXECDIR}/Files/Downloads
    ${pdf_path}    Set Variable    ${EXECDIR}/assets/1.pdf
    ${extracted_text}    Extract Text From PDF    ${pdf_path}
    Log    Extracted Text: ${extracted_text}

# Extract Text From PDF
#     ${pdf_file}     Open PDF     ${EXECDIR}/assets/1.pdf
#     ${text}         Get PDF Text     ${pdf_file}
#     Log             ${text}
#     Close PDF       ${pdf_file}

# Click Download Pdf Button
#     # Wait Until Element Is Visible    ${caseDetailPdfBtn}
#     # Click Element    ${caseDetailPdfBtn}
#     ${pdf_content}    Read PDF Content    ${EXECDIR}/assets/1.pdf
#     Log    PDF Content: ${pdf_content}