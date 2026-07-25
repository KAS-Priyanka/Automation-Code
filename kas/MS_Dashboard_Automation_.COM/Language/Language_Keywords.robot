*** Settings ***
Library    SeleniumLibrary
Library    Process

Library    DateTime
Library    String
Library    RequestsLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource     Language_Variables.robot

*** Keywords ***

Open Page From Sales
    [Arguments]    ${locator}    ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                    ${locator}
    Log To Console    ${label} 

Open Page From Inventory
    [Arguments]    ${locator}      ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                    ${locator}
    Log To Console    ${label}

Open Page From Fulfillment
    [Arguments]    ${locator}   ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                   ${locator}
    Log To Console    ${label}

Select Language From Dropdown For All Pages
    [Arguments]    ${dropdown_locator}   ${language}
    # Select language
    Click Element    ${dropdown_locator}
    Click Element    xpath=//span[normalize-space()='${language}']/parent::div
    Set Global Variable    ${SELECTED_LANG}    ${language}
    Log To Console    ${language} Selected successfully

Validate Language On Other Page
    [Arguments]    ${page_dict}
    Should Not Be Empty    ${SELECTED_LANG}
    Log To Console     Validating language: ${SELECTED_LANG}
    ${expected}=    Get From Dictionary    ${page_dict}    ${SELECTED_LANG}

    Wait Until Keyword Succeeds    5x    1s
    ...    Page Should Contain    ${expected}

    Log To Console     ${SELECTED_LANG} language validated on page


Select Language From Dropdown1
    [Arguments]    ${dropdown_locator}    ${language}

    # Get language code from dictionary
    ${lang_code}=    Get From Dictionary    ${LANG_CODES}    ${language}

    # Select language
    Click Element    ${dropdown_locator}
    Click Element    xpath=//span[normalize-space()='${language}']/parent::div

    # Store selected language globally
    Set Global Variable    ${SELECTED_LANG}    ${language}

    Sleep    3s

    # Capture network entries
    ${entries}=    Execute Javascript
    ...    return JSON.stringify(window.performance.getEntries());

    # Validate selected language code in network requests
    Should Match Regexp
    ...    ${entries}
    ...    .*(${lang_code}|lang=${lang_code}|locale=${lang_code}).*

    Log To Console    ${language} validated successfully


Validate Selected Language
    [Arguments]    ${dropdown_locator}    ${language}

    Click Element    ${dropdown_locator}
    Click Element    xpath=//span[normalize-space()='${language}']/parent::div

    Sleep    5s

    ${text}=       Get Text    xpath=//body
    ${pattern}=    Get From Dictionary    ${LANG_ALPHABETS}    ${language}

    # English exists
    Should Match Regexp    ${text}    .*[A-Za-z].*

    # Selected language exists
    Should Match Regexp    ${text}    .*${pattern}.*

    # No other script languages allowed
    FOR    ${lang}    IN    @{LANG_BLOCK_LIST}
        IF    '${lang}' != '${language}'
            ${p}=    Get From Dictionary    ${LANG_ALPHABETS}    ${lang}
            Should Not Match Regexp    ${text}    .*${p}.*
        END
    END

    Log To Console    ${language} validated successfully