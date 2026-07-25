*** Settings ***
Library    SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Language_Keywords.robot


Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup    https://dashboard.mysellercentral.com/sign-in    mayuresh.adititoys@gmail.com    ++Pass@123

Suite Teardown   Close All Browsers


**** Test Cases ***

1.Verify Login ,Verify Dashboard And MSC Intelligence Flow
    [Documentation]  Verify login, dashboard redirection, MSC Intelligence popup open/close 
    Verify Dashboard Redirection
    Verify MSC Intelligence popup Open and Close  
    Open MSC Intelligence And Verify Insights
    Verify MSC Intelligence popup Open and Close

2.Verify Dashboard Page Load And Language Selection
    [Documentation]    Verify dashboard loads successfully and user can change language 
    Verify Page Load
    Select Language From Dropdown1  ${LANG_HEADER_ANY}  Assamese

   
