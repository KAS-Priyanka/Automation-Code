*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Inventory_keyword.robot

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

2.Validate Inventory Navigation ,Open Dashboard Page and Verify MSC Intelligence
    [Documentation]    Open Dashboard page from Inventory sidebar and verify MSC Intelligence popup
    Open Page From Sidebar    ${INVENTORY_LABEL}  Inventory
    Open Page From Inventory  ${DASHBOARD_LINK}     Dashboard Link visible on dashboard
    Verify MSC Intelligence popup Open and Close
   


3.Verify Inventory Dashboard Page load
    [Documentation]    Verify Inventory Dashboard page is loaded successfully and user is redirected correctly
    Verify Page Load
    Log To Console   Dashboard page fully loaded
    Wait Until Page Contains      Inventory      10s
    Log To Console    Dashboard page loaded successfully
 
#Verify Date Range Picker For Dashboard Page
    #Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Yesterday
    #Verify Page Load
    Log To Console    Date range picker verified on dashboard page

4.Verify Inventory Cards
    [Documentation]    Verify No of SKUs, Inventory Units, and Inventory Value cards show correct values with proper currency format.
    Validate Cards  ${NO_OF_SKUS_CARD}  No of SKUs 
    Validate Cards   ${INVENTORY_UNITS_CARD}  Inventory Units 
    Validate Cards  ${INVENTORY_VALUE_CARD}  Inventory Value 
    Validate Revenue Currency From UI   ${COUNTRY}   ${INVENTORY_VALUE}


5.Verify Revenue Units VS Inventory Card
    [Documentation]    Verify Revenue vs Inventory graph loads correctly, dropdown selection updates data, and download works.
    Validate Graph   ${REVENUE_UNITS_VS_INVENTORY_CARD}   Revenue Units VS Inventory 
    Select Dropdown Option And Verify  ${REVENUE_UNITS_VS_INVENTORY_DROPDOWN}   11000511    ${REVENUE_UNITS_VS_INVENTORY_SHIMMER}     ${REVENUE_UNITS_VS_INVENTORY_CARD}     
    Click Button   ${REVENUE_UNITS_VS_INVENTORY_DOWNLOAD_BTN}  Revenue Units VS Inventory Download


6.Verify SKU WISE FBA Units Card
    [Documentation]    Verify SKU-wise FBA Units graph renders correctly and toggle switches between ascending and descending order.
    Validate Graph  ${SKU_WISE_FBA_UNITS_CARD_CANVAS}    SKU WISE FBA Units
    Asc And Desc Toggle   ${SKU_WISE_FBA_UNITS_TOGGLE}   SKU wise FBA Units toogle click  ${SKU_WISE_FBA_UNITS_CARD_CANVAS}


# 7.Verify SKU WISE FBM Units Card
#     [Documentation]    Verify SKU-wise FBM Units graph renders correctly and toggle switches sorting order.
#     Validate Graph  ${SKU_WISE_FBM_UNITS_CARD_CANVAS}   SKU WISE FBM Units 
#     Asc And Desc Toggle      ${SKU_WISE_FBM_UNITS_TOGGLE}      SKU wise FBM Units toogle click  ${SKU_WISE_FBM_UNITS_CARD_CANVAS}


8.Verify SKU Net Month Coverage
    [Documentation]    Verify SKU Net Month Coverage graph, dropdown selection (2 Month), toggle behavior, and report download functionality.
    Validate Graph  ${SKU_NET_MONTH_COVERAGE_CARD_CANVAS}   SKU Net Month Coverage 
    Click Button  ${SKU_NET_MONTH_COVERAGE_DOWNLOAD_BTN}  SKU Net Month Coverage Download Button

    Validate Dropdown Selection For Inventory
    ...    ${SKU_NET_MONTH_COVERAGE_DROPDOWN}
    ...    ${SKU_NET_MONTH_COVERAGE_DROPDOWN_POPUP}
    ...    2 Month
    ...    ${SKU_NET_MONTH_COVERAGE_SHIMMER}
    Asc And Desc Toggle    ${SKU_NET_MONTH_COVERAGE_TOGGLE}   SKU Net Month Coverage toogle click  ${SKU_NET_MONTH_COVERAGE_CARD_CANVAS}
     

9.Verify Inventory Distribution Coverage
    [Documentation]    Verify Inventory Distribution Coverage graph loads and displays correct distribution data.
    Validate Graph  ${INVENTORY_DISTRIBUTION_COVERAGE_CARD_CANVAS}  Inventory Distribution Coverage 


10.Verify FBA VS FBM
    [Documentation]    Verify FBA vs FBM comparison graph is displayed with correct data representation.
    Validate Graph  ${FBA_VS_FBM}   FBA VS FBM 


11.Verify Inventory Report
    [Documentation]    Verify Inventory Report table displays correct data and report download is successfully triggered.
    Validate Cards  ${INVENTORY_REPORT_CARD_TABLE}  Inventory Report 
    Click Button   ${INVENTORY_REPORT_DOWNLOAD_BTN}  Inventory Report Download button 
    Validate Tables  ${INVENTORY_REPORT_TABLE}  Inventory Report


12.Verify SKU Wise Week Of Coverage
    [Documentation]    Verify dropdown selection (2 Weeks) updates data and table correctly shows data or empty state.
    Validate Dropdown Selection For Inventory
    ...    ${SKU_WISE_WEEK_OF_COVERAGE_DROPDOWN}
    ...    ${SKU_WISE_WEEK_OF_COVERAGE_DROPDOWN_POPUP}
    ...    2 Weeks
    ...    ${SKU_WISE_WEEK_OF_COVERAGE_SHIMMER}

    Check Table Empty Or Data  ${SKU_WISE_WEEK_OF_COVERAGE_CARD_NO_DATA}   ${SKU_WISE_WEEK_OF_COVERAGE_CARD_DATA}