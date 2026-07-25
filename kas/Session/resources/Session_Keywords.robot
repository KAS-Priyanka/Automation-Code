*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource    Session_Variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary



*** Keywords ***

Disable Screenshots
    Set Screenshot Directory    screenshots

Open Application
    [Arguments]    ${url}
    Log To Console    Opening ${url}
    Open Browser    ${url}    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Wait Until Element Is Visible    ${PAGE_HEADING}    5s
    Log To Console    Page loaded successfully

Enter Login Credentials And Submit
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    5s
    Input Text    ${EMAIL_INPUT}    ${email}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Wait Until Element Is Not Visible    id=preloader    20s
    Click Button    ${CONTINUE_BTN}    Continue clicked
    Wait Until Keyword Succeeds    5s    0.5s
    ...    Page Should Contain Element    xpath=//div[contains(.,'Login Success')]  
    Log To Console    Login successful with email: ${email}

Login Setup
    [Arguments]    ${url}    ${email}    ${password}
    Open Application    ${url}
    Enter Login Credentials And Submit    ${email}    ${password}

#---button click---
Click Button
    [Arguments]    ${locator}  ${label}
    Wait Until Element Is Visible    ${locator}    5s
    Click Element    ${locator}
    Log To Console    ${label} visible and clicked successfully

#---Session Page Keywords---
Verify Wallet Section
    [Arguments]    ${wallet_button}    ${wallet_value}

    Wait Until Element Is Visible    ${wallet_button}    10s
    Element Should Be Visible        ${wallet_button}

    ${value}=    Get Text    ${wallet_value}
    Should Contain    ${value}    ₹
    ${value}=    Remove String    ${value}    ₹
    ${value}=    Convert To Integer    ${value}

    Should Be True    ${value} >= 0
    Log To Console    Wallet balance is ₹${value} and is valid

Send Commerce IQ Query
    [Arguments]    ${query}    ${chat_input}  

    Wait Until Element Is Visible    ${chat_input}    20s
    sleep  2s
    Input Text    ${chat_input}    ${query}
    Log To Console    Chat query entered successfully
    Press Keys    ${chat_input}    ENTER
    Log To Console    Query sent successfully

Send Commerce IQ Query With Thinking Mode
    [Arguments]      ${thinking}   ${chat_input}  ${query}
    Wait Until Keyword Succeeds    5x    2s    Click Element    ${thinking} 
    sleep  2s
    Input Text    ${chat_input}    ${query}
    Log To Console    Chat query entered successfully
    Press Keys    ${chat_input}    ENTER
    Log To Console    Query sent successfully


Commerce IQ Response
    [Arguments]    ${expected_text1}    ${expected_text2}
    Wait Until Keyword Succeeds    120s    2s    Element Should Be Visible   ${AI_LOADING}         
    Wait Until Keyword Succeeds    120s    2s    Element Should Be Visible    ${AI_RESPONSE}
    # Get response
    ${response}=    Get Text    ${AI_RESPONSE}

    # Convert to lowercase
    ${response_lower}=    Convert To Lower Case    ${response}
    ${expected1}=    Convert To Lower Case    ${expected_text1}
    ${expected2}=    Convert To Lower Case    ${expected_text2}

    # Validation
    Should Contain    ${response_lower}    ${expected1}
    Should Contain    ${response_lower}    ${expected2}

    Log To Console    AI Response Verified Successfully

Validate Analysis Table  
    [Arguments]    ${analysis_table}  ${export_btn} 
    Scroll Element Into View  ${analysis_table}
    Wait Until Element Is Visible    ${analysis_table}    5s
    Scroll Element Into View  ${analysis_table}  
    wait Until Element Is Visible    ${export_btn}    5s
    Click Element    ${export_btn}
    Log To Console    Analysis Table Exported Successfully

Validate Wallet Balance In Response
    [Arguments]    ${wallet_balance}   ${wallet_balance_value}
    Wait Until Element Is Visible    ${wallet_balance}    10s
    Element Should Be Visible        ${wallet_balance}

    ${value1}=    Get Text    ${wallet_balance_value}
    Should Contain    ${value1}    ₹  Or   $
    ${value1}=    Remove String    ${value1}   ₹  Or   $
    ${value1}=    Convert To Integer    ${value1}
    Should Be True    ${value1} >= 0

    ${value2}=    Get Text    ${WALLET_VALUE}
    Should Contain    ${value2}    ₹  Or   $
    ${value2}=    Remove String    ${value2}   ₹  Or   $
    ${value2}=    Convert To Integer    ${value2}

    Should Be Equal    ${value1}    ${value2}
    Log To Console    Wallet balance is ${value1} and is valid

Create New Session
    [Arguments]   ${new_session_btn}
    Scroll Element Into View  ${new_session_btn}
    Wait Until Element Is Visible    ${new_session_btn}    5s
    Click Button    ${new_session_btn}    New Session button
    Wait Until Page Contains   Let’s grow your store,    timeout= 10s
    Log To Console   New Session loaded successfully
  
Validate Connected Marketplaces
    ${response}=    Get Text    ${AI_RESPONSE}

    FOR    ${market}    IN    @{expected_marketplaces}
        ${status}=    Run Keyword And Return Status    Should Contain    ${response}    ${market}
    END

    Log To Console    All marketplaces are displayed correctly in the AI response

Click History Value
    [Arguments]    ${history_value}
    ${FIRST_SESSION_HISTORY}=    Set Variable    xpath=(//span[contains(.,'${history_value}')]/ancestor::div[contains(@class,'cursor-pointer')]//img[@alt='Kebab menu'])[1]
    Wait Until Element Is Visible    ${FIRST_SESSION_HISTORY}    10s
    Click Element    ${FIRST_SESSION_HISTORY}
    Wait Until Page Contains    Analysis Table    timeout=5s
    Log To Console     ${history_value}
    Sleep    5s

Validate Memory And AI Section
    [Arguments]  ${no_memory_text}  ${MEMORY_HEADER}    ${MEMORY_CHIPS}    ${AI_LABEL}    ${AI_CONTENT}
    
    ${is_memory}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${MEMORY_HEADER}

    ${is_no_memory}=    Run Keyword And Return Status
    ...    Element Should Be Visible   ${no_memory_text}


    IF    ${is_memory}
        Wait Until Element Is Visible    ${MEMORY_CHIPS}    5s
        Wait Until Element Is Visible    ${AI_LABEL}    1s
        Wait Until Element Is Visible    ${AI_CONTENT}    1s

    Log To Console     Old User → Memory Present

    ELSE IF    ${is_no_memory}
        Log To Console     New User → No Memory

    ELSE
        Fail     Memory popup not loaded properly
    END

    
    