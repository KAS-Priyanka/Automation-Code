*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource    ../resources/variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary


*** Keywords ***


Open Page From Inventory

    [Arguments]    ${locator}      ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                    ${locator}
    Log To Console    ${label} 

Validate Dropdown Selection For Inventory
    [Arguments]    ${DROPDOWN}    ${POPUP}    ${OPTION_TEXT}    ${SHIMMER}

    Scroll Element Into View    ${DROPDOWN}
    Wait Until Element Is Visible    ${DROPDOWN}    10s
    Click Element    ${DROPDOWN}

    Wait Until Element Is Visible    ${POPUP}    5s
    Log To Console    Dropdown popup visible

   ${option_locator}=    Set Variable    xpath=//li[contains(@class,'filter-li') and .//span[normalize-space()='${OPTION_TEXT}']]

    Wait Until Element Is Visible    ${option_locator}    5s
    ${expected}=    Get Text    ${option_locator}
    ${expected}=    Strip String    ${expected}

    Log To Console    Selected option text = ${expected}

    Scroll Element Into View    ${option_locator}
    Sleep    1s

    # Use JS click (prevents interactable issues)
    Execute JavaScript    arguments[0].scrollIntoView(true);    ${option_locator}
    Execute JavaScript    arguments[0].click();    ${option_locator}

    # Wait for shimmer / loader
    #Wait Until Keyword Succeeds    5s    1s
    #...    Element Should Be Visible    ${SHIMMER}
    Wait Until Keyword Succeeds    10s    2s
    ...    Element Should Not Be Visible    ${SHIMMER}    
    
    ${actual}=    Get Text    ${DROPDOWN}
    ${actual}=    Strip String    ${actual}

    Log To Console    Dropdown value = ${actual}

    Should Be Equal As Strings    ${actual}    ${expected}

Validate Report Search
    [Arguments]    ${SEARCH_INPUT}    ${ROWS_LOCATOR}    ${EMPTY_LOCATOR}    ${SEARCH_TEXT}

    Wait Until Keyword Succeeds    15s    2s
    ...    Check Report Search Result Loaded    ${ROWS_LOCATOR}    ${EMPTY_LOCATOR}

    ${no_data}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${EMPTY_LOCATOR}

    IF    ${no_data}
        Log To Console    ⚠ Table has no data, skipping search
        RETURN
    END

    # Step 2 — Perform search
    Wait Until Element Is Visible    ${SEARCH_INPUT}
    Clear Element Text              ${SEARCH_INPUT}
    Input Text                      ${SEARCH_INPUT}    ${SEARCH_TEXT}
    Sleep    1s

    # Step 3 — Validate search results
    ${rows}=    Get WebElements    ${ROWS_LOCATOR}
    ${count}=   Get Length         ${rows}
    Should Be True    ${count} > 0

    FOR    ${row}    IN    @{rows}
        ${text}=    Get Text    ${row}
        Should Contain    ${text.lower()}    ${SEARCH_TEXT.lower()}
    END

    Log To Console     Search '${SEARCH_TEXT}' validated
    

Check Report Search Result Loaded
    [Arguments]    ${ROWS_LOCATOR}    ${EMPTY_LOCATOR}

    ${empty}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${EMPTY_LOCATOR}

    ${rows}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${ROWS_LOCATOR}

    Should Be True    ${empty} or ${rows}


Select Timeline Option
    [Arguments]    ${DROPDOWN}    ${OPTION_TEMPLATE}    ${SELECTED_LOCATOR}    ${VALUE}    ${LABEL}

    Wait Until Element Is Visible    ${DROPDOWN}    10s
    Click Element                   ${DROPDOWN}

    ${opt}=    Replace String    ${OPTION_TEMPLATE}    {{VALUE}}    ${VALUE}

    Wait Until Element Is Visible    ${opt}    10s
    Click Element                   ${opt}

    Element Text Should Be          ${SELECTED_LOCATOR}    ${VALUE}
    Log To Console                  ${LABEL} Timeline changed successfully to ${VALUE}
    Click Element    ${PROJECTION_SUBMIT_BUTTON}


#-----Suppressed Listing -----
Suppressed Listing Report Card
  # --- Check EMPTY state ---
    ${is_empty}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${SUPRESSED_LISTINGS_REPORT_CARD_TABLE_EMPTY}

    IF    ${is_empty}
        Log To Console     Inventory Listing Report shows Empty state — dropdown NOT selected

    ELSE
        Page Should Contain Element       ${SUPRESSED_LISTINGS_REPORT_CARD_TABLE_DATA}
        Log To Console     Inventory Listing Report shows data

        # ---- ONLY HERE dropdown is allowed ----
       Suppressed Reasons Dropdown    Missing info
    END
   

Suppressed Reasons Dropdown 
    [Arguments]    ${value}

    Wait Until Element Is Visible   ${SUPRESSED_REASONS_DROPDOWN}    10s
    Select From List By Label       ${SUPRESSED_REASONS_DROPDOWN}    ${value}
    List Selection Should Be         ${SUPRESSED_REASONS_DROPDOWN}    ${value}
    Log To Console  dropdown option seletcted successfully

    Scroll Element Into View   ${SUPRESSED_LISTINGS_REPORT} 
    #Wait Until Element Is Visible   ${SUPPRESSED_LISTINGS_REPORT_SHIMMER}
    
    #Wait Until Page Does Not Contain Element    ${SUPPRESSED_LISTINGS_REPORT_SHIMMER}    20s
    Scroll Element Into View    ${SUPRESSED_LISTINGS_REPORT_CARD}
    Wait Until Element Is Visible    ${SUPRESSED_LISTINGS_REPORT_CARD}    10s

    
