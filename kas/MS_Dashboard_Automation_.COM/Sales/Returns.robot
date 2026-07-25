**** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource   Sales_Keywords.robot

Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup    https://dashboard.mysellercentral.com/sign-in  ketan.bhagwate@gmail.com   ++Pass@123
Suite Teardown   Close Browser


*** Test Cases ***

1.Verify Login ,Verify Dashboard,Verify MSC Intelligence
    [Documentation]    Verify successful login, dashboard redirection, MSC Intelligence popup functionality,
    ...                and validate insights along with page load.
    Verify Dashboard Redirection
    Verify MSC Intelligence popup Open and Close  
    Open MSC Intelligence And Verify Insights
    Verify MSC Intelligence popup Open and Close
    Verify Page Load
   
2.Validate Sales Navigation,Open Returns Page and Verify MSC Intelligence
    [Documentation]    Validate navigation to Sales module, open Returns page from sidebar,

    Open Page From Sidebar  ${SALES_LABEL}      Sales label 
    Open Page From Sales    ${RETURNS_LINK}      Returns sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}

3.Verify Returns Page load
    [Documentation]    Verify Returns page is loaded successfully and user is redirected correctly
    Verify Page Load
    Log To Console   Returns page fully loaded
    Wait Until Page Contains     Return Orders          10s
    Log To Console     Returns page loaded successfully
 
4.Verify Date Range Picker For Return Page
    [Documentation]    Validate date range picker functionality on Returns page by selecting
    ...                predefined range (Last 1 Year) and verifying page load.    
    Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Last 7 days
    Verify Page Load

5.Verify Returns Cards

    Wait Until Page Contains     Return Orders          10s
    Log To Console     Returns page loaded successfully

    Validate Cards    ${RETURNS_TOTAL_CARD}   Number of Returns 
    Validate Cards Value  ${RETURNS_TOTAL_VALUE}       Number of Returns 

    Validate Cards    ${RETURNS_UNITS_CARD}  Unit 
    Validate Cards Value   ${RETURNS_UNITS_VALUE}     Unit 

    Validate Cards    ${RETURNS_TOTAL_AMOUNT_CARD}   Total Amount
    Validate Cards Value   ${RETURNS_TOTAL_AMOUNT_VALUE}      Total Amount

    Validate Cards    ${RETURNS_REFUND_RATE_CARD}  Refund Rate 
    Validate Cards Value  ${RETURNS_REFUND_RATE_VALUE}      Refund Rate
    
    Validate Cards     ${RETURNS_RETURN_RATE_CARD}  Returns Rate 
    Validate Cards Value   ${RETURNS_RETURN_RATE_VALUE}      Returns Rate 

    Log To Console     All Returns summary cards are visible

6.Verify State Wise Contribution Canvas
    [Documentation]
    Validate Dropdown
    ...    ${STATE_WISE_CONTRIBUTION_CANVAS}
    ...    ${TOP_5_CITY_TABLE}
    ...    ${STATE_WISE_CONTRIBUTION_DROPDOWN}
    ...    ${STATE_WISE_CONTRIBUTION_DROPDOWN_POPUP}
    ...    GA
    
    
7.Verify City Wise Contribution Canvas 
    [Documentation] 
    Validate Dropdown
    ...    ${CITY_WISE_CONTRIBUTION_CANVAS} 
    ...    ${TOP_5_SKU_TABLE} 
    ...    ${CITY_WISE_CONTRIBUTION_DROPDOWN}  
    ...    ${CITY_WISE_CONTRIBUTION_DROPDOWN_POPUP} 
    ...     PELZER

    
    Scroll Element Into View    ${TOP_5_CITY_TABLE}
    Wait Until Element Is Visible   ${TOP_5_CITY_TABLE}   5s

    Scroll Element Into View    ${TOP_5_SKU_TABLE}
    Wait Until Element Is Visible   ${TOP_5_SKU_TABLE}   5s
  

12.Validate Returns Cards   

    Wait Until Element Is Visible   ${ATOZ_CLAIM_CHART_CANVAS}  5s
    scroll Element Into View    ${ATOZ_CLAIM_CHART_CANVAS}
    Wait Until Page Contains   A to Z Claim     5s
    log To Console     A to Z Claim Reasons Graph visible on Returns page

   
    Wait Until Element Is Visible    ${PAID_BY_CHART_CANVAS}  5s
    scroll Element Into View    ${PAID_BY_CHART_CANVAS}
    Wait Until Page Contains   Label Paid By     5s
    log To Console     Paid By Graph visible on Returns page

   
    Wait Until Element Is Visible   ${CARRIER_CHART_CANVAS}      5s
    scroll Element Into View       ${CARRIER_CHART_CANVAS}
    Wait Until Page Contains    Carrier     5s
    log To Console     Carrier Graph visible on Returns page

    Wait Until Element Is Visible   ${MODE_OF_DELIVERY_CHART_CANVAS}    5s
    scroll Element Into View       ${MODE_OF_DELIVERY_CHART_CANVAS}
    Wait Until Page Contains   Mode Of Delivery    5s
    Log To Console     Mode of Delivery Graph visible on Returns page

13.Verify SKU Wise Report
    
    Validate Tables  ${RETURN_SKU_WISE_TABLE_WITH_COLUMNS}  Return SKU wise 
    Click Button   ${RETURN_SKU_WISE_TABLE_DOWNLAOD_BUTTON}    Return SKU table downlaod button


14.Verify Quality Feedback SKUS   
    Wait Until Page Contains   Quality feedback sku's     5s
    Check Table Empty Or Data  ${QUALITY_FEEDBACK_TABLE_EMPTY}    ${QUALITY_FEEDBACK_TABLE}

15.Verify Return Reason Graph    
    Validate Graph   ${RETURN_REASON_CANVAS}  Return Reason Chart
    Wait Until Page Contains  Return Reason     5s

16.Verify Category Wise Rerurn Graph   
    Validate Graph   ${CATEGORY_WISE_RETURN_CANVAS}   Category wise Return Chart
    Wait Until Page Contains  Category-wise Return        5s

17.Verify Return Orders Report 
    Validate Tables    ${RETURN_ORDERS_REPORT}  Return Orders Report 

    Wait Until Page Contains    Return Orders Report    5s
    Check Table Empty Or Data  ${RETURN_ORDERS_REPORT_TABLE_EMPTY}   ${RETURN_ORDERS_REPORT_TABLE_WITH_COLUMNS}
    Click Button  ${RETURN_ORDERS_REPORT_TABLE_DOWNLAOD_BUTTON}    Return Orders Report downlaod button
    Search And Verify Result In Table
    ...    ${RETURN_ORDER_REOPRT_SEARCH_INPUT} 
    ...   3357990
    ...    ${RETURN_ORDERS_REPORT_TABLE_WITH_COLUMNS}
    
    Log To Console     Download button clicked successfully

