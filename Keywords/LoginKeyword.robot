*** Settings ***
Resource        ../Page/LoginPage.robot
Resource        ../Resourses/TestData/${env}/config.robot

*** Keywords ***
Open Browser And Sign In With Username And Password
    [Arguments]    ${username}    ${password}

    # Specify the Chrome options
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --disable-popup-blocking
    Call Method    ${chrome_options}    add_argument    --start-maximized

    # Specify the Chrome preferences
    ${chrome_prefs}=    Create Dictionary
    Set To Dictionary    ${chrome_prefs}    download.default_directory     ${EXECDIR}/assets

    # Set the preferences in Chrome options
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${chrome_prefs}

    Open Browser    ${url}    browser=chrome    options=${chrome_options}
   
    Set Window Position    0    0
    Maximize Browser Window
    Enter Username    ${username}
    Enter Password    ${password}
    Click Sign In Button