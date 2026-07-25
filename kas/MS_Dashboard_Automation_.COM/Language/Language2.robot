*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Language_Keywords.robot


Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup    https://dashboard.mysellercentral.com/sign-in  ketan.bhagwate@gmail.com   ++Pass@123
Suite Teardown   Close Browser



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
    Validate Selected Language  ${LANG_HEADER_ANY}  Spanish

3.Verify Sales Navigation ,Shipped Page With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Sales-> Shipped and MSC Intelligence Flow and language selection
    Open Page From Sidebar  ${SALES_LABEL}      Sales
    Open Page From Sales    ${SHIPPED_LINK}    Shipped sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
  Verify MSC Intelligence Button Visible    ${MSC_BUTTON}  
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Hindi

4.Verify Cancel Page With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Cancel page with MSC Intelligence Flow and language selection
    Open Page From Sales    ${CANCELLED_LINK}    Cancel sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close 
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Korean

# 5.Verify Returns Page With MSC Intelligence Flow And Language Selection
#     [Documentation]    Verify Returns page with MSC Intelligence Flow and language selection        
#     Open Page From Sales    ${RETURNS_LINK}     Returns sub-menu visible on dashboard
#     Verify MSC Intelligence popup Open and Close        
#    Verify MSC Intelligence Button Visible    ${MSC_BUTTON} 
#     Verify Page Load
#     Validate Selected Language  ${LANG_HEADER_ANY}  German

6.Verify Coupon Performance Page With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Coupon Performance page with MSC Intelligence Flow and language selection        
    Open Page From Sales   ${COUPON_LINK}   Coupon Performance sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close        
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  French

7.Verify Promotion Performance Page With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Promotion Performance Page with MSC Intelligence Flow and language selection        
    Open Page From Sales   ${PROMOTION_LINK}   Promotion Performance sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Italian


8.Verify Projection Page With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Projection page with MSC Intelligence Flow and language selection        
    Open Page From Sales  ${PROJECTION_LINK}   Projection sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close        
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Tamil

9.Verify Repeat-purchase Page With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Repeat-purchase page with MSC Intelligence Flow and language selection        
    Open Page From Sales  ${REPEAT_PURCHASE_ANALYSIS_LINK}   Repeat-purchase sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close        
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Kannada

# 10.Verify Inventory Navigation ,Dashboard Page With MSC Intelligence Flow And Language Selection
#     [Documentation]    Verify Dashboard Page page with MSC Intelligence Flow and language selection 
#     Open Page From Sidebar    ${INVENTORY_LABEL}  Inventory
#     Open Page From Inventory   ${DASHBOARD_LINK}   Dashboard Page sub-menu visible on  
#     Verify MSC Intelligence popup Open and Close        
#     Verify Page Load
#     Validate Selected Language  ${LANG_HEADER_ANY}  Malayalam


11.Verify Projection With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Projection Page page with MSC Intelligence Flow and language selection 
    Open Page From Inventory  ${INVENTORY_PROJECTION_LINK}   Projection sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close        
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Telugu

12.Verify Overview With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Overview Page page with MSC Intelligence Flow and language selection 
    Open Page From Sales  ${INVENTORY_OVERVIEW_LINK}   Overview sub-menu visible on dashboard
    Verify MSC Intelligence popup Open and Close        
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Bangla

13.Verify Suppressed listing With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Suppressed listingPage page with MSC Intelligence Flow and language selection 
    Open Page From Sales  ${INVENTORY_SUPPRESSED_LISTINGS_LINK}    Overview sub-menu visible on dashboard        
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}  Assamese

14.Verify Fulfillment-> Multi-channel Fulfillment With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Fulfillment page with MSC Intelligence Flow and language selection 
    Open Page From Sidebar  ${FULFILLMENT_LABEL}  Fulfillment
    Open Page From Fulfillment   ${MULTI_CHANNEL_FULFILMENT_LINK}   Multi-channel fulfillment sub-menu visible on dashboard
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}    Marathi

14.Verify Multi-channel Fulfillment With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Fulfillment page with MSC Intelligence Flow and language selection  
    Open Page From Sidebar  ${FULFILLMENT_LABEL}  Fulfillment
    Open Page From Fulfillment  ${FULFILLMENT_CENTER_LINK}   Multi-Center fulfillment sub-menu visible on dashboard     
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}   Gujarati

15.Verify Business page With MSC Intelligence Flow And Language Selection
    [Documentation]    Verify Business page with MSC Intelligence Flow and language selection        
    Open Page From Sidebar    ${BUSINESS_LINK}   Business
    Verify MSC Intelligence popup Open and Close        
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}
    Verify Page Load
    Validate Selected Language  ${LANG_HEADER_ANY}   Punjabi
    Validate Selected Language  ${LANG_HEADER_ANY}   Urdu
    Validate Selected Language  ${LANG_HEADER_ANY}   English


        


  

