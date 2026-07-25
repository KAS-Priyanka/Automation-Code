*** Settings ***
Resource   ../resources/Common_keywords.robot
Resource    ../resources/variables.robot
Library     SeleniumLibrary


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

2.Verify Dashboard Header Elements
    [Documentation]    Validate all header components such as logo, brand selection, country dropdown,
    ...                marketplace, language selection, notification icon, and revenue cards for multiple countries.

    Verify MSC Logo Visible    ${MSC_LOGO}
    Verify Brand Visible   ${BRAND}
    Select Brand From Dropdown  ${BRAND}  APSMOTIV
    Verify Country 
    Select From Dropdown  ${COUNTRY}    United Kingdom
    Verify MSC Intelligence popup Open and Close In Dashboard
    Verify Card Visible    Today              ${TODAY_CARD}     ${TODAY_CARD_DATE}   
    Validate Revenue Currency From UI        ${COUNTRY}          ${REVENUE_VALUE_TODAY}

    Verify Card Visible    Yesterday      ${YESTERDAY_CARD}      ${YESTERDAY_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}              ${REVENUE_VALUE_YESTERDAY}

    Verify Card Visible    Last 7 Days    ${LAST7DAYS_CARD}      ${LAST7DAYS_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}            ${REVENUE_VALUE_LAST_7_DAYS}

    Verify Card Visible    Last 30 Days   ${LASTMONTH_CARD}      ${LASTMONTH_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}           ${REVENUE_VALUE_LAST_MONTH}
    Log To Console   Country dropdown and cards verified for United State

    Select From Dropdown  ${COUNTRY}    India
    Verify MSC Intelligence popup Open and Close In Dashboard
    Verify Card Visible    Today              ${TODAY_CARD}     ${TODAY_CARD_DATE}   
    Validate Revenue Currency From UI        ${COUNTRY}          ${REVENUE_VALUE_TODAY}

    Verify Card Visible    Yesterday      ${YESTERDAY_CARD}      ${YESTERDAY_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}              ${REVENUE_VALUE_YESTERDAY}

    Verify Card Visible    Last 7 Days    ${LAST7DAYS_CARD}      ${LAST7DAYS_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}            ${REVENUE_VALUE_LAST_7_DAYS}
    Verify Card Visible    Last 30 Days   ${LASTMONTH_CARD}      ${LASTMONTH_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}           ${REVENUE_VALUE_LAST_MONTH}
    Log To Console   Country dropdown and cards verified for India

    Select From Dropdown  ${COUNTRY}    United State
    Verify MSC Intelligence popup Open and Close In Dashboard
    Verify Card Visible    Today              ${TODAY_CARD}     ${TODAY_CARD_DATE}   
    Validate Revenue Currency From UI        ${COUNTRY}          ${REVENUE_VALUE_TODAY}

    Verify Card Visible    Yesterday      ${YESTERDAY_CARD}      ${YESTERDAY_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}              ${REVENUE_VALUE_YESTERDAY}

    Verify Card Visible    Last 7 Days    ${LAST7DAYS_CARD}      ${LAST7DAYS_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}            ${REVENUE_VALUE_LAST_7_DAYS}

    Verify Card Visible    Last 30 Days   ${LASTMONTH_CARD}      ${LASTMONTH_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}           ${REVENUE_VALUE_LAST_MONTH}
    Log To Console   Country dropdown and cards verified for United State


    Select Language From Dropdown  ${LANG_HEADER_ANY}   Spanish
    #Verify MSC Intelligence popup Open and Close
    Select Language From Dropdown  ${LANG_HEADER_ANY}   English
   #Verify MSC Intelligence popup Open and Close
    Verify Marketplace   ${COUNTRY}  ${MARKETPLACE}
    Verify Brand Visible    ${BRAND}
    Verify Notification Icon Visible    ${NOTIFICATION}
    Verify Profile Icon Visible        ${PROFILE_ICON}
    Verify MSC Intelligence Button Visible    ${MSC_BUTTON}

3.Verify Dashboard Cards 
    [Documentation]    Validate visibility and correctness of dashboard summary cards including
    ...                Today, Yesterday, Last 7 Days, and Last 30 Days revenue.

    Verify Card Visible    Today              ${TODAY_CARD}     ${TODAY_CARD_DATE}   
    Validate Revenue Currency From UI        ${COUNTRY}          ${REVENUE_VALUE_TODAY}

    Verify Card Visible    Yesterday      ${YESTERDAY_CARD}      ${YESTERDAY_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}              ${REVENUE_VALUE_YESTERDAY}

    Verify Card Visible    Last 7 Days    ${LAST7DAYS_CARD}      ${LAST7DAYS_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}            ${REVENUE_VALUE_LAST_7_DAYS}

    Verify Card Visible    Last 30 Days   ${LASTMONTH_CARD}      ${LASTMONTH_CARD_DATE}
    Validate Revenue Currency From UI        ${COUNTRY}           ${REVENUE_VALUE_LAST_MONTH}

4.Validate All Dashboard Dates
    [Documentation]    Validate correctness of date values displayed in dashboard cards including
    ...                Today, Yesterday, Last 7 Days, and Last Month ranges.
    Validate Today Date
    Validate Yesterday Date
    Validate Last 7 Days Range
    Validate Last Month Range

5.Validates All Dashboard Graph And Card
    [Documentation]    Validate all dashboard graphs, tables, and performance cards including
    ...                SKU reports, revenue graphs, category ranking, account health, and compliance.

    Verify SKU Wise Section  
    Validate Graph   ${UNITS_SOLD_PER_HOUR_GRAPH}  Units Sold Per Hour 
    
    Validate Graph    ${REVENUE_PER_HOUR_GRAPH}  Revenue Per Hour 
    
    Validate Graph    ${REVENUE_REPORT}      Revenue Report
    
    Validate Tables   ${SKU_WISE_REPORT}    SKU Wise Report visible
    
    Validate Graph  ${CATEGORY_WISE_SALES_REPORT}  Category Wise Sales Contribution 

    Validate Graph    ${MAIN_CATEGORY_RANKING_GRAPH}     Main Category Ranking 
    Asc And Desc Toggle  ${MAIN_CATEGORY_TOGGLE}   main  ${MAIN_CATEGORY_RANKING_GRAPH} 

    Validate Graph    ${SUB_CATEGORY_RANKING_GRAPH}   Sub Category Ranking Graph
    Asc And Desc Toggle  ${SUB_CATEGORY_TOGGLE}  sub   ${SUB_CATEGORY_RANKING_GRAPH}

    Validate Graph   ${PRODUCT_LISTING_STATUS_GRAPH}    Product Listing Status

    Validate Graph   ${ACCOUNT_HEALTH_GRAPH}    Account health 

    Validate Cards  ${SHIPPING_PERFORMANCE_CARD}   shipping Performance 

    Validate Tables  ${CUSTOMER_SERVICE_PERFORMANCE_CARD}   Customer Service Performance 

    Validate Graph   ${POLICY_COMPLIANCE_CARD}    Policy Compliance 

    Log To Console     All dashboard cards verified successfully

    