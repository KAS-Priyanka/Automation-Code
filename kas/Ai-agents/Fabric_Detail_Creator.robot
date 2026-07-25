*** Settings ***
Library     SeleniumLibrary
Resource    ./resources/Ai_agents_Variables.robot
Resource    ./resources/Ai-agents_Keywords.robot

    
Suite Setup    Run Keywords
...    Disable Screenshots
...    AND
...    Login Setup    https://mysellercentral.com/ai-agents/sign-in    shaheen@kascommerce.com    ++Pass@123
Suite Teardown   Close Browser




*** Test Cases ***

1.Verify Login Success And AI-agents Page Loaded
    [Documentation]    Verify AI Agents page and wallet section

    Wait Until Page Contains   AI Agents   5s
    Log To Console     AI Agent page loaded successfully
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}

#2.Verify Filter For Agents
    #[Documentation]    Verify filtering of agents: Visual Intelligence, Listing Intelligence, and All
    #Filter And Validate Agents   ${VISUAL_INTELLIGENCE}
    #Filter And Validate Agents   ${LISTING_INTELLIGENCE}
    #Filter And Validate Agents   ${ALL_FILTER}   

3.Launch Fabric Detail Creator Agent
    [Documentation]    Validate AI agent card, launch Fabric Detail Creator, and click Generate New Content
    Verify AI-agents Card  ${FABRIC_DETAIL_CREATOR_CARD}  ${FABRIC_DETAIL_CREATOR_TITLE}    ${FABRIC_DETAIL_CREATOR_PRICE}  ${FABRIC_DETAIL_CREATOR_AGENT_LAUNCH_BTN}
    Launch AI Agent   Fabric Detail Creator
   
4.Verify Fabric Detail Creator Page,Wallet Section And Template Download
    [Documentation]   Verify Fabric Detail Creator Page, Wallet Section And Template Download button
    Wait Until Page Contains   Fabric Detail Creator    5s   
    Log To Console    Fabric Detail Creator page loaded successfully    

    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}
    Click Button  ${TEMPLATE_DOWNLOAD_BUTTON}   Template Download
    Click Element   ${HELP_BTN}

#5.Verify Invalid Image And Invalid Bulk Excel Sheet
   #[Documentation]    Upload invalid image and validate error message
    #Upload Invalid Image    ${INVALID_IMAGE}   ${INVALID_IMAGE_ERROR}
    #Upload Invalid Excel Sheet  ${INVALID_EXCEL_SHEET}

6.Verify Valid Image 
    [Documentation]    Upload valid image 
    Upload Product Image   ${FABRIC_DETAIL_CREATOR_VALID_IMAGE}

7.Add fabric Title,Output Image Size,Select Style 
    [Documentation]    Provide fabric title, choose output image size and style
    Wait Until Page Contains Element    ${FABRIC_TITLE_INPUT}      5s
    Enter fabric Title    ${FABRIC_TITLE_INPUT}    Women's Mehndi Printed, Embroidered, Embellished Bandhani Georgette Party Saree
    Select Output Image Size   Amazon.com
    Select And Validate Style    Sunlit Loft
   
8.Verify Deselect All,Remove,Selected Text
    [Documentation]    Verify image selection, deselection, and selection count
    Wait Until Element Is Visible     ${SELECT_ALL_BUTTON}    10s
    Element Should Be Visible        ${REMOVE_BUTTON}
    Element Should Be Visible        ${SELECTED_TEXT}
    Verify Image Selection      ${UPLOADED_IMAGE_PREVIEW}
    Verify Image Deselection   ${UPLOADED_IMAGE_PREVIEW}
    Verify Image Selection      ${UPLOADED_IMAGE_PREVIEW}
    Verify Selection Count    ${UPLOADED_IMAGE_WITH_TICK}

9.Verify Price And Generate Image
    [Documentation]    Verify generate count, generate image, and validate copy/download pricing
    Verify Generate Count    ${UPLOADED_IMAGE_WITH_TICK}   ${GENERATE_BTN}   
    Wait Until Processing Disappears    ${PROCESSING_TEXT}
    Element Should Be Visible    ${GENERATED_IMAGE}
    Element Should Be Visible  ${GENERATED_STATUS}
    Log To Console    Image generated successfully
    Validate Copy And Download Icon Price    ${COPY_ICON}   ₹20  ${DOWNLOAD_ICON}    ₹20
    
10.Verify Generated Images,Copy And Download Functionality
    [Documentation]    Validate generated image preview, copy action, and download functionality
    Open Generated Images For Fabric     ${GENERATED_IMAGE}     ${IMAGE_PREVIEW}
    Click Button   ${HISTORY_PREVIEW_CLOSE_BTN}   Close Preview

# 11.Validate Download Button 
#     [Documentation]    Validate Excel upload, image generation, and wallet balance deduction on download
#     Verify Wallet Change After Download  ${DOWNLOAD_BUTTON}     20
#     Log To Console    download functionality and wallet deduction verified successfully

12.Verify Remove Button
    [Documentation]    Select image and remove selected image
    Select Image      ${IMAGE_BLUE_TICK}  ${REMOVE_BUTTON}
    sleep  3s
    Remove Selected Image    1   ${REMOVE_BUTTON}  ${UPLOADED_IMAGE_PREVIEW}


13.Verify History
    [Documentation]    Open history, apply filter, and validate page state
    Open History  ${HISTORY_BTN}   ${FILTER_BTN}   History Page visible succefully
    Click Button  ${FILTER_BTN}  filter 
    Select Date Range And Validate     Today
    Validate History Page State For Fabric    ${NO_HISTORY}   ${WITH_HISTORY}
   
14.Verify Navigate back to Fabric Detail Creator Page and AI Agents tabs
    [Documentation]    Navigate back to Fabric Detail Creator Page and AI Agents tabs
    Click Button  ${FABRIC_DETAIL_CREATOR_TAB}  Navigate back to Fabric Detail Creator Page
    Wait Until Page Contains  Fabric Detail Creator   5s  
    Click Button   ${AI_AGENTS_TAB}   Navigate back to AI Agents tab
    Wait Until Element Is Visible       ${ALL_FILTER}    5s
    
15.Verify Search 
    [Documentation]    Verify search for an AI agent 
    Search AI Agent    A+ Content Creator

