*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

*** Variables ***
${base_url}       https://portal-v2-qa.mac-non-prod.appmanteam.com/apps/case-keeper/cases
${username}       client_admin_1@mac-portal-v2.com
${password}       !QAZ2wsx

*** Test Cases ***


Login and Use Token
    ${data}    Create Dictionary    username=niki    password=1234    grant_type=password    client_id=mac-case-keeper
    ${response} =    POST    https://portal-dev.mac-non-prod.appmanteam.com/auth/realms/mac-portal/protocol/openid-connect/token    data=${data}
    # Log To Console    Response Body: ${response.text}
    ${response_body}=    Set Variable    ${response.text}
    ${response_dict} =    Evaluate    json.loads($response_body)
    ${access_token} =    Get From Dictionary    ${response_dict}    access_token
    Set Variable    ${access_token}
    Log To Console    Access Token: ${access_token}

# Perform a POST Request
    ${headers} =   Create Dictionary 
    Set To Dictionary    ${headers}    Content-Type    application/json
    Set To Dictionary    ${headers}    Authorization    Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJjMVZfcU9CYVNBTkxmTDRKSEp5eTcyTXJGSDhZTGk2WkRmN05vb3ozX2EwIn0.eyJleHAiOjE2OTY5MzAwMjksImlhdCI6MTY5Njg0MzY4MiwiYXV0aF90aW1lIjoxNjk2ODQzNjI5LCJqdGkiOiI1ZjRmZjkzYi1mYjI5LTQzOTktOGVhNS01NDdhYzEyNTQ4NzkiLCJpc3MiOiJodHRwczovL3BvcnRhbC1xYS5tYWMtbm9uLXByb2QuYXBwbWFudGVhbS5jb20vYXV0aC9yZWFsbXMvbWFjLXBvcnRhbCIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiJhOTkxZGQ0Yy03NTAzLTRmMWQtYjExMS0xNjY3YTI3NjM1NWMiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJtYWMtY2FzZS1rZWVwZXIiLCJzZXNzaW9uX3N0YXRlIjoiYmM1Y2NlMjMtMWM2Yi00ZjA0LWFiZGEtYTU0YTk1MTJjYjk2IiwiYWxsb3dlZC1vcmlnaW5zIjpbIioiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbImFjY291bnRfYWRtaW4iLCJiZF9hZG1pbiIsImFnZW5jeV9zdXBwb3J0Iiwic3lzdGVtX2FkbWluIiwiYWRtaW4iLCJzdXBwb3J0Iiwic3VwZXJ2aXNvciIsImNsaWVudF9hZG1pbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoib3BlbmlkIGdyb3VwcyBwcm92aWRlcl9hdHRyaWJ1dGUgYWdlbnRfY29kZSBsaWNlbnNlX2V4cGlyZXNfYXQgcGhvbmUgbGljZW5zZV9ubyBwcm9maWxlIGVtYWlsIiwic2lkIjoiYmM1Y2NlMjMtMWM2Yi00ZjA0LWFiZGEtYTU0YTk1MTJjYjk2IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsInByb3ZpZGVyIjoibWFjLXBvcnRhbCIsIm5hbWUiOiJuaWtpdGEgdGhvbWFzIiwiZ3JvdXBzIjpbIi9hZHZpc29yLXpvbmUiLCIvYWdlbmN5Il0sInByZWZlcnJlZF91c2VybmFtZSI6Im5pa2kiLCJnaXZlbl9uYW1lIjoibmlraXRhIiwiZmFtaWx5X25hbWUiOiJ0aG9tYXMiLCJlbWFpbCI6Im5pa2l0YS50QGFwcG1hbi5jby50aCJ9.ctl4zuD4tuUam0J-Hs2JFozvxDW6Ra2WRC2IUw8H08N6hDiTNrwH_DWBkRpwglzcVIw9_rT9BhWOzVhQF5sxRDdSiSeJeP3nNw36FzRTZTxGm0BFemTsltRYK3QDOfE04-_rZhSg2zcWrdTTm8RnJAd151I2hO_qOs1VpmhO7zfxhlzf3QFz-oU_PS7B8LtrIKedmIWk4FnXfgBDImi1d218NneaIjZ4b5-XIDCX25ZQK4kQyg_fomwceJb2vtNFrWBXz5XC2LWtTP0PADEtUFKUmU4Ha_sKLh7IHzMRZbc_VKRK243RxNeubVYLHG60CE3omsUgPmcoDUp5aXMiRA

    ${file_path}    Get File   ../dashboard-automation/data/payload.json
    ${json_data} =    Evaluate   json.loads('''${file_path}''')
    ${response} =    POST    https://portal-qa.mac-non-prod.appmanteam.com/api/v2/case-keeper/cases    json=${json_data}
    ...    headers=${headers}
    
        Log To Console    Response Body: ${response.text}
        Log To Console    Request Headers: ${response.headers}
