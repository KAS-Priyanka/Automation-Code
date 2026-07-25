*** Settings ***
Library     SeleniumLibrary
Resource    ./resources/Ai_agents_Variables.robot
Resource    ./resources/Ai-agents_Keywords.robot

    
Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup    https://mysellercentral.com/ai-agents/sign-in    shaheen@kascommerce.com    ++Pass@123

Suite Teardown   Close Browser



*** Test Cases ***

1.Verify Login Success And AI-agents Page Loaded
    [Documentation]    Verify AI Agents page and wallet section
    Wait Until Page Contains   AI Agents   5s
    Log To Console     AI Agent page loaded successfully
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}

# 2.Verify Filter For Agents
#     [Documentation]    Verify filtering of agents: Visual Intelligence, Listing Intelligence, and All
#     Filter And Validate Agents   ${VISUAL_INTELLIGENCE}
#     Filter And Validate Agents   ${LISTING_INTELLIGENCE}
#     Filter And Validate Agents   ${ALL_FILTER}   

    
3.Launch Infographic Agent  
    [Documentation]    Validate AI agent card, launch Lifestyle Photo Creator
    Verify AI-agents Card  ${LIFESTYLE_CARD}  ${LIFESTYLE_TITLE}   ${LIFESTYLE_PRICE}  ${LIFESTYLE_AGENT_LUNCH_BTN}
    Launch AI Agent   Lifestyle Image Creator
  

4.Verify Lifestyle Image Creator Page,Wallet Section And Template Download
    [Documentation]   Verify Lifestyle Image Creator Page, Wallet Section And Template Download button
    Wait Until Page Contains   Lifestyle Image Creator    5s   
    Log To Console    Lifestyle Image Creator page loaded successfully
    Verify Wallet Section   ${WALLET_LABEL}     ${WALLET_VALUE}
    # Click Button  ${TEMPLATE_DOWNLOAD_BUTTON}   Template Download
    # Click Element   ${HELP_BTN}   
    
5.Enter Invalid ASIN And Verify Error
    Enter ASIN   B0FXGVJS   Invalid ASIN entered.
    Element Text Should Be    ${INVALID_ASIN_ERROR}    Enter a valid ASIN

6.Verify Valid ASIN Entry, Marketplace Selection, ASIN Removal and Product Upload
    Enter ASIN   B000GAYQJ0   Valid ASIN entered successfully.
    Select Marketplace For ASIN  ${ASIN_MARKETPLACE_DROPDOWN}   Amazon.com
    Enter ASIN   B0CJ4R8W4J   Valid ASIN entered successfully.
    Remove ASIN     B0CJ4R8W4J  ASIN removed successfully.
    Click Button    Upload   

7.Add Product Description,Marketplace,Theme And Custom Scene
    Click Button    Select all  
    Wait Until Page Contains   Describe your product:
    Enter Product Description    ${PRODUCT_DESCRIPTION}    Stylish wristwatch with a premium design, durable strap, precise timekeeping, and a comfortable fit, suitable for everyday wear, office, and casual occasions.
    Select Marketplace  ${MARKETPLACE_DROPDOWN}   Amazon.com
    Click Button  Themes  
    Select And Validate Theme    Modern Office
    Click Button    Custom
   Enter Scene Instructions    ${SCENE_INSTRUCTION_INPUT}    Display the wristwatch on a modern office desk beside a laptop and notebook with soft natural lighting, realistic shadows, and a premium professional workspace background.
  


# 5.Verify Invalid Image And Invalid Bulk Excel Sheet
#    [Documentation]    Upload invalid image and validate error message
#     Upload Invalid Image    ${INVALID_IMAGE}   ${INVALID_IMAGE_ERROR}
#     #Upload Invalid Excel Sheet  ${INVALID_EXCEL_SHEET}

# 6.Verify Valid Image 
#     [Documentation]    Upload valid image 
#     Upload Product Image    ${VALID_IMAGE} 

# 7.Add Product Description,Marketplace,Theme And Custom Scene
#     [Documentation]    Provide product description, choose marketplace and theme, add custom scene
    
    #Wait Until Page Contains   Select your images    5s
    #Click Element   ${SELECTION_ICON}
    #Log To Console  image selected
    Wait Until Page Contains Element    ${PRODUCT_DESCRIPTION}     5s
    #Wait Until Page Contains    Describe your product   5s
    #Input Text   ${PRODUCT_DESCRIPTION}   s
    Wait Until Page Contains   Describe your product:
    Enter Product Description   ${PRODUCT_DESCRIPTION}  Stylish black bag with multiple compartments,designed for everyday use, travel, and office needs.
    Select Marketplace    Amazon.com
    Click Button  ${THEMES_TAB}   Themes
    Select And Validate Theme    Modern Office
    Click Button  ${CUSTOM_TAB}    Custom
    Enter Scene Instructions   ${SCENE_INSTRUCTION_INPUT}  A modern professional carrying the black leather backpack while walking through a city street with soft natural lighting.
  
# 8.Verify Deselect All,Remove,Selected Text
#     [Documentation]    Verify image selection, deselection, and selection count
#     Wait Until Element Is Visible     ${SELECT_ALL_BUTTON}    10s
#     Element Should Be Visible        ${REMOVE_BUTTON}
#     Element Should Be Visible        ${SELECTED_TEXT}
#     Verify Image Selection      ${UPLOADED_IMAGE_PREVIEW}
#     Verify Image Deselection   ${UPLOADED_IMAGE_PREVIEW}
#     Verify Image Selection      ${UPLOADED_IMAGE_PREVIEW}
#     Verify Selection Count    ${UPLOADED_IMAGE_WITH_TICK}

# 9.Verify Price And Generate Image
#     [Documentation]    Verify generate count, generate image, and validate copy/download pricing
#     Verify Generate Count    ${UPLOADED_IMAGE_WITH_TICK}   ${GENERATE_BTN}   
#     Wait Until Processing Disappears    ${PROCESSING_TEXT}
#     Element Should Be Visible    ${GENERATED_IMAGE}
#     Element Should Be Visible  ${GENERATED_STATUS}
#     Log To Console    Image generated successfully
#     Validate Copy And Download Icon Price    ${COPY_ICON}   ₹20  ${DOWNLOAD_ICON}    ₹20
    
# 10.Verify Generated Images,Copy ,Download and Download All Functionality
#     [Documentation]    Validate generated image preview, copy action and download All functionality
#     Open Generated Images    ${GENERATED_IMAGE}     ${IMAGE_PREVIEW}
#     Validate Copy ,Download,Download All Button Price   ${COPY_BUTTON}   ₹20  ${DOWNLOAD}    ₹20  ${DOWNLOAD_ALL}  ₹20
#     Log To Console    images Generated successfully
#     Click Button  ${COPY_BUTTON}    copy 
#     #Wait Until Page Contains   Image copied!
#     #Log To Console  image copied successfully
#     #Wait Until Page Does Not Contain  Image copied!
#     Click Button  ${DOWNLOAD}    Download
#     Log To Console  image download successfully
#     Click Button  ${COPY_BUTTON}    copy 
#     #Wait Until Page Contains    copied   10s

#  11.Verify Image Regeneration And Feedback Functionality
#     [Documentation]    Validate image regeneration flow with prompt input and submission
#     Image Regeneration   ${REGENERATE_BUTTON}  ${CLOSE_PROMPT}  ${INPUT_BOX}  ${SEND_BTN} 
#     Feedback for Image   ${THUMBS_UP_BTN}   ${THUMBS_DOWN_BTN}  Good Quality Lifestyle Image generated

# 12.Verify Close And Download All Button  
#     [Documentation]    Validate download all images functionality and close action
#     Download All Images And Close  ${DOWNLOAD_ALL}   ${CLOSE_BUTTON}

# 13.Validate Download Button And Verify Remove Button functionality
#     [Documentation]    Validate Excel upload, image generation, and wallet balance deduction on download,  Select image and remove selected image
#     Verify Wallet Change After Download  ${DOWNLOAD_BUTTON}     20
#     Log To Console    download functionality and wallet deduction verified successfully
#     Select Image      ${IMAGE_BLUE_TICK}  ${REMOVE_BUTTON}
#     Remove Selected Image    1   ${REMOVE_BUTTON}  ${UPLOADED_IMAGE_PREVIEW}

# 14.Validate Excel upload, Download Button 
#     [Documentation]    Validate Excel upload, image generation, and wallet balance deduction on download
#     Upload Valid Excel Sheet  ${VALID_EXCEL_SHEET_LIFESTYLE}   ${EXCEL_SUCCESS_POPUP} 
#     Click Button  ${SELECT_ALL_BUTTON}  Select all clicked successfully
#     Verify Generate Count  ${UPLOADED_IMAGE_WITH_TICK}   ${GENERATE_BTN}  
#     Wait Until Processing Disappears    ${PROCESSING_TEXT}
#     Element Should Be Visible    ${GENERATED_IMAGE}
#     Element Should Be Visible  ${GENERATED_STATUS}
#     Log To Console    Image generated successfully
#     Validate Copy And Download Icon Price    ${COPY_ICON}   ₹20  ${DOWNLOAD_ICON}    ₹20
#     Validate Download Button   ${DOWNLOAD_BUTTON}   20
#     Log To Console    download functionality and wallet deduction verified successfully

# 15.Verify History
#     [Documentation]    Open history, apply filter, and validate page state
#     Open History  ${HISTORY_BTN}   ${FILTER_BTN}   History Page visible succefully
#     Click Button  ${FILTER_BTN}  filter 
#     Select Date Range And Validate     Today
#     Validate History Page State  ${NO_HISTORY}   ${WITH_HISTORY}
   
# 16.Verify Navigate back to Lifestyle Photo and AI Agents tabs
#     [Documentation]    Navigate back to Lifestyle Photo and AI Agents tabs
#     Click Button  ${LIFESTYLE_PHOTO_CREATOR_TAB}  Navigate back to Lifestyle Photo tab
#     Wait Until Page Contains  Lifestyle Image Creator   5s  
#     Click Button   ${AI_AGENTS_TAB}   Navigate back to AI Agents tab
#     Wait Until Element Is Visible       ${ALL_FILTER}    5s
    
# 17.Verify Search 
#     [Documentation]    Verify search for an AI agent 
#     Search AI Agent    A+ Content Creator


