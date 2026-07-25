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
   
2.Validate Sales Navigation,Open Analysis and Verify MSC Intelligence
    [Documentation]    Validate navigation to Sales module, open Shipped page from sidebar,
    ...                and verify MSC Intelligence popup 
    Open Page From Sidebar  ${SALES_LABEL}      Sales label   
    Open Page From Sales    ${ANALYSIS_LINK}    Analysis link 
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}

3.Verify Analysis Page load

    Verify Page Load
    Log To Console   Analysis page fully loaded
    Wait Until Page Contains    Analysis Orders          10s
    Log To Console    Analysis page loaded successfully
    Wait Until Page Contains    Reports     10s
    Log To Console     Analysis page loaded successfully

4.Verify Analysis Graph

    Click Button    ${WEEKY_SALES_ANALYSIS_PDF_DOWNLOAD}   Weekly Sales Analysis PDF Download button 
    Wait Until Page Contains    Overall Sales Analysis    5s
    Validate Graph   ${UNITS_SOLD_CHART}     Units Sold 
    Validate Graph   ${REVENUE_CHART}  Revenue 
    Validate Graph    ${ANALYSIS_DAY_OF_WEEK_CHART}     Day of the Week Chart visible
    Wait Until Page Contains   Day of the week / Period of the day Mapping    5s
    Validate Graph    ${ANALYSIS_PERIOD_OF_DAY_CHART}   Period of the Day 
    Validate Graph     ${OVERALL_WEEKLY_REVENUE/_INVENTORY_CHART}   Overall Weekly Revenue/Inventory
    Page Should Contain    Overall Weekly Revenue Analysis / Inventory Mapping  
    Validate Graph     ${STATE_WISE_TOP_CONTRIBUTORS_CHART}  State Wise Top Contribution 
    Page Should Contain  Region Wise Top Contributors 
    Validate Graph     ${CITY_WISE_TOP_CONTRIBUTORS_CHART}   City Wise Top Contribution 
    Validate Graph   ${CANCELLED_SKUS_CHART}   Cancelled SKUs 
    Wait Until Page Contains   Top 5 Cancelled SkUs / Return Skus    5s
    Validate Graph  ${RETURNED_SKU_CARD}  retured SKU
    Wait Until Page Contains    Weekly Report Summary  5s
    Validate Graph  ${ANALYSIS_SUMMARY_CARD}    Analysis Summary 






