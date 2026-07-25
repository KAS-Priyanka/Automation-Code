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

2.Validate Fulfillment Navigation And Verify Multi Channel Fulfilment Link Click 

    Open Page From Sidebar    ${FULFILLMENT_LABEL}  Fulfillment 
    Open Page From Fulfillment  ${MULTI_CHANNEL_FULFILMENT_LINK}     Multi Channel Fulfilment Link visible on dashboard

3.Verify Multi Channel Fulfilment Page load
    Verify Page Load
    Log To Console   Multi Channel Fulfilment page fully loaded
    Wait Until Page Contains     Multi Channel Fulfilment      10s
    Wait Until Page Contains   Import    5s
    Log To Console    Multi Channel Fulfilment page loaded successfully
 
4.Verify Import Orders
    Wait Until Page Contains  import  10s
    Wait Until Page Contains  MCF Form   5s
    
    Enter Text In Field    ${MERCHANT_FULFILLMENT_ORDER_ID}        ORD1001
    Enter Text In Field    ${DISPLAYABLE_ORDER_ID}                 DISP1001
    Enter Text In Field    ${DISPLAYABLE_ORDER_DATE}               03/04/2026
    #Select Dropdown Value  ${MERCHANT_SKU_DROPDOWN}                SKU001
    Enter Text In Field    ${QUANTITY_INPUT}                       2
    Enter Text In Field    ${MERCHANT_FULFILLMENT_ORDER_ITEM_ID}   ITEM001
    Enter Text In Field    ${GIFT_MESSAGE}                         Gift message
    Enter Text In Field    ${DISPLAYABLE_COMMENT}                  Comment
    Enter Text In Field    ${DISPLAYABLE_ORDER_COMMENT}            Order comment
    Enter Text In Field    ${PER_UNIT_DECLARED_VALUE}              200
    Select Dropdown Value  ${DELIVERY_SLA_DROPDOWN}                Standard
    Enter Text In Field    ${RECIPIENT_NAME_INPUT}                 Priyanka
    Enter Text In Field    ${ADDRESS_FIELD_ONE}                    Mumbai Street
    Enter Text In Field    ${ADDRESS_FIELD_TWO}                    Andheri
    Enter Text In Field    ${ADDRESS_FIELD_THREE}                  West
    Enter Text In Field    ${COUNTRY_CODE_INPUT}                   IN
    Enter Text In Field    ${STATE_CODE_INPUT}                     MH
    Enter Text In Field    ${CITY_INPUT}                           Mumbai
    Enter Text In Field    ${POSTAL_CODE_INPUT}                    400001
    Enter Text In Field    ${PHONE_NUMBER_INPUT}                   9876543210
    Enter Text In Field    ${NOTIFICATION_EMAIL_INPUT}             test@gmail.com
    Select Dropdown Value  ${FULFILLMENT_ACTION_DROPDOWN}          Ship
    Select Dropdown Value  ${CARRIER_PREFERENCES_DROPDOWN}         AllowAMZL
    Click Element          ${UPLOAD_BUTTON}
    sleep  time_=5s
    #Log To Console   Import Orders uploaded successfully
    Wait Until Page Contains   Merchant SKU is required.
    Log To Console   Validation message for missing Merchant SKU displayed successfully    
    

5.Verify New Orders Tab   
    Open Tab And Verify  ${NEW_ORDERS_TAB}    New Orders
    Verify Page Load
    Validate Tables  ${IMPORTED_ORDERS_TABLE}  Imported Orders Table
    Click Button  ${IMPORTED_ORDERS_TABLE_DOWNLOAD_BTN}   Imported Orders 


6.Verify In Process Tab
    Open Tab And Verify  ${IN_PROCESS_TAB}    In Process
    Verify Page Load
    Validate Tables  ${IN_PROCESS_ORDERS_TABLE_CARD}   In Process Orders Table
    Select And Validate Dropdown    ${IN_PROCESS_ORDERS_DROPDOWN}     Planning
   

7.Verify Tracking Details Tab
    Open Tab And Verify  ${TRACKING_TAB}     Tracking Details
    Verify Page Load
    Validate Tables  ${TRACKING_DETAILS_TABLE_CARD}   Tracking Details Table
    Select And Validate Dropdown    ${TRACKING_DETAILS_DROPDOWN}    CompletePartialled