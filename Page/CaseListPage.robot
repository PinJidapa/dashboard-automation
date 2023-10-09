*** Settings ***
Library    SeleniumLibrary
Resource    ../Keywords/Utils.robot

*** Variables ***
${table_locator}    //table[@class='table-compact w-full']
${firstCase}    //table[@class='table-compact w-full']//tbody/tr[1]
${sixthCase}    //table[@class='table-compact w-full']//tbody/tr[6]
${pathNotePopUpTH}    //div[contains(text(),'ฟีเจอร์ใหม่')]
${pathNotePopUpEN}    //div[contains(text(),'New update')]
${gotItButton}    //button[@id='ok-button']

*** Keywords ***    

Select The First Case
    Wait Until Element Is Visible    ${firstCase}
    Click Element    ${firstCase}

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

Read CSV File And Validate The Data In Table
    [Arguments]    ${CaseCreateByCsvNo}
    Wait Until Element Is Visible   ${table_locator} 
    Wait Until Element Is Visible    ${firstCase} 
    # Wait Until Element Is Visible    ${sixthCase} 
    ${fullNameValue}=    Create List
    ${fileContents} =    Get File    /Users/pinpinn/dashboard-automation/Resourses/TestData/csv/test1.csv
    
    # Split the file contents into lines
    ${lines} =    Split To Lines    ${fileContents}
    
    # Iterate over the lines and split them into a list of values
    FOR    ${line}    IN    @{lines}
        ${values} =    Split String    ${line}    ,
        # Extract values from the list based on column index
        ${caseTypeCodeCsv}    Set Variable    ${values[0]}
        ${citizenIdCsv}    Set Variable    ${values[1]}
        ${titleCodeCsv}    Set Variable    ${values[2]}
        ${firstNameCsv}    Set Variable    ${values[3]}
        ${lastNameCsv}    Set Variable    ${values[4]}
        ${dateOfBirthCsv}    Set Variable    ${values[5]}
        ${phoneNumberCsv}    Set Variable    ${values[6]}
        ${emailCsv}    Set Variable    ${values[7]}
        ${proprietorTypeCsv}    Set Variable    ${values[8]}
        ${notifyTypeCsv}    Set Variable    ${values[9]}
        
        ${fullNameCsv} =    Set Variable    ${firstNameCsv} ${lastNameCsv}
        Append To List    ${fullNameValue}    ${fullNameCsv}
        ${fullNamesListCsv}=    Evaluate    [x for x in ${fullNameValue} if x != 'firstName lastName']
    END
    
    ${fullNameListTable}=    Create List
    ${matchingNameFound}    Set Variable    False 
    ${columnIndex}    Set Variable    1  # Adjust this to the correct column index (zero-based) for "Case Type"
    ${columnIndexAsInt}    Convert To Integer    ${columnIndex}
    ${tableElements}    Get WebElements    xpath=${tableLocator}//tr/td[${columnIndexAsInt + 1}]  # Add 1 to the index to account for 1-based indexing in XPath
    FOR    ${index}    IN RANGE    ${CaseCreateByCsvNo}
        ${element}    Get From List    ${tableElements}    ${index}
        ${fullName}    Get Text    ${element}
        Append To List    ${fullNameListTable}    ${fullName} 
    END
    ${listsMatch}=    Compare Lists    ${fullNameListTable}   ${fullNamesListCsv}
    Log To Console    ${fullNameListTable}
    Log To Console    ${fullNamesListCsv}
    Should Be True    ${listsMatch}

Compare Lists
    [Arguments]    ${list1}    ${list2}
    ${sorted_list1} =    Evaluate    sorted(${list1})
    ${sorted_list2} =    Evaluate    sorted(${list2})
    ${lists_match} =    Evaluate    ${sorted_list1} == ${sorted_list2}
    [Return]    ${lists_match}

Check Path Note Pop Up
    Sleep    2s
    ${element_th_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpTH}
    ${element_en_exists}    Run Keyword And Return Status    Element Should Be Visible    ${pathNotePopUpEN}

    Run Keyword If    ${element_th_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    ...    ELSE IF    ${element_en_exists}    Run Until Keyword Succeed    Click Element    ${gotItButton}
    ...    ELSE    Wait Until Element Is Visible    ${firstCase}

Check The Case After Create The Case
    [Arguments]    ${expectFullName}
    ${columnIndex}    Set Variable    1  # Adjust this to the correct column index (zero-based) for "Case Type"
    ${columnIndexAsInt}    Convert To Integer    ${columnIndex}
    ${tableElements}    Get WebElements    xpath=${tableLocator}//tr/td[${columnIndexAsInt + 1}]  # Add 1 to the index to account for 1-based indexing in XPath
    ${element}    Get From List    ${tableElements}    0
    ${fullName}    Get Text    ${element}
    Log To Console    ${fullName}
    Should Be Equal As Strings    ${fullName}    ${expectFullName}        