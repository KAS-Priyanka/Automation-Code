*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource   variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary


*** Keywords ***

Launch Browser
    Log To Console     Opening application
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Wait For Home Page To Load
    Wait Until Element Is Visible    ${PAGE_HEADING}    10s
    Log To Console     Page loaded successfully  


Click Create Account
   Click Element  ${CREATE_ACCOUNT_TAB}  
   Wait Until Page Contains   Re-enter Password  
   Log To Console   Redireced on Create Account Page


Verify Signup With Existing Email
    [Arguments]    ${EMAIL}  ${PASSWORD}  ${RE_PASSWORD}

    Wait Until Page Contains    Create your account    15s

    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Input Text   ${EMAIL_INPUT}    ${EMAIL}

    # Trigger validation
    Press Keys    ${EMAIL_INPUT}    TAB

    Wait Until Page Contains    already in use    10s
    Element Should Be Visible    ${SIGN_UP_ERROR_MSG}

   # Password mismatch validation
    Input Text    ${PASSWORD_INPUT}    ${PASSWORD}
    Input Text    ${RE_PASSWORD_INPUT}    ${RE_PASSWORD}

    Press Keys    ${RE_PASSWORD_INPUT}    TAB
    Wait Until Page Contains    Passwords do not match    10s

    Log To Console    Duplicate email + password mismatch validation working

Clear Field
    [Arguments]    ${locator}

    Wait Until Element Is Visible    ${locator}    10s
    Press Keys    ${locator}    CTRL+A
    Press Keys    ${locator}    BACKSPACE
    Log To Console    Cleared field: ${locator}


Enter Signup Details
    [Arguments]    ${email}    ${pass}  ${repass}  
    Input Text    ${EMAIL_INPUT}     ${email}
    Input Text   ${PASSWORD_INPUT}    ${pass}
    Input Text  ${RE_PASSWORD_INPUT}   ${repass}   

    Wait Until Element Is Enabled    ${CONTINUE_BTN}
    Click Button    ${CONTINUE_BTN}    Continue clicked

    Wait Until Page Contains  Tell us about yourself
    Log To Console  redired successfully

Enter Onboarding Details
    [Arguments]    ${name}    ${store}

    Wait Until Page Contains    Tell us about yourself    10s

    Input Text    ${FULL_NAME}     ${name}
    Input Text    ${STORE_NAME}   ${store}

   

Verify Onboarding Min Length Errors
    Wait Until Page Contains    Tell us about yourself    10s

    Page Should Contain    Name must be at least 2 characters
    Page Should Contain    Store name must be at least 2 characters

    Element Should Be Disabled    ${CONTINUE_BTN}

    Log To Console    Onboarding min length validation working
    
Verify OTP Page
   
    Wait Until Page Contains    Verify your email    15s
    Wait Until Page Contains    Resend OTP in    5s

Verify Email With Invalid OTP

    Wait Until Page Contains    Verify your email    15s

    Enter Dynamic OTP    123456
    Click Element    ${VERIFY_BTN}

    # Validate error message
    Wait Until Page Contains
    ...    Verification failed: Invalid verification code provided
    ...    10s

    Page Should Contain    Invalid verification code
    # Ensure user stays on OTP page
    Page Should Contain    Verify your email

    Log To Console    Invalid OTP validation passed
    Log To Console    Invalid OTP validation working

Enter Dynamic OTP
    [Arguments]    ${OTP}

    Should Not Be Empty    ${OTP}
    Wait Until Element Is Visible    ${OTP_BOXES}    15s

    ${boxes}=    Get WebElements    ${OTP_BOXES}
    ${count}=    Get Length    ${boxes}

    FOR    ${i}    IN RANGE    ${count}
        ${digit}=    Get Substring    ${OTP}    ${i}    ${i+1}
        Input Text    ${boxes}[${i}]    ${digit}
    END



Fetch OTP From Temp Mail
    [Arguments]    ${email}    ${password}

    Create Session    mail    https://api.mail.tm

    ${payload}=    Create Dictionary    address=${email}    password=${password}
    ${token_resp}=    POST On Session    mail    /token    json=${payload}
    ${token}=         Set Variable    ${token_resp.json()['token']}

    ${headers}=    Create Dictionary    Authorization=Bearer ${token}

    ${msg_resp}=    GET On Session    mail    /messages    headers=${headers}
    ${messages}=    Set Variable    ${msg_resp.json()['hydra:member']}
    Should Not Be Empty    ${messages}

    ${id}=    Set Variable    ${messages[0]['id']}

    ${mail_resp}=    GET On Session    mail    ${id}    headers=${headers}
    ${body}=         Set Variable    ${mail_resp.json()['text']}

    ${otp}=    Evaluate    __import__('re').search(r'\d{6}', '''${body}''').group(0)
    RETURN    ${otp}


Enter OTP In Boxes
    [Arguments]    ${otp}    ${locator}=xpath=//input[@inputmode='numeric']

    Wait Until Element Is Visible    ${locator}    20s
    @{boxes}=    Get WebElements    ${locator}

    FOR    ${i}    ${box}    IN ENUMERATE    @{boxes}
        ${digit}=    Get Substring    ${otp}    ${i}    ${i+1}
        Input Text    ${box}    ${digit}
    END


Generate Temp Email
    &{headers}=    Create Dictionary    User-Agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64)
    Create Session    mail    https://www.1secmail.com    headers=${headers}

    ${response}=    GET On Session
    ...    mail
    ...    url=/api/v1/
    ...    params=action=genRandomMailbox&count=1

    ${email}=    Set Variable    ${response.json()[0]}
    Log To Console    Generated Email: ${email}
    RETURN    ${email}


Enter Login Credentials
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    5s
    Input Text    ${EMAIL_INPUT}    ${email}
    Input Text    ${PASSWORD_INPUT}    ${password}
    Log To Console    Login credentials entered successfully
   


Submit and Verify Login
    Click Button    ${CONTINUE_BTN}    Continue clicked
    Wait Until Page Contains    Login Success    10s
    Wait Until Element Is Visible        ${SESSION_LOGO}   20s
    Wait Until Page Contains  Commerce IQ     5s
    Log To Console     Logged in successfully and Session loaded

Verify Session
    [Documentation]    Verifies Session logo, AI agent and dashboard icon visibility

    Scroll Element Into View  ${SESSION_LOGO} 
    Wait Until Element Is Visible  ${SESSION_LOGO}   5s
    Wait Until Page Contains  Commerce IQ     5s
    Log To Console  Session Logo is visible


    Scroll Element Into View  ${AI_AGENT}
    Wait Until Element Is Visible   ${AI_AGENT}   5s
    Log To Console  AI Agent is visible

    Scroll Element Into View   ${DASHBOARD_MENU} 
    Wait Until Element Is Visible  ${DASHBOARD_MENU}   5s
    Click Element    ${DASHBOARD_MENU} 
    Log To Console   Dashboard Icon is visible



Validate Commerce IQ Dashboard
    Wait Until Page Contains    Commerce IQ    10s
    Wait Until Element Is Visible    ${NEW_SESSION_BTN}    10s
    Log To Console    Dashboard loaded successfully

Verify MSC Logo Visible  
    Wait Until Element Is Visible    ${MSC_LOGO}      20s
    log To Console     MSC Logo visible

Verify Ai agent
    Wait Until Element Is Visible    ${AI_AGENT}      20s
    log To Console     AI agent visible
    Click Element  ${AI_AGENT}
    Log To Console     AI agent clicked

Verify MSC Intelligence popup

    Wait Until Page Contains   here are your useful Insights!    10s
    Wait Until Element Is Visible    ${BTN_CLOSE}    10s
    Click Element                   ${BTN_CLOSE}
    Log To Console                   Close button clicked

Verify MSC Intelligence Button Clickable
    wait Until Page Does Not Contain    ${MSC_BUTTON}    10s
    click Element                 ${MSC_BUTTON}
    log To Console                   MSC Intelligence button clicked

Verify MSC Intelligence Button Visible
 
    Scroll Element Into View        ${MSC_BUTTON}     
    Wait Until Element Is Visible   ${MSC_BUTTON}     5s
    Log To Console    msc intelligence button is visible

Wait For Dashboard Fully Loaded
    Wait Until Keyword Succeeds    30s    2s
    ...    Element Should Not Be Visible    ${SKELETON_ELEMENTS}

    Wait Until Element Is Visible    ${CHART_ELEMENTS}       20s
    Log To Console    WHOLE dashboard page fully loaded

Verify Dashboard Fully Loaded
    Wait Until Keyword Succeeds    25s    2s
    ...    Element Should Not Be Visible    ${SKELETON_ELEMENTS}

    Wait Until Element Is Visible    ${CHART_ELEMENTS}       20s
    Log To Console    WHOLE dashboard page fully loaded


Select From Dropdown
    [Arguments]    ${dropdown_locator}    ${option_text}

    # Open dropdown
    Wait Until Element Is Visible    ${dropdown_locator}    10s
    Click Element    ${dropdown_locator}

    # Dynamic option locator
    ${option}=    Set Variable
    ...    xpath=//div[contains(@class,'z-50')]//span[normalize-space()='${option_text}']/parent::div

    Wait Until Element Is Visible    ${option}    10s
    Click Element    ${option}

    Log To Console    Selected: ${option_text}

Verify Country 
    ${country}=    Get Text   ${COUNTRY}
    Log To Console    Selected country: ${country}

    @{allowed}=    Create List    India    United State
    List Should Contain Value    ${allowed}    ${country}
    
    

Verify Marketplace 
    
   ${country}=    Get Text    ${COUNTRY}
    ${market}=     Get Text    ${MARKETPLACE} 

    Log To Console    Country: ${country}
    Log To Console    Marketplace: ${market}

    IF    '${country}' == 'India'
        @{allowed}=    Create List    Amazon.in    Shopify.com/in
        List Should Contain Value    ${allowed}    ${market}

    ELSE IF    '${country}' == 'United State'
        Should Be Equal    ${market}    Amazon.com

    ELSE IF    '${country}' == 'United Kingdom'
        Should Be Equal    ${market}    Amazon.co.uk

    ELSE
        Fail    Unsupported country: ${country}
    END


Verify Brand Visible
    ${brand_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${BRAND}    3s

    Should Be True    ${brand_visible}
    Log To Console     At least one brand is visible


Select Brand From Dropdown
    [Arguments]    ${dropdown_locator}    ${option_text}

    Wait Until Element Is Visible    ${dropdown_locator}    10s
    Click Element    ${dropdown_locator}

    ${option}=    Set Variable
    ...    xpath=//span[normalize-space()='${option_text}']/parent::div

    Wait Until Element Is Visible    ${option}    10s
    Click Element    ${option}

    Log To Console    Selected: ${option_text}

Verify Language Visible
   Wait Until Element Is Visible    ${LANG_HEADER_ANY}    5s
    Log To Console     Language is visible

Select Language From Dropdown

    [Arguments]    ${dropdown_locator}    ${language}

    # Get expected text from dictionary
    ${expected}=    Get From Dictionary    ${LANG_EXPECTED_TEXT}    ${language}

    # Select language
    Click Element    ${dropdown_locator}
    Click Element    xpath=//span[normalize-space()='${language}']/parent::div

    # Validate text
    Wait Until Keyword Succeeds    5s    1s
    ...    Page Should Contain    ${expected}
 
    Log To Console    ${language} validated successfully


Verify Notification Icon Visible
    Wait Until Element Is Visible    ${NOTIFICATION}         5s
    #Click Element      ${NOTIFICATION}     5s
    #Wait Until Page Contains Element  ${NOTIFICATION}     5s
    log to Console     Notification icon visible

Verify Profile Icon Visible
    Wait Until Element Is Visible    ${PROFILE_ICON}         5s
    log To Console     Profile icon visible
    Log To Console     All dashboard header elements loaded successfully

Validate Today Date
    ${ui_date}=    Get Text    ${TODAY_DATE}
    ${ui_date}=    Strip String    ${ui_date}
    ${system_date}=    Get Current Date    result_format=%Y-%m-%d
    ${system_date}=    Convert To String    ${system_date}

    Should Be Equal As Strings    ${ui_date}    ${system_date}
    Log To Console    Today OK → ${ui_date}

Validate Currency By Country
    [Arguments]    ${country}    ${revenue}

    ${country}=    Strip String    ${country}
    ${revenue}=    Strip String    ${revenue}

    ${symbol}=    Get From Dictionary    ${CURRENCY_MAP}    ${country}

    Log To Console    Country: ${country}
    Log To Console    Expected Symbol: ${symbol}
    Log To Console    Revenue: ${revenue}

    Should Start With    ${revenue}    ${symbol}
    Log To Console    ✅ Currency validated

Validate Revenue Currency From UI
    [Arguments]    ${country_locator}    ${revenue_locator}

    ${country}=    Get Text    ${country_locator}
    ${revenue}=    Get Text    ${revenue_locator}

    Validate Currency By Country    ${country}    ${revenue}

Verify Percentage Symbol
    [Arguments]    ${locator}    ${label}

    ${value}=    Get Text    ${locator}
    Should Contain    ${value}    %
    Log To Console    ${label} contains % symbol: ${value}


Validate Yesterday Date
    ${ui}=    Get Text    ${YESTERDAY_DATE}
    ${ui}=    Strip String    ${ui}

    ${yesterday}=    Get Current Date    result_format=%Y-%m-%d    increment=-1d

    Should Be Equal As Strings    ${ui}    ${yesterday}
    Log To Console    Yesterday OK → ${ui}


Validate Last 7 Days Range
    ${ui}=    Get Text    ${LAST7DAYS_DATE}
    ${ui}=    Strip String    ${ui}

    ${start}=    Get Current Date    result_format=%Y-%m-%d    increment=-7d
    ${end}=      Get Current Date    result_format=%Y-%m-%d    increment=-1d

    Should Contain    ${ui}    ${start}
    Should Contain    ${ui}    ${end}

    Log To Console    Last 7 Days OK → ${ui}
Validate Last Month Range
    ${ui}=    Get Text    ${LASTMONTH_DATE}
    ${ui}=    Strip String    ${ui}

    ${end}=      Get Current Date    result_format=%Y-%m-%d    increment=-1d
    ${start}=    Get Current Date    result_format=%Y-%m-%d    increment=-30d

    Log To Console    Expected: ${start} to ${end}
    Should Contain    ${ui}    ${end}

    Log To Console    Last Month OK → ${ui}

Verify Card Visible
    [Arguments]    ${card_name}    ${card_locator}    ${date_locator}
    Scroll Element Into View         ${date_locator}    
    Wait Until Element Is Visible    ${date_locator}    5s
    Wait Until Element Is Visible    ${card_locator}    5s

    Log To Console    ${card_name} card visible




Verify SKU Wise Section
    Wait Until Element Is Visible     ${VIEW_SKU_WISE_DROPDOWN_BUTTON}   15s
    Click Element    ${VIEW_SKU_WISE_DROPDOWN_BUTTON}
    log To Console     View SKU Wise dropdown button visible

    Wait Until Page Contains    Monitor the exceptional performance of the Top 5 SKUs    20s
    log To Console     SKU Wise text visible

    Scroll Element Into View   ${SKU_TODAY_TOP_HEADER}
    wait Until Element Is Visible    ${SKU_TODAY_TOP_HEADER}    20s

    scroll Element Into View   ${SKU_TODAY_TABLE}
    wait Until Element Is Visible    ${SKU_TODAY_TABLE}         5s
    wait Until Element Is Visible    ${SKU_YESTERDAY_TOP_HEADER}    5s
    wait Until Element Is Visible    ${SKU_YESTERDAY_TABLE}         5s
    wait Until Element Is Visible    ${SKU_LAST7DAYS_TOP_HEADER}    10s
    wait Until Element Is Visible    ${SKU_LAST7DAYS_TABLE}         10s
    wait Until Element Is Visible    ${SKU_LASTMONTH_TOP_HEADER}    10s
    wait Until Element Is Visible    ${SKU_LASTMONTH_TABLE}         10s

    log To Console     SKU Wise headers visible
    Wait Until Page Contains Element    ${HIDE_SKU_WISE_BTN}    30s
    Scroll Element Into View            ${HIDE_SKU_WISE_BTN}
    Click Element                      ${HIDE_SKU_WISE_BTN}
    log To Console     Hide SKU Wise button clicked
    
Validates All Dashboard Graph  
    [Arguments]    ${locator}    ${timeout}=5s
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    

Asc And Desc Toggle  
    [Arguments]    ${locator}   ${mgs}

    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}
    Log To Console    ${mgs}Category Toggle Clicked
#---Shipped------

Validate Cards
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Card visible

Validate Search
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Search visible
Validate Cards With Value
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Card with value visible
    
Validate Cards Value
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Card Value visible

Validate Graph
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} graph visible

Open Page From Sales

     [Arguments]    ${locator}    ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                    ${locator}
    Log To Console    ${label} 



Validate Tables
    [Arguments]    ${locator}  ${label}   ${timeout}=10s
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} table visible


Check Table Empty Or Data
    [Arguments]    ${empty_locator}    ${table_locator}

    ${empty}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${empty_locator}
    ...    5s

    IF    ${empty}
        Log To Console    ⚠️ Table is EMPTY
    ELSE
        Wait Until Element Is Visible    ${table_locator}    7s
        Log To Console    ✅ Table has DATA
    END





Select Dropdown Option And Verify
    [Arguments]    ${dropdown}    ${value}    ${loader_locator}   ${data_locator}

    # Click dropdown
    Wait Until Element Is Visible    ${dropdown}    10s
    Click Element    ${dropdown}

    # Type value (optional but improves speed)
    Input Text    ${dropdown}    ${value}

    # Dynamic option locator
    ${option}=    Set Variable
    ...    xpath=//ul[@role='listbox']//li[contains(.,'${value}')]

    # Check if option exists
    ${is_present}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${option}    5s

    Run Keyword If    ${is_present}
    ...    Click Element    ${option}
    ...    ELSE
    ...    Log To Console    ⚠️ Dropdown option not available: ${value}
   
    # Wait loader disappear (safe)
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible    ${loader_locator}    5s

    # Wait data load
    Wait Until Element Is Visible    ${data_locator}    10s

    # Retry-safe validation
    ${selected}=    Wait Until Keyword Succeeds    3x    2s
    ...    Run Keyword And Return
    ...    Get Element Attribute    ${dropdown}    value

    ${selected}=    Strip String    ${selected}

    Log To Console    Expected = ${value}
    Log To Console    Actual   = ${selected}

    Run Keyword And Continue On Failure
    ...    Should Be Equal As Strings    ${selected}    ${value}


    Log To Console    ✅ Dropdown validation successful
    




Validate Dropdown
    [Arguments]    ${canvas}    ${sku_table}    ${city_dropdown}    ${city_popup}    ${city_value}

    # --- City Wise Chart ---
    Scroll Element Into View    ${canvas}
    Wait Until Element Is Visible    ${canvas}    10s
    Wait Until Page Contains    City wise Contribution    10s
    Log To Console    Shipping City wise contribution chart loaded

    # --- SKU Table ---
    Scroll Element Into View    ${sku_table}
    Wait Until Element Is Visible    ${sku_table}    10s
    Wait Until Page Contains    Top 5 SKU in selected City    10s
    Log To Console    Shipping Top 5 SKU table loaded

    # --- City Dropdown ---
    Scroll Element Into View    ${city_dropdown}
    Wait Until Element Is Visible    ${city_dropdown}    10s
    Click Element    ${city_dropdown}
    Wait Until Element Is Visible    ${city_popup}    10s

    # Build dynamic option locator
    ${option_locator}=    Set Variable    xpath=//li[normalize-space()='${city_value}']
    Wait Until Keyword Succeeds    10x    1s
    ...    Scroll And Click Option    ${city_popup}    ${option_locator}


    Log To Console    Selecting city = ${city_value}
    Click Element    ${option_locator}

    # --- Validate selected value ---
    Wait Until Element Is Visible    ${city_dropdown}    15s
    ${actual}=    Get Text    ${city_dropdown}
    ${actual}=    Strip String    ${actual}

    Log To Console    Dropdown value = ${actual}
    Should Be Equal As Strings    ${actual}    ${city_value}
    Log To Console    City value matches


Scroll And Click Option
    [Arguments]    ${popup}    ${option_locator}

    ${found}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${option_locator}

    IF    ${found}
        Click Element    ${option_locator}
        RETURN
    END

    # Scroll popup
    Execute Javascript
    ...    arguments[0].scrollTop = arguments[0].scrollTop + 300
    ...    ${popup}

    Fail    Option not visible yet

Navigate To Page
    [Arguments]    ${page}

    ${locator}=    Set Variable
    ...    ${SKU_CARD}//a[@aria-label='Page ${page}']

    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}
    Wait For Pagination Update


Validate Page
    [Arguments]    ${expected}
    ${actual}=    Get Text    ${SKU_ACTIVE_PAGE}
    Should Be Equal    ${actual}    ${expected}

Navigate To Previous Page
    Click Element    ${SKU_PREV}
    Wait For Pagination Update

Navigate To Next Page
    Click Element    ${SKU_NEXT}
    Wait For Pagination Update


Wait For Pagination Update
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Be Visible
    ...    ${SKU_ACTIVE_PAGE}










#verify date range picker 
    wait Until Element Is Visible    ${DATE_RANGE_PICKER_INPUT}    10s
    Click Element                   ${DATE_RANGE_PICKER_INPUT}
    Wait Until Element Is Visible    ${CALENDAR_POPUP}    10s
    Click Element               ${TODAY_BTN}    
  
    Wait Until Element Is Not Visible    ${CALENDAR_POPUP}    10s
    ${month}=    Get Current Date    result_format=%b
    ${day}=      Get Current Date    result_format=%d
    ${year}=     Get Current Date    result_format=%Y

    ${day}=      Convert To Integer    ${day}

    ${today}=    Set Variable    ${month} ${day}, ${year}
    Log To Console    ${today}

    Wait Until Keyword Succeeds    15x    2s   Wait Until Date Input Has Value

    ${actual}=    Get Element Attribute    ${DATE_PICKER_INPUT}     placeholder
    Should Be Equal    ${actual}    ${today}
    Log To Console     Date range picker working fine

verify search input 
    Wait Until Element Is Visible    ${SEARCH_INPUT}      5s
    Scroll Element Into View   ${SEARCH_INPUT}
    Log To Console     Search input box visible on Returns page

Wait Until Date Input Has Value
    ${val}=    Get Element Attribute     ${DATE_PICKER_INPUT}    placeholder
    Should Not Be Empty    ${val}



Validate Cities Belong To State
    [Arguments]    ${STATE}

    ${STATE}=    Strip String    ${STATE}

    ${rows}=    Get WebElements    ${SHIPPING_TOP_5_CITY_TABLE}  

    @{validCities}=    Get From Dictionary    ${STATE_CITY_MAP}    ${STATE}

    # normalize expected list
    @{expectedLower}=    Create List
    FOR    ${c}    IN    @{validCities}
        ${lc}=    Convert To Lower Case    ${c}
        Append To List    ${expectedLower}    ${lc}
    END

    FOR    ${row}    IN    @{rows}
        ${city}=    Get Text    ${row}
        ${city}=    Fetch From Left    ${city}    ${SPACE}
        ${city}=    Strip String    ${city}
        ${city}=    Convert To Lower Case    ${city}

        Log To Console    Checking city = ${city}

        List Should Contain Value    ${expectedLower}    ${city}
    END


Validate Return Cities Belong To Selected State
    [Arguments]    ${STATE}

    ${STATE}=    Strip String    ${STATE}

    ${rows}=    Get WebElements     ${TOP_5_CITY_TABLE}  

    @{validCities}=    Get From Dictionary    ${STATE_CITY_MAP}    ${STATE}

    # normalize expected list
    @{expectedLower}=    Create List
    FOR    ${c}    IN    @{validCities}
        ${lc}=    Convert To Lower Case    ${c}
        Append To List    ${expectedLower}    ${lc}
    END

    FOR    ${row}    IN    @{rows}
        ${city}=    Get Text    ${row}
        ${city}=    Fetch From Left    ${city}    ${SPACE}
        ${city}=    Strip String    ${city}
        ${city}=    Convert To Lower Case    ${city}

        Log To Console    Checking city = ${city}

        List Should Contain Value    ${expectedLower}    ${city}
    END

Validate Return Top 5 SKU Belong To Selected City    
    [Arguments]    ${STATE}

    ${STATE}=    Strip String    ${STATE}

    ${rows}=    Get WebElements      ${TOP_5_SKU_TABLE} 

    @{validCities}=    Get From Dictionary    ${STATE_CITY_MAP}    ${STATE}

    # normalize expected list
    @{expectedLower}=    Create List
    FOR    ${c}    IN    @{validCities}
        ${lc}=    Convert To Lower Case    ${c}
        Append To List    ${expectedLower}    ${lc}
    END

    FOR    ${row}    IN    @{rows}
        ${city}=    Get Text    ${row}
        ${city}=    Fetch From Left    ${city}    ${SPACE}
        ${city}=    Strip String    ${city}
        ${city}=    Convert To Lower Case    ${city}

        Log To Console    Checking city = ${city}

        List Should Contain Value    ${expectedLower}    ${city}
    END


#---Inventory Projection----





   

Select Timeline Option
    [Arguments]    ${DROPDOWN}    ${OPTION_TEMPLATE}    ${SELECTED_LOCATOR}    ${VALUE}    ${LABEL}

    Wait Until Element Is Visible    ${DROPDOWN}    10s
    Click Element                   ${DROPDOWN}

    ${opt}=    Replace String    ${OPTION_TEMPLATE}    {{VALUE}}    ${VALUE}

    Wait Until Element Is Visible    ${opt}    10s
    Click Element                   ${opt}

    Element Text Should Be          ${SELECTED_LOCATOR}    ${VALUE}
    Log To Console                  ${LABEL} Timeline changed successfully to ${VALUE}
    Click Element    ${PROJECTION_SUBMIT_BUTTON}






Verify Pagination 
   ${has_page}=    Run Keyword And Return Status
    ...    Page Should Contain Element  ${PAGINATION}
    
    IF    ${has_page}
        Click Element    ${PAGINATION}
        Log To Console    Clicked pagination Page 2
    ELSE
        Fail    Page 2 not available in pagination
    END





    





Search In Inventory Status Table
    [Arguments]    ${VALUE}

    Wait Until Element Is Visible    ${INVENTORY_STATUS_SEARCH}    10s
    Clear Element Text              ${INVENTORY_STATUS_SEARCH}
    Input Text                     ${INVENTORY_STATUS_SEARCH}    ${VALUE}

    Sleep    1s

    ${has_rows}=    Run Keyword And Return Status
    ...    Wait Until Page Contains Element
    ...    ${INVENTORY_STATUS_REPORT_TABLE_DATA} 
    ...    5s

    IF    ${has_rows}
        Log To Console     Results found for search: ${VALUE}

    ELSE
        Wait Until Page Contains    No Records Found    5s
        Log To Console     No Records Found for search: ${VALUE}

    END



    

    
Validate Report Search
    [Arguments]    ${SEARCH_INPUT}    ${ROWS_LOCATOR}    ${EMPTY_LOCATOR}    ${SEARCH_TEXT}

    Wait Until Keyword Succeeds    15s    2s
    ...    Check Report Search Result Loaded    ${ROWS_LOCATOR}    ${EMPTY_LOCATOR}

    ${no_data}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${EMPTY_LOCATOR}

    IF    ${no_data}
        Log To Console    ⚠ Table has no data, skipping search
        RETURN
    END

    # Step 2 — Perform search
    Wait Until Element Is Visible    ${SEARCH_INPUT}
    Clear Element Text              ${SEARCH_INPUT}
    Input Text                      ${SEARCH_INPUT}    ${SEARCH_TEXT}
    Sleep    1s

    # Step 3 — Validate search results
    ${rows}=    Get WebElements    ${ROWS_LOCATOR}
    ${count}=   Get Length         ${rows}
    Should Be True    ${count} > 0

    FOR    ${row}    IN    @{rows}
        ${text}=    Get Text    ${row}
        Should Contain    ${text.lower()}    ${SEARCH_TEXT.lower()}
    END

    Log To Console    ✅ Search '${SEARCH_TEXT}' validated
    

Check Report Search Result Loaded
    [Arguments]    ${ROWS_LOCATOR}    ${EMPTY_LOCATOR}

    ${empty}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${EMPTY_LOCATOR}

    ${rows}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${ROWS_LOCATOR}

    Should Be True    ${empty} or ${rows}




    












Open Tab And Verify
    [Arguments]    ${tab_locator}    ${expected_text}

    Scroll Element Into View    ${tab_locator}
    Wait Until Element Is Visible    ${tab_locator}    5s
    Click Element    ${tab_locator}
    Wait Until Page Contains    ${expected_text}    10s
    Log To Console    ${expected_text} Tab loaded successfully

Profit And Loss Cards
    Scroll Element Into View    ${PNL_TOP_CARD}
    Wait Until Element Is Visible   ${PNL_TOP_CARD}   5s
    Log To Console    PNL Top Card loaded successfully with all elements

    Scroll Element Into View  ${PNL_INCOME_EXPENSE_CARD}
    Wait Until Element Is Visible  ${PNL_INCOME_EXPENSE_CARD}   5s
    Log To Console    PNL Income Expense Card loaded successfully

    
    Scroll Element Into View  ${PNL_REPORT_CARD} 
    Wait Until Element Is Visible  ${PNL_REPORT_CARD}    5s
    Log To Console    PNL Report Card loaded successfully




Profit And loss Shimmer

    

    # Wait for shimmer to disappear
   

    #Wait Until Page Contains Element  ${PNL_INCOME_EXPENSE_CARD_SHIMMER}  1s
    #Wait Until Page Contains Element  ${PNL_REPORT_CARD_SHIMMER}  1s

    #Wait Until Page Does Not Contain Element   ${PNL_INCOME_EXPENSE_CARD_SHIMMER}  10s
    #Wait Until Page Does Not Contain Element   ${PNL_REPORT_CARD_SHIMMER}  10s
    

    Wait Until Element Is Visible   ${PNL_REPORT_CARD} 
    Log To Console    PNL cards loaded successfully
    Wait Until Element Is Visible   ${PNL_INCOME_EXPENSE_CARD}
    
    Log To Console    PNL Income Expense cards loaded successfully





    
    
Profit And Loss Update Cogs Button
    Scroll Element Into View    ${UPDATE_COGS_BTN}
    Wait Until Element Is Visible  ${UPDATE_COGS_BTN}  5s
    Click Element    ${UPDATE_COGS_BTN}
    Log To Console    Update Cogs button clicked successfully


Update Products Cogs Cards  
    Scroll Element Into View  ${TOTAL_PRODUCTS_CARD} 
    Wait Until Element Is Visible   ${TOTAL_PRODUCTS_CARD}   3s
    Log To Console     Total Products Card loaded successfully

    Scroll Element Into View   ${UPDATED_PRODUCTS_CARD}
    Wait Until Element Is Visible   ${UPDATED_PRODUCTS_CARD}  3s
    Log To Console     Updated Products Card loaded successfully

    Scroll Element Into View    ${REMAINING_PRODUCTS_TO_MAP_CARD}
    Wait Until Element Is Visible   ${REMAINING_PRODUCTS_TO_MAP_CARD}
    Log To Console     Remaining Products To Map Card loaded successfully



Map Product Cogs Card
    Scroll Element Into View    ${MAP_PRODUCT_COGS_CARD}
    Wait Until Element Is Visible    ${MAP_PRODUCT_COGS_CARD}    10s
    Log To Console     Map Product Cogs Card loaded successfully

    Wait Until Element Is Visible    ${MAP_PRODUCT_COGS_SEARCH}    10s
    Log To Console     Search field is visible

    Wait Until Element Is Visible    ${MAP_PRODUCT_COGS_UPLOAD_BTN}    10s
    Log To Console     Upload Report button is visible

    Wait Until Element Is Visible    ${MAP_PRODUCT_COGS_DOWNLOAD_BTN}    10s
    Log To Console     Download Report button is visible


    Scroll Element Into View   ${MAP_PRODUCT_COGS_TABLE}
    Wait Until Element Is Visible  ${MAP_PRODUCT_COGS_TABLE}
    Log To Console     Map Product Cogs Table is visible




   
   #-----Marketing----


#---marketing-Sponsored Brand---
Toggle Switch On
    [Arguments]    ${input_locator}

    ${container}=    Set Variable    ${input_locator}/parent::div

    Checkbox Should Not Be Selected    ${input_locator}
    Click Element                      ${container}

Click Toggle
    [Arguments]    ${mode}
    Run Keyword If    '${mode}'=='Group'      Click Element    ${GROUP_BUTTON}
    ...    ELSE IF    '${mode}'=='Ungroup'    Click Element    ${UNGROUP_BUTTON}
    Log To Console  Toggle clicked

Verify Page Load of Sponsored Brands 
    Wait Until Keyword Succeeds    25s    2s
    ...    Element Should Not Be Visible   ${SPONSORED_LOADING}

    Wait Until Element Is Visible    ${CHART_ELEMENTS}       20s
    Log To Console    WHOLE page fully loaded

Verify Page Load of Sponsored Product 
    Wait Until Keyword Succeeds    25s    2s
    ...    Element Should Not Be Visible   ${SPONSORED_LOADING}

    Wait Until Element Is Visible    ${CHART_ELEMENTS}       20s
    Log To Console    WHOLE page fully loaded

Verify Page Load of Sponsored Display 
    Wait Until Keyword Succeeds    25s    2s
    ...    Element Should Not Be Visible   ${SPONSORED_LOADING}

    Wait Until Element Is Visible    ${CHART_ELEMENTS}       20s
    Log To Console    WHOLE page fully loaded









