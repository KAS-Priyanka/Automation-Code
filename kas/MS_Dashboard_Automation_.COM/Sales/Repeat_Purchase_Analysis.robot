**** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource     Sales_Keywords.robot

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
2.Validate Sales Navigation,Open Repeat Purchase Analysis Page and Verify MSC Intelligence
    [Documentation]    Validate navigation to Sales module, open Repeat Purchase Analysis from sidebar,
    ...                and verify MSC Intelligence popup 
    Open Page From Sidebar  ${SALES_LABEL}      Sales label
    Open Page From Sales   ${REPEAT_PURCHASE_ANALYSIS_LINK}       Repeat Purchase Analysis link visible on dashboard
    Verify MSC Intelligence popup Open and Close 
3.Verify Repeat Purchase Analysis Page 
    [Documentation]    Verify Repeat Purchase Analysis page is loaded successfully and user is redirected correctly
    ...                to the Sales section.
    Verify Page Load
    Wait Until Page Contains    Repeat Purchase Orders      10s
    Log To Console     Sales page loaded successfully
    Log To Console   Repeat Purchase Orders Page fully loaded

4.Verify Date Range Picker For Repeat Purchase Analysis Page
    [Documentation]    Validate date range picker functionality on Repeat Purchase Analysis page by selecting
    ...                predefined range (Last 1 Year) and verifying page load.
    Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}    Last 1 Year
    Verify Page Load


5.Verify Repeat Purchase Analysis Cards
    [Documentation]    Validate all summary cards on Repeat Purchase Analysis page including Total Orders, Unique Customers, Repeated Customers, Repeat Revenue,
    ...                and verify currency along with graph download functionality.
    Validate Cards  ${TOTAL_ORDERS_CARD}  Total Orders  
    Validate Cards Value  ${TOTAL_ORDERS_VALUE}  Total Orders Value

    Validate Cards   ${UNIQUE_CUSTOMER_CARD}  Unique Customers 
    Validate Cards Value  ${UNIQUE_CUSTOMER_VALUE}  Unique Customers Value 
    
    Validate Cards   ${REPEATED_CUSTOMER_CARD}   Repeat Revenue Value 
    Validate Cards Value  ${REPEATED_CUSTOMER_VALUE}  Repeated Customer Card 

    Validate Cards  ${REPEAT_REVENUE_CARD}   Repeat Revenue 
    Validate Cards Value  ${REPEAT_REVENUE_VALUE}  Repeat Revenue Value 

6.Verify Repeat Purchase Report
    [Documentation]    Validate Repeat Purchase Report table data and download functionality
    Validate Tables  ${REPEAT_PURCHASE_REPEAT_CARD}   Repeat Purchase Report 
    Click Button  ${REPEAT_PURCHASE_REPEAT_DOWNLOAD_BTN}  Repeat Purchase Report Downlaod button 
    Check Table Empty Or Data  ${REPEAT_PURCHASE_REPEAT_CARD_TABLE_EMPTY}     ${REPEAT_PURCHASE_REPEAT_CARD_TABLE_DATA}
    
    


  





    



