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

#----Wallet-----
${AGENT_SEARCH_BOX}    xpath=//input[@placeholder='Search for Agents']
${WALLET_LABEL}    xpath=//span[normalize-space()='Wallet:']
${WALLET_VALUE}    xpath=//span[normalize-space()='Wallet:']/following-sibling::span
${ADD_BUTTON}    xpath=//button[normalize-space()='Add']

#--Session Page---
${GENERATE_LISTING}    xpath=//button//span[text()='Generate Listing']
${NEW_SESSION_BTN}    xpath=//button[normalize-space()='New Session']
${CHAT_INPUT}        xpath=//textarea[contains(@class,'flex-1')]
${SEND_BUTTON}       xpath=(//textarea/ancestor::div[contains(@class,'rounded')]//button)[4]
${AI_RESPONSE}    xpath=//div[@data-message-index='1']
@{expected_marketplaces}    Amazon.in    Amazon.com    Amazon.co.uk  Shopify.com/in
${AI_LOADING}    xpath=//div[contains(@class,'rounded-2xl') and contains(@class,'shadow-sm') and contains(@class,'border')]
${HISTORY_BTN}    xpath=//button[.//div[normalize-space()='New Session']]//div[contains(@class,'cursor-pointer')][2]
${HISTORY_LOADER}   xpath=//div[contains(@class,'smallLoader')]
${THINKING}   xpath=//span[contains(text(),'Thinking')]/ancestor::div[contains(@class,'cursor-pointer')]
#---Memory---
${MEMORY_BTN}     xpath=//span[text()='Memory']/parent::div
${NO_MEMORY_TEXT}    xpath=//h3[contains(text(),'No memories saved')]
${MEMORY_HEADER}    xpath=//p[normalize-space()='Memories:']
${MEMORY_CHIPS}     xpath=//p[normalize-space()='Memories:']/following-sibling::div//span[contains(@class,'body-text-primary')]
${AI_LABEL}         xpath=//span[normalize-space()='AI Understanding:']
${AI_CONTENT}       xpath=//span[normalize-space()='AI Understanding:']/following::div[contains(@class,'rounded')][1]//span
${MEMORY_CLOSE_BTN}  xpath=//div[contains(@class,'headline-small') and contains(.,'Memory')]//following::button[1]

${ANALYSIS_TABLE}           xpath=//h2[text()='Analysis Table']
${EXPORT_BTN}    xpath=//h2[text()='Analysis Table']/ancestor::div[contains(@class,'border')]//button[.//text()[contains(.,'Export')]]
${WALLET_BALANCE}   xpath=//div[contains(text(),'Wallet Balance')]
${WALLET_BALANCE_VALUE}    xpath=(//div[.//text()[normalize-space()='Wallet Balance']]//span[contains(@class,'text-') and (contains(text(),'₹') or contains(text(),'$'))])[2]