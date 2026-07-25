*** Settings ***
Resource   ../resources/Common_keywords.robot
Resource    ../resources/variables.robot
Library     SeleniumLibrary


Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup    https://dashboard.mysellercentral.com/sign-in   ketan.bhagwate@gmail.com   ++Pass@123
Suite Teardown   Close Browser

*** Test Cases ***

1.Verify Login ,Verify Dashboard,Verify MSC Intelligence
    [Documentation]    Verify successful login, dashboard redirection, MSC Intelligence popup functionality,
    ...                and validate insights along with page load.
    Verify Dashboard Redirection
    ...    Home
    ...    Unlock sophisticated insights into sales, returns and orders via our dynamic table interface
    Verify Page Load

2.Verify Dashboard Header Elements
    [Documentation]    Validate all header components such as logo, brand selection, country dropdown,
    ...                marketplace, language selection, notification icon, and revenue cards for multiple countries.

    Verify MSC Logo Visible    ${MSC_LOGO}
    Verify Country 
    Select From Dropdown  ${COUNTRY}    India
    Select From Dropdown  ${MARKETPLACE}   Amazon.in
    Select Brand From Dropdown  ${BRAND}  ALL PARTS SOURCE
    Verify Notification Icon  ${NOTIFICATION} 
    Verify Profile Icon Visible  ${PROFILE_ICON}

3.Verify Date Filter
    [Documentation]    Validate date filter functionality by selecting a specific date range and verifying page load.
    ${date_filter}=    Set Variable    This Year
    Set Suite Variable    ${DATE_FILTER}    ${date_filter}
    Select Date Filter  ${DATE_FILTER_PANEL}  ${TODAY_DATE_FILTER}   ${date_filter}
    Verify Compare Filter Selection    ${date_filter}
    Verify Page Load
4.Verify Revenue,Orders,Order Units,Returns and Return Units Cards
    [Documentation]    Validate the functionality of revenue, orders, order units, returns, and return units cards.
    
    Verify KPI Card    Revenue        ${DATE_FILTER}
    Verify KPI Card    Orders         ${DATE_FILTER}
    Verify KPI Card    Order Units    ${DATE_FILTER}
    Verify KPI Card    Returns        ${DATE_FILTER}
    Verify KPI Card    Return Units   ${DATE_FILTER}
4.Verify Trend Graph andTop 5 SKU
    Verify Trend Card  ${DATE_FILTER}
    Select Trend Dropdown
    ...    ${DATE_FILTER}
    ...    Revenue
    Check Table Empty Or Data
    ...    ${TOP5_SKUS_EMPTY_LOCATOR}
    ...    ${TOP5_SKUS_TABLE_LOCATOR}
5.Verify Revenue Report Graph 
    Validate Graph  ${REVENUE_REPORT_CARD}  Revenue Report

6.Verify Product Listing Status Graph And category Wise Sales Contribution Table
    Validate Graph  ${PRODUCT_LISTING_STATUS_CARD}  Product Listing Status
    Check Table Empty Or Data   ${CATEGORY_WISE_SALES_CARD_EMPTY_LOCATOR}    ${CATEGORY_WISE_SALES_CARD_TABLE_LOCATOR}  
   
7.Verify Account Health And Shipping Performance Cards
    Validate Graph  ${ACCOUNT_HEALTH_GRAPH}   Account Health
    Validate Tables  ${SHIPPING_PERFORMANCE_CARD}  Shipping Performance

8.Verify Policy Compliance And Customer Service Performance Cards
    Validate Tables   ${POLICY_COMPLIANCE_CARD}  Policy Compliance
    Validate Tables   ${CUSTOMER_SERVICE_PERFORMANCE_CARD}  Customer Service Performance