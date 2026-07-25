*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource    ../resources/variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary


*** Keywords ***

Select From Custom Dropdown for Business
    [Arguments]    ${dropdown_locator}    ${option_text}

    # Open dropdown
    Wait Until Element Is Visible    ${dropdown_locator}    10s
    Scroll Element Into View        ${dropdown_locator}
    Click Element                   ${dropdown_locator}

    # Build dynamic option locator
    ${option_locator}=    Set Variable
    ...    xpath=//ul//li[contains(@class,'filter-li')][.//span[normalize-space()='${option_text}']]


     # try normal wait first
    ${status}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${option_locator}    3s

    ${container}=    Get WebElement
    ...    xpath=//ul[contains(@class,'overflow')]

    ${found}=    Set Variable    False

    FOR    ${i}    IN RANGE    0    20
        ${visible}=    Run Keyword And Return Status
        ...    Page Should Contain Element    ${option_locator}

        IF    ${visible}
            Exit For Loop
        END

        Execute Javascript
        ...    arguments[0].scrollTop += 200
        ...    ${container}

        Sleep    0.3s
    END

    # Select option
    Wait Until Element Is Visible    ${option_locator}    10s
    Scroll Element Into View        ${option_locator}
    Click Element                   ${option_locator}

    # Validate selected value (generic span inside dropdown)
    ${selected}=    Get Text  ${dropdown_locator}

    Should Be Equal As Strings      ${selected}    ${option_text}

    Log To Console     Dropdown selected: ${option_text}


Verify Business Chart And Report Shimmer

    # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible    ${BUSINESS_CHART_SHIMMER}    3s
    Log To Console     Business Chart shimmer appeared

     # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible    ${STANDARD_REPORT_SHIMMER}    3s

   Log To Console     Report Chart shimmer appeared

    # wait until shimmer is gone
    Wait Until Page Does Not Contain Element
    ...    ${BUSINESS_CHART_SHIMMER}
    ...    25s
    Log To Console     Business Chart shimmer gone

    Run Keyword And Ignore Error
    ...    Wait Until Page Does Not Contain Element
    ...    ${STANDARD_REPORT_SHIMMER}
    ...    25s
    
    Log To Console     Reports shimmer gone

    # final chart must be present
    Wait Until Element Is Visible
    ...    ${BUSINESS_CHART_CARD}
    ...    20s

    Log To Console     Business Chart refreshed — shimmer cleared
   
    # final table/card must be present
    Wait Until Element Is Visible
    ...    ${STANDARD_REPORT_CARD}
    ...    20s

    Log To Console     Reports table refreshed


Week Wise Comparison Report Shimmer

    # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible   ${WEEK_WISE_COMPARISON_REPORT_SHIMMER}    3s
    Log To Console     Week Wise Comparison Report shimmer appeared

    # wait until shimmer is gone
    Wait Until Page Does Not Contain Element
    ...    ${WEEK_WISE_COMPARISON_REPORT_SHIMMER}
    ...    25s
    Log To Console     Week Wise Comparison Report shimmer gone

    # final table/card must be present
    Wait Until Element Is Visible
    ...    ${WEEK_WISE_COMPARISON_REPORT_CARD} 
    ...    20s

    Log To Console     Week Wise Comparison Report table refreshed

Time Sheet Shimmer
    # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible    ${SELECT_TIME_PERIOD_CARD_SHIMMER}     2s
    Log To Console     Selcect time Period Card shimmer appeared

     # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible   ${UNITS_SOLD_PER_HOURS_CARD_SHIMMER}     1s
   Log To Console     Unit Sold Per Hours Card shimmer appeared

    # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible    ${REVENUE_PER_HOUR_CARD_SHIMMER}   1s
   Log To Console     Revenue Per Hour Card shimmer appeared


    # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible    $${BUSINESS_TIME_SHEET_DATA_CARD_SHIMMER}     1s
   Log To Console     Business Time Sheet Data Card shimmer appeared

    # shimmer may appear briefly
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Visible   ${COMPARE_SALES_CARD_SHIMMER}    1s
   Log To Console     Compare Sales Card shimmer appeared

    # wait until shimmer is gone
    Wait Until Page Does Not Contain Element
    ...    ${SELECT_TIME_PERIOD_CARD_SHIMMER} 
    ...    5s
    Log To Console     Selcect time Period Card shimmer gone

    Run Keyword And Ignore Error
    ...    Wait Until Page Does Not Contain Element
    ...   ${UNITS_SOLD_PER_HOURS_CARD_SHIMMER} 
    ...    5s
    
    Log To Console    Unit Sold Per Hours Card shimmer gone

    Run Keyword And Ignore Error
    ...    Wait Until Page Does Not Contain Element
    ...    ${REVENUE_PER_HOUR_CARD_SHIMMER}
    ...    5s
    
    Log To Console     Revenue Per Hour Card shimmer gone

    Run Keyword And Ignore Error
    ...    Wait Until Page Does Not Contain Element
    ...    ${BUSINESS_TIME_SHEET_DATA_CARD_SHIMMER} 
    ...    5s
    
    Log To Console     Business Time Sheet Data Card shimmer gone


    Run Keyword And Ignore Error
    ...    Wait Until Page Does Not Contain Element
    ...    ${COMPARE_SALES_CARD_SHIMMER}
    ...    5s
    
    Log To Console     Compare Sales Card gone

    # final chart must be present
    Wait Until Element Is Visible
    ...    ${SELECT_TIME_PERIOD_CARD}
    ...    5s

    Log To Console     Selcect time Period Card refreshed — shimmer cleared
   
    # final table/card must be present
    Wait Until Element Is Visible
    ...   ${UNITS_SOLD_PER_HOURS_CARD} 
    ...    5s

    Log To Console     Unit Sold Per Hours Card table refreshed

     # final table/card must be present
    Wait Until Element Is Visible
    ...   ${REVENUE_PER_HOUR_CARD}
    ...    5s

    Log To Console     Revenue Per Hour Card table refreshed

 # final table/card must be present
    Wait Until Element Is Visible
    ...    ${BUSINESS_TIME_SHEET_DATA_CARD} 
    ...    5s

    Log To Console    Business Time Sheet Data Card e refreshed

 # final table/card must be present
    Wait Until Element Is Visible
    ...   ${COMPARE_SALES_CARD} 
    ...    5s

    Log To Console     Compare Sales Card refreshed


Download Profit And Loss Report
    [Arguments]    ${DOWNLOAD_BTN}    ${PDF_BTN}    ${CSV_BTN}

    Scroll Element Into View    ${DOWNLOAD_BTN}
    Wait Until Element Is Visible    ${DOWNLOAD_BTN}    5s
    Click Element    ${DOWNLOAD_BTN}

    Wait Until Element Is Visible    ${PDF_BTN}    5s
    Click Element    ${PDF_BTN}
    Log To Console     PDF download triggered

    Wait Until Element Is Visible    ${CSV_BTN}    5s
    Click Element    ${CSV_BTN}
    Log To Console     CSV download triggered


Update First SKU Cogs
    [Arguments]    ${value}

    Scroll Element Into View    ${FIRST_ROW_COGS_INPUT}
    Wait Until Element Is Visible    ${FIRST_ROW_COGS_INPUT}    5s

    Clear Element Text    ${FIRST_ROW_COGS_INPUT}
    Input Text    ${FIRST_ROW_COGS_INPUT}    ${value}

    Click Element    ${FIRST_ROW_UPDATE_BTN}

    ${updated_value}=    Get Element Attribute    ${FIRST_ROW_COGS_INPUT}    value  
    Should Be Equal    ${updated_value}    ${value}  
    Log To Console   ${updated_value}
    

    Log To Console    First SKU COGS successfully updated and validated to ${value}  
Go To Page
    [Arguments]    ${page_number}

    WHILE    True
        ${is_present}=    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    xpath=//ul[@role='navigation']//a[@aria-label='Page ${page_number}']

        IF    ${is_present}
            Click Element    xpath=//ul[@role='navigation']//a[@aria-label='Page ${page_number}']
            Log To Console     Navigated to page ${page_number}
            Exit For Loop
        ELSE
            Click Element    ${NEXT_BTN}
        END
    END




Click Next Page
    Wait Until Element Is Visible    ${NEXT_BTN}    5s
    Click Element    ${NEXT_BTN}
    Log To Console     Clicked Next


Click Previous Page
    Wait Until Element Is Visible    ${PREVIOUS_BTN}    5s
    Click Element    ${PREVIOUS_BTN}
    Log To Console     Clicked Previous


Validate Active Page
    [Arguments]    ${expected}

    ${current}=    Get Text    ${ACTIVE_PAGE}
    Should Be Equal    ${current}    ${expected}
    Log To Console     Active page is ${expected}
