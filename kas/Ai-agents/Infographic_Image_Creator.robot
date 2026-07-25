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
    Verify AI-agents Card  ${INFOGRAPHIC_CARD}   ${INFOGRAPHIC_TITLE}   ${INFOGRAPHIC_PRICE}  ${INFOGRAPHIC_AGENT_LAUNCH_BTN}
    Launch AI Agent   Infographic Creator
    
4.Verify Infographic Creator Page,Wallet Section And Template Download
    [Documentation]    Verify  Infographic Creator page,wallet section And Template Download button
    Wait Until Page Contains  Infographic Creator    5s   
    Log To Console    Infographic Creator page loaded successfully
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}
    Click Button  ${TEMPLATE_DOWNLOAD_BUTTON}   Template Download
    Click Element   ${HELP_BTN}   

5.Verify Invalid Image And Bulk Excel Sheet
    [Documentation]    Upload invalid image and validate error message
    Upload Invalid Image    ${INVALID_IMAGE}   ${INVALID_IMAGE_ERROR}
    #Upload Invalid Excel Sheet  ${INVALID_EXCEL_SHEET}

6.Verify Valid Image 
    [Documentation]    Upload valid image
    Upload Product Image    ${VALID_IMAGE} 

7.Add Product Description,marketplace
    [Documentation]    Provide product description, choose marketplace and theme, add custom scene
    #Wait Until Page Contains   Select your images    5s
    #Click Element   ${SELECTION_ICON}
    #Log To Console  image selected
    Wait Until Page Contains Element    ${PRODUCT_DESCRIPTION}     5s
    Wait Until Page Contains    Describe your product   5s
    Input Text   ${PRODUCT_DESCRIPTION}   s
    Wait Until Page Contains   Describe your product:
    Enter Product Description   ${PRODUCT_DESCRIPTION}  tylish black bag with multiple compartments,designed for everyday use, travel, and office needs.
    Select Marketplace    Amazon.com

    # Select And Validate Theme    Urban Street Vibe

    # Click Button  ${CUSTOM_TAB}    Custom
    # Enter Scene Instructions   ${SCENE_INSTRUCTION_INPUT}  A premium lifestyle scene showing the Milton Duo DLX 1000 Thermosteel Water Bottle placed on a modern office desk with natural lighting
    
    # Upload Multiple Product Images

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
    Click Element          ${GENERATE_BTN}
    Wait Until Processing Disappears    ${PROCESSING_TEXT}
    Element Should Be Visible    ${GENERATED_IMAGE}
    Element Should Be Visible  ${GENERATED_STATUS}
    Log To Console    Image generated successfully
    Validate Copy And Download Icon Price    ${COPY_ICON}   ₹20  ${DOWNLOAD_ICON}    ₹20
    
10.Verify Generated Images,Copy And Download Functionality
    [Documentation]    Open generated image, validate copy functionality, and verify download
    Open Generated Images    ${GENERATED_IMAGE}     ${IMAGE_PREVIEW}
    Validate Copy ,Download,Download All Button Price   ${COPY_BUTTON}   ₹20  ${DOWNLOAD}    ₹20  ${DOWNLOAD_ALL}  ₹20
    Log To Console    images Generated successfully
    Click Button  ${COPY_BUTTON}    copy 
    Wait Until Page Contains   Image copied!
    Log To Console  image copied successfully
    Wait Until Page Does Not Contain  Image copied!
    Click Button  ${DOWNLOAD}    Download
    Log To Console  image download successfully

11.Verify Image Regeneration
    [Documentation]    Validate image regeneration flow with prompt input and submission
    Image Regeneration   ${REGENERATE_BUTTON}  ${CLOSE_PROMPT}  ${INPUT_BOX}  ${SEND_BTN} 
    Feedback for Image   ${THUMBS_UP_BTN}   ${THUMBS_DOWN_BTN}  Good Quality Infographic image generated

12.Verify Close And Download All Button Functionality
    [Documentation]    Validate download all images functionality and close action
    Download All Images And Close  ${DOWNLOAD_ALL}   ${CLOSE_BUTTON}

13.Verify Remove Button
    [Documentation]    Select image and remove selected image
    Select Image      ${IMAGE_BLUE_TICK}  ${REMOVE_BUTTON}
    Remove Selected Image    1   ${REMOVE_BUTTON}  ${UPLOADED_IMAGE_PREVIEW}

14.Validate Excel upload, Download Button 
    [Documentation]    Validate Excel upload, image generation, and wallet balance deduction on download
    Upload Valid Excel Sheet  ${VALID_EXCEL_SHEET_INFOGRAPHIC}  ${EXCEL_SUCCESS_POPUP} 
    Click Button  ${SELECT_ALL_BUTTON}  Select all clicked successfully
    Verify Generate Count  ${UPLOADED_IMAGE_WITH_TICK}   ${GENERATE_BTN}  
    Wait Until Processing Disappears    ${PROCESSING_TEXT}
    Element Should Be Visible    ${GENERATED_IMAGE}
    Element Should Be Visible  ${GENERATED_STATUS}
    Log To Console    Image generated successfully
    Validate Copy And Download Icon Price    ${COPY_ICON}   ₹20  ${DOWNLOAD_ICON}    ₹20
    Validate Download Button   ${DOWNLOAD_BUTTON}   20
    Log To Console    download functionality and wallet deduction verified successfully

15.Verify History
    [Documentation]    Open history, apply filter, and validate page state
    Open History  ${HISTORY_BTN}   ${FILTER_BTN}   History Page visible succefully
    Click Button  ${FILTER_BTN}  filter 
    Select Date Range And Validate     Today
    Validate History Page State  ${NO_HISTORY}   ${WITH_HISTORY}
   
16.Verify Navigate back to Infographic Creator Tab and AI Agents tabs
    [Documentation]    Navigate back to Infographic Creator and AI Agents tabs
    Click Button  ${INFOGRAPHIC_CREATOR_TAB}  Navigate back to Infographic Creator tab
    Wait Until Page Contains  Infographic Creator  5s  
    Click Button   ${AI_AGENTS_TAB}   Navigate back to AI Agents tab
    Wait Until Element Is Visible       ${ALL_FILTER}    5s
17.Verify Search 
    [Documentation]    Verify search for an AI agent 
    Search AI Agent    A+ Content Creator