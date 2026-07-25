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
5.Open Promotion Performance Page  
    Open Page From Sales   ${PROMOTION_LINK}    Promotion Performance link visible on dashboard

6.Verify MSC Intelligence on Promotion Performance Page
    Verify MSC Intelligence popup Open and Close
    Verify MSC Intelligence Button Visible

7.Verify Promotion Page Full loade
    Verify Page Load
    Log To Console     Promotion page fully loaded

#Verify Date Range Picker For Promotion Performance Page
    #Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Last 1 Year
    #Verify Page Load

8.Verify Promotion Performance Cards
    Wait Until Page Contains     Promotion Performance      10s
    Log To Console     Promotion Performance page loaded successfully

      
    Validate Cards  ${TOTAL_REVENUE_CARD}    Total Revenue 
    Validate Revenue Currency From UI        ${COUNTRY}       ${TOTAL_REVENUE_VALUE}

    Validate Cards    ${CONVERSION_RATE_CARD}    Conversion Rate
    Verify Percentage Symbol     ${CONVERSION_RATE_VALUE}   Conversion Rate

    Validate Cards  ${UNITS_SOLD_CARD}    Units Sold
    Log To Console     All cards are visible

#---- Deal Analysis Section Verification ----
9.Verify Deal Analysis Section

    Wait Until Page Contains   Deal Analysis      5s 
    Check Table Empty Or Data    ${DEAL_ANALYSIS_EMPTY}  ${DEAL_ANALYSIS} 
    #Click Button   ${DEAL_ANALYSIS_DOWNLOAD_BTN}   Deal Analysis download button 

10.Verify SKU Wise Analysis Section

    
    Wait Until Page Contains  Sku Wise Analysis      5s
   #Wait Until Element Is Visible    ${SKU_WISE_SORT_DROPDOWN}    5s
    #Click Element                   ${SKU_WISE_SORT_DROPDOWN}

   # Wait Until Element Is Visible    ${SKU_SORT_OPTION}          5s
    #Click Element                   ${SKU_SORT_OPTION}

    # ---- VERIFY selected value ----
    #Wait Until Element Is Visible    ${SKU_SELECTED_VALUE}      5s
    #Element Text Should Be          ${SKU_SELECTED_VALUE}    Revenue: High to Low
    #Log To Console    SKU Sort option selected successfully

   
   # --- Check EMPTY state ---
    Wait Until Page Contains  Sku Wise Analysis      5s
   
    Check Table Empty Or Data    ${SKU_EMPTY_STATE}   ${SKU_WISE_ANALYSIS}
    #Click Button   ${SKU_WISE_ANALYSIS_DOWNLOAD_BTN}   SKU Download button 