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
    [Documentation]    Validate AI agent card, launch Lifestyle Photo Creator
    Verify AI-agents Card  ${LIFESTYLE_CARD}  ${LIFESTYLE_TITLE}   ${LIFESTYLE_PRICE}  ${LIFESTYLE_AGENT_LUNCH_BTN}
    Launch AI Agent   Lifestyle Image Creator
  
4.Verify Lifestyle Image Creator Page,Wallet Section And Template Download
    [Documentation]   Verify Lifestyle Image Creator Page, Wallet Section And Template Download button
    Wait Until Page Contains   Lifestyle Image Creator    5s   
    Log To Console    Lifestyle Image Creator page loaded successfully
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}
    Button Click  ${TEMPLATE_DOWNLOAD_BUTTON}   Template Download
    Button Click   ${HELP_BTN}    ?
    
5.Enter Invalid ASIN And Verify Error
    Enter ASIN   B0FXGVJS   Invalid ASIN entered.
    Element Text Should Be    ${INVALID_ASIN_ERROR}    Enter a valid ASIN

6.Verify Valid ASIN Entry, Marketplace Selection, ASIN Removal and Product Upload
    Select Marketplace For ASIN  ${ASIN_MARKETPLACE_DROPDOWN}   Amazon.com
    Enter ASIN  B000U5O5XI  Valid ASIN entered successfully.
    Enter ASIN   B000GAYQJ0   Valid ASIN entered successfully.
    Enter ASIN   B0CJ4R8W4J   Valid ASIN entered successfully.
    Remove ASIN     B0CJ4R8W4J  ASIN removed successfully.
    Click Button    Upload   

7.Open Uploaded Image And Remove Image
    Open Image   1
    Remove Image  ${IMAGE_REMOVE_BUTTON}

8.Add Product Description,Marketplace,Theme And Custom Scene
    Click Button    Select all  
    Wait Until Page Contains   Describe your product:
    Enter Product Description    ${PRODUCT_DESCRIPTION}    Stylish wristwatch with a premium design, durable strap, precise timekeeping, and a comfortable fit, suitable for everyday wear, office, and casual occasions.
    Wait Until Page Contains  Marketplace:    2s
    Select Marketplace  ${MARKETPLACE_DROPDOWN}  Amazon.com
    Button Click  ${THEMES_TAB}   Themes  
    Select And Validate Theme    Modern Office
    Wait Until Page Contains      Saving
    Log To Console    Saving...
    Button Click    ${CUSTOM_TAB}  Custom
    Enter Scene Instructions    ${SCENE_INSTRUCTION_INPUT}    Display the wristwatch on a modern office desk beside a laptop and notebook with soft natural lighting, realistic shadows, and a premium professional workspace background.
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
    Verify Wallet Change After Copy   ${COPY_BUTTON}    15 
    Wait Until Page Contains   Image Copied!

11.Verify Image Regeneration ,Feedback And Download Functionality
    [Documentation]    Validate image regeneration flow with prompt input and submission
    Image Regeneration   ${REGENERATE_BUTTON}  ${CLOSE_PROMPT}  ${INPUT_BOX}  ${SEND_BTN} 
    Feedback For Image   ${GENERATED_IMAGE1}   ${THUMBS_DOWN_BTN1}   ${THUMBS_UP_BTN1}  UP   The background looks natural and complements the product.
    Button Click   ${DOWNLOAD}    Download
    
12.Verify Download All And Close Button  
    [Documentation]    Validate download all images functionality and close action
    Download All Images And Close  ${DOWNLOAD_ALL}   ${CLOSE_BUTTON}

13.Verify History
    [Documentation]    Open history, apply filter, and validate page state
    Open History  ${HISTORY_BTN}   ${FILTER_BTN}   History Page visible succefully
    Button Click  ${FILTER_BTN}  filter 
    Select Date Range And Validate     Today
    Validate History Page State  ${NO_HISTORY}   ${WITH_HISTORY}
   
14.Verify Navigate back to Lifestyle Image and AI Agents tabs
    [Documentation]    Navigate back to Lifestyle Image and AI Agents tabs
    Button Click  ${LIFESTYLE_Image_CREATOR_TAB}  Navigate back to Lifestyle Image tab
    Wait Until Page Contains  Lifestyle Image Creator   5s  
    Button Click  ${AI_AGENTS_TAB}   Navigate back to AI Agents tab
    Wait Until Element Is Visible       ${ALL_FILTER}    5s
    
15.Verify Search 
    [Documentation]    Verify search for an AI agent 
    Search AI Agent    A+ Content Creator


