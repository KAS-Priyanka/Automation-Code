*** Settings ***
Library     SeleniumLibrary
Resource    ./resources/Ai_agents_Variables.robot
Resource    ./resources/Ai-agents_Keywords.robot
    

Suite Setup    Run Keywords
...    Set Screenshot Directory    ./screenshots
...    AND
...    Login Setup    https://mysellercentral.com/ai-agents/sign-in    shaheen@kascommerce.com    ++Pass@123
Suite Teardown   Close Browser


*** Test Cases ***

1.Verify Login And AI-agents Page Redirection
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
    [Documentation]    Validate AI agent card, launch Infographic Creator
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}
    Verify AI-agents Card  ${INFOGRAPHIC_IMAGE_CREATOR_CARD}   ${INFOGRAPHIC_TITLE}   ${INFOGRAPHIC_PRICE}  ${INFOGRAPHIC_AGENT_LAUNCH_BTN}
    Launch AI Agent   Infographic Image Creator
    Button Click  ${TEMPLATE_DOWNLOAD_BUTTON}   Template Download
    Click Element   ${HELP_BTN}   
    
5.Enter Invalid ASIN And Verify Error
    Enter ASIN   B0FXGVJS   Invalid ASIN entered.
    Element Text Should Be    ${INVALID_ASIN_ERROR}    Enter a valid ASIN

6.Verify Valid ASIN Entry, Marketplace Selection, ASIN Removal and Product Upload
    Select Marketplace For ASIN  ${ASIN_MARKETPLACE_DROPDOWN}   Amazon.com
    Enter ASIN  B0CQ2CTKBH  Valid ASIN entered successfully.
    Enter ASIN   B000GAYQJ0   Valid ASIN entered successfully.
    Enter ASIN   B0CJ4R8W4J   Valid ASIN entered successfully.
    Remove ASIN     B0CJ4R8W4J  ASIN removed successfully.
    Click Button    Upload   

7.Open Uploaded Image 
    Open Image   1
    Remove Image  ${IMAGE_REMOVE_BUTTON}

8.Add Product Description,Marketplace,Theme And Custom Scene
    Click Button    Select all  
    Wait Until Page Contains   Describe your product:
    Enter Product Description    ${PRODUCT_DESCRIPTION}    Stylish wristwatch with a premium design, durable strap, precise timekeeping, and a comfortable fit, suitable for everyday wear, office, and casual occasions.
    Enter Key Features   ${KEY_FEATURES_INPUT}  Quartz movement, Water resistant, Stainless steel strap, Scratch-resistant glass
    Wait Until Page Contains      Saving
    Log To Console    Saving...
    Wait Until Page Contains  Marketplace:    2s
    Select Marketplace  ${MARKETPLACE_DROPDOWN}  Amazon.com
    Page Should Contain    Auto Saved
    Log To Console    Changes auto-saved successfully.

9.Verify Price And Generate Image
    [Documentation]    Verify generate count, generate image, and validate copy/download pricing
    Verify Selection, Remove And Generate Counts   ${UPLOADED_IMAGE_WITH_TICK}  ${REMOVE_BTN}  ${GENERATE_BTN}  ${SELECTION_LABEL}
    Button Click   ${GENERATE_BTN}  Generate 
    Wait Until Processing Disappears    ${PROCESSING_TEXT}
    Check Generation Status   ${GENERATED_STATUS}  ${FALIED_STATUS}  
    View Next Generated Image   ${GENERATED_IMAGE}  ${NEXT_IMAGE_BTN}   ${ACTIVE_IMAGE_CARD}  
    View Next Generated Image   ${GENERATED_IMAGE}  ${NEXT_IMAGE_BTN}  ${LEFT_ACTIVE_IMAGE_CARD}

10.Verify Generated Images,Copy Functionality
    [Documentation]    Validate generated image preview, copy action and download All functionality
    Open Generated Images    ${GENERATED_IMAGE}     ${IMAGE_PREVIEW}
    Button Click   ${COPY_BUTTON}    copy 
    Wait Until Page Contains   Image Copied!

11.Verify Image Regeneration ,Feedback And Download Functionality
    [Documentation]    Validate image regeneration flow with prompt input and submission
    Image Regeneration For Infographic   ${REGENERATE_BUTTON}  ${SEND_BTN} 
    Feedback For Image   ${GENERATED_IMAGE1}   ${THUMBS_DOWN_BTN1}   ${THUMBS_UP_BTN1}  UP   The background looks natural and complements the product.
    #Button Click   ${DOWNLOAD}    Download
    
12.Verify Close And Download All Button  
    [Documentation]    Validate download all images functionality and close action
    Download All Images And Close  ${DOWNLOAD_ALL}   ${CLOSE_BUTTON}

13.Verify History
    [Documentation]    Open history, apply filter, and validate page state
    Open History  ${HISTORY_BTN}   ${FILTER_BTN}   History Page visible succefully
    Button Click  ${FILTER_BTN}  filter 
    Select Date Range And Validate     Today
    Validate History Page State  ${NO_HISTORY}   ${WITH_HISTORY}
   
16.Verify Navigate back to Infographic Creator Tab and AI Agents tabs
    [Documentation]    Navigate back to Infographic Creator and AI Agents tabs
    Button Click    ${INFOGRAPHIC_IMAGE_CREATOR_TAB}  Navigate back to Infographic Creator tab
    Wait Until Page Contains  Infographic Image Creator  5s  
    Button Click   ${AI_AGENTS_TAB}   Navigate back to AI Agents tab
    Wait Until Element Is Visible       ${ALL_FILTER}    5s
17.Verify Search 
    [Documentation]    Verify search for an AI agent 
    Search AI Agent    AI Listing Creator