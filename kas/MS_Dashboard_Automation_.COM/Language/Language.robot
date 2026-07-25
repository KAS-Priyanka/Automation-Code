*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Language_Keywords.robot


Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup    https://dashboard.mysellercentral.com/sign-in    mayuresh.adititoys@gmail.com    ++Pass@123

Suite Teardown   Close All Browsers


**** Test Cases ***

1.Verify Login ,Verify Dashboard And MSC Intelligence Flow
    [Documentation]  Verify login, dashboard redirection, MSC Intelligence popup open/close 
    Verify Dashboard Redirection
    Verify MSC Intelligence popup Open and Close  
    Open MSC Intelligence And Verify Insights
    Verify MSC Intelligence popup Open and Close

2.Verify Dashboard Page Load And Language Selection
    [Documentation]    Verify dashboard loads successfully and user can change language 
    Verify Page Load
    Select Language From Dropdown  ${LANG_HEADER_ANY}   Spanish
   
3.Verify Sales Navigation And Shipped Page With MSC Intelligence Flow
    [Documentation]    Verify Sales-> Shipped and MSC Intelligence Flow
    Open Page From Sidebar  ${SALES_LABEL}      Sales
    Open Page From Sales    ${SHIPPED_LINK}    Shipped sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible  
    Verify Page Load
    Validate Language On Other Page   ${SHIPPED}
    Validate Language On Other Page  ${FULFILMENT}
   

4.Verify Cancel Page With MSC Intelligence Flow
    [Documentation]    Verify Cancel and MSC Intelligence Flow
    Open Page From Sales   ${CANCELLED_LINK}     Cancel sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible  
    Verify Page Load
    Select Language From Dropdown For All Pages   ${LANG_HEADER_ANY}  Marathi
    Validate Language On Other Page   ${QUANTITY}
    

5.Verify Returns Page With MSC Intelligence Flow
    [Documentation]    Verify Returns and MSC Intelligence Flow
    Open Page From Sales   ${RETURNS_LINK}    Returns sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible  
    Verify Page Load
    Select Language From Dropdown For All Pages   ${LANG_HEADER_ANY}   Korean
    Validate Language On Other Page  ${UNITS}
    Validate Language On Other Page  ${CARRIER}

6.Verify Projection Page With MSC Intelligence Flow
    [Documentation]    Verify Projection and MSC Intelligence Flow
    Open Page From Sales   ${PROJECTION_LINK}     Projection sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible  
    Verify Page Load
    Select Language From Dropdown For All Pages   ${LANG_HEADER_ANY}   German
    Validate Language On Other Page    ${SUBMIT}

7.Verify Inventory Overview Page With MSC Intelligence Flow
    [Documentation]    Verify Inventory ->  Overview and MSC Intelligence Flow
    Open Page From Sidebar    ${INVENTORY_LABEL}  Inventory
    Open Page From Sales   ${INVENTORY_OVERVIEW_LINK}      Overview sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible  
    Verify Page Load
    Select Language From Dropdown For All Pages   ${LANG_HEADER_ANY}   Urdu
    Validate Language On Other Page  ${INVENTORY_HEALTH_DICT}
    




    