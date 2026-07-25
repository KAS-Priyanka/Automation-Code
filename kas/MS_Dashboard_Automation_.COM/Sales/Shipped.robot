*** Settings ***
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
   
2.Validate Sales Navigation,Open Shipped Page and Verify MSC Intelligence
    [Documentation]    Validate navigation to Sales module, open Shipped page from sidebar,
    ...                and verify MSC Intelligence popup 
    Open Page From Sidebar  ${SALES_LABEL}      Sales  
    Open Page From Sales    ${SHIPPED_LINK}    Shipped sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}

3.Verify Shipped Page 
    [Documentation]    Verify Shipped page is loaded successfully and user is redirected correctly
    ...                to the Sales section.
    Verify Page Load
    Log To Console   Shipped page fully loaded
    Wait Until Page Contains     Sales      10s
    Log To Console     Sales page redirection successfully

4.Verify Date Range Picker For Shipped Page
    [Documentation]    Validate date range picker functionality on Shipped page by selecting
    ...                predefined range (Last 1 Year) and verifying page load.

    Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Last 1 Year
    Verify Page Load
  
5.Verify Shipped Cards
    [Documentation]    Validate all summary cards on Shipped page including Order, Units, Revenue,
    ...                and verify currency along with graph download functionality.
    Validate Cards  ${ORDER_CARD}    Order 
    Validate Cards    ${UNITS_CARD}    Units 
    Validate Cards    ${REVENUE_CARD}    Revenue 
    Validate Revenue Currency From UI        ${COUNTRY}   ${REVENUE_CARD_VALUE}

    Validate Cards   ${UNITS_SOLD_VS_AVERAGE_SELLING_PRICE_GRAPH}     Units Sold Vs Average Selling Price Graph visible on Shipped page
    Click Button  ${UNITS_SOLD_VS_AVERAGE_SELLING_PRICE_GRAPH_DOWNLOAD_BTN}  Units Sold Vs Average Selling Price Graph download

6.Verify Units Sold VS Average Selling Price Graph
    [Documentation]    Validate Units Sold vs Average Selling Price graph and verify dropdown selection
    ...                updates graph data correctly.
    Validate Graph    ${UNITS_SOLD_VS_AVERAGE_SELLING_PRICE_GRAPH}  Units Sold VS Average Selling Price
    Select Dropdown Option And Verify   ${UNITS_SOLD_VS_AVERAGE_SELLING_PRICE_GRAPH_DROPDOWN}  11000502 L  ${UNITS_GRAPH_SHIMMER}  ${UNITS_SOLD_VS_AVERAGE_SELLING_PRICE_GRAPH}  
    
7.Verify Day Of Week Chart
    [Documentation]    Validate Day of Week chart and ensure dropdown selection updates data correctly.
    Validate Cards     ${DAY_OF_WEEK_CHART}  Day Of Week
    Select Dropdown Option And Verify    ${DAY_OF_WEEK_DROPDOWN}    11005800   ${DAY_OF_WEEK_SHIMMER}  ${DAY_OF_WEEK_CHART}
   
8.Verify Period of day chart
    [Documentation]    Validate Period of day chart and ensure dropdown selection updates data correctly.
    Validate Cards      ${PERIOD_OF_DAY_CHART}  Verify Period of day
    Select Dropdown Option And Verify   ${PERIOD_OF_DAY_DROPDOWN}   11000511  ${PERIOD_OF_DAY_SHIMMER}  ${PERIOD_OF_DAY_CHART} 

9.Verify Top SKU section
    [Documentation]    Validate Top SKU section including dropdown functionality for state-wise contribution
    ...                and verify correct data is displayed for selected state.
   Validate Dropdown
    ...    ${SHIPPING_STATE_WISE_CONTRIBUTION_CANVAS} 
    ...    ${SHIPPING_TOP_5_CITY_TABLE} 
    ...    ${SHIPPING_TOP_5_STATE_DROPDOWN} 
    ...    ${SHIPPING_TOP_5_STATE_DROPDOWN_POPUP} 
    ...      SC

10.Verify City Wise Contribution Section
    [Documentation]    Validate city-wise contribution section including SKU table and dropdown
    ...                selection for city filtering.
    Validate Dropdown
    ...    ${SHIPPING_CITY_WISE_CONTRIBUTION_CANVAS}
    ...    ${SHIPPING_TOP_5_SKU_TABLE}
    ...    ${SHIPPING_TOP_5_SKU_DROPDOWN}
    ...    ${SHIPPING_TOP_5_SKU_DROPDOWN_POPUP}
    ...    LA PAZ

    
11.Validate Shipped Graph
    [Documentation]    Validate all shipped page graphs including Prime User, Business User,
    ...                Shipping Performance, Fulfillment Type, and SKU Wise Performance report.
    Validate Graph    ${PRIME_USER_CHART}     Prime User
    Wait Until Page Contains  Prime User       5s   

    Validate Graph  ${BUSINESS_USER_CHART}   Business User 
    Wait Until Page Contains    Business User       5s
       
    Validate Graph   ${SHIPPING_SERVICES_CHART_CARD}     Shipping Performance 
    Wait Until Page Contains    Shipping Services        5s
         
    Validate Graph  ${FULFILMENT_CHART_CARD}    Fulfillment Type 
    Wait Until Page Contains    Fulfillment       5s

    Validate tables  ${SKU_WISE_PERFORMACE_REPORT}  SKU Wise Performance Report 
    Wait Until Page Contains    SKU Wise Performance Report       5s

12.Validate SKU Wise Performance Report
    [Documentation]    Validate SKU Wise Performance report including download functionality,
    ...                pagination, and table verification.
    
    Click Button  ${SKU_WISE_PERFORMACE_REPORT_DOWNLOAD_BTN}  SKU Wise Performance Report download 
    Validate Tables  ${SKU_WISE_PERFORMACE_REPORT}   SKU Wise Performance Report table after download
    Click Page Number    2   ${SKU_WISE_PERFORMACE_REPORT}
    Verify Active Page    2
    Click Next Page    ${SKU_WISE_PERFORMACE_REPORT}
 

13.Validate Shipped Order Reports
    [Documentation]    Validate Shipped Order Report table including search functionality, [Documentation]    Validate Shipped Order Reports including table visibility, download functionality,
    ...                and search verification within the report.    
    Validate tables  ${SHIPPING_ORDER_REOPRT}  Shipping Order Report 
    Wait Until Page Contains    Shipped Order Reports       5s
    Click Button  ${SHIPPING_ORDER_REOPRT__DOWNLOAD_BTN}  shipping order download button
    Search And Verify Result In Table
    ...    ${SHIPPING_ORDER_REOPRT_SEARCH_INPUT}
    ...  38801301
    ...    ${SHIPPING_ORDER_REOPRT}
    



