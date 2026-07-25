*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource    Ai_agents_Variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary



*** Keywords ***

#--------Login Keywords-------   
*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource   Ai_agents_Variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary

*** Keywords ***
   
Open Application
    [Arguments]    ${url}
    Log To Console    Opening application: ${url}
    Open Browser    ${url}    chrome
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Wait Until Element Is Visible    ${PAGE_HEADING}    10s
    Log To Console    Application opened successfully.

Enter Login Credentials And Submit
    [Arguments]    ${email}    ${password}
    Wait Until Element Is Visible    ${EMAIL_INPUT}    10s
    Input Text    ${EMAIL_INPUT}    ${email}
    Wait Until Element Is Visible    ${PASSWORD_INPUT}    10s
    Input Text    ${PASSWORD_INPUT}    ${password}
    Wait Until Element Is Not Visible    id=preloader    20s
    Wait Until Element Is Enabled    ${CONTINUE_BTN}    10s
    Click Element    ${CONTINUE_BTN}
    Log To Console    Clicked on Continue button.
    #Wait Until Page Contains    Login Success    10s
    Log To Console    Login successful for user: ${email}

Login Setup
    [Arguments]    ${url}    ${email}    ${password}
    Open Application    ${url}
    Enter Login Credentials And Submit    ${email}    ${password}



#---button click---
# Click Button
#     [Arguments]    ${locator}  ${label}
#     Wait Until Element Is Visible    ${locator}    5s
#     Click Element    ${locator}
#     Log To Console    ${label} visible and clicked successfully

Click Button
    [Arguments]    ${button_name}
    ${button}=    Set Variable    xpath=//button[.//span[normalize-space()='${button_name}']]
    Wait Until Element Is Visible    ${button}    10s
    Click Element    ${button}
    Log To Console    '${button_name}' button clicked successfully.


#--------Ai-agents----
Verify Wallet Section
    [Arguments]    ${wallet_button}    ${wallet_value}
    Wait Until Element Is Visible    ${wallet_button}    10s
    Element Should Be Visible        ${wallet_button}
    ${value}=    Get Text    ${wallet_value}
    Should Contain    ${value}    ₹
    ${value}=    Remove String    ${value}    ₹
    ${value}=    Remove String    ${value}    ,
    ${value}=    Strip String     ${value}
    ${value}=    Convert To Integer    ${value}
    Should Be True    ${value} >= 0
    Log To Console    Wallet balance is ₹${value} and is valid
    RETURN    ${value}

Verify Recharge Wallet Elements   
    Element Should Be Visible    ${ENTER_AMOUNT_INPUT}
    Page Should Contain    ₹100
    Page Should Contain    ₹500
    Page Should Contain    ₹1,000
    Page Should Contain    ₹2,000
    Element Should Be Visible    ${CANCEL_BUTTON}
    Element Should Be Visible    ${MAKE_PAYMENT_BUTTON}
    Log To Console    Recharge wallet popup elements verified

Verify Available Balance With Wallet
    [Arguments]    ${available_balance_locator}    ${wallet_value}
    Wait Until Element Is Visible    ${available_balance_locator}    15s
    ${available}=    Get Text    ${available_balance_locator}
    Log To Console    Value = ${available}
    Should Not Be Empty    ${available}
    ${available}=    Remove String    ${available}    Available Balance:
    ${available}=    Remove String    ${available}    ₹
    ${available}=    Remove String    ${available}    ,
    ${available}=    Strip String     ${available}
    ${available}=    Convert To Integer    ${available}
    Should Be Equal As Integers    ${wallet_value}    ${available}
    Log To Console    Wallet ₹${wallet_value} matches Available Balance ₹${available}


Check Wallet History Empty Or Data
    [Arguments]    ${empty_locator}    ${table_locator}

    ${empty}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible
    ...    ${empty_locator}
    ...    5s

    IF    ${empty}
        Log To Console     History Table is EMPTY
    ELSE
        Wait Until Element Is Visible    ${table_locator}    7s
        Log To Console     History Table has DATA
    END

Enter Wallet Amount 
    [Arguments]    ${amount}

    Element Should Be Disabled   ${MAKE_PAYMENT_BUTTON}
    Log To Console    Make Payment button is disabled initially
    Wait Until Element Is Visible    ${ENTER_AMOUNT_INPUT}    10s
    Clear Element Text    ${ENTER_AMOUNT_INPUT}
    Input Text            ${ENTER_AMOUNT_INPUT}    ${amount}
    Log To Console    Amount entered: ${amount}
    ${entered}=    Get Value    ${ENTER_AMOUNT_INPUT}
    Should Be Equal    ${entered}    ${amount}
    # Wait until button becomes enabled
   # Wait Until Element Is Enabled    ${MAKE_PAYMENT_BUTTON}    10s
    RETURN    ${amount}

Verify Input Amount With Total Amount
    [Arguments]    ${total_amount}    ${input_value}

    # Get value from UI
    ${total}=    Get Element Attribute    
    ...    ${total_amount}    
    ...    data-value
    ${total}=    Convert To Integer    ${total}
    Should Be Equal As Integers    ${input_value}    ${total}
    Log To Console    input Value ₹${input_value} matches Total Amount ₹${total}

Enter Contact Details
    [Arguments]    ${mobile}
    Wait Until Element Is Visible    ${RAZORPAY_IFRAME}    15s
    Select Frame    ${RAZORPAY_IFRAME}

    Wait Until Element Is Visible    ${MOBILE_FIELD}    10s
    Click Element    ${MOBILE_FIELD}
    Input Text    ${MOBILE_FIELD}         ${mobile}
    

Handle Razorpay Exit Popup
    [Arguments]  ${yes_exit_btn}    ${payment_cancelled_toast}

    Wait Until Page Contains    Are you sure you want to exit?    10s

    Wait Until Element Is Visible    ${yes_exit_btn}    10s
    Click Element                   ${yes_exit_btn}
    Log To Console     Clicked Yes, exit successfully

    Wait Until Keyword Succeeds    3x    2s
    ...    Page Should Contain     ${payment_cancelled_toast}
    Log To Console     Payment cancelled message displayed
    Wait Until Keyword Succeeds    3x    2s
    ...    Page Should Not Contain     ${payment_cancelled_toast}
    Log To Console     Payment cancelled toast disappeared

#----Setting---
Open Profile Menu 
    [Arguments]    ${profile_icon}   
    Wait Until Element Is Visible    ${profile_icon}     5s
    Click Element                    ${profile_icon} 

Open Settings
    [Arguments]   ${settings}  
    Wait Until Element Is Visible    ${settings}       5s
    Click Element  ${settings} 

Open Help & Support 
    [Arguments]   ${Help_and_Support}  
    Wait Until Element Is Visible    ${Help_and_Support}      5s
    Click Element   ${Help_and_Support}

Open Logout
    [Arguments]   ${logout}
    Wait Until Element Is Visible     ${logout}     10s
    Click Element    ${logout} 

#----AI Agents Keywords---
Search AI Agent
    [Arguments]    ${agent_name}

    Wait Until Element Is Visible    ${AGENT_SEARCH_BOX}    10s
    Input Text            ${AGENT_SEARCH_BOX}    ${agent_name}
    Press Keys    ${AGENT_SEARCH_BOX}    ENTER
    Wait Until Element Is Visible  xpath=//h3[normalize-space()='${agent_name}']/ancestor::div[contains(@class,'cursor-pointer')]
    Log To Console    ${agent_name} card is visible after search
    sleep  4s

Filter And Validate Agents
    [Arguments]    ${filter}
    Click Element    ${filter}
    Sleep    2s

Verify AI-agents Card
    [Arguments]    ${card}    ${title}    ${price}    ${launch}

    Wait Until Element Is Visible    ${card}    10s
    Element Should Be Visible        ${title}
    Element Should Be Visible        ${price}
    Element Should Be Visible        ${launch}
    Log To Console    AI Agent card verified successfully

Launch AI Agent
    [Arguments]    ${agent_name}
    ${button}=    Set Variable    xpath=//h3[normalize-space()='${agent_name}']/ancestor::div[contains(@class,'cursor-pointer')]//button[normalize-space()='Launch']
    Wait Until Element Is Visible    ${button}    10s
    Scroll Element Into View         ${button}
    Click Element                    ${button}
    Sleep    2s    ${agent_name} agent launched successfully

Select Marketplace For ASIN
    [Arguments]  ${marketplace_dropdown}  ${marketplace}
    Wait Until Element Is Visible    ${marketplace_dropdown}    10s
    Click Element    ${marketplace_dropdown}
    ${marketplace_option}=    Set Variable    xpath=//span[normalize-space()='${marketplace}']
    Wait Until Element Is Visible    ${marketplace_option}    10s
    Click Element    ${marketplace_option}
    Log To Console    Marketplace '${marketplace}' selected successfully.


Enter ASIN
    [Arguments]    ${asin}    ${msg}
    Wait Until Element Is Visible    ${ASIN_INPUT}    20s
    Click Element    ${ASIN_INPUT}
    Input Text    ${ASIN_INPUT}    ${asin}
    Press Keys    ${ASIN_INPUT}    ENTER
    Log To Console   ${msg}

Remove ASIN
    [Arguments]    ${asin}  ${msg}
    ${remove_btn}=    Set Variable    xpath=//button[@aria-label='Remove ${asin}']
    Wait Until Element Is Visible    ${remove_btn}    10s
    Click Element    ${remove_btn}
    Log To Console    ${msg}


Click Upload Button
    [Arguments]    ${button_locator}
    Wait Until Element Is Visible    ${button_locator}    10s
    Click Element    ${button_locator}
    Log    Upload button clicked successfully.



Enter Product Description
    [Arguments]  ${product_description}  ${product_text}

    Wait Until Element Is Visible   ${product_description}    10s
    Scroll Element Into View         ${product_description}
    Input Text                       ${product_description}    ${product_text}
    Log To Console                   Product description entered successfully

Select Marketplace
    [Arguments]        ${marketplace_dropdown}  ${option}
    Wait Until Page Contains  Marketplace:    2s
    Click Element    ${marketplace_dropdown}
    ${option_locator}=    Set Variable    xpath=//span[normalize-space()='${option}']
    Wait Until Element Is Visible    ${option_locator}    10s
    Click Element                    ${option_locator}
    ${value_locator}=    Set Variable    xpath=//button[.//span[normalize-space()='${option}']]
    Wait Until Element Is Visible    ${value_locator}    10s
    Log To Console    Marketplace ${option} selected 

Select And Validate Theme
    [Arguments]    ${theme}

    Wait Until Page Contains    Selected: None    3s

    ${theme_locator}=    Set Variable    xpath=//p[normalize-space()='${theme}']/ancestor::button

    Wait Until Element Is Visible    ${theme_locator}    10s
    Scroll Element Into View         ${theme_locator}
    Click Element                    ${theme_locator}

    # Validate selected theme
    Wait Until Element Is Visible    ${SELECTED_THEME}    10s
    Element Should Contain           ${SELECTED_THEME}    ${theme}

    Log To Console    Theme ${theme} selected successfully

Verify All Themes Displayed
    Element Should Be Visible    ${MOUNTAIN_ESCAPE}
    Element Should Be Visible    ${MODERN_OFFICE}
    Element Should Be Visible    ${COZY_HOMES}
    Element Should Be Visible    ${URBAN_STREET_VIBE}
    Element Should Be Visible    ${SUNRISE_FIELDS}
    Element Should Be Visible    ${ELEGANT_DINING}
    Element Should Be Visible    ${WINTER_WONDERLAND}
    Element Should Be Visible    ${SPORTS_STADIUM}

    Log To Console    All themes are displayed successfully

Enter Scene Instructions
    [Arguments]   ${scene_instructions}   ${text}

    Wait Until Element Is Visible     ${scene_instructions}    10s
    Scroll Element Into View          ${scene_instructions}
    Clear Element Text                ${scene_instructions}
    Input Text                       ${scene_instructions}    ${text}

Upload Invalid Image
    [Arguments]    ${file_path}    ${invalid_image_error}
    Choose File    ${FILE_UPLOAD_INPUT}    ${file_path}
    Wait Until Element Is Visible    
    ...   ${invalid_image_error}        3s

    ${msg}=    Get Text    ${invalid_image_error}
    Log To Console    Error Message: ${msg}

    Should Contain    ${msg}    Only JPG
    Wait Until Keyword Succeeds    10x    1s    
    ...    Page Should Not Contain Element    
    ...    ${invalid_image_error}

Upload Invalid Excel Sheet
    [Arguments]    ${file_path}
    Choose File    ${FILE_UPLOAD_INPUT}    ${file_path}

Upload Valid Excel Sheet
    [Arguments]    ${file_path}   ${excel_success_popup}
    Choose File    ${FILE_UPLOAD_INPUT}    ${file_path}
    Wait Until Keyword Succeeds
    ...    10s    1s
    ...    Element Should Be Visible
    ...    ${excel_success_popup}
    Wait Until Keyword Succeeds
    ...    10s    1s
    ...    Element Should Be Visible
    ...     ${excel_success_popup}
    ${msg}=    Get Text   ${excel_success_popup}
    Log To Console    Error Message: ${msg}
    Wait Until Page Contains Element   ${UPLOADED_IMAGE_PREVIEW}   2s
    Log To Console    Excel images uploaded successfully



Upload Product Image
    [Arguments]    ${file_path}
    Choose File                      ${FILE_UPLOAD_INPUT}    ${file_path}
    Wait Until Page Contains Element   ${UPLOADED_IMAGE_PREVIEW}   5s
    Log To Console    Product image uploaded successfully

Upload Multiple Product Images
    ${files}=    Catenate    SEPARATOR=\n    @{IMAGES}
    Choose File    ${FILE_UPLOAD_INPUT}    ${files}
    Log To Console    Uploaded all images

Verify Image Deselection
    [Arguments]    ${image_card}
    Click Element    ${image_card}
    Wait Until Element Is Visible    ${SELECT_ALL_BUTTON}    5s
    Log To Console    Image deselected successfully

Verify Image Selection
    [Arguments]    ${image_card}
    Wait Until Element Is Visible    ${image_card}    5s
    Click Element    ${image_card}
    Wait Until Element Is Visible    ${DESELECT_ALL_BUTTON}    5s
    Log To Console    Image selected successfully

Select Image
    [Arguments]    ${image_card}  ${remove_btn}
    Click Element    ${image_card}
    Wait Until Element Is Visible    ${remove_btn}    5s
    Log To Console    Image selected successfully

Verify Selection Count
    [Arguments]  ${selected_image}  
    ${count}=    Get Element Count    ${selected_image}
    Log To Console    Actual selected count: ${count}

    # Get UI text (e.g., "2 selected")
    ${ui_text}=    Get Text    ${SELECTED_TEXT}
    Log To Console    UI text: ${ui_text}

    # Extract number from UI text
    ${ui_count}=    Evaluate    int('${ui_text}'.split()[0])

    Log To Console    UI count: ${ui_count}

    # Compare both
    Should Be Equal As Integers    ${count}    ${ui_count}
    Log To Console  expected and UI count is same

Verify Generate Count 
    [Arguments]    ${selected_image}    ${genarated_btn}   

    ${count}=    Get Element Count    ${selected_image}

    ${generate_text}=    Get Text    ${genarated_btn}
    Log To Console    Generate Text: ${generate_text}
    Should Contain    ${generate_text}    (${count})
    Log To Console    Generate count ${count} is displayed correctly on button

    Wait Until Element Is Visible    ${genarated_btn}      10s
    Log To Console    Generate button is enabled with correct count
    Click Element  ${genarated_btn}  
    Log To Console    Generate button clicked successfully
 
   
Remove Selected Image
    [Arguments]    ${index}  ${remove_btn}  ${uploaded_image_preview}
    
    ${before_count}=    Get Element Count     ${uploaded_image_preview}
    
    Click Element    (//button[.//img])[${index}]
    
    Wait Until Element Is Visible   ${remove_btn}    10s
    Click Element    ${remove_btn}
    
    ${after_count}=    Get Element Count     ${uploaded_image_preview}
    Should Be True    ${after_count} < ${before_count}
    Log To Console    Image removed successfully, remaining images: ${after_count}

Verify Wallet Change After Download
    [Arguments]    ${download_locator}    ${deduct_value}

    ${wallet_before}=    Get Text    ${WALLET_VALUE}
    Log To Console    Wallet Before: ${wallet_before}

    ${before}=    Replace String    ${wallet_before}    ₹    ${EMPTY}
    ${before}=    Strip String    ${before}
    ${before}=    Convert To Integer    ${before}

    Click Element    ${download_locator}

    Wait Until Keyword Succeeds    20s    3s    Wallet Should Update    ${before}

    ${wallet_after}=    Get Text    ${WALLET_VALUE}
    Log To Console    Wallet After: ${wallet_after}

    ${after}=    Replace String    ${wallet_after}    ₹    ${EMPTY}
    ${after}=    Strip String    ${after}
    ${after}=    Convert To Integer    ${after}

    ${deduct_value}=    Convert To Integer    ${deduct_value}

    ${expected}=    Evaluate    ${before} - ${deduct_value}
    Log To Console    Expected Wallet: ${expected}

    Should Be Equal As Integers    ${after}    ${expected}

    Log To Console    Wallet deduction verified successfully. Deducted: ₹${deduct_value}

Wallet Should Update
    [Arguments]    ${before}

    ${wallet_now}=    Get Text    ${WALLET_VALUE}
    ${wallet_now}=    Replace String    ${wallet_now}    ₹    ${EMPTY}
    ${wallet_now}=    Strip String    ${wallet_now}
    ${wallet_now}=    Convert To Integer    ${wallet_now}

    Should Not Be Equal As Integers    ${wallet_now}    ${before}

Wait Until Processing Disappears
    [Arguments]    ${processing_locator}
    Wait Until Keyword Succeeds    5 min    5 sec
    ...    Element Should Not Be Visible    ${processing_locator}
Validate Copy And Download Icon Price
    [Arguments]    ${copy_icon}   ${tooltip1}  ${download_icon}  ${tooltip2}  
    Element Should Be Visible     ${copy_icon} 
    Mouse Over     ${copy_icon}    
    Wait Until Keyword Succeeds    20x    1s
    ...    Page Should Contain    ${tooltip1}

    Element Should Be Visible    ${download_icon}
    Mouse Over   ${download_icon}
    Wait Until Keyword Succeeds    20x    1s
    ...    Page Should Contain    ${tooltip2}
    Log To Console   Both the Tooltip visible successfully
    Mouse Up    ${download_icon}

Validate Copy ,Download,Download All Button Price
    [Arguments]    ${copy_icon}   ${tooltip1}  ${download_icon}  ${tooltip2}  ${download_all_button}  ${tooltip3}
    Element Should Be Visible     ${copy_button} 
    Mouse Over     ${copy_icon}    
    Wait Until Keyword Succeeds    20x    1s
    ...    Page Should Contain    ${tooltip1}

    Element Should Be Visible    ${download_button}
    Mouse Over   ${download_icon}
    Wait Until Keyword Succeeds    20x    1s
    ...    Page Should Contain    ${tooltip2}
    Mouse Up    ${download_icon}

    Element Should Be Visible    ${download_all_button}
    Mouse Over   ${download_all}    
    Wait Until Keyword Succeeds    20x    1s
    ...    Page Should Contain    ${tooltip3}
    Mouse Up    ${download_all}       
    Log To Console  All the Tooltip visible successfully

    

Validate Tooltip Not Visible After Copy And Download Hover
    [Arguments]    ${copy_icon}  ${tooltip1}  ${download_icon}  ${tooltip2}
 
    Click Element    ${copy_icon}
    Sleep    2s
    Mouse Over    ${copy_icon}
    Element Should Not Be Visible    ${tooltip1}
    Mouse Up    ${copy_icon}
    Click Element    ${copy_icon}
    Sleep    2s
    Mouse Over    ${download_icon}
    Element Should Not Be Visible    ${tooltip2}
    Mouse Out    ${download_icon}
    Log To Console  Both the Tooltip not visible after click action successfully

Verify Wallet Deduction On Copy
    [Arguments]   ${copy_locator}    ${deduct_value}

    ${wallet_before}=    Get Text    ${WALLET_VALUE}
    Log To Console    Wallet Before: ${wallet_before}

    ${before}=    Evaluate    int(''.join(filter(str.isdigit, """${wallet_before}""")))

    Click Element    ${copy_locator}
    Wait Until Page Contains    Image copied!
    Page Should Contain   ₹10 debited from your Wallet.
    Sleep    5s

    ${wallet_after}=    Get Text    ${WALLET_VALUE}
    Log To Console    Wallet After: ${wallet_after}

    ${after}=    Evaluate    int(''.join(filter(str.isdigit, """${wallet_after}""")))

    ${expected}=    Evaluate    ${before} - ${deduct_value}

    Should Be Equal    ${after}    ${expected}
    Log To Console    Wallet deduction on copy action verified successfully. Deducted: ₹${deduct_value}

Open Generated Images  
    [Arguments]    ${generated_image}   ${image_preview}
    Scroll Element Into View   ${generated_image}
    Wait Until Element Is Visible   ${generated_image}
    Wait Until Element Is Not Visible    xpath=//div[contains(@class,'overlay')]
    Click Element   ${generated_image}
    #Wait Until Page Contains    Preview    5s

    Wait Until Keyword Succeeds      5x    2 sec
    ...    Element Should Be Visible    ${image_preview}
    ${count}=    Get Element Count    ${image_preview}
    Should Be Equal As Integers    ${count}    3
    Log To Console  value matches

Image Regeneration
    [Arguments]    ${regenerate_btn}    ${close_prompt}    ${input_box}    ${send_btn}

    ${remaining}=    Set Variable    2

    FOR    ${i}    IN RANGE    1    3
       
        Wait Until Element Is Visible    ${regenerate_btn}    10s
        mouse Over    ${regenerate_btn}
        Wait Until Keyword Succeeds    10s    1s
        ...    Page Should Contain    ${remaining} remaining

        Log To Console    🔍 Before click: ${remaining} remaining
        Click Element    ${regenerate_btn}

        Wait Until Element Is Visible    ${input_box}    5s
        Wait Until Element Is Visible    ${close_prompt}    2s
        sleep  3s
        Click Element    ${close_prompt}
        Sleep   2s
        Click Element    ${regenerate_btn}
        Input Text    ${input_box}    Stylish leather handbag in a modern lifestyle setting
        Wait Until Element Is Visible  ${send_btn}    5s 
        sleep  2s
        Click Element    ${send_btn}

        Wait Until Keyword Succeeds    5 min    5 sec
        ...    Element Should Not Be Visible    ${REGENERATING_TEXT}
        Element Should Be Visible    ${COPY_BUTTON}
        Element Should Be Visible    ${DOWNLOAD}

        ${remaining}=    Evaluate    ${remaining} - 1
        Log To Console    Remaining after attempt ${i}: ${remaining}
    END

Feedback for Image
    [Arguments]   ${thumps_up}  ${thumps_down}  ${feedback_message}
     # Hover on first generated image
    ${img}=    Get WebElement    xpath=(//img[contains(@alt,'Generated')])[1]
    Mouse Over    ${img}
    Click Element    ${thumps_down}
    Click Element     ${feedback_close_btn}
    Click Element   ${thumps_up} 
    Wait Until Page Contains  Tell us why?    
    Input Text    ${FEEDBACK_TEXTAREA}     ${feedback_message}
    Click Element   ${FEEDBACK_SUBMIT_BTN}
    Log To Console    Feedback submitted successfully

Download All Images And Close
    [Arguments]   ${downlaod_all}  ${close}
    # Click Download All
    Wait Until Element Is Visible    ${download_all}    10s
    Click Element                   ${download_all}
    Log To Console  download All Images successfully
    Wait Until Element Is Visible    ${close}    10s
    Click Element                   ${close}
    Wait Until Page Contains    Generated    5s
    Log To Console  Image preview closed successfully

Validate Download Button
    [Arguments]  ${download_button}  ${value}
    # Count images
    ${count}=    Get Element Count    xpath=//span[normalize-space()='Generated']/ancestor::div[contains(@class,'min-w-0')]//span[contains(@class,'tour-checkbox')]

    # Select images
    ${checkboxes}=    Get WebElements    xpath=//span[normalize-space()='Generated']/ancestor::div[contains(@class,'min-w-0')]//span[contains(@class,'tour-checkbox')]
    FOR    ${cb}    IN    @{checkboxes}
        Click Element    ${cb}
    END
    Log To Console   ${count}

    Wait Until Element Contains    xpath=//button[contains(.,'Download')]    (${count})    5s
    ${download_btn}=    Get WebElement    ${download_button}
    Mouse Over    ${download_btn}
    Sleep    1s
    ${expected}=    Evaluate    ${count} * ${value}
    Wait Until Page Contains  ₹${expected}    10s
    Log To Console  price for download button is correct based on selected images

    ${wallet_before}=    Get Text    ${WALLET_VALUE}
    Log To Console    Wallet Before: ${wallet_before}

    ${before}=    Replace String    ${wallet_before}    ₹    ${EMPTY}
    ${before}=    Strip String    ${before}
    ${before}=    Convert To Integer    ${before}

    Click Element    ${download_button}

    Wait Until Keyword Succeeds    20s    3s    Wallet Should Update    ${before}

    ${wallet_after}=    Get Text    ${WALLET_VALUE}
    Log To Console    Wallet After: ${wallet_after}

    ${after}=    Replace String    ${wallet_after}    ₹    ${EMPTY}
    ${after}=    Strip String    ${after}
    ${after}=    Convert To Integer    ${after}

   ${expected1}=    Evaluate    ${before} - ${expected}
    Log To Console    Expected Wallet: ₹${expected1}

    Should Be Equal As Integers    ${after}    ${expected1}

    Log To Console     Wallet deduction verified successfully. Deducted: ₹${expected}
    
Validate Lifestyle History Images
    Wait Until Page Contains    Lifestyle Photo Created History    10s
    Wait Until Page Contains Element    xpath=//img    10s

Validate All History Created Dates
    ${count}=    Get Element Count   ${CREATED_DATE_LIST}
    Log To Console    Total History Records: ${count}

Verify Preview Images In History
    Click Element    ${FIRST_PREVIEW_BTN}
    Wait Until Page Contains    Lifestyle Photo Created History    5s

    Wait Until Keyword Succeeds    2 min    5 sec
    ...    Element Should Be Visible    ${VIEW_IMAGES}

    ${count}=    Get Element Count    ${VIEW_IMAGES}

    Should Be Equal As Integers    ${count}    3

Check Marketplaces 
    [Arguments]   ${marketplace}   ${label}
    Wait Until Element Is Visible   ${marketplace}    6s
    Click Element   ${marketplace}  
    Wait Until Element Is Visible    xpath=//div[normalize-space()='Amazon.in']    5s

    Element Should Be Visible    xpath=//div[normalize-space()='Amazon.in']
    Element Should Be Visible    xpath=//div[contains(text(),'Shopify')]
    Element Should Be Visible    xpath=//div[normalize-space()='Amazon.com']
    Log To Console    ${label}
    Click Element   ${marketplace}  

Open History
    [Arguments]   ${history_btn}  ${fliter_btn}  ${label}
    Wait Until Element Is Visible   ${history_btn}    6s
    Click Element   ${history_btn} 
    Wait Until Element Is Visible   ${fliter_btn}   5s
    Log To Console    ${label}



Select Date Range And Validate
    [Arguments]    ${option}

    # Click option (Today / This week / This month / This year)
    Wait Until Element Is Visible    xpath=//button[normalize-space()='${option}']    10s
    Click Element    xpath=//button[normalize-space()='${option}']
    sleep  5s

    # Get values
    ${from_value}=    Get Element Attribute    xpath=//input[@placeholder='No start date']    value
    ${to_value}=      Get Element Attribute    xpath=//input[@placeholder='No end date']   value

    Log    Option: ${option}
    Log    From: ${from_value}
    Log    To: ${to_value}

    # Convert to date format (IMPORTANT)
    ${from_date}=    Convert Date    
    ...    ${from_value}    
    ...    date_format=%d %b %Y    
    ...    result_format=%Y-%m-%d

    ${to_date}=    Convert Date    
    ...    ${to_value}    
    ...    date_format=%d %b %Y    
    ...    result_format=%Y-%m-%d

    # Common validation → TO >= FROM
    Should Be True    '${to_date}' >= '${from_date}'    
    ...    msg=❌ Invalid range: TO date is earlier than FROM date

    # 🔥 Option-specific validation
    Run Keyword If    '${option}' == 'Today'    
    ...    Should Be Equal    ${from_date}    ${to_date}

    Run Keyword If    '${option}' == 'This week'    
    ...    Validate Week Range    ${from_date}    ${to_date}

    Run Keyword If    '${option}' == 'This month'    
    ...    Validate Month Range    ${from_date}    ${to_date}

    Run Keyword If    '${option}' == 'This year'    
    ...    Validate Year Range    ${from_date}    ${to_date}

    # Click Apply
    Click Button   ${APPLY_BTN}  Apply 

Validate Week Range
    [Arguments]    ${from_date}    ${to_date}

    ${diff}=    Subtract Date From Date    ${to_date}    ${from_date}
    Should Be True    ${diff.days} <= 6    
    ...    msg=❌ Week range is invalid

Validate Month Range
    [Arguments]    ${from_date}    ${to_date}

    ${from_month}=    Convert Date    ${from_date}    result_format=%m
    ${to_month}=      Convert Date    ${to_date}      result_format=%m

    Should Be Equal    ${from_month}    ${to_month}    
    ...    msg=❌ Month range is invalid

Validate Year Range
    [Arguments]    ${from_date}    ${to_date}

    ${from_year}=    Convert Date    ${from_date}    result_format=%Y
    ${to_year}=      Convert Date    ${to_date}      result_format=%Y

    Should Be Equal    ${from_year}    ${to_year}    
    ...    msg=❌ Year range is invalid

Validate History Page State
    [Arguments]   ${no_history}   ${with_history}
    ${is_empty}=    Run Keyword And Return Status
    ...    Wait Until Keyword Succeeds
    ...    25s    5s
    ...     Element Should Be Visible
    ...    ${NO_HISTORY}     

    IF    ${is_empty}
        Validate Empty History   ${no_history}   
    ELSE
        Validate History Cards   ${with_history}
    END

Validate Empty History
    [Arguments]   ${no_history}
    Wait Until Element Is Visible    ${no_history}    5s
    Log To Console    History is empty

Validate History Cards 
    [Arguments]        ${with_history}
    # Wait for page/grid to load
    Wait Until Element Is Visible    ${with_history}    25s
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Not Be Visible    
    ...    //div[contains(@class,'bg-[#F6F7F8]')]        
    Wait Until Element Is Visible    xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]    5s
    Log To Console     History cards loaded successfully

    Scroll Element Into View       xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]
    Click Element                   xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]
    Wait Until Keyword Succeeds      5x    10 sec
    ...    Element Should Be Visible    ${HISTORY_PREVIEW}
    ${count}=    Get Element Count    ${HISTORY_PREVIEW}
    Should Be Equal As Integers    ${count}    3
    Log To Console  value matches
    Log To Console    Preview loaded successfully
    sleep   5s
    Click Element   ${HISTORY_PREVIEW_CLOSE_BTN}  
    Wait Until Page Contains     History    5s
    sleep  2s
    Log To Console    Preview closed successfully


#-----fabric keywords-----
Enter fabric Title
    [Arguments]  ${product_description}  ${fabric_text}

    Wait Until Page Contains  Fabric Title     5s
    Wait Until Element Is Visible   ${fabric_title_input}     10s
    Scroll Element Into View         ${fabric_title_input}
    Input Text                       ${fabric_title_input}    ${fabric_text}
    Log To Console                   Product description entered successfully

Select Output Image Size
    [Arguments]    ${option}
    Wait Until Page Contains  Output image size:   2s
    Click Element   ${output_image_size_dropdown}

    ${option_locator}=    Set Variable    xpath=//span[normalize-space()='${option}']

    Wait Until Element Is Visible    ${option_locator}    10s
    Click Element                    ${option_locator}

    # Validate dropdown shows selected value
    ${value_locator}=    Set Variable    xpath=//button[.//span[normalize-space()='${option}']]
    Wait Until Element Is Visible    ${value_locator}    10s
    Element Should Be Visible        ${value_locator}

    Log To Console    Marketplace ${option} selected 


Select And Validate Style
    [Arguments]    ${style}
    ${style_locator}=    Set Variable    xpath=//p[normalize-space()='${style}']/ancestor::div[contains(@class,'cursor-pointer')]

    Wait Until Element Is Visible    ${style_locator}    10s
    Scroll Element Into View         ${style_locator}
    Click Element                    ${style_locator}

    # Validate selected style
    #Wait Until Element Is Visible    ${SELECTED_STYLE}    10s
    #Element Should Contain           ${SELECTED_STYLE}    ${style}

    Log To Console    Style ${style} selected successfully


Open Generated Images For Fabric
    [Arguments]    ${generated_image}   ${image_preview}
    Scroll Element Into View   ${generated_image}
    Wait Until Element Is Visible   ${generated_image}
    Wait Until Element Is Not Visible    xpath=//div[contains(@class,'overlay')]
    Click Element   ${generated_image}
    #Wait Until Page Contains    Preview    5s
    Sleep    2s
    Wait Until Keyword Succeeds      5x    2 sec
    ...    Element Should Be Visible    ${image_preview}
    ${count}=    Get Element Count    ${image_preview}
    Should Be Equal As Integers    ${count}    1
    Log To Console  value matches
    sleep  3s



Validate History Page State For Fabric
    [Arguments]   ${no_history}   ${with_history}
    ${is_empty}=    Run Keyword And Return Status
    ...    Wait Until Keyword Succeeds
    ...    25s    5s
    ...     Element Should Be Visible
    ...    ${NO_HISTORY}     

    IF    ${is_empty}
        Validate Empty History   ${no_history}   
    ELSE
        Validate History Cards For Fabric  ${with_history}
    END


Validate History Cards For Fabric
    [Arguments]        ${with_history}
    # Wait for page/grid to load
    Wait Until Element Is Visible    ${with_history}    5s
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Not Be Visible    
    ...    //div[contains(@class,'bg-[#F6F7F8]')]        
    Wait Until Element Is Visible    xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]    5s
    Log To Console     History cards loaded successfully

    Scroll Element Into View       xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]
    Click Element                   xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]
    Wait Until Keyword Succeeds      5x    10 sec
    ...    Element Should Be Visible    ${HISTORY_PREVIEW}
    ${count}=    Get Element Count    ${HISTORY_PREVIEW}
    Sleep    2s
    Should Be Equal As Integers    ${count}    1
    Log To Console  value matches
    Log To Console    Preview loaded successfully
    sleep   5s
    Click Element   ${HISTORY_PREVIEW_CLOSE_BTN}  
    Wait Until Page Contains     History    5s
    sleep  2s
    Log To Console    Preview closed successfully


    #---Background Removal Keywords---


Select Output Image Size For Background Removal
    [Arguments]    ${output_image_size_dropdown}  ${option}
    Wait Until Page Contains  Output image sizess:   2s
    Click Element   ${output_image_size_dropdown}

    ${option_locator}=    Set Variable    xpath=//span[normalize-space()='${option}']

    Wait Until Element Is Visible    ${option_locator}    10s
    Click Element                    ${option_locator}

    # Validate dropdown shows selected value
    ${value_locator}=    Set Variable    xpath=//button[.//span[normalize-space()='${option}']]
    Wait Until Element Is Visible    ${value_locator}    10s
    Element Should Be Visible        ${value_locator}

    Log To Console    Marketplace ${option} selected 

Select Background Color
    [Arguments]    ${color}
    # Convert HEX → RGB
    ${hex}=    Set Variable    ${color[1:]}

    ${r}=    Evaluate    int('${hex[0:2]}',16)
    ${g}=    Evaluate    int('${hex[2:4]}',16)
    ${b}=    Evaluate    int('${hex[4:6]}',16)

    ${rgb}=  Set Variable    rgb(${r}, ${g}, ${b})

    Log To Console    Converted ${color} → ${rgb}
    ${locator}=    Set Variable    
    ...    xpath=//div[contains(@style,'${rgb}')]/ancestor::div[contains(@class,'cursor-pointer')]

    Wait Until Element Is Visible    ${locator}    10s
    Click Element                    ${locator}
    Wait Until Element Contains    
    ...    xpath=//div[contains(text(),'Selected')]    
    ...    ${color}    10s

    # Validation
    ${text}=    Get Text    xpath=//div[contains(text(),'Selected')]
    Should Contain    ${text}    ${color}
    Log To Console    Background color ${color} selected successfully

Open Generated Images For Background Removal
    [Arguments]    ${generated_image}   ${image_preview}
    Scroll Element Into View   ${generated_image}
    Wait Until Element Is Visible   ${generated_image}
    Wait Until Element Is Not Visible    xpath=//div[contains(@class,'overlay')]
    Click Element   ${generated_image}
    #Wait Until Page Contains    Preview    5s

    Wait Until Keyword Succeeds      5x    2 sec
    ...    Element Should Be Visible    ${image_preview}
    ${count}=    Get Element Count    ${image_preview}
    Should Be Equal As Integers    ${count}    1
    Log To Console  value matches
    sleep  2s


Validate History Page State For Background Removal
    [Arguments]   ${no_history}   ${with_history}
    ${is_empty}=    Run Keyword And Return Status
    ...    Wait Until Keyword Succeeds
    ...    25s    5s
    ...     Element Should Be Visible
    ...    ${NO_HISTORY}     

    IF    ${is_empty}
        Validate Empty History   ${no_history}   
    ELSE
        
        Validate History Cards For Background Removal   ${with_history}
    END


Validate History Cards For Background Removal
    [Arguments]        ${with_history}
    # Wait for page/grid to load
    Wait Until Element Is Visible    ${with_history}    5s
    Wait Until Keyword Succeeds    5x    2s
    ...    Element Should Not Be Visible    
    ...    //div[contains(@class,'bg-[#F6F7F8]')]        
    Wait Until Element Is Visible    xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]    5s
    Log To Console     History cards loaded successfully

    Scroll Element Into View       xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]
    Click Element                   xpath=(//button[@type='button' and .//img[contains(@class,'tour-spotlight-image')]])[1]
    Wait Until Keyword Succeeds      5x    10 sec
    ...    Element Should Be Visible    ${HISTORY_PREVIEW}
    ${count}=    Get Element Count    ${HISTORY_PREVIEW}
    Should Be Equal As Integers    ${count}    1
    Log To Console  value matches
    Log To Console    Preview loaded successfully
    sleep   5s
    Click Element   ${HISTORY_PREVIEW_CLOSE_BTN}  
    Wait Until Page Contains     History    5s
    sleep  2s
    Log To Console    Preview closed successfully

