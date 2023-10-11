*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Resource    ../Resourses/TestData/${env}/config.robot

*** Keywords *** 
Post Create Case
    ${data}    Create Dictionary    username=pin-v2   password=!QAZ2wsx    grant_type=password    client_id=mac-case-keeper
    ${response} =    POST    ${authUrl}    data=${data}
    # Log To Console    Response Body: ${response.text}
    ${response_body}=    Set Variable    ${response.text}
    ${response_dict} =    Evaluate    json.loads($response_body)
    ${access_token} =    Get From Dictionary    ${response_dict}    access_token
    Set Variable    ${access_token}

    ${headers} =   Create Dictionary 
    Set To Dictionary    ${headers}    Content-Type    application/json
    Set To Dictionary    ${headers}    Authorization    Bearer ${access_token} 
    ${file_path}    Get File   ../dashboard-automation/data/payload.json
    ${json_data} =    Evaluate   json.loads('''${file_path}''')
    ${responseCases} =    POST    ${createCaseUrl}    json=${json_data}
    ...    headers=${headers}

    ${responseBodyCases}=    Set Variable    ${responseCases.text}
    ${responseDictCases}=    Evaluate    json.loads($responseBodyCases)
    ${verificationId}=    Get From Dictionary     ${responseDictCases["proprietors"][0]["verifications"][0]}    id  
    Set Test Variable    ${verificationId}

    ${verificationUrl}=    Set Variable    ${clientBaseUrl}${verificationId}
    Log To Console     ${verificationUrl}   
    # Set Test Variable    ${verificationUrl}

Patch Consent
    ${headers} =    Create Dictionary
    Set To Dictionary    ${headers}    Authorization     Bearer NzdhN2VkZmItYjY5Mi00MWIzLThkNWYtZGY1ZjY3ODJhNTQ0
    ${file_path}    Get File    ../dashboard-automation/data/patchConsentBody.json
    ${json_data} =    Evaluate   json.loads('''${file_path}''')
    Log To Console    verificationId:${verificationId}
    ${patchConsent} =    PATCH    https://portal-qa.mac-non-prod.appmanteam.com/api/v2/kyc/verifications/${verificationId}
    ...    json=${json_data}
    ...    headers=${headers}
    # Log To Console    xxx:${patchConsent.text}

Post Front ID Card
    ${headers} =    Create Dictionary
    Set To Dictionary    ${headers}    Authorization     Bearer NzdhN2VkZmItYjY5Mi00MWIzLThkNWYtZGY1ZjY3ODJhNTQ0
    #Get File For Streaming Upload 
    ${file1}=    Get File For Streaming Upload    ../dashboard-automation/data/pinIdCard.png
    ${files}=    Create Dictionary    file    ${file1}
    
    Log To Console    data:${files}
    ${postFrontIdCard}=    POST     https://portal-qa.mac-non-prod.appmanteam.com/api/v2/kyc/verifications/${verificationId}/frontIdCards  
    ...    files=${files} 
    ...    headers=${headers}
    Log To Console    ${postFrontIdCard.txt}
    #http://localhost:3000