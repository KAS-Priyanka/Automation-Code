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

5.Open Coupon Performance Page  
    Open Page From Sales    ${COUPON_LINK}    Coupon Performance link 

6.Verify MSC Intelligence on Coupon Performance Page
    Verify MSC Intelligence popup Open and Close
    Verify MSC Intelligence Button Visible

7.Verify Coupon Page load
    Verify Page Load
    Log To Console     Coupon page fully loaded
    Wait Until Page Contains     Coupons Performance      10s
    Log To Console     Coupon Performance page loaded successfully

#Verify Date Range Picker For Coupon Performance Page
   #Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Last 1 Year
    #Verify Page Load

8.Verify Coupon Performance Cards

    Validate Cards  ${COUPON_EXPIRING_CARD}   coupon Expiring Soon 
    Validate Cards    ${COUPONS_COUNT_CARD}   Coupon Count 
    Validate Cards    ${BUDGET_SPENT_CARD}   Budget Spent 
    Validate Revenue Currency From UI        ${COUNTRY}          ${BUDGET_SPENT_CARD_VALUE}
    Validate Cards    ${COUPONS_CONVERSION_CARD}   Coupons Conversion Rate 
    Validate Cards   ${COUPONS_ACTIVE_CARD}   Active Coupons 
    Validate Cards   ${COUPONS_CLICKS_CARD}   Coupons Clicks 
    Validate Cards    ${SALES_GENERATED_CARD}    Sales Generated card visible
    Validate Cards    ${ACOS_CARD}    ACoS card visible
    Verify Percentage Symbol   ${ACOS_CARD_VALUE}  ACoS
    Log To Console   All cards are visisble 


9.Verify List of Coupons Count

    Validate Tables  ${LIST_OF_COUPONS_COUNT}   List of Coupons 
    Validate Tables   ${LIST_OF_COUPONS_COUNT_TABLE}   List of Coupons Report 

10.Verify List Of Top Performing Coupons

    Scroll Element Into View       ${LIST_OF_TOP_PERFORMING_COUPONS_TITLE} 
    Wait Until Element Is Visible  ${LIST_OF_TOP_PERFORMING_COUPONS_TITLE}    5s
    Log To Console   Top Performing Coupons section visible
    Check Table Empty Or Data  ${LIST_OF_TOP_PERFORMING_COUPONS_EMPTY}     ${LIST_OF_TOP_PERFORMING_COUPONS_DATA}

11.Verify List Of Under Performing Coupons
    
    Scroll Element Into View         ${LIST_OF_UNDER_PERFORMING_COUPONS_TITLE} 
    Wait Until Element Is Visible    ${LIST_OF_UNDER_PERFORMING_COUPONS_TITLE}     10s
    Check Table Empty Or Data  ${LIST_OF_UNDER_PERFORMING_COUPONS_EMPTY}     ${LIST_OF_UNDER_PERFORMING_COUPONS_DATA}

12.Verify List Of Coupons Nearing Budget Limit
    
    Scroll Element Into View         ${LIST_OF_COUPONS_NEARING_BUDGET_LIMIT_TITLE}
    Wait Until Element Is Visible    ${LIST_OF_COUPONS_NEARING_BUDGET_LIMIT_TITLE}    10s
    Check Table Empty Or Data   ${LIST_OF_COUPONS_NEARING_BUDGET_LIMIT_EMPTY}     ${LIST_OF_COUPONS_NEARING_BUDGET_LIMIT_DATA}
   
13.Verify Coupons Expiring    
    Scroll Element Into View        ${COUPONS_EXPIRING_TITLE}
    Wait Until Element Is Visible   ${COUPONS_EXPIRING_TITLE}    10s
    Check Table Empty Or Data    ${COUPONS_EXPIRING_EMPTY}     ${COUPONS_EXPIRING_DATA}
   