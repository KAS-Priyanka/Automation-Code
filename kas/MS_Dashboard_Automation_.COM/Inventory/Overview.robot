*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Inventory_keyword.robot


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
2.Validate Inventory Navigation ,Open Overview page and Verify MSC Intelligence
    [Documentation]    Open Inventory Overview page from Inventory sidebar and verify MSC Intelligence popup
    Open Page From Sidebar    ${INVENTORY_LABEL}  Inventory
    Open Page From Inventory  ${INVENTORY_OVERVIEW_LINK}     Projection Link visible on dashboard
    Verify MSC Intelligence popup Open and Close
    #Verify MSC Intelligence Button Visible    ${MSC_BUTTON}

3.Verify Inventory Overview Page load
    [Documentation]    Verify Inventory Overview page is loaded successfully and user is redirected correctly
    Verify Page Load
    Log To Console  Inventory Overview page fully loaded
    Wait Until Page Contains      Inventory      10s
    Log To Console    Inventory Overview page loaded successfully
 

#Verify Date Range Picker For Suppressed Listings Page
    #Verify Date Picker   ${DATE_RANGE_PICKER_INPUT}   Last 30 days
    #Verify Page Loaded 

4.Verify Inventory Overview 
    [Documentation]    Verify Total LTFS, Storage Fees, Inventory Health, and Inventory Value cards display correct data.
    Validate Cards  ${TOTAL_LTFS_CHARGE_CRAD}  Total LTFS 
    Validate Cards   ${STORAGE_FEES_CARD}  Storage Fees 
    Validate Cards  ${INVENTORY_HEALTH}   Inventory Health 
    Validate Cards  ${TOTAL_INV_UNITS_AGE}   Inventory Value 
    

5.Verify Inventory Status Graph
    [Documentation]    Verify Inventory Status graph is displayed and shows correct data.
    Validate Graph   ${INVENTORY_STATUS_CARD_CANVAS}  Inventory Status


6.Verify Inventory Status Report
    [Documentation]    Verify Inventory Status report table, search functionality, and download feature.
    Validate Cards  ${INVENTORY_STATUS_REPORT_CARD}   Inventory Status Report 
    Check Table Empty Or Data  ${INVENTORY_STATUS_REPORT_TABLE_EMPTY}    ${INVENTORY_STATUS_REPORT_TABLE_DATA} 
    Click Button  ${INVENTORY_STATUS_REPORT_DOWNLOAD_BTN}  Inventory Status Report Download button 

    Search And Verify Result In Table
    ...     ${INVENTORY_STATUS_SEARCH}
    ...     APSMOTIV
    ...     ${INVENTORY_STATUS_REPORT_TABLE_DATA}
    

7.Verify Inventory Age Report
    [Documentation]    Verify Inventory Age report table, search functionality, and download feature.
    Validate Cards  ${INVENTORY_STATUS_REPORT_CARD}   Inventory Status Report 
    Check Table Empty Or Data  ${INVENTORY_AGE_REPORT_TABLE_EMPTY}     ${INVENTORY_AGE_REPORT_TABLE_DATA} 
    Click Button   ${INVENTORY_AGE_REPORTT_DOWNLOAD_BTN}   Inventory Age Report Download button 
    
    Search And Verify Result In Table
    ...      ${INVENTORY_AGE_SEARCH}
    ...      Bajato
    ...      ${INVENTORY_AGE_REPORT_TABLE_DATA}
    
    
8.Verify Inventory Storage Report
    [Documentation]    Verify Inventory Storage report table, search functionality, and download feature.
    Validate Cards  ${INVENTORY_STORAGE_REPORT_CARD}   Inventory Storage Report 
    Check Table Empty Or Data  ${INVENTORY_STORAGE_REPORT_TABLE_EMPTY}   ${INVENTORY_STORAGE_REPORT_TABLE_DATA}  
    Click Button  ${INVENTORY_STORAGE_REPORTT_DOWNLOAD_BTN}   Inventory Storage Report Download button 
    
    Search And Verify Result In Table
    ...      ${INVENTORY_STORAGE_SEARCH}
    ...     Tractor 
    ...      ${INVENTORY_STORAGE_REPORT_TABLE_DATA}
    

9.Verify Inventory Removal Report
    [Documentation]    Verify Inventory Removal report table, search functionality, and download feature.
    Validate Cards  ${INVENTORY_REMOVAL_REPORT_CARD}   Inventory Removal Report 

    Check Table Empty Or Data   ${INVENTORY_REMOVAL_REPORT_TABLE_EMPTY}  ${INVENTORY_REMOVAL_REPORT_TABLE_DATA}
    Click Button  ${INVENTORY_REMOVAL_REPORTT_DOWNLOAD_BTN}  Inventory Removal Report Download button 

    Search And Verify Result In Table
    ...     ${INVENTORY_REMOVAL_SEARCH}
    ...     APSMOTIV
    ...     ${INVENTORY_REMOVAL_REPORT_TABLE_DATA}