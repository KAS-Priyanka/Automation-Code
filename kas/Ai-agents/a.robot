*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
Set Zoom Properly
    Open Browser    https://test-uat.mysellercentral.com/ai-agents/sign-in    chrome
    Maximize Browser Window
    Sleep    2s

    # Click page to focus
    Click Element    //body

    # Zoom out to 80%
    Press Keys    None    CTRL+-
    Press Keys    None    CTRL+-

    Sleep    10s
    Close Browser