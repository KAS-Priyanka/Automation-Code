**** Settings ***
Library     SeleniumLibrary
Resource    ../resources/variables.robot
Resource    ../resources/Common_Keywords.robot
Resource    Business_Keyword.robot

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


2.Validate Open Reports Page and Verify MSC Intelligence
    [Documentation]    Verify navigation to Business → Reports page and MSC Intelligence visibility
    Open Page From Sidebar     ${BUSINESS_LINK}   Business
    Verify MSC Intelligence popup Open and Close
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}
3.Verify Business Reports Page load
    [Documentation]    Verify Business Reports page loads successfully and required text is visible.
    Verify Page Load
    Log To Console  Business Reports page fully loaded
    Wait Until Page Contains    Reports      10s
    Log To Console  Business Reports page loaded successfully

4.Verify Business Reports Cards
    [Documentation]    Verify Business chart is displayed correctly and download functionality works.
    Validate Cards  ${STANDARD_REPORT_SUBMIT_CARD}   Business Stanard Report Submit 

5.Verify Business Card
    [Documentation]    Verify Business chart is displayed correctly and download functionality works.
    Validate Graph  ${BUSINESS_CHART_CARD}   Business Chart 
    Click Button  ${BUSINESS_CHART_CARD_DOWNLOAD_BTN}    Report download button 

6.Verify Standard Report Card
    [Documentation]    Verify Standard Report table displays data or empty state correctly.
    Validate Tables  ${STANDARD_REPORT_CARD}   Standard Report 
    Check Table Empty Or Data  ${STANDARD_REPORT_CARD_TABLE_EMPTY}   ${STANDARD_REPORT_CARD_TABLE_DATA}
    

7.Verify Date Picker For Business Reports
    [Documentation]    Verify date picker selects "Yesterday" and updates data correctly.
    Verify Date Picker     ${SELECT_TIME_PERIOD_CARD_DATE_PICKER}    Yesterday

8.Verify Standard Report Dropdown Option And Submit Button
    [Documentation]    Verify dropdown selections and submit button update report data with shimmer.
    Select From Custom Dropdown for Business   ${UNITS_SOLD_DROPDOWN}  Buy Box Percentage
    Select From Custom Dropdown for Business  ${ALL_ASINS_DROPDOWN}   B00TQ7UNQO 
    Click Button    ${STANDARD_REPORT_SUMBIT_BTN}  Submit 
    Verify Business Chart And Report Shimmer
    
10.Verify Week Wise Comparison
    [Documentation]    Verify Week Wise Comparison tab opens and loads successfully.
    Open Tab And Verify  ${WEEK_WISE_COMPARISON_TAB}    Select Type of Report
    Verify Page Load

11.Verify Week Wise Comparison Cards
    [Documentation]    Verify cards, dropdown selection, shimmer, and download functionality.

    Validate Cards   ${SELECT_TYPE_OF_CARD}      Select Type Of 
    Validate Cards  ${WEEK_WISE_COMPARISON_REPORT_CARD}   Week Wise Comparison Report 
    Click Button  ${WEEK_WISE_COMPARISON_REPORT_DOWNLAOD_BTN}      Week Wise Comparison Report download button 
   Select From Custom Dropdown for Business
    ...  ${SELECT_TYPE_OF_DROPDOWN}
    ...    Page Views
    Week Wise Comparison Report Shimmer


12.Verify Time Sheet Tab
    [Documentation]    Verify cards, dropdown selection, shimmer, and download functionality.

    Open Tab And Verify    ${TIME_SHEET_TAB}    Select Time Period
    Verify Page Load
    Log To Console  Time Sheet Tab fully loaded
 

13.Verify Time Sheet Cards
    [Documentation]    Verify Select Time Period card, Units Sold and Revenue graphs, Time Sheet data table, Compare Sales table, and both download buttons work correctly.
    Validate Cards   ${SELECT_TIME_PERIOD_CARD}    Select Time Period 
    Validate Graph   ${UNITS_SOLD_PER_HOURS_CARD}  Units Sold Per Units 
    Validate Graph  ${REVENUE_PER_HOUR_CARD}   Revenue Per Hour 
    Validate Tables   ${BUSINESS_TIME_SHEET_DATA_CARD}  Busines Time Sheet Data  
    Click Button  ${BUSINESS_TIME_SHEET_DATA_DOWNLOAD_BTN}     Busines Time Sheet Data download button 
    Validate Tables    ${COMPARE_SALES_CARD}  Compare Sales Table is visible
    Click Button  ${COMPARE_SALES_CARD_DOWNLOAD_BTN}     Compare Sales Card download button 

14.Verify Dropdown 
    [Documentation]    Verify date picker, dropdown selection, and shimmer update Time Sheet data.
    Verify Date Picker     ${SELECT_TIME_PERIOD_CARD_DATE_PICKER}    Last 1 Year
    Select From Custom Dropdown for Business
    ...  ${SELECT_TIME_PERIOD_CARD_DROPDOWN}
    ...   110062800
    Click Button    ${SELECT_TIME_PERIOD_SUBMIT_BTN}  Button
    Time Sheet Shimmer


16.Verify Profit And Loss Tab
    [Documentation]    Verify navigation to Profit And Loss tab, page load, and MSC Intelligence popup functionality.
    Open Tab And Verify    ${PROFIT_AND_LOSS_TAB}    PNL Income Expense
    Verify Page Load
    Log To Console  Profit And Loss Tab fully loaded

17.Verify Profit And Loss Cards
    [Documentation]    Verify PNL cards, graphs, date filter, and report download options.
    Validate Cards    ${PNL_TOP_CARD}    PNL Top Card 
    Validate Graph  ${PNL_INCOME_EXPENSE_CARD}    PNL Income Expense 
    Validate Cards  ${PNL_REPORT_CARD}     PNL Report 
    Verify Date Picker     ${PROFIT_AND_LOSS_DATE_PICKER}    Last 30 days
    Validate Graph  ${PNL_INCOME_EXPENSE_CARD}    PNL Income Expense 
    Validate Cards  ${PNL_REPORT_CARD}     PNL Report     
    #Download Profit And Loss Report    ${PROFIT_AND_LOSS_DOWNLOAD_BTN}   ${PNL_DOWNLOAD_PDF_BTN}   ${PNL_DOWNLOAD_CSV_BTN}

18.Verify Profit And Loss Update Cogs Button And Verify Update Products Cogs Page Load
    [Documentation]    Verify Update Cogs button visibility, click functionality, and Update Products Cogs page load.
    Click Button    ${UPDATE_COGS_BTN}    Update Cogs button 
    Wait Until Page Contains  Update Products Cogs
    Verify Page Load
    Log To Console  Update Products Cogs page fully loaded

19.Verify Update Products Cogs Cards
    [Documentation]    Verify Total, Updated, and Remaining Products cards display correct values.
    Validate Cards  ${TOTAL_PRODUCTS_CARD}      Total Products 
    Validate Cards   ${UPDATED_PRODUCTS_CARD}     Updated Products 
    Validate Cards    ${REMAINING_PRODUCTS_TO_MAP_CARD}     Remaining Products To Map 


20.Verify Map Product Cogs Card
    [Documentation]    Verify Map Product COGS card, search, upload, download, and table functionality.
    Validate Cards    ${MAP_PRODUCT_COGS_CARD}     Map Product Cogs Card loaded successfully
    Wait Until Element Is Visible    ${MAP_PRODUCT_COGS_SEARCH}    10s
    Log To Console     Search field is visible
    Wait Until Element Is Visible    ${MAP_PRODUCT_COGS_UPLOAD_BTN}    10s
    Log To Console     Upload Report button is visible
    Click Button   ${MAP_PRODUCT_COGS_DOWNLOAD_BTN}    Download Report button 
    Validate Tables   ${MAP_PRODUCT_COGS_TABLE}     Map Product Cogs 

#21.Update First Product Cogs
   # [Documentation]    Verify updating first SKU COGS value is successful.
    #Update First SKU Cogs    100




    