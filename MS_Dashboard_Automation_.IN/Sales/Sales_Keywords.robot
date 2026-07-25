*** Settings ***
Library    SeleniumLibrary
Library    Process
Resource    ../resources/variables.robot
Library    DateTime
Library    String
Library    RequestsLibrary


*** Keywords ***

Open Page From Sales

     [Arguments]    ${locator}    ${label}
    Wait Until Element Is Visible    ${locator}    10s
    Scroll Element Into View         ${locator}
    Click Element                    ${locator}
    Log To Console    ${label} 


Select Dropdown Option And Validate
    [Arguments]    ${dropdown}    ${value}

    Click Element    ${dropdown}

    ${option}=    Set Variable
    ...    xpath=//span[contains(@class,'filter-label') and normalize-space()='${value}']

    Wait Until Element Is Visible    ${option}    5s
    Click Element    ${option}

    ${selected}=    Get Text    ${dropdown}//span
    ${selected}=    Strip String    ${selected}

    Should Be Equal As Strings    ${selected}    ${value}

    Log To Console    Dropdown option '${value}' selected and validated successfully

    
#---Projection---
Select Timeline And Submit
    [Arguments]    
    ...    ${present_dropdown}    
    ...    ${present_option_locator}    
    ...    ${present_value}    
    ...    ${projected_dropdown}    
    ...    ${projected_option_locator}    
    ...    ${projected_value}    
    ...    ${submit_button}

    # ---- Present Timeline ----
    Wait Until Element Is Visible    ${present_dropdown}    10s
    Click Element    ${present_dropdown}

    ${present_option}=    Replace String    ${present_option_locator}    {{VALUE}}    ${present_value}

    Wait Until Element Is Visible    ${present_option}    5s
    Click Element    ${present_option}

    Log To Console    Present timeline selected = ${present_value}

    # ---- Projected Timeline ----
    Wait Until Element Is Visible    ${projected_dropdown}    10s
    Click Element    ${projected_dropdown}

    ${projected_option}=    Replace String    ${projected_option_locator}    {{VALUE}}    ${projected_value}

    Wait Until Element Is Visible    ${projected_option}    5s
    Click Element    ${projected_option}

    Log To Console    Projected timeline selected = ${projected_value}

    # ---- Submit ----
    Wait Until Element Is Visible    ${submit_button}    10s
    Click Element    ${submit_button}

    Log To Console    Projection submitted successfully