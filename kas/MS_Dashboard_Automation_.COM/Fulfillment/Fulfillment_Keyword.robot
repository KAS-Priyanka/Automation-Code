*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource    ../resources/variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary


*** Keywords ***
Open Page From Fulfillment

    [Arguments]    ${locator}   ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                   ${locator}
    Log To Console    ${label}

Search And Validate
    [Arguments]    ${locator}    ${text}    ${result}    ${no_record}  ${empty_search}

    # Step 1: Check if table initially has data
    ${table_empty}=    Run Keyword And Return Status    Element Should Be Visible    ${no_record}

    IF    ${table_empty}
        Log To Console    Table is empty. Search will not be performed.
    ELSE
        # Step 2: Perform search
        Wait Until Element Is Visible    ${locator}    10s
        Clear Element Text    ${locator}
        Input Text    ${locator}    ${text}
        Press Keys    ${locator}    ENTER

        Sleep    2s

        # Step 3: Check result after search
        ${no_data_after_search}=    Run Keyword And Return Status    Element Should Be Visible    ${empty_search}
        IF    ${no_data_after_search}
            Log To Console   No data found after search
        ELSE
            Wait Until Element Is Visible    ${result}    10s
            Scroll Element Into View    ${result}
            Element Should Contain    ${result}    ${text}
            Log To Console    Data found and validated successfully
        END
    END


#---fulfillment-
Enter Text In Field
    [Arguments]    ${locator}    ${text}

    Wait Until Element Is Visible    ${locator}    10s
    Input Text    ${locator}    ${text}

Select Dropdown Value
    [Arguments]    ${locator}    ${value}

    Wait Until Element Is Visible    ${locator}    10s
    Select From List By Label    ${locator}    ${value}

Select And Validate Dropdown Value
    [Arguments]    ${dropdown}    ${value}

    Click Element    ${dropdown}
    Run Keyword And Ignore Error    Input Text    ${dropdown}    ${value}

    ${option}=    Set Variable    xpath=//ul[@role='listbox']//li[normalize-space()='${value}']

    Click Element    ${option}

    # Get selected value (input OR div safe)
    ${status}    ${selected}=    Run Keyword And Ignore Error
    ...    Get Element Attribute    ${dropdown}    value

    Run Keyword If    '${status}'=='FAIL' or not ${selected}
    ...    ${selected}=    Get Text    ${dropdown}

    Should Be Equal As Strings    ${selected}    ${value}
    Log To Console    ✅ Dropdown validated: ${selected}