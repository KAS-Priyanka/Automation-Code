*** Settings ***
Library     SeleniumLibrary
Resource    ./resources/Session_Variables.robot
Resource    ./resources/Session_Keywords.robot

Suite Setup    Run Keywords
...    Disable Screenshots
...    AND
...    Login Setup   https://mysellercentral.online/sign-in  mayuresh.adititoys@gmail.com   ++Pass@123
Suite Teardown   Close Browser



*** Test Cases ***

1.Verify Session Page Loaded
    Disable Screenshots
    Wait Until Page Contains  Commerce IQ   5s
    Log To Console    Session page loaded successfully
    
2.Verify Wallet 
  Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}

# 3.Verify Memory Functionality
#     Wait Until Element Is Visible    ${MEMORY_BTN}    5s
#     Click Element    ${MEMORY_BTN}

#     Wait Until Page Contains    Memory    timeout=20s
#     Log To Console    Memory popup loaded successfully
#     Validate Memory And AI Section  ${NO_MEMORY_TEXT}  ${MEMORY_HEADER}    ${MEMORY_CHIPS}    ${AI_LABEL}    ${AI_CONTENT}
#     click Element   ${MEMORY_CLOSE_BTN} 
#     Log To Console    Memory popup closed successfully

4.Verify Commerce IQ Chat ,Commerce IQ Response And New Session
    Click Button  ${GENERATE_LISTING}   Generate Listing button
    #1st Query
    Send Commerce IQ Query
    ...   Give me the total number of returns for Amazon.in from 4 March 2026 to 2 April 2026.
    ...    ${CHAT_INPUT}  
    Commerce IQ Response
    ...   Returns 
    ...   Amazon.in
    Validate Analysis Table  ${ANALYSIS_TABLE}  ${EXPORT_BTN}   
    Validate Wallet Balance In Response    ${WALLET_BALANCE_VALUE}   ${WALLET_VALUE} 
    Create New Session   ${NEW_SESSION_BTN}
    
    #2nd Query
    Send Commerce IQ Query   
    ...    How many AI agents do we have?
    ...    ${CHAT_INPUT}  
    Commerce IQ Response
    ...    10 specialized AI agents 
    ...     Smart Listing Agent 
    Validate Wallet Balance In Response    ${WALLET_BALANCE_VALUE}   ${WALLET_VALUE} 
    Create New Session   ${NEW_SESSION_BTN}

    #3rd Query
    Send Commerce IQ Query     
    ...     Give me the report for revenue, orders, order unit, returns, returns unit for today for amazon.in
    ...    ${CHAT_INPUT}  
    Commerce IQ Response
    ...   Revenue	
    ...   Orders 
    Validate Analysis Table  ${ANALYSIS_TABLE}  ${EXPORT_BTN}   
    Validate Wallet Balance In Response    ${WALLET_BALANCE_VALUE}   ${WALLET_VALUE} 
    Create New Session   ${NEW_SESSION_BTN}

    #4th Query
    Send Commerce IQ Query   
    ...   Show the total list of connected marketplaces.
    ...    ${CHAT_INPUT}  

    Validate Connected Marketplaces
    Validate Wallet Balance In Response    ${WALLET_BALANCE_VALUE}   ${WALLET_VALUE} 
    
    #5th Query
    Send Commerce IQ Query   
    ...    How many AI agents do we have?
    ...    ${CHAT_INPUT}  

    Commerce IQ Response
    ...    10 specialized AI agents 
    ...     Smart Listing Agent 
    Create New Session   ${NEW_SESSION_BTN}
    
5.Verify Commerce IQ Chat With Thinking Mode,Commerce IQ Response And New Session   
    #1st Query
    Send Commerce IQ Query With Thinking Mode   
    ...  ${THINKING}  
    ...  ${CHAT_INPUT}
    ...  Give me Total Value of Inventory for Amazon.in

    # Commerce IQ Response
    # ...    10 specialized AI agents 
    # ...     Smart Listing Agent 
    
    #2nd Query
    Send Commerce IQ Query With Thinking Mode   
    ...  ${THINKING}  
    ...  ${CHAT_INPUT}
    ...  Give me Total no of Repeate Customers for Amazon.in

    # Commerce IQ Response
    # ...    10 specialized AI agents 
    # ...     Smart Listing Agent 

    #3rd Query
    Send Commerce IQ Query With Thinking Mode   
    ...  ${THINKING}  
    ...  ${CHAT_INPUT}
    ...  Give me Total Repeat Value for Amazon.in

    # Commerce IQ Response
    # ...    10 specialized AI agents 
    # ...     Smart Listing Agent 
    

    #4th Query
    Send Commerce IQ Query With Thinking Mode   
    ...  ${THINKING}  
    ...  ${CHAT_INPUT}
    ...  Give me inventory Total Storage Fees for Amazon.in

    # Commerce IQ Response
    # ...    10 specialized AI agents 
    # ...     Smart Listing Agent 

    #5th Query
    Send Commerce IQ Query With Thinking Mode   
    ...  ${THINKING}  
    ...  ${CHAT_INPUT}
    ...  Give me Total Suppressed Listings for Amazon.in

    # Commerce IQ Response
    # ...    10 specialized AI agents 
    # ...     Smart Listing Agent 

    

7.Verify Session History
    Click Button    ${HISTORY_BTN}    Session History button
    Wait Until Page Contains   Chat history   timeout= 20s
    Wait Until Keyword Succeeds    120s    2s    Element Should Not Be Visible    ${HISTORY_LOADER}
    Log To Console   Session History loaded successfully
    sleep  2s
    #Click History Value  Give me the total number of re...
