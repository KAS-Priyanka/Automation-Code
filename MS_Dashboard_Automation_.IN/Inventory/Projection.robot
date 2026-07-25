*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Inventory_keyword.robot

Suite Setup    Run Keywords
...   Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup   https://dashboard.mysellercentral.com/sign-in  mayuresh.adititoys@gmail.com   ++Pass@123
Suite Teardown   Close Browser



*** Test Cases ***

1.Verify Login ,Verify Dashboard,Verify MSC Intelligence
    [Documentation]    Verify successful login, dashboard redirection, MSC Intelligence popup functionality,
    ...                and validate insights along with page load.
    Verify Dashboard Redirection
    Verify MSC Intelligence popup Open and Close  
    Open MSC Intelligence And Verify Insights
    Verify MSC Intelligence popup Open and Close
    Verify Page Load

2.Validate Inventory Navigation ,Open Projection page and Verify MSC Intelligence
    [Documentation]    Open Projection page from Inventory sidebar and verify MSC Intelligence popup   
    Open Page From Sidebar    ${INVENTORY_LABEL}  Inventory 
    Open Page From Inventory  ${INVENTORY_PROJECTION_LINK}      Projection Link visible on dashboard
    Verify MSC Intelligence popup Open and Close
    Verify MSC Intelligence Button Visible

3.Verify Inventory Projection Page load
    [Documentation]    Verify Inventory Projection page is loaded successfully and user is redirected correctly
    Verify Page Load
    Log To Console    Projection page fully loaded
    Wait Until Page Contains    Inventory Projection    10s
    Log To Console    Projection page loaded successfully

4.Verify Inventory Projection Report
    [Documentation]    Verify timeline selection for present and projected data, table load, and report download functionality.

    ${PRESENT}=     Set Variable    Two Month
    ${PROJECTED}=   Set Variable    Three Month

    Select Timeline Option
    ...    ${PROJECTION_PRESENT_TIMELINE_DROPDOWN}
    ...    ${PROJECTION_PRESENT_TIMELINE_OPTION}
    ...    ${PROJECTION_PRESENT_TIMELINE_SELECTED}
    ...    ${PRESENT}
    ...    Inventory-Present
    Wait Until Keyword Succeeds    10s    2s
    ...    Element Should Be Visible  ${INVENTORY_PROJECTION_REPORT_SHIMMER}
    Wait Until Element Is Not Visible    ${INVENTORY_PROJECTION_REPORT_SHIMMER}    5s

    Select Timeline Option
    ...    ${PROJECTION_PROJECTED_TIMELINE_DROPDOWN}
    ...    ${PROJECTION_PROJECTIED_TIMELINE_OPTION}
    ...    ${PROJECTION_PROJECTIED_TIMELINE_SELECTED}
    ...    ${PROJECTED}
    ...    Inventory-Projected

    Wait Until Keyword Succeeds    10s    2s
    ...    Element Should Be Visible  ${INVENTORY_PROJECTION_REPORT_SHIMMER}
    Wait Until Element Is Not Visible    ${INVENTORY_PROJECTION_REPORT_SHIMMER}    5s

    Click Button  ${PROJECTION_SUBMIT_BUTTON}  Submit button on projection page
    Wait Until Keyword Succeeds    10s    2s
    ...    Element Should Be Visible  ${INVENTORY_PROJECTION_REPORT_SHIMMER}
    Wait Until Element Is Not Visible    ${INVENTORY_PROJECTION_REPORT_SHIMMER}    5s
    Check Table Empty Or Data   ${INVENTORY_PROJECTION_REPORT_EMPTY}   ${INVENTORY_PROJECTION_REPORT_TABLE} 
    Click Button  ${INVENTORY_PROJECTION_REPORT_DOWNLOAD_REPORT}  Inventory Projection Report Download button
    
   