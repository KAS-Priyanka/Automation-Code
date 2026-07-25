**** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource   Sales_Keywords.robot

Suite Setup    Run Keywords
...   Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup   https://dashboard.mysellercentral.com/sign-in  mayuresh.adititoys@gmail.com   ++Pass@123
Suite Teardown   Close Browser

*** Test Cases ***

1.Login And Verify Dashboard
    Verify Dashboard Redirection
    
2.Verify MSC Intelligence
    Verify MSC Intelligence popup Open and Close  
    Open MSC Intelligence And Verify Insights
    Verify MSC Intelligence popup Open and Close

3.Verify Dashboard Page Load
    Verify Page Load
    
4.Validate Sales Navigation
    Open Page From Sidebar  ${SALES_LABEL}      Sales label 

5.Verify Analysis Page  
    Open Page From Sales    ${ANALYSIS_LINK}    Analysis link 

6.Verify Analysis Page load

    Verify Page Load
    Log To Console   Analysis page fully loaded
    Wait Until Page Contains    Analysis Orders          10s
    Log To Console    Analysis page loaded successfully

    Wait Until Page Contains    Reports     10s
    Log To Console     Analysis page loaded successfully

7.Verify Analysis Graph

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






