**** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource   Sales_Keywords.robot

Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup   https://dashboard.mysellercentral.com/sign-in  mayuresh.adititoys@gmail.com   ++Pass@123
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

2.Validate Sales Navigation ,Open Cancelled Page and Verify MSC Intelligence
    [Documentation]    Verify navigation to Sales → Cancelled page and MSC Intelligence visibility
    Open Page From Sidebar    ${SALES_LABEL}  Sales
    Open Page From Sales    ${CANCELLED_LINK}    Cancel sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close
    Verify MSC Intelligence Button Visible
       
3.Verify Cancelled Page Load
    [Documentation]    Verify Cancelled Orders page loads successfully.
    Verify Page Load
    Wait Until Page Contains      Cancelled Orders      10s
    Log To Console     Cancelled Orders page loaded successfully


4.Verify Date Range Picker For Cancel Page
    [Documentation]    Verify date range filter (Last 30 days) works correctly.
    Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}  Last 30 days
    Verify Page Load
    
5.Verify Cards
    [Documentation]    Validate summary cards on Cancelled page including Total Orders, Cancelled Orders,
    Validate Cards  ${CANCEL_TOTAL_ORDERS_CARD}   Total Orders Card Visible 
    Validate Cards Value  ${CANCEL_TOTAL_ORDERS_CARD_VALUE}  Total Orders

    Validate Cards   ${CANCEL_CANCELLED_ORDERS_CARD}      Cancelled Orders  
    Validate Cards Value   ${CANCEL_CANCELLED_ORDERS_CARD_VALUE}  Cancelled Orders 

    Validate Cards    ${CANCEL_QUANTITY_CARD}             Cancel Quantity  
    Validate Cards Value  ${CANCEL_QUANTITY_CARD_VALUE}  Cancel Quantity  
    
    Validate Cards    ${CANCEL_RATE_CARD}      Cancel Rate
    Element Should Contain    ${CANCELLATION_RATE_VALUE}    %
   
    Log To Console    All Cancel summary cards are visible

6.Verify Category Wise Cancel Graph
    [Documentation]    Validate Category Wise Cancelled Orders graph visibility and download functionality.

    Validate Graph  ${CATEGORY_WISE_CANCEL_GRAPH}    Cancelled Orders Graph visible on Cancelled page
    
    Click Button  ${CATEGORY_WISE_CANCEL_GRAPH_DOWNLOAD_BTN}      category wise cancel downlaod button visible and click
   
7.Verify Cancelled Order Reoprt   
    [Documentation]    Validate Cancelled Order Report table visibility and download functionality.
    Validate tables   ${CANCELLED_ORDER_REPORT}   Cancelled Orders Report
    Wait Until Page Contains   Cancelled Order Report     5s
    log To Console     Cancelled Orders Report visible on Cancelled page

    Click Button  ${CANCELLED_ORDER_REPORT_DOWNLOAD_BTN}  cancelled order report
    Log To Console  cancelled order report downlaod visible and click
   

8.Verify Cancelled Order Report SKU Wise
    [Documentation]    Validate Cancelled Order Report SKU Wise table visibility and download functionality.
    Wait Until Page Contains   Cancelled Order Report SKU Wise     5s
    Click Button  ${CANCELLED_SKU_WISE_TABLE_DOWNLOAD_BTN}  Cancelled Order Report SKU Wise downlaod 
    Check Table Empty Or Data    ${CANCELLED_SKU_WISE_EMPTY}  ${CANCELLED_SKU_WISE_Table}