*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
Library    ../Scripts/api.py
Resource    ../Resourses/TestData/${env}/config.robot
Library    DateTime

*** Variables ***
${random_chars}    Evaluate    ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(10))

*** Keywords *** 
Post Create Case
# username=pin-v2   password=!QAZ2wsx
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
    ${file_path}    Get File   ${EXECDIR}/data/payload.json
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
    Set To Dictionary    ${headers}    Authorization     Bearer ${portalPrivateKey}
    ${file_path}    Get File    ../dashboard-automation/data/patchConsentBody.json
    ${json_data} =    Evaluate   json.loads('''${file_path}''')
    Log To Console    verificationId:${verificationId}
    ${patchConsent} =    PATCH    ${kycUrl}${verificationId}
    ...    json=${json_data}
    ...    headers=${headers}
    # Log To Console    xxx:${patchConsent.text}

Post Front ID Card
    ${headers} =    Create Dictionary
    Set To Dictionary    ${headers}    Authorization     Bearer ${portalPrivateKey}
    ${response} =    Upload File    ${kycUrl}${verificationId}/frontIdCards    ${EXECDIR}/data/pinIdCard.png    image/png    ${headers}
    Log To Console    ${response}

Patch Front ID Card
    ${headers} =    Create Dictionary
    Set To Dictionary    ${headers}    Authorization     Bearer ${portalPrivateKey}
    ${file_path}    Get File    ../dashboard-automation/data/patchIdCard.json
    ${json_data} =    Evaluate   json.loads('''${file_path}''')
    ${response} =    PATCH    ${kycUrl}${verificationId}/frontIdCards
    ...    json=${json_data}
    ...    headers=${headers}

Post Back ID Card
    ${headers} =    Create Dictionary
    Set To Dictionary    ${headers}    Authorization     Bearer ${portalPrivateKey}
    ${response} =    Upload File    ${kycUrl}${verificationId}/backIdCards    ${EXECDIR}/data/pinBackIdCard.png    image/png    ${headers}
    Log To Console    ${response}

Patch Back ID Card And Comfirm Dopa
    ${headers} =    Create Dictionary
    Set To Dictionary    ${headers}    Authorization     Bearer ${portalPrivateKey}
    ${file_path}    Get File    ../dashboard-automation/data/patchIdCard.json
    ${json_data} =    Evaluate   json.loads('''${file_path}''')
    ${response} =    PATCH    ${kycUrl}${verificationId}/backIdCards
    ...    json=${json_data}
    ...    headers=${headers}