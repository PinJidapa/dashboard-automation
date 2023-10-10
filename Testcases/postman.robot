*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
*** Test Cases ***
Post Create Case
    ${data}    Create Dictionary    username=niki    password=1234    grant_type=password    client_id=mac-case-keeper
    ${response} =    POST    https://portal-qa.mac-non-prod.appmanteam.com/auth/realms/mac-portal/protocol/openid-connect/token    data=${data}
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
    ${responseCases} =    POST    https://portal-qa.mac-non-prod.appmanteam.com/api/v2/case-keeper/cases    json=${json_data}
    ...    headers=${headers}


    ${responseBodyCases}=    Set Variable    ${responseCases.text}
    ${responseDictCases}=    Evaluate    json.loads($responseBodyCases) 
    ${caseId}=    Get From Dictionary     ${responseDictCases["proprietors"][0]}    verificationRef
    Log To Console    ${caseId}   


    ${verificationUrl}=    Set Variable    https://portal-v2-qa.mac-non-prod.appmanteam.com/apps/identity-verification/${caseId}
    Log To Console    ${verificationUrl}
