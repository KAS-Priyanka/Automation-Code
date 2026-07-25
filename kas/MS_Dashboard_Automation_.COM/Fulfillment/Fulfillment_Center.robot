**** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Fulfillment_Keyword.robot

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

2.Validate Fulfillment Navigation

    Open Page From Sidebar    ${FULFILLMENT_LABEL}  Fulfillment
    Open Page From Fulfillment  ${FULFILLMENT_CENTER_LINK}    Fulfillment Center Link visible on dashboard
    #Verify MSC Intelligence popup
    #Verify MSC Intelligence Button Visible


4.Verify Fulfillment Center Page load
    Verify Page Load
    Log To Console   Fulfillment Center page fully loaded
    Wait Until Page Contains      Fulfillment Center      10s
    Log To Console    Fulfillment Center page loaded successfully
 

#Verify Date Range Picker For Fulfillment Center Page

    #Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Last 1 Year
    #Verify Page Load
    

5.Verify Fulfillment Center Cards
    # Wait for loader if present
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible
    ...    xpath=//div[contains(@class,'loader')]
    ...    20s

    # Wait for skeleton/shimmer loader
    Run Keyword And Ignore Error
    ...    Wait Until Element Is Not Visible
    ...    xpath=//*[contains(@class,'skeleton') or contains(@class,'shimmer')]
    ...    30s

    Validate Cards  ${CANCELED_CARD}  Canceled 
    Validate Cards   ${PENDING_CARD}  Pending 
    Validate Cards  ${SHIPPED_CARD}  Shipped 

6.Verify New Orders Table
    
    Check Table Empty Or Data  ${NEW_ORDERS_TABLE_EMPTY}    ${NEW_ORDERS_TABLE_DATA}
    Search And Validate  ${SEARCH_BOX}   S02-6437131-2191131     ${RESULT_TEXT}    ${NEW_ORDERS_TABLE_EMPTY}   ${EMPTY_SEARCH_NEW_ORDERS}
7.Verify In Process
    Open Tab And Verify  ${IN_PROCESS_TAB}    In Process
    Wait Until Element Is Not Visible  xpath=//div[contains(@class,'loader')]  10s
    Wait Until Element Is Not Visible   xpath=//*[contains(@class,'skeleton') or contains(@class,'shimmer')]   10s
    Validate Tables  ${MULTI_CHANNEL_IN_PROCESS_ORDERS_TABLE_CARD}   In Process Orders 


8.Verify Tracking Details
    Open Tab And Verify  ${TRACKING_TAB}     Tracking Details
    Wait Until Element Is Not Visible   xpath=//div[contains(@class,'loader')]   10s
    Wait Until Element Is Not Visible    xpath=//*[contains(@class,'skeleton') or contains(@class,'shimmer')]    10s
    Validate Tables  ${MULTI_CHANNEL_COMPLETED_ORDERS_TABLE_CARD}   Completed Orders
    Check Table Empty Or Data  ${MULTI_CHANNEL_COMPLETED_ORDERS_TABLE_EMPTY}    ${MULTI_CHANNEL_COMPLETED_ORDERS_TABLE_DATA} 
    Search And Validate  ${SEARCH_BOX}   403-4606308-4193149    ${RESULT_TEXT}      ${MULTI_CHANNEL_COMPLETED_ORDERS_TABLE_EMPTY}  ${EMPTY_SEARCH_Tracking Details}

