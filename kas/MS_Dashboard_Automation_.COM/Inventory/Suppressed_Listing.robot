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

2.Validate Inventory Navigation ,Open Suppressed Listings page Page and Verify MSC Intelligence
    [Documentation]    Open Suppressed Listings page from Inventory sidebar and verify MSC Intelligence popup 
       
    Open Page From Sidebar    ${INVENTORY_LABEL}  Inventory
    Open Page From Inventory  ${INVENTORY_SUPPRESSED_LISTINGS_LINK}    Suppressed Listings Link visible on dashboard

#Verify MSC Intelligence
    #Verify MSC Intelligence popup
    # Verify MSC Intelligence Button Visible


3.Verify Suppressed Listing Page load
    [Documentation]    Verify Suppressed Listing page is loaded successfully and user is redirected correctly
    Verify Page Load
    Log To Console  Suppressed Listing page fully loaded
    Wait Until Page Contains      Suppressed Listings      10s
    Log To Console    Suppressed Listing page loaded successfully

#Verify Date Range Picker For Suppressed Listings Page

    #Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Last 30 days
    #Verify Page Load


4.Verify Suppressed Listing Cards
    [Documentation]  Verify Total Suppressed Listings, Inventory Quantity, and Loss of Sales cards display correct data.
    Validate Cards  ${TOTAL_SUPRESSED_LISTINGS_CARD}   Total Supressed Listings 

    Validate Cards   ${INVENTORY_QUANITY_CARD}  Inventory Quanity

    Validate Cards  ${LOSS_OF_SALES_CARD}   Loss of Sales 

5.Verify Suppressed Reasons Graph
    [Documentation]  Validate Suppressed Reasons graph displays correct data and is visible on the page.
    Validate Graph  ${SUPRESSED_REASONS_GRAPH}  Suppressed Reasons 

6.Verify Suppressed Listing Report Card
    [Documentation]  Validate Suppressed Listing Report card is visible and download functionality works.
    Validate Tables  ${SUPRESSED_LISTINGS_REPORT_CARD}    Suppressed Listing report 
    Click Button  ${SUPRESSED_LISTINGS_REPORT_DOWNLOAD_BTN}  Suppressed Listing Report Download
    Suppressed Listing Report Card

  