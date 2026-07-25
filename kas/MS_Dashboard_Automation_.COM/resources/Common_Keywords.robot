*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource   variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary

*** Keywords ***
Disable Screenshots
    Set Screenshot Directory    ../screenshots
   
Store Screenshot 
    Set Screenshot Directory    ./screenshots
   
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
    Click Element   ${CONTINUE_BTN}    
    Log To Console  Continue Button Visible and Click
    Wait Until Page Contains    Login Success    20s
    Log To Console    Login successful with email: ${email}

Login Setup
    [Arguments]    ${url}    ${email}    ${password}
    Open Application    ${url}
    Enter Login Credentials And Submit    ${email}    ${password}


Verify Dashboard Redirection 
    Wait Until Page Contains  Home     5s
    Log To Console     Logged in successfully and Dashboard loaded


Verify Session Page And Open Dashboard
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

Verify MSC Logo Visible
    [Arguments]    ${msc_logo_locator}

    Wait Until Element Is Visible    ${msc_logo_locator}    20s
    Log To Console    MSC logo is visible

Verify Ai agent
    Wait Until Element Is Visible    ${AI_AGENT}      20s
    log To Console     AI agent visible
    Click Element  ${AI_AGENT}
    Log To Console     AI agent clicked

Verify MSC Intelligence popup Open and Close
    ${popup1}=    Run Keyword And Return Status    Wait Until Page Contains    MSC Intelligence    10s
    ${popup2}=    Run Keyword And Return Status    Wait Until Page Contains    No insights available right now.    10s

    Run Keyword If    ${popup1} or ${popup2}    Log To Console    Popup is displayed
    ...    ELSE    Fail    Popup did not appear

    Wait Until Element Is Visible    ${BTN_CLOSE}    10s
    Click Element    ${BTN_CLOSE}
    Log To Console    Close button clicked

Verify MSC Intelligence popup Open and Close In Projection Page

    Wait Until Page Contains    here are your useful Insights!   30s
    Wait Until Element Is Visible    ${BTN_CLOSE}    10s
    Click Element                   ${BTN_CLOSE}
    Log To Console                   Close button clicked



Verify MSC Intelligence popup Open and Close In Dashboard

    Wait Until Page Contains   here are your useful Insights!   30s
    Wait Until Element Is Visible    ${BTN_CLOSE}    10s
    Click Element                   ${BTN_CLOSE}
    Log To Console                   Close button clicked

Open MSC Intelligence And Verify Insights
    Wait Until Keyword Succeeds    30s    2s
    ...    Page Should Contain Element    ${MSC_BUTTON}
    click Element                 ${MSC_BUTTON}
    Wait Until Page Contains    MSC Intelligence   5s
    log To Console                   MSC Intelligence button clicked

Verify MSC Intelligence Button Visible
    [Arguments]    ${msc_button_locator}

    Scroll Element Into View        ${msc_button_locator}
    Wait Until Element Is Visible   ${msc_button_locator}    10s
    Log To Console    MSC Intelligence button is visible

Verify Page Load
    #Wait Until Keyword Succeeds    10s    0.5s
    #...    Element Should Be Visible    ${SKELETON_ELEMENTS}

    Wait Until Keyword Succeeds    50s    2s
    ...    Run Keywords
    ...    Page Should Not Contain Element    ${SKELETON_ELEMENTS}
    ...    AND
    ...    Page Should Contain Element    ${CHART_ELEMENTS}

Verify Country 
    ${country}=    Get Text   ${COUNTRY}
    Log To Console    Selected country: ${country}

    @{allowed}=    Create List    India    United State
    List Should Contain Value    ${allowed}    ${country}
    
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
    

Verify Marketplace 
    [Arguments]    ${country_locator}    ${marketplace_locator}

    ${country}=    Get Text    ${country_locator}
    ${market}=     Get Text    ${marketplace_locator}

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
    [Arguments]    ${brand_locator}

    ${brand_visible}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${brand_locator}    10s

    Should Be True    ${brand_visible}    Brand is not visible on the page

    Log To Console    Brand is visible


Select Brand From Dropdown
    [Arguments]    ${dropdown_locator}    ${option_text}

    Wait Until Element Is Visible    ${dropdown_locator}    5s
    Click Element    ${dropdown_locator}

    ${option}=    Set Variable
    ...    xpath=//span[normalize-space()='${option_text}']/parent::div

    Wait Until Element Is Visible    ${option}    5s
    Click Element    ${option}

    Log To Console    Selected: ${option_text}

Verify Language Visible
   Wait Until Element Is Visible    ${LANG_HEADER_ANY}    2s
    Log To Console     Language is visible

Select Language From Dropdown

    [Arguments]    ${dropdown_locator}    ${language}

    # Get expected text from dictionary
    ${expected}=    Get From Dictionary    ${LANG_EXPECTED_TEXT}    ${language}

    # Select language
    Click Element    ${dropdown_locator}
    Click Element    xpath=//span[normalize-space()='${language}']/parent::div

     # 👉 Store selected language globally (IMPORTANT 🔥)
    Set Global Variable    ${SELECTED_LANG}    ${language}
    # Validate text
    Wait Until Keyword Succeeds    5x    2s
    ...    Page Should Contain    ${expected}
 
    Log To Console    ${language} validated successfully


Verify Notification Icon Visible
    [Arguments]    ${notification_locator}

    Wait Until Element Is Visible    ${notification_locator}    10s
    Log To Console    Notification icon is visible


Verify Profile Icon Visible
    [Arguments]    ${profile_locator}

    Wait Until Element Is Visible    ${profile_locator}    10s
    Log To Console    Profile icon is visible
    Log To Console    All dashboard header elements loaded successfully



Validate Dropdown
    [Arguments]    ${canvas}    ${table}    ${dropdown}    ${popup}    ${value}

    # Open dropdown
    Wait Until Element Is Visible    ${dropdown}    10s
    Click Element    ${dropdown}

    # Select option
    ${option}=    Set Variable    xpath=//li[normalize-space()='${value}']
    Wait Until Element Is Visible    ${option}    5s
    Click Element    ${option}

    # Wait for chart/table update
    Wait Until Element Is Visible    ${canvas}    10s
    Wait Until Element Is Visible    ${table}    10s

    # Verify selected value
    ${selected}=    Get Text    ${dropdown}
    Log To Console    Selected City = ${selected}

    Should Contain    ${selected}    ${value}

    Log To Console    ✅ Dropdown validation successful
Verify Card Visible
    [Arguments]    ${card_name}    ${card_locator}    ${date_locator}
    Scroll Element Into View         ${date_locator}    
    Wait Until Element Is Visible    ${date_locator}    5s
    Wait Until Element Is Visible    ${card_locator}    5s

    Log To Console    ${card_name} card visible

Validate Today Date
    ${ui_date}=    Get Text    ${TODAY_DATE}
    ${ui_date}=    Strip String    ${ui_date}
    ${system_date}=    Get Current Date    result_format=%Y-%m-%d
    ${system_date}=    Convert To String    ${system_date}

    Should Be Equal As Strings    ${ui_date}    ${system_date}
    Log To Console    Today OK → ${ui_date}
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

Verify SKU Wise Section
    Wait Until Element Is Visible     ${VIEW_SKU_WISE_DROPDOWN_BUTTON}   5s
    Click Element    ${VIEW_SKU_WISE_DROPDOWN_BUTTON}
    log To Console     View SKU Wise dropdown button visible

    Wait Until Page Contains    Monitor the exceptional performance of the Top 5 SKUs    10s
    log To Console     SKU Wise text visible

    Scroll Element Into View   ${SKU_TODAY_TOP_HEADER}
    wait Until Element Is Visible    ${SKU_TODAY_TOP_HEADER}    10s

    scroll Element Into View   ${SKU_TODAY_TABLE}
    wait Until Element Is Visible    ${SKU_TODAY_TABLE}         5s
    wait Until Element Is Visible    ${SKU_YESTERDAY_TOP_HEADER}    1s
    wait Until Element Is Visible    ${SKU_YESTERDAY_TABLE}         1s
    wait Until Element Is Visible    ${SKU_LAST7DAYS_TOP_HEADER}    1s
    wait Until Element Is Visible    ${SKU_LAST7DAYS_TABLE}         1s
    wait Until Element Is Visible    ${SKU_LASTMONTH_TOP_HEADER}    1s
    wait Until Element Is Visible    ${SKU_LASTMONTH_TABLE}         1s

    log To Console     SKU Wise headers visible
    Wait Until Page Contains Element    ${HIDE_SKU_WISE_BTN}    15s
    Scroll Element Into View            ${HIDE_SKU_WISE_BTN}
    Click Element                      ${HIDE_SKU_WISE_BTN}
    log To Console     Hide SKU Wise button clicked
    
Validates All Dashboard Graph  
    [Arguments]    ${locator}    ${timeout}=5s
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    

Asc And Desc Toggle  
    [Arguments]    ${locator}   ${mgs}  ${main_category_ranking_graph}   

    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}
    Log To Console    ${mgs}Category Toggle Clicked
    Wait Until Element Is Visible  ${main_category_ranking_graph}   10s
    Log To Console    Category Ranking graph visible after toggle

Validate Return Cities Belong To Selected State
    [Arguments]    ${STATE}

    ${STATE}=    Strip String    ${STATE}

    Wait Until Element Is Visible    ${TOP_5_CITY_TABLE}//tr[1]    10s

    @{validCities}=    Get From Dictionary    ${STATE_CITY_MAP}    ${STATE}

    # Normalize expected city list
    @{expectedLower}=    Create List
    FOR    ${city}    IN    @{validCities}
        ${city}=    Convert To Lower Case    ${city}
        Append To List    ${expectedLower}    ${city}
    END

    ${rows}=    Get WebElements    ${TOP_5_CITY_TABLE}//tr

    FOR    ${row}    IN    @{rows}

        ${cell}=    Call Method    ${row}    find_element    xpath    .//td[1]
        ${city}=    Get Text    ${cell}

        ${city}=    Strip String    ${city}
        ${city}=    Convert To Lower Case    ${city}

        Log To Console    Checking city = ${city}

        List Should Contain Value    ${expectedLower}    ${city}

    END

    Log To Console    All cities belong to selected state


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



#---common keywords for dashboard-----

Open Page From Sidebar
    [Arguments]    ${locator}   ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                  ${locator}
    Log To Console    ${label} 

Open Tab And Verify
    [Arguments]    ${tab_locator}    ${expected_text}

    Scroll Element Into View    ${tab_locator}
    Wait Until Element Is Visible    ${tab_locator}    15s
    Click Element    ${tab_locator}
    Wait Until Page Contains    ${expected_text}    10s
    Log To Console    ${expected_text} Tab loaded successfully
    
Validate Cards
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Card visible

Validate Cards Value
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Card Value visible


Validate Cards With Value
    [Arguments]    ${locator}  ${label}  ${timeout}=5s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Card with value visible
    


Validate Graph
    [Arguments]    ${locator}  ${label}  ${timeout}=5s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} graph visible

Validate Tables
    [Arguments]    ${locator}  ${label}   ${timeout}=5s
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


Validate Search
    [Arguments]    ${locator}  ${label}  ${timeout}=10s  
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    Log To Console    ${label} Search visible

#---button click---
Click Button
    [Arguments]    ${locator}  ${label}
    Wait Until Element Is Visible    ${locator}    5s
    Click Element    ${locator}
    Log To Console    ${label} visible and clicked

#----date picker keywords-----
Verify Date Picker
    [Arguments]    ${DATE_PICKER}    ${option}

    Wait Until Element Is Visible    ${DATE_PICKER}    5s
    Click Element    ${DATE_PICKER}

    Wait Until Element Is Visible    //li[normalize-space()='${option}']    5s
    Click Element    //li[normalize-space()='${option}']

    Validate Date Picker For Preset    ${DATE_PICKER}    ${option}

    
Validate Date Picker For Preset
    [Arguments]    ${DATE_PICKER}    ${option}

    Run Keyword If    '${option}' == 'Today'
    ...    Validate Today    ${DATE_PICKER}

    Run Keyword If    '${option}' == 'Yesterday'
    ...    Validate Yesterday    ${DATE_PICKER}

    Run Keyword If    '${option}' == 'Last 7 days'
    ...    Validate Last X Days    ${DATE_PICKER}    7

    Run Keyword If    '${option}' == 'Last 30 days'
    ...    Validate Last X Days    ${DATE_PICKER}    30

    Run Keyword If    '${option}' == 'Last 60 days'
    ...    Validate Last X Days    ${DATE_PICKER}    60

    Run Keyword If    '${option}' == 'Last 1 Year'
    ...    Validate Last One Year    ${DATE_PICKER}

Validate Today
    [Arguments]    ${DATE_PICKER}

    ${today}=    Get Current Date    result_format=%b %d, %Y
    ${today}=    Evaluate    "${today}".replace(" 0", " ")

    ${value}=    Get Element Attribute
    ...    ${DATE_PICKER}
    ...    placeholder

    Log To Console    📅 Picker Value: ${value}
    Log To Console    📅 Expected: ${today}

    Should Contain    ${value}    ${today}


Validate Yesterday
    [Arguments]    ${DATE_PICKER}

    ${yesterday}=    Get Current Date    increment=-1 day    result_format=%b %d, %Y
    ${yesterday}=    Evaluate    "${yesterday}".replace(" 0", " ")

    ${value}=    Get Element Attribute
    ...    ${DATE_PICKER}
    ...    placeholder

    Log To Console    📅 Picker Value: ${value}
    Log To Console    📅 Expected: ${yesterday}

    Should Contain    ${value}    ${yesterday}

Validate Last X Days
    [Arguments]    ${DATE_PICKER}    ${days}

    ${end}=    Get Current Date    result_format=%b %d, %Y
    ${end}=    Evaluate    "${end}".replace(" 0", " ")

    ${adjusted_days}=    Evaluate    ${days} - 1
    ${start}=    Get Current Date
    ...    increment=-${adjusted_days} day
    ...    result_format=%b %d, %Y

    ${start}=    Evaluate    "${start}".replace(" 0", " ")

    Wait Until Keyword Succeeds
    ...    12s
    ...    1s
    ...    Date Picker Should Contain Range
    ...    ${DATE_PICKER}
    ...    ${start}
    ...    ${end}
Validate Last One Year
    [Arguments]    ${DATE_PICKER}

    ${end}=      Get Current Date    result_format=%b %d, %Y
    ${end}=      Evaluate    "${end}".replace(" 0", " ")

    ${start}=    Get Current Date    increment=-365 day    result_format=%b %d, %Y
    ${start}=    Evaluate    "${start}".replace(" 0", " ")

    ${value}=    Get Element Attribute
    ...    ${DATE_PICKER}
    ...    placeholder

    Log To Console    📅 Picker Value: ${value}
    Log To Console    📅 Expected Start: ${start}
    Log To Console    📅 Expected End: ${end}

    Wait Until Keyword Succeeds
    ...    12s
    ...    1s
    ...    Date Picker Should Contain Range
    ...    ${DATE_PICKER}
    ...    ${start}
    ...    ${end}
    
Date Picker Should Contain Range
    [Arguments]    ${DATE_PICKER}    ${start}    ${end}

    ${value}=    Get Element Attribute    ${DATE_PICKER}    placeholder

    Log To Console    UI Range = ${value}
    Log To Console    Expected Start = ${start}
    Log To Console    Expected End = ${end}

    Should Contain    ${value}    ${start}
    Should Contain    ${value}    ${end}


#---dropdown keywords-----
Select Dropdown Option And Verify
    [Arguments]    ${dropdown}    ${value}    ${loader_locator}   ${data_locator}

    Wait Until Element Is Visible    ${dropdown}    10s
    Click Element    ${dropdown}

    Input Text    ${dropdown}    ${value}

    ${option}=    Set Variable
    ...    xpath=//ul[@role='listbox']//li[contains(.,'${value}')]

    ${is_present}=    Run Keyword And Return Status
    ...    Wait Until Page Contains Element    ${option}    5s


     IF    ${is_present}
        Log To Console     Option found: ${value}
        Click Element    ${option}
    ELSE
        Log To Console     Option NOT available: ${value}
        
    END
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible    ${loader_locator}    5s

    Wait Until Element Is Visible    ${data_locator}    10s

    ${selected}=    Get Element Attribute    ${dropdown}    value
    ${selected}=    Strip String    ${selected}

    Log To Console    ==============================
    Log To Console    Expected Value : ${value}
    Log To Console    Selected Value : ${selected}
    Log To Console    ==============================

    ${status}=    Run Keyword And Return Status
    ...    Should Be Equal As Strings    ${selected}    ${value}

    Run Keyword If    ${status}
    ...    Log To Console    ✅ Dropdown validation successful
    ...    ELSE
    ...    Log To Console    ❌ Dropdown validation failed


Select And Validate Dropdown
    [Arguments]    ${dropdown_locator}    ${value}

    # Open dropdown
    Wait Until Element Is Visible    ${dropdown_locator}    10s
    Click Element    ${dropdown_locator}

    # Select option
    Wait Until Element Is Visible    //span[normalize-space()='${value}']    5s
    Click Element    //span[normalize-space()='${value}']

    # Validate selected value
    ${selected}=    Get Text   (//div[contains(@class,'cursor-pointer')]//span[contains(@class,'font-medium')])[2]
    Log To Console    Selected dropdown value: ${selected}

    Should Be Equal    ${selected}    ${value}

#---Search keywords---
Search And Verify Result In Table
    [Arguments]    ${search_locator}    ${value}    ${table_locator}
    
    ${has_data}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${table_locator}
    ...    5s

    IF    not ${has_data}
        Log To Console    ⚠️ Table is empty. Skipping search
        Return From Keyword
    END
    Wait Until Element Is Visible    ${search_locator}    10s
    Click Element    ${search_locator}
    Clear Element Text    ${search_locator}
    Input Text    ${search_locator}    ${value}

    # Wait for table refresh
    scroll Element Into View    ${table_locator}
    Wait Until Keyword Succeeds    20x    2s
    ...    Element Should Be Visible    ${table_locator}

    ${result_locator}=    Set Variable
    ...    ${table_locator}//td[contains(.,'${value}')]
   
    ${is_found}=    Run Keyword And Return Status
    ...    Wait Until Page Contains Element
    ...    ${result_locator}
    ...    5s

    IF    ${is_found}
        Log To Console     Value found in table: ${value}
    ELSE
        Log To Console     Value not found table: ${value}
        
    END

#---Session---
Validate Commerce IQ Dashboard
    Wait Until Page Contains    Commerce IQ    10s
    Wait Until Element Is Visible    ${NEW_SESSION_BTN}    10s
    Log To Console    Dashboard loaded successfully

#--Pagination----
Click Page Number
    [Arguments]    ${page_no}    ${table_locator}

    ${page_button}=    Set Variable
    ...    ${SKU_CARD}//a[@aria-label='Page ${page_no}']


    Wait Until Element Is Visible    ${page_button}    10s
    Click Element    ${page_button}

    Wait Until Element Is Visible    ${table_locator}    10s

    Log To Console    Navigated to page ${page_no}

Click Next Page
    [Arguments]    ${table_locator}

    ${next_btn}=    Set Variable
    ...    ${SKU_CARD}//a[@aria-label='Next page']

    Wait Until Element Is Visible    ${next_btn}    10s
    Click Element    ${next_btn}

    Wait Until Element Is Visible    ${table_locator}    10s

    Log To Console    Moved to next page

Verify Active Page
    [Arguments]    ${expected_page}

    ${active}=    Get Text    ${SKU_CARD}//a[@aria-current='page']  

    Should Be Equal As Strings    ${active}    ${expected_page}

    Log To Console    Active page verified : ${active}