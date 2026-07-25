*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource   Sales_Keywords.robot

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

2.Validate Sales Navigation And Open Shipped Page 
    [Documentation]    Validate navigation to Sales module, open Shipped page from sidebar,
    ...                and verify MSC Intelligence popup 
    Open Page From Sidebar  ${SALES_LABEL}      Sales  
    Open Page From Sales    ${SHIPPED_LINK}    Shipped sub-menu visible on dashboard 

3.Verify Shipped Page 
    [Documentation]    Verify Shipped page is loaded successfully and user is redirected correctly
    ...                to the Sales section.
    Verify Page Load
    Log To Console   Shipped page fully loaded
    Wait Until Page Contains   Shipped Orders     10s
    wait Until Page Contains   Unlock sophisticated insights into sales, returns and orders via our dynamic table interface     10s
    Log To Console     Shipped page redirection successfully
    Select From Dropdown  ${COUNTRY}    India
    Select From Dropdown  ${MARKETPLACE}   Amazon.in
    Verify Page Load

# 4.Verify Date Filter
#     [Documentation]    Validate date filter functionality by selecting a specific date range and verifying page load.
#     ${date_filter}=    Set Variable    This Year
#     Set Suite Variable    ${DATE_FILTER}    ${date_filter}
#     Select Date Filter  ${DATE_FILTER_SECTION}   ${TODAY_DATE_FILTER_DROPDOWN}    ${date_filter}
#     Verify Compare Filter Selection    ${date_filter}
#     Verify Page Load

# 5.Verify Order ,Units,revenue Cards
#     [Documentation]    Validate the functionality of revenue, orders, order units, returns, and return units cards.
    
#     Verify KPI Card    Order        ${DATE_FILTER}
#     Verify KPI Card   Units         ${DATE_FILTER}
#     Verify KPI Card    Revenue    ${DATE_FILTER}

6.Verify Units Sold Graph And Average Selling Price Graph
    [Documentation]    Validate the functionality of Units Sold and Average Selling Price graphs.
       
    Validate Graph  ${UNITS_SOLD_GRAPH}  Units Sold
    Validate Graph  ${AVERAGE_SELLING_PRICE_GRAPH}  Average Selling Price
    
    
    

