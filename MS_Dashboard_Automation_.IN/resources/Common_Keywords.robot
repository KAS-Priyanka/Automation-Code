*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource   variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary

*** Keywords ***
   
Open Application
    [Arguments]    ${url}
    Log To Console    Opening application: ${url}
    Open Browser    ${url}    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Wait Until Element Is Visible    ${PAGE_HEADING}    10s
    Log To Console    Application opened successfully.

Enter Login Credentials And Submit
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Input Text    ${EMAIL_INPUT}    ${email}
    Wait Until Element Is Visible    ${PASSWORD_INPUT}    10s
    Input Text    ${PASSWORD_INPUT}    ${password}
    Wait Until Element Is Not Visible    id=preloader    20s
    Wait Until Element Is Enabled    ${CONTINUE_BTN}    10s
    Click Element    ${CONTINUE_BTN}
    Log To Console    Clicked on Continue button.
    Wait Until Page Contains    Login Success    10s
    Log To Console    Login successful for user: ${email}

Login Setup
    [Arguments]    ${url}    ${email}    ${password}
    Open Application    ${url}
    Enter Login Credentials And Submit    ${email}    ${password}


Verify Dashboard Redirection
    [Arguments]    ${page_title}    ${page_description}

    Wait Until Page Contains    ${page_title}    10s
    Wait Until Page Contains    ${page_description}    5s
    Log To Console    User logged in successfully. Dashboard loaded successfully.



Verify MSC Logo Visible
    [Arguments]    ${logo_locator}
    Wait Until Element Is Visible    ${logo_locator}    20s
    Log To Console    MSC Logo is visible.

Verify Ai agent
    Wait Until Element Is Visible    ${AI_AGENT}      20s
    log To Console     AI agent visible
    Click Element  ${AI_AGENT}
    Log To Console     AI agent clicked


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

# Select Language From Dropdown

#     [Arguments]    ${dropdown_locator}    ${language}

#     # Get expected text from dictionary
#     ${expected}=    Get From Dictionary    ${LANG_EXPECTED_TEXT}    ${language}

#     # Select language
#     Click Element    ${dropdown_locator}
#     Click Element    xpath=//span[normalize-space()='${language}']/parent::div

#      #  Store selected language globally (IMPORTANT )
#     Set Global Variable    ${SELECTED_LANG}    ${language}
#     # Validate text
#     Wait Until Keyword Succeeds    5x    2s
#     ...    Page Should Contain    ${expected}
#     Log To Console    ${language} validated successfully


Verify Notification Icon
    [Arguments]    ${notification_locator}
    Wait Until Element Is Visible    ${notification_locator}    10s
    Click Element    ${notification_locator}
    Wait Until Page Contains    Notification    10s
    Log To Console    Notification popup opened successfully.
    Click Element     ${notification_locator}
    Wait Until Page Contains    Today    10s
    Log To Console    Notification popup closed successfully.

Verify Profile Icon Visible
    [Arguments]    ${profile_locator}
    Wait Until Element Is Visible    ${PROFILE_ICON}         2s
    log To Console     Profile icon visible
    Log To Console     All dashboard header elements loaded successfully

Select Date Filter
    [Arguments]    ${date_filter_panel}  ${today_date_filter}   ${date_filter}

    wait Until Element Is Visible    ${date_filter_panel}    10s
    Click Element   ${today_date_filter} 
    Wait Until Element Is Visible    //div[contains(@class,'shadow-lg')]//div[normalize-space()='${date_filter}']    10s
    Click Element    //div[contains(@class,'shadow-lg')]//div[normalize-space()='${date_filter}']
    Log To Console    Selected Date Filter: ${date_filter}

Verify Compare Filter Selection
    [Arguments]    ${date_filter}

    IF    '${date_filter}' == 'Today'
        Element Should Be Visible    xpath=(//span[normalize-space()='D']/ancestor::div[contains(@class,'bg-white')])[2]

    ELSE IF    '${date_filter}' == 'Last 7 Days'
        Element Should Be Visible    xpath=(//span[normalize-space()='W']/ancestor::div[contains(@class,'bg-white')])[2]

    ELSE IF    '${date_filter}' == 'This Month'
        Element Should Be Visible    xpath=(//span[normalize-space()='M']/ancestor::div[contains(@class,'bg-white')])[2]

    ELSE IF    '${date_filter}' == 'This Year'
        Element Should Be Visible    xpath=(//span[normalize-space()='Y']/ancestor::div[contains(@class,'bg-white')])[2]

    ELSE
        Fail    Invalid Date Filter: ${date_filter}
    END

    Log To Console    Compare filter verified for ${date_filter}
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
    Log To Console     Dropdown validation successful

Verify KPI Card
    [Arguments]    ${card_title}    ${date_filter}

    IF    '${date_filter}' == 'Today'
        ${compare_text}=    Set Variable    vs yesterday
    ELSE IF    '${date_filter}' == 'This Week'
        ${compare_text}=    Set Variable    vs last week
    ELSE IF    '${date_filter}' == 'This Month'
        ${compare_text}=    Set Variable    vs last month
    ELSE IF    '${date_filter}' == 'This Year'    
        ${compare_text}=    Set Variable    vs last year
    ELSE
        Fail    Invalid date filter: ${date_filter}
    END

    ${locator}=    Set Variable
    ...    //p[normalize-space()='${card_title}']/ancestor::div[contains(@class,'bg-background-light')][1][.//span[contains(@class,'headline-medium')] and .//div[contains(.,'%')] and .//span[contains(normalize-space(),'${compare_text}')]]
    Log To Console    ${card_title} card is visible.

    Page Should Contain Element    ${locator}
Verify Card 
    [Arguments]       ${card_locator}    ${card_name}
    Scroll Element Into View         ${card_locator}    
    Wait Until Element Is Visible    ${card_locator}    5s
    Log To Console    ${card_name} card visible

Verify Trend Card
    [Arguments]    ${date_filter}

    IF    '${date_filter}' == 'Today'
        ${trend_title}=    Set Variable    Hourly Trend
    ELSE IF    '${date_filter}' == 'This Week'
        ${trend_title}=    Set Variable    Weekly Trend
    ELSE IF    '${date_filter}' == 'This Month'
        ${trend_title}=    Set Variable    Monthly Trend
    ELSE IF    '${date_filter}' == 'This Year'
        ${trend_title}=    Set Variable    Yearly Trend
    ELSE
        Fail    Invalid date filter: ${date_filter}
    END

    Page Should Contain Element
    ...    //span[normalize-space()='${trend_title}']/ancestor::div[contains(@class,'rounded-2xl')][.//span[normalize-space()='Units sold'] and .//canvas][1]
    Log To Console    ${trend_title} card is visible.


Select Trend Dropdown
    [Arguments]    ${DATE_FILTER}    ${dropdown_value}

    IF    '${DATE_FILTER}' == 'Today'
        ${trend_title}=    Set Variable    Hourly Trend
    ELSE IF    '${DATE_FILTER}' == 'This Week'
        ${trend_title}=    Set Variable    Weekly Trend
    ELSE IF    '${DATE_FILTER}' == 'This Month'
        ${trend_title}=    Set Variable    Monthly Trend
    ELSE IF    '${DATE_FILTER}' == 'This Year'
        ${trend_title}=    Set Variable    Yearly Trend
    ELSE
        Fail    Invalid date filter: ${DATE_FILTER}
    END
    Click Element    //span[normalize-space()='${trend_title}']/ancestor::div[contains(@class,'rounded-2xl')][1]//div[contains(@class,'cursor-pointer')]
    Click Element    //li//span[normalize-space()='${dropdown_value}']
    Element Should Be Visible    //span[normalize-space()='${trend_title}']/ancestor::div[contains(@class,'rounded-2xl')][1]//span[normalize-space()='${dropdown_value}']

Verify Table Data Status
    [Arguments]    ${empty_locator}    ${table_locator}

    ${empty}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${empty_locator}
    ...    5s

    IF    ${empty}
        Log To Console    Table is EMPTY
    ELSE
        Wait Until Element Is Visible    ${table_locator}    7s
        Log To Console    Table has DATA
    END


Validates All Dashboard Graph  
    [Arguments]    ${locator}    ${timeout}=5s
    Scroll Element Into View    ${locator}
    Wait Until Element Is Visible    ${locator}    ${timeout}
    

Asc And Desc Toggle  
    [Arguments]    ${locator}   ${mgs}

    Wait Until Element Is Visible    ${locator}    10s
    Click Element    ${locator}
    Log To Console    ${mgs}Category Toggle Clicked


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
    Log To Console     Currency validated

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
    Wait Until Element Is Visible    ${tab_locator}    5s
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
        Log To Console     Table is EMPTY
    ELSE
        Wait Until Element Is Visible    ${table_locator}    7s
        Log To Console     Table has DATA
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

    Log To Console     Picker Value: ${value}
    Log To Console     Expected: ${today}

    Should Contain    ${value}    ${today}


Validate Yesterday
    [Arguments]    ${DATE_PICKER}

    ${yesterday}=    Get Current Date    increment=-1 day    result_format=%b %d, %Y
    ${yesterday}=    Evaluate    "${yesterday}".replace(" 0", " ")

    ${value}=    Get Element Attribute
    ...    ${DATE_PICKER}
    ...    placeholder

    Log To Console     Picker Value: ${value}
    Log To Console     Expected: ${yesterday}

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

    Log To Console     Picker Value: ${value}
    Log To Console     Expected Start: ${start}
    Log To Console     Expected End: ${end}

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
    ...    Log To Console     Dropdown validation successful
    ...    ELSE
    ...    Log To Console     Dropdown validation failed


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
        Log To Console     Table is empty. Skipping search
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