*** Settings ***
Library     SeleniumLibrary
Resource    ./resources/Ai_agents_Variables.robot
Resource    ./resources/Ai-agents_Keywords.robot
    
Suite Setup    Run Keywords
...    Disable Screenshots
...    AND
...    Login Setup    https://test-uat.mysellercentral.com/ai-agents/    mayuresh.adititoys@gmail.com    ++Pass@123

Suite Teardown   Close Browser


*** Test Cases ***

1.Verify Login And AI-agents Page Redirection
    Wait Until Page Contains   AI Agents   5s
    Log To Console     AI Agent page loaded successfully

2.Verify MarketPlaces
    Check Marketplaces   ${MARKETPLACES_BTN}     marketplaces visible successfully

3.Verify Recharge Wallet Page
    [Documentation]    Validate wallet balance, open recharge wallet page, and verify available balance and UI elements
    
    ${wallet}=  Verify Wallet Section   ${WALLET_LABEL}   ${WALLET_VALUE}
    Click Button    ${ADD_BUTTON}    Add button
    Wait Until Page Contains    Recharge Wallet    5s
    Log To Console    Navigated to Recharge Wallet page successfully
    
    Verify Available Balance With Wallet
    ...    ${AVAILABLE_BALANCE}
    ...    ${wallet}
    Verify Recharge Wallet Elements


4.Verify Payment History   
    [Documentation]    Verify payment history page, validate records, and check receipt functionality
    Click Button  ${PAYMENT_HISTORY_BTN}   Payment History
    Wait Until Page Contains   Wallet Payment History    5s
    Log To Console    Payment history is displayed successfully
    Check Wallet History Empty Or Data  ${PAYMENT_HISTORY_EMPTY}  ${PAYMENT_HISTORY_WITH DATA}
    Click Button  ${RECEIPT_BUTTON}  Receipt button

5.Verify Payment Cancel
    [Documentation]    Validate wallet balance, recharge wallet flow, and cancel functionality
    ${wallet}=  Verify Wallet Section   ${WALLET_LABEL}   ${WALLET_VALUE}
    Click Button    ${ADD_BUTTON}    Add button
    Wait Until Page Contains    Recharge Wallet    5s
    Log To Console    Navigated to Recharge Wallet page successfully
    
    Verify Available Balance With Wallet
    ...    ${AVAILABLE_BALANCE}
    ...    ${wallet}
    Verify Recharge Wallet Elements

    Click Button  ${CANCEL_BUTTON}  cancel 
    Wait Until Page Contains   Wallet History   5s
    Log To Console  payment cancel Successfully

6.Verify Payment Submit
    [Documentation]    Verify wallet recharge flow, enter amount, make payment, and validate total amount
    ${wallet}=  Verify Wallet Section   ${WALLET_LABEL}   ${WALLET_VALUE}

    Click Button    ${ADD_BUTTON}    Add button
    Wait Until Page Contains    Recharge Wallet    5s
    Log To Console    Navigated to Recharge Wallet page successfully
    
    Verify Available Balance With Wallet
    ...    ${AVAILABLE_BALANCE}
    ...    ${wallet}
    Verify Recharge Wallet Elements
    
    ${input_value}=    Enter Wallet Amount    100

    Click Button    ${MAKE_PAYMENT_BUTTON}  make payment
    Wait Until Page Contains    Processing    5s
    Enter Contact Details      8668937436
   
    Verify Input Amount With Total Amount
    ...    ${TOTAL_AMOUNT} 
    ...    ${input_value}

7.Close Razorpay And Cancel Payment
    [Documentation]    Cancel Razorpay payment, close wallet flow, and return to AI Agents page
    Click Element  ${RAZORPAY_CLOSE_BTN}
    Log To Console   Payment Option closed successfully
    Handle Razorpay Exit Popup   ${YES_EXIT_BTN}  Payment cancelled
    Click Element    ${WALLET_CLOSE_BTN}    
    Wait Until Page Contains   Wallet History    5s
    Log To Console  Recharge Wallet Closed successfully
    Click Button   ${AI_AGENTS_TAB}   Navigate back to AI Agents tab
    Wait Until Page Contains   All   5s
    
8.Verify Profile Menu,Settings,Logout
    [Documentation]    Verify profile menu navigation: settings, help & support, and logout
    Open Profile Menu   ${PROFILE_ICON}
    Open Settings  ${SETTINGS}
    Wait Until Page Contains  Account Settings   30s
    Open Profile Menu   ${PROFILE_ICON}
    Open Help & Support  ${HELP_SUPPORT_BTN} 
    Wait Until Page Contains   Help Support   30s
    Open Profile Menu   ${PROFILE_ICON}
    Open Logout   ${LOGOUT_BTN}
    Wait Until Page Contains    Sign in to your account to continue    30s


