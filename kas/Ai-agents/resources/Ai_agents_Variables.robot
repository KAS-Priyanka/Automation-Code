*** Settings ***
Library    SeleniumLibrary
Library    Process
Library    Collections
Library    String


*** Variables ***

#--variables for login--
${PAGE_HEADING}       xpath=//span[normalize-space()='Log In']
${CREATE_ACCOUNT_TAB}  xpath=//a[.//span[normalize-space()='Create account']]
${EMAIL_INPUT}        xpath=//input[@type='email']
${PASSWORD_INPUT}     xpath=//input[@type='password']
${CONTINUE_BTN}       xpath=//button[normalize-space()='Continue']

#---Settings---
${PROFILE_ICON}   xpath=//div[contains(@class,'bg-semantic-green')]/ancestor::div[contains(@class,'cursor-pointer')]
${SETTINGS}      xpath=//button[.//span[normalize-space()='Settings']]
${LOGOUT_BTN}     xpath=//button[.//span[normalize-space()='Log out']]
${HELP_SUPPORT_BTN}    xpath=//button[.//span[normalize-space()='Help & Support']]

#----Ai-agents-----
${AGENT_SEARCH_BOX}    xpath=//input[@placeholder='Search for Agents']
${WALLET_LABEL}    xpath=//span[normalize-space()='Wallet:']
${WALLET_VALUE}    xpath=//span[normalize-space()='Wallet:']/following-sibling::span
${ADD_BUTTON}    xpath=//button[normalize-space()='Add']
${ENTER_AMOUNT_INPUT}   xpath=//input[@placeholder='0.00']
${CANCEL_BUTTON}    xpath=//button[normalize-space()='Cancel']
${MAKE_PAYMENT_BUTTON}    xpath=//button[normalize-space()='Make Payment']
${AVAILABLE_BALANCE}      xpath=//span[contains(text(),'Available Balance')]/following-sibling::span
${PAYMENT_HISTORY_BTN}    xpath=//button[.//text()[normalize-space()='Payment history']]
${PAYMENT_HISTORY_EMPTY}    xpath=//div[.//h2[normalize-space()='Wallet Payment History']]//table//td[contains(.,'No data available')]
${PAYMENT_HISTORY_WITH DATA}    xpath=//h2[normalize-space()='Wallet Payment History']/ancestor::div//table
${RECEIPT_BUTTON}    xpath=//button[normalize-space()='Reciept']
${RAZORPAY_IFRAME}      xpath=//iframe[contains(@src,'razorpay')]
${MOBILE_FIELD}       xpath=//input[@type='tel']
${TOTAL_AMOUNT}    xpath=//h3[@data-value]
${RAZORPAY_CLOSE_BTN}     xpath=//button[@data-testid='checkout-close']
${YES_EXIT_BTN}    xpath=//button[normalize-space()='Yes, exit']
${PAYMENT_CANCELLED_TOAST}    xpath=//div[contains(text(),'Payment cancelled')]
${WALLET_CLOSE_BTN}    xpath=//button[@aria-label='Close']

${ALL_FILTER}                xpath=//button[normalize-space()='All']
${VISUAL_INTELLIGENCE}       xpath=//button[normalize-space()='Visual Intelligence']
${LISTING_INTELLIGENCE}      xpath=//button[normalize-space()='Listing Intelligence']

#---lifestyle photo creator---
${LIFESTYLE_CARD}     xpath=//h3[normalize-space()='Lifestyle Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]
${LIFESTYLE_TITLE}    xpath=//h3[normalize-space()='Lifestyle Image Creator']
${LIFESTYLE_PRICE}    xpath=//h3[normalize-space()='Lifestyle Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]//span[normalize-space()='₹15']
${LIFESTYLE_AGENT_LUNCH_BTN}  xpath=//h3[normalize-space()='Lifestyle Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]//button[normalize-space()='Launch']
${GENERATE_CONTENT_BTN}   xpath=//*[name()='path' and contains(@d,'M256 48C141.31 48')]/ancestor::*[name()='svg']
${HELP_BTN}     xpath=//button[contains(@class,'h-8') and contains(@class,'w-8')]

#---ASIN input---
${ASIN_INPUT}    xpath=//input[contains(@class,'flex-1')]
${ASIN_MARKETPLACE_DROPDOWN}   xpath=//button[contains(@class,'inline-flex')][.//img[contains(@alt,'Amazon')]]
${INVALID_ASIN_ERROR}    xpath=//p[normalize-space()='Enter a valid ASIN']
${UPLOAD_BUTTON}    xpath=//button[.//span[normalize-space()='Upload']]

${IMAGE_REMOVE_BUTTON}  xpath=(//div[contains(@class,'rounded-2xl') and .//img]//button[normalize-space()='Remove'])[2]

${PRODUCT_DESCRIPTION}    xpath=//input[@placeholder='Stainless steel water bottle with matte finish']
${KEY_FEATURES_INPUT}     xpath=//label[normalize-space()='Key Features:']/following::input[1]
${MARKETPLACE_DROPDOWN}    xpath=//label[normalize-space()='Marketplace:']/following::button[1]
${AUTO_TAB}            xpath=//*[normalize-space()='Auto']
${THEMES_TAB}          xpath=//*[normalize-space()='Themes']
#${SELECTED_THEME_TEXT}   xpath=//button[contains(@class,'bg-primary') and contains(@class,'text-white')]//span[1]
${SELECTED_THEME}    xpath=//p[contains(text(),'Selected:')]

${SCENE_INPUT}         xpath=//label[normalize-space()='Scene Instructions:']/following::input[1]
# ${MOUNTAIN_ESCAPE}        xpath=//p[normalize-space()='Mountain Escape']/ancestor::button
# ${MODERN_OFFICE}          xpath=//p[normalize-space()='Modern Office']/ancestor::button
# ${COZY_HOMES}             xpath=//p[normalize-space()='Cozy Homes']/ancestor::button
# ${URBAN_STREET_VIBE}      xpath=//p[normalize-space()='Urban Street Vibe']/ancestor::button
# ${SUNRISE_FIELDS}         xpath=//p[normalize-space()='Sunrise Over Fields']/ancestor::button
# ${ELEGANT_DINING}         xpath=//p[normalize-space()='Elegant Dining']/ancestor::button
# ${WINTER_WONDERLAND}      xpath=//p[normalize-space()='Winter Wonderland']/ancestor::button
# ${SPORTS_STADIUM}         xpath=//p[normalize-space()='Sports Stadium']/ancestor::button

${CUSTOM_TAB}          xpath=//*[normalize-space()='Custom']
${SCENE_INSTRUCTION_INPUT}  xpath=//label[contains(text(),'Style Instructions')]/following::input[1]
${FILE_UPLOAD_INPUT}    xpath=//input[@type='file']

${INVALID_IMAGE}   E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\invalid.pdf
${INVALID_IMAGE_ERROR}  xpath=(//div[contains(@class,'Toastify__toast') and contains(.,'Only JPG')])[last()]
${INVALID_EXCEL_SHEET}  xpath=E:\\selenium project\\kas\\MS_Dashboard_Automation\\Ai-agents\\AI-agents images\\invalid_excel_sheet.xlsx
${TEMPLATE_DOWNLOAD_BUTTON}  xpath=//button[normalize-space()='Download template']
${VALID_IMAGE}      E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\bag.jpg

@{IMAGES}
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img1.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img2.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img3.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img4.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img5.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img6.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img7.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img8.jpg
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img9.png
...    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\img10.jpg
${VALID_EXCEL_SHEET_LIFESTYLE}       E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\Valid_Lifestyle_Agent.xlsx
${VALID_EXCEL_SHEET_INFOGRAPHIC}       E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\Valid_Infographic_Agent.xlsx
${VALID_EXCEL_SHEET_BACKGROUND_CHANGE}  E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\Valid_Background_Change.xlsx

${EXCEL_SUCCESS_POPUP}  xpath=//div[contains(text(),'Excel data extracted')]
${DESELECT_ALL_BUTTON}    xpath=//button[contains(.,'Deselect all')]
${SELECTION_ICON}  xpath=//*[contains(@class,'driver-active-element')]
${DOWNLOAD_BUTTON}    xpath=//button[contains(.,'Download')]
${REMOVE_BUTTON}    xpath=//button[contains(.,'Remove')]
${UPLOADED_IMAGE_PREVIEW}  xpath=//img[contains(@class,'tour-spotlight-image')]
#${UPLOADED_IMAGE_WITH_TICK}    xpath=//div[contains(@class,'tour-spotlight-shell') and contains(@class,'border-[#4F96E2]')]/ancestor::button
${UPLOADED_IMAGE_WITH_TICK}  xpath=//div[@role='button']//div[contains(@class,'bg-[#1573D6]')][.//*[name()='svg']]
${REMOVE_BTN}       xpath=//button[contains(.,'Remove')]
${GENERATE_BTN}     xpath=//button[contains(.,'Generate')]
${SELECTION_LABEL}  xpath=//span[contains(.,'selected')]
${SELECT_ALL_BUTTON}    xpath=//button[normalize-space()='Select all']
${PRICE}    xpath=(//span[contains(@class,'body-text-secondary') and contains(text(),'₹')])[1]

${PROCESSING_TEXT}    xpath=//*[contains(text(),'Processing')]
${GENERATED_STATUS}    xpath=//span[contains(text(),'Generated')]
${FALIED_STATUS}    xpath=//span[contains(text(),'Failed')]
${GENERATED_IMAGE}    xpath=//div[@role='button'][following-sibling::span//span[normalize-space()='Generated']]
${PREVIOUS_IMAGE_BTN}    xpath=(//div[@role='button'])[1]//button[contains(@class,'left-[5px]')]
${NEXT_IMAGE_BTN}    xpath=(//button[contains(@class,'right-[5px')])[last()]

${COPY_ICON}    xpath=(//button[contains(@class,'w-8') and contains(@class,'h-8')])[2]
${DOWNLOAD_ICON}   xpath=(//button[contains(@class,'w-8') and contains(@class,'h-8')])[3]
${IMAGE_PREVIEW}     xpath=//img[contains(@alt,'Generated')]
${ACTIVE_IMAGE_CARD}    xpath=//div[@role='button'][.//button[contains(@class,'left-[5px]') and not(@disabled)] and .//button[contains(@class,'right-[5px]') and not(@disabled)]]
${LEFT_ACTIVE_IMAGE_CARD}  xpath=//div[@role='button'][.//img[contains(@class,'tour-spotlight-image')] and .//button[contains(@class,'left-[5px]') and not(@disabled)] and not(.//button[contains(@class,'right-[5px]') and not(@disabled)])]
${DOWNLOAD_BTN}  xpath=//button[contains(text(),'Download')]
${COPY_BUTTON}        xpath=(//button[.//span[text()='Copy']])[1]
${DOWNLOAD}    xpath=(//button[.//span[text()='Download']])[1]
${REGENERATE_BUTTON}  xpath=(//button[contains(text(),'Regenerate')])[1]
${INPUT_BOX}       xpath=//input[@placeholder='Enter prompt (optional)']
${REGENERATING_TEXT}  xpath=//div[text()='Regenerating...']
${SEND_BTN}       xpath=//button[@aria-label='Submit prompt']
${CLOSE_PROMPT}       xpath=//button[@aria-label='Close prompt']
${GENERATED_IMAGE1}    xpath=(//img[contains(@alt,'Generated')])[1]
${GENERATED_IMAGE2}    xpath=(//img[contains(@alt,'Generated')])[2]
${GENERATED_IMAGE3}    xpath=(//img[contains(@alt,'Generated')])[3]

${THUMBS_UP_BTN1}    xpath=(//button[@aria-label='Like'])[1]
${THUMBS_DOWN_BTN1}    xpath=(//button[@aria-label='Dislike'])[1]
${THUMBS_UP_BTN2}    xpath=(//button[@aria-label='Like'])[2]
${THUMBS_DOWN_BTN2}    xpath=(//button[@aria-label='Dislike'])[2]
${THUMBS_UP_BTN3}    xpath=(//button[@aria-label='Like'])[3]
${THUMBS_DOWN_BTN3}    xpath=(//button[@aria-label='Dislike'])[3]
${FEEDBACK_POPUP}    xpath=//div[contains(@class,'absolute') and .//h3[text()='Tell us why?']]
${FEEDBACK_CLOSE_BTN}  xpath=//button[@aria-label='Close feedback']
${THUMBS_UP_FEEDBACK_TEXTAREA}    xpath=//textarea[@placeholder='Add comment']
${THUMBS_DOWN_FEEDBACK_TEXTAREA}    xpath=//textarea[@placeholder='Add comment or describe the issue']
${FEEDBACK_SUBMIT_BTN}   xpath=//button[text()='Submit']
${VIEW_IMAGES}    xpath=//img[@alt='lifestyle']
${CLOSE_BUTTON}    xpath=//button[normalize-space()='Close']
${DOWNLOAD_ALL}    xpath=//button[normalize-space()='Download all']
${IMAGE_NO}    xpath=//button[contains(@class,'group')]//img
${IMAGE_BLUE_TICK}   xpath=//span[contains(@class,'tour-checkbox')]
${AI_AGENTS_TAB}    xpath=//span[normalize-space()='AI Agents']
${LIFESTYLE_Image_CREATOR_TAB}    xpath=//span[contains(text(),'Lifestyle Image Creator')]

${MARKETPLACES_BTN}   xpath=//button[.//span[text()='Marketplaces']]

#----History---
${HISTORY_BTN}   xpath=//button[.//span[text()='History']]

${FILTER_BTN}    xpath=//button[.//span[normalize-space()='Filter']]
${APPLY_BTN}    xpath=//button[normalize-space()='Apply']
${WITH_HISTORY}  xpath=//img[contains(@class,'tour-spotlight-image')]
${NO_HISTORY}    xpath=//p[text()='History not available']
${HISTORY_PREVIEW}   xpath=(//img[contains(@alt,'Generated')])
${HISTORY_PREVIEW_CLOSE_BTN}     xpath=//div[contains(@class,'flex justify-end')]//button
#---infographic Creator----

${INFOGRAPHIC_IMAGE_CREATOR_CARD}     xpath=//h3[normalize-space()='Infographic Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]
${INFOGRAPHIC_TITLE}    xpath=//h3[normalize-space()='Infographic Image Creator']
${INFOGRAPHIC_PRICE}    xpath=//h3[normalize-space()='Infographic Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]//span[normalize-space()='₹15']
${INFOGRAPHIC_AGENT_LAUNCH_BTN}  xpath=//h3[normalize-space()='Infographic Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]//button[normalize-space()='Launch']
${INFOGRAPHIC__IMAGE_CREATOR_TAB}    xpath=//span[normalize-space()='Infographic Image Creator']
${NO_IMAGES}    xpath=(//div[normalize-space()='No image'])[1]

#----history-----
${CREATED_DATE_LIST}  xpath=//p[contains(.,'Created At')]//span
${FIRST_PREVIEW_BTN}    xpath=(//button[normalize-space()='Preview'])[1]
${GENERATE_CONTENT}          xpath=//p[text()='Generate New Content']

#Banner Image Creator
${BANNER_IMAGE_CREATOR_CARD}     xpath=//h3[normalize-space()='Banner Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]
${BANNER_IMAGE_CREATOR_TITLE}    xpath=//h3[normalize-space()='Banner Image Creator']
${BANNER_IMAGE_CREATOR_PRICE}    xpath=//h3[normalize-space()='Banner Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]//span[normalize-space()='₹15']
${BANNER_IMAGE_CREATOR_AGENT_LAUNCH_BTN}  xpath=//h3[normalize-space()='Banner Image Creator']/ancestor::div[contains(@class,'cursor-pointer')]//button[normalize-space()='Launch']
${BANNER_IMAGE_CREATOR_TAB}    xpath=//span[normalize-space()='Banner Image Creator']    
${LOGO_UPLOAD_BUTTON}    xpath=//label[normalize-space()='Logo (Optional):']/following-sibling::button
${LOGO_IMAGE}    E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\logo.jpg
${BANNER_SIZE_DROPDOWN}  xpath=//label[normalize-space()='Banner Size:']/following::button[1]
#Fabric Detail Creator
${FABRIC_DETAIL_CREATOR_CARD}    xpath=//h3[normalize-space()='Fabric Detail Creator']/ancestor::div[contains(@class,'cursor-pointer')]

${FABRIC_DETAIL_CREATOR_TITLE}    xpath=//h3[normalize-space()='Fabric Detail Creator']
${FABRIC_DETAIL_CREATOR_PRICE}    xpath=//h3[normalize-space()='Fabric Detail Creator']/ancestor::div[contains(@class,'cursor-pointer')]//span[normalize-space()='₹15']
${FABRIC_DETAIL_CREATOR_AGENT_LAUNCH_BTN}  xpath=//h3[normalize-space()='Fabric Detail Creator']/ancestor::div[contains(@class,'cursor-pointer')]//button[normalize-space()='Launch']
${FABRIC_DETAIL_CREATOR_TAB}    xpath=//span[normalize-space()='Fabric Detail Creator']
${FABRIC_DETAIL_CREATOR_VALID_IMAGE}      E:\\selenium project\\kas\\MS_Dashboard_Automation\\Ai-agents\\AI-agents images\\green_sadi.jpg
${FABRIC_TITLE_INPUT}       xpath=//input[@placeholder='e.g. Premium Cotton Fabric']
${OUTPUT_IMAGE_SIZE_DROPDOWN}   xpath=//label[normalize-space()='Output image size:']/following::button[1]
${STYLE}  xpath=//button[.//span[normalize-space()='Style']]

#Background Remover
${BACKGROUND_REMOVER_CARD}    xpath=//h3[normalize-space()='Background Remover']/ancestor::div[contains(@class,'cursor-pointer')]
${BACKGROUND_REMOVER_TITLE}    xpath=//h3[normalize-space()='Background Remover']
${BACKGROUND_REMOVER_PRICE}    xpath=//h3[normalize-space()='Background Remover']/ancestor::div[contains(@class,'cursor-pointer')]//span[normalize-space()='₹10']
${BACKGROUND_REMOVER_AGENT_LAUNCH_BTN}  xpath=//h3[normalize-space()='Background Remover']/ancestor::div[contains(@class,'cursor-pointer')]//button[normalize-space()='Launch']
${BACKGROUND_REMOVER_TAB}    xpath=//span[normalize-space()='Background Remover']
${BACKGROUND_REMOVER_VALID_IMAGE}      E:\\selenium project\\kas\\Ai-agents\\AI-agents images\\food_jar.jpg
${OUTPUT_IMAGE_SIZE_DROPDOWN2}   xpath=//label[normalize-space()='Output image sizess:']/following::button[1]


#Color Variant Creator
${COLOR_VARIANT_CREATOR_CARD}    xpath=//h3[normalize-space()='Color Variant Creator']/ancestor::div[contains(@class,'cursor-pointer')]
${PRODUCT_VIDEO_CREATOR_CARD}    xpath=//h3[normalize-space()='Product Video Creator']/ancestor::div[contains(@class,'cursor-pointer')]
${COMPETITOR_TRACKER_CARD}    xpath=//h3[normalize-space()='Competitor Tracker']/ancestor::div[contains(@class,'cursor-pointer')]
${KEYWORD_INTELLIGENCE_CARD}    xpath=//h3[normalize-space()='Keyword Intelligence']/ancestor::div[contains(@class,'cursor-pointer')]
${CROSS_MARKETPLACE_LISTING_AGENT_CARD}    xpath=//h3[normalize-space()='Cross Marketplace Listing Agent']/ancestor::div[contains(@class,'cursor-pointer')]

${AI_LISTING_CREATOR_CARD}    xpath=//h3[normalize-space()='AI Listing Creator']/ancestor::div[contains(@class,'cursor-pointer')]

${IMAGE_ENHANCER_CARD}    xpath=//h3[normalize-space()='Image Enhancer']/ancestor::div[contains(@class,'cursor-pointer')]

${BANNER_CREATOR_CARD}    xpath=//h3[normalize-space()='Banner Creator']/ancestor::div[contains(@class,'cursor-pointer')]