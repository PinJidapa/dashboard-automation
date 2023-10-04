*** Variables ***
${username}    //input[@id='username']
${password}    //input[@id='password']
${signInBtn}    //input[@id='kc-login']

*** Keywords ***
Enter Username
    [Arguments]   ${value}
    Wait Until Element Is Visible    ${username}    10s
    Input Text    ${username}    ${value}

Enter Password
    [Arguments]   ${value}
    Wait Until Element Is Visible    ${password}    10s
    Input Text    ${password}    ${value}

Click Sign In Button
    Run Until Keyword Succeed    Click Element    ${signInBtn}