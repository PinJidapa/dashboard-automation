*** Settings ***
Library    SeleniumLibrary
Resource    ../Keywords/Utils.robot

*** Variables ***
${table_locator}    //table[@class='table-compact w-full']

*** Keywords ***    
Check Status in Every Row
    [Arguments]    ${expected_status}
    ${column_index}    Set Variable    3  # Adjust this to the correct column index (zero-based) for "Case Type"
    ${column_index_as_int}    Convert To Integer    ${column_index}
    ${table_elements}    Get WebElements    xpath=${table_locator}//tr/td[${column_index_as_int + 1}]  # Add 1 to the index to account for 1-based indexing in XPath
    FOR    ${element}    IN    @{table_elements}
        ${text}    Get Text    ${element}
        Log To Console   ${text}
        Should Be Equal As Strings     ${text}    ${expected_status}
    END