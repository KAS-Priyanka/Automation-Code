**** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource   Sales_Keywords.robot

Suite Setup    Run Keywords
...    Set Screenshot Directory    ../screenshots
...    AND
...    Login Setup    https://dashboard.mysellercentral.com/sign-in  ketan.bhagwate@gmail.com   ++Pass@123
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

2.Validate Sales Navigation,Open Projection Page and Verify MSC Intelligence
    [Documentation]    Validate navigation to Sales module, open  Projection Page from sidebar,
    ...                and verify MSC Intelligence popup
    Open Page From Sidebar  ${SALES_LABEL}      Sales label     
    Open Page From Sales     ${PROJECTION_LINK}    Projection link visible on dashboard
    Verify MSC Intelligence popup Open and Close In Projection Page 

3.Verify Projection Page load
    Verify Page load
    Log To Console   Projection page fully loade
    Wait Until Page Contains    Sales Projection      10s
    Log To Console     redirect on Projection page loaded successfully

4.Verify Sales Projection Report
    
    Select Timeline And Submit
    ...    ${PROJECTION_PRESENT_TIMELINE_DROPDOWN}
    ...    ${PROJECTION_PRESENT_TIMELINE_OPTION}
    ...    Two Month    
    ...    ${PROJECTION_PROJECTED_TIMELINE_DROPDOWN}
    ...    ${PROJECTION_PROJECTIED_TIMELINE_OPTION}
    ...    Two Month
    ...    ${PROJECTION_SUBMIT_BUTTON}

    Check Table Empty Or Data   ${SALES_PROJECTION_REPORT_EMPTY}    ${SALES_PROJECTION_REPORT_TABLE}
    Click Button  ${SALES_PROJECTION_REPORT_DOWNLOAD_REPORT}  Sales Projection Report Download Report button 
   
    
         