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

1.Verify Login Success And AI-agents Page Loaded
    [Documentation]    Verify AI Agents page and wallet section
    Wait Until Page Contains   AI Agents   5s
    Log To Console     AI Agent page loaded successfully
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}

2.Verify Filter For Agents
    [Documentation]    Verify filtering of agents: Visual Intelligence, Listing Intelligence, and All
    Filter And Validate Agents   ${VISUAL_INTELLIGENCE}
    Filter And Validate Agents   ${LISTING_INTELLIGENCE}
    Filter And Validate Agents   ${ALL_FILTER}   

    
3.Launch Infographic Agent  
    [Documentation]    Validate AI agent card, launch Lifestyle Photo Creator, and click Generate New Content
    Verify AI-agents Card  ${LIFESTYLE_CARD}  ${LIFESTYLE_TITLE}   ${LIFESTYLE_PRICE}  ${LIFESTYLE_AGENT_LUNCH_BTN}
    Launch AI Agent   Lifestyle Photo Creator
    Wait Until Page Contains  Generate New Content    5s
    Log To Console    Lifestyle Photo Creator launched successfully
    Click Button    ${GENERATE_CONTENT_BTN}  Generate New Content
   

4.Verify Lifestyle Image Creator Page,Wallet Section And Template Download
    [Documentation]    Verify Lifestyle Image Creator page,wallet section And Template Download button 
    Wait Until Page Contains   Lifestyle Image Creator    5s   
    Log To Console    Lifestyle Image Creator page loaded successfully
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}
    Click Button  ${TEMPLATE_DOWNLOAD_BUTTON}   Template Download
    
15.Verify History
    [Documentation]    Open history, apply filter, and validate page state
    Open History  ${HISTORY_BTN}   ${FILTER_BTN}   History Page visible succefully
    Click Button  ${FILTER_BTN}  filter 
    Select Date Range And Validate     Today
    Validate History Page State  ${NO_HISTORY}   ${WITH_HISTORY}

16.Verify Navigate back to Lifestyle Photo and AI Agents tabs
    [Documentation]    Navigate back to Lifestyle Photo and AI Agents tabs
    Click Button  ${LIFESTYLE_PHOTO_CREATOR_TAB}  Navigate back to Lifestyle Photo tab
    Wait Until Keyword Succeeds    5x    5s
    ...    Element Should Be Visible    ${GENERATE_CONTENT_BTN}    
    sleep  2s
    Click Button   ${AI_AGENTS_TAB}   Navigate back to AI Agents tab
    Wait Until Element Is Visible       ${ALL_FILTER}    5s
17.Verify Search 
    [Documentation]    Verify search for an AI agent 
    Search AI Agent    A+ Content Creator


