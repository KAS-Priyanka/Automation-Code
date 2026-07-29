*** Settings ***
Library    SeleniumLibrary
Library    Process
Library    Collections
Library    String


*** Variables ***

${SELECTED_LANG}    NONE
${PAGE_HEADING}       xpath=//span[normalize-space()='Log In']
${CREATE_ACCOUNT_TAB}  xpath=//a[.//span[normalize-space()='Create account']]

${EMAIL_INPUT}        xpath=//input[@type='email']
${PASSWORD_INPUT}     xpath=//input[@type='password']
${RE_PASSWORD_INPUT}  xpath=//label[normalize-space()='Re-enter Password']/following::input[@type='password']

${OTP_BOXES}    xpath=//input[@inputmode='numeric']
#--- Login Credentials ---         

${CONTINUE_BTN}       xpath=//button[normalize-space()='Continue']
#---Register---

${SIGN_UP_ERROR_MSG}      xpath=//p[contains(text(),'already in use')]

${FULL_NAME}   xpath=//input[@placeholder='Enter your name']
${STORE_NAME}  xpath=//input[@placeholder='Enter Store name']

${INVALID_OTP}   357899


${VERIFY_BTN}  xpath=//button[.//span[normalize-space()='Verify']]
#--- Dashboard Elements ---
${SKELETON_ELEMENTS}   xpath=//*[contains(@class,'skeleton') or contains(@class,'shimmer')]
${MARKETING_LOADING}   xpath=//div[contains(@class,'spinner') or contains(@class,'loader') or contains(@class,'animate-spin')]

${SPONSORED_LOADING}  xpath=//*[contains(normalize-space(),'Loading')]
${CHART_ELEMENTS}        xpath=//*[name()='svg' or name()='canvas']
${MSC_BUTTON}        xpath=//button[.//span[normalize-space()='MSC Intelligence']]

#--- Header Elements ---
${MSC_LOGO}        xpath=//img[@alt='logo' and contains(@class,'h-8')]
${SESSION_LOGO}    xpath=//button[.//div[normalize-space()='Session']]
${AI_AGENT}  xpath=//button[.//div[normalize-space()='AI Agents']]
${DASHBOARD_MENU}    xpath=//button[.//div[normalize-space()='Dashboard']]
${COUNTRY}  xpath=(//div[contains(@class,'cursor-pointer')][.//img[contains(@src,'mp-logos')]])[1]
${MARKETPLACE}    xpath=(//div[contains(@class,'cursor-pointer')][.//img[contains(@src,'mp-logos')]])[5]
${ALL_BRANDS}     xpath=//div[contains(@class,'relative inline-block')]//div[contains(@class,'gradient-border-gray') and .//div[normalize-space()='All Brands']]
${NOTIFICATION}  xpath=//div[contains(@class,'rounded-[9px]')]//*[local-name()='svg']
${NOTIFICATION_POPUP}
${PROFILE_ICON}   xpath=//div[contains(@class,'bg-semantic-green')]/ancestor::div[contains(@class,'cursor-pointer')]
${SETTINGS}      xpath=//button[.//span[normalize-space()='Settings']]
${LOGOUT_BTN}     xpath=//button[.//span[normalize-space()='Log out']]
${HELP_SUPPORT_BTN}    xpath=//button[.//span[normalize-space()='Help & Support']]
${LANG_HEADER_ANY}    xpath=(//div[contains(@class,'rounded-[10px]') and contains(@class,'cursor-pointer') and .//span])[last()]
${BTN_CLOSE}             xpath=//*[name()='svg' and contains(@class, 'text-xl')]
${BRAND}          xpath=(//div[contains(@class,'cursor-pointer')][.//div[contains(@class,'truncate')]])[3]
#--cards---
${DATE_FILTER_PANEL}     xpath=(//div[.//span[contains(@class,'truncate')] and .//span[normalize-space()='Compare'] and .//span[normalize-space()='D'] and .//span[normalize-space()='W'] and .//span[normalize-space()='M'] and .//span[normalize-space()='Y']])[10]    
${TODAY_DATE_FILTER}    xpath=//div[contains(@class,'inline-flex') and contains(@class,'cursor-pointer')][.//span[contains(@class,'truncate')]]
${TODAY_DROPDOWN}    xpath=//span[normalize-space()='Today']/ancestor::div[contains(@class,'cursor-pointer')]
${DATE_FILTER}    ${EMPTY}
${TODAY_DATE_FILTER_DROPDOWN}    xpath=//span[normalize-space()='Today']/ancestor::div[contains(@class,'cursor-pointer')]

${TODAY_CARD_DATE}   xpath=//div[contains(@class,'rounded-t') and .//div[normalize-space()='Today']]
${TODAY_DATE}  xpath=(//div[normalize-space()='Today']/ancestor::div[contains(@class,'rounded')]//div[contains(text(),'-')])[1]

${TODAY_CARD}    xpath=(//div[normalize-space()='Today']
...    /ancestor::div[contains(@class,'rounded-t')]
...    /following-sibling::div[contains(@class,'rounded-b')
...    and .//div[normalize-space()='Revenue']
...    and .//span[normalize-space()='Orders']
...    and .//div[normalize-space()='Returns']
...    and .//div[normalize-space()='Order Units']
...    and .//div[normalize-space()='Return Units']]
...    )[1]

&{CURRENCY_MAP}
...    India=₹
...    United State=$
...    United Kingdom=£

#--Home--
${TOP5_SKUS_EMPTY_LOCATOR}    //span[normalize-space()='Top 5 SKUs']/ancestor::div[contains(@class,'rounded-2xl')][1]//div[normalize-space()='No Records Found']
${TOP5_SKUS_TABLE_LOCATOR}    //span[normalize-space()='Top 5 SKUs']/ancestor::div[contains(@class,'rounded-2xl')][1]//div[contains(@class,'pr-2')]
${REVENUE_REPORT_CARD}    //span[@title='Revenue Report']/ancestor::div[contains(@class,'border') and contains(@class,'rounded-2xl')][1]
${PRODUCT_LISTING_STATUS_CARD}  //p[normalize-space()='Product Listing Status']/ancestor::div[contains(@class,'rounded-2xl') and contains(@class,'border')][1]
${CATEGORY_WISE_SALES_CARD_TABLE_LOCATOR}  //h2[normalize-space()='Category Wise Sales Contribution']/ancestor::div[contains(@class,'rounded-2xl') and contains(@class,'border')][1]
${CATEGORY_WISE_SALES_CARD_EMPTY_LOCATOR}  
${ACCOUNT_HEALTH_GRAPH}   //span[normalize-space()='Account Health']/ancestor::div[contains(@class,'rounded-2xl')][1]
${SHIPPING_PERFORMANCE_CARD}  //h2[normalize-space()='Shipping Performance']/ancestor::div[contains(@class,'rounded-2xl')][1]
${POLICY_COMPLIANCE_CARD}      (//div[     .//span[normalize-space()='Policy Compliance']     and .//span[normalize-space()='Food and Product Safety Issues']     and .//span[normalize-space()='Listing Policy Violations']     and .//span[normalize-space()='Restricted Product Policy Violations']     and .//span[normalize-space()='Customer Product Reviews Policy Violations']     and .//span[normalize-space()='Other Policy Violations'] ][contains(@class,'rounded-2xl')][1])[2]
${CUSTOMER_SERVICE_PERFORMANCE_CARD}    //span[normalize-space()='Customer Service Performance']/ancestor::div[contains(@class,'box-border') and contains(@class,'bg-white') and contains(@class,'rounded-2xl')][1]
#---Sales Module Elements---
${SALES_LABEL}   xpath=//button[.//span[normalize-space()='Sales']]
${SHIPPED_LINK}    xpath=//a[@href='/shipping-reports' and normalize-space()='Shipped']
${UNITS_SOLD_GRAPH}  (//div[contains(@class,'rounded-2xl')][.//span[normalize-space()='Units sold'] and .//canvas])[2]
${AVERAGE_SELLING_PRICE_GRAPH}   (//div[contains(@class,'rounded-2xl')][.//span[normalize-space()='Average Selling Price'] and .//canvas])[2]
#--sales page elements--- 
${DATE_FILTER_SECTION}  
...    (//div[.//span[contains(@class,'truncate')] and .//span[normalize-space()='Compare'] and .//span[normalize-space()='D'] and .//span[normalize-space()='W'] and .//span[normalize-space()='M'] and .//span[normalize-space()='Y']])[8]

#--cancel order module elements---
${CANCELLED_LINK}      xpath=//a[normalize-space()='Cancel' and @href='/cancel-reports']


# --- Cancel Page Cards ---

${CANCEL_TOTAL_ORDERS_CARD}       xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Total Orders']]
${CANCEL_TOTAL_ORDERS_CARD_VALUE}  xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Total Orders']]//div[contains(@class,'text-2xl')]

${CANCEL_CANCELLED_ORDERS_CARD}   xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Cancelled Orders']]
${CANCEL_CANCELLED_ORDERS_CARD_VALUE}  xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Cancelled Orders']]//div[contains(@class,'text-2xl')]

${CANCEL_QUANTITY_CARD}           xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Quantity']]
${CANCEL_QUANTITY_CARD_VALUE}    xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Quantity']]//div[contains(@class,'text-2xl')]

${CANCEL_RATE_CARD}               xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Cancellation Rate']]
${CANCELLATION_RATE_VALUE}       xpath=//div[normalize-space()='Cancellation Rate']/ancestor::div[contains(@class,'shadow')]//div[contains(@class,'text-2xl')]

${CATEGORY_WISE_CANCEL_GRAPH}     xpath=//div[normalize-space()='Category Wise Cancels']  /ancestor::div[contains(@class,'chart-bg')]  //canvas
${CATEGORY_WISE_CANCEL_GRAPH_DOWNLOAD_BTN}         xpath=//div[contains(@class,'chart-bg')][.//canvas]//button[.//span[normalize-space()='Download Report']]



${CANCELLED_ORDER_REPORT}       xpath=//div[.//div[normalize-space()='Cancelled Order Report']]
...    //table
...    [.//th[normalize-space()='Order Id']
...     and .//th[.//span[normalize-space()='Order Amount']]
...     and .//th[.//span[normalize-space()='Cancelled Order Quantity']]
...     and .//th[normalize-space()='Order Date']
...     and .//th[normalize-space()='Sales Channel']
...     and .//th[normalize-space()='Shipping Method']
...     and .//th[normalize-space()='Country']
...     and .//th[normalize-space()='City']]


${CANCELLED_ORDER_REPORT_DOWNLOAD_BTN}    xpath=//div[normalize-space()='Cancelled Order Report']/ancestor::div[contains(@class,'chart-bg')]//button[.//span[normalize-space()='Download Report']]


${CANCELLED_SKU_WISE_TABLE}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Cancelled Order Report SKU Wise']]//table
${CANCELLED_SKU_WISE_EMPTY}   xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Cancelled Order Report SKU Wise']]//div[contains(@class,'items-center') and normalize-space()='No Records Found']
${CANCELLED_SKU_WISE_TABLE_DOWNLOAD_BTN}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Cancelled Order Report SKU Wise']]//button[.//span[normalize-space()='Download Report']]


#--return order module elements---
#--cards
${RETURNS_LINK}           xpath=//a[@href='/returns-reports' and normalize-space()='Returns']

${RETURNS_TOTAL_CARD}        xpath=//div[normalize-space()='Number of Returns'] /ancestor::div[contains(@class,'round')][.//div[normalize-space()='Total Number of Returns']]
${RETURNS_TOTAL_VALUE}        xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Total Number of Returns']]//div[contains(@class,'text-2xl')]

${RETURNS_UNITS_CARD}       xpath=//div[normalize-space()='Units']/ancestor::div[contains(@class,'round')][.//div[normalize-space()='Total Number of Units']]
${RETURNS_UNITS_VALUE}       xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Total Number of Units']]//div[contains(@class,'text-2xl')]

${RETURNS_TOTAL_AMOUNT_CARD}    xpath=//div[normalize-space()='Total Amount']/ancestor::div[contains(@class,'round')][.//div[normalize-space()='Total  Amount']]
${RETURNS_TOTAL_AMOUNT_VALUE}      xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Total  Amount']]//div[contains(@class,'text-2xl')]


${RETURNS_REFUND_RATE_CARD}    xpath=//div[normalize-space()='Refund Rate']/ancestor::div[contains(@class,'round')][.//div[normalize-space()='Refund Rate']]
${RETURNS_REFUND_RATE_VALUE}    xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Refund Rate']]//div[contains(@class,'text-2xl')]


${RETURNS_RETURN_RATE_CARD}         xpath=//div[normalize-space()='Return Rate']/ancestor::div[contains(@class,'round')][.//div[normalize-space()='Return Rate']]
${RETURNS_RETURN_RATE_VALUE}        xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Return Rate']]//div[contains(@class,'text-2xl')]


#--state wise contribution canvas---
${STATE_WISE_CONTRIBUTION_CANVAS}     xpath=//div[contains(@class,'chart-bg')] [.//div[normalize-space()='State wise Contribution']] //canvas
${TOP_5_CITY_TABLE}                 xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Top 5 City in selected State']]//table
${STATE_WISE_CONTRIBUTION_DROPDOWN}          xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Top 5 City in selected State']] //span[contains(@class,'font-medium')]
${STATE_WISE_CONTRIBUTION_DROPDOWN_POPUP}     xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Top 5 City in selected State']] //ul[contains(@class,'flex') and contains(@class,'flex-col')]
#${STATE_WISE_CONTRIBUTION_DROPDOWN_OPTION}      xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Top 5 City in selected State']]//ul[contains(@class,'flex-col')]//li[contains(@class,'filter-li')][2]


#---CITY WISE CONTRIBUTION---
${CITY_WISE_CONTRIBUTION_CANVAS}  xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='City wise Contribution']]//canvas
${TOP_5_SKU_TABLE}      xpath=//div[contains(@class,'chart-bg')] [.//div[normalize-space()='Top 5 SKU in selected City']]//table
${CITY_WISE_CONTRIBUTION_DROPDOWN}            xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Top 5 SKU in selected City']] //span[contains(@class,'font-medium')]
${CITY_WISE_CONTRIBUTION_DROPDOWN_POPUP}     xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Top 5 SKU in selected City']]//ul[contains(@class,'flex-col') and contains(@class,'overflow-auto')]
${CITY_WISE_CONTRIBUTION_OPTION}             xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Top 5 SKU in selected City']]//ul[contains(@class,'flex-col')]//li[contains(@class,'filter-li')][2]



${ATOZ_CLAIM_CHART_CANVAS}     xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='A to Z Claim']]//canvas
${PAID_BY_CHART_CANVAS}    xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='Label Paid By']]//canvas
${CARRIER_CHART_CANVAS}    xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='Carrier']]//canvas
${MODE_OF_DELIVERY_CHART_CANVAS}    xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='Mode Of Delivery']]//canvas



${RETURN_SKU_WISE_TABLE_WITH_COLUMNS}    xpath=//table[thead//th//span[normalize-space()='SKU']and thead//th//span[normalize-space()='Units']and thead//th//span[normalize-space()='Revenue']and thead//th//span[normalize-space()='Refund Amount']]

${RETURN_SKU_WISE_TABLE_DOWNLAOD_BUTTON}     xpath=//div[normalize-space()='SKU Wise Report']/ancestor::div[contains(@class,'shadow')]//button[.//span='Download Report']
${QUALITY_FEEDBACK_TABLE}   xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()="Quality feedback sku's"]]//table

${QUALITY_FEEDBACK_TABLE_EMPTY}   xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()="Quality feedback sku's"]]//div[contains(@class,'items-center') and normalize-space()='No Records Found']

${RETURN_REASON_CANVAS}     xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='Return Reason']]//canvas
${CATEGORY_WISE_RETURN_CANVAS}   xpath=//div[contains(@class,'chart-bg')] [.//span[normalize-space()='Category-wise Return']] //canvas


${RETURN_ORDERS_REPORT}      xpath=//div[normalize-space()='Return Orders Report']  /ancestor::div[contains(@class,'chart-bg')]
${RETURN_ORDERS_REPORT_TABLE_WITH_COLUMNS}    xpath=//div[.//div[normalize-space()='Return Orders Report']]  //table[     .//span[normalize-space()='Order Id']     and .//span[normalize-space()='Return Status']     and .//span[normalize-space()='Revenue']     and .//span[contains(normalize-space(),'Refunded Amt')]     and .//span[normalize-space()='Returned Units']     and .//span[normalize-space()='Order Date']     and .//span[normalize-space()='Return Req On']     and .//span[normalize-space()='Return Carrier']     and .//span[normalize-space()='Tracking Id']  ]
${RETURN_ORDERS_REPORT_TABLE_DOWNLAOD_BUTTON}     xpath=//div[normalize-space()='Return Orders Report']/ancestor::div[contains(@class,'shadow')]//button[.//span='Download Report']
${RETURN_ORDERS_REPORT_TABLE_EMPTY}   xpath=(//div[normalize-space()='Return Orders Report']/ancestor::div[contains(@class,'chart-bg')])//div[contains(@class,'items-center') and contains(@class,'justify-center')and normalize-space()='No Records Found']

${SEARCH_INPUT}    xpath=//input[@id='default-search']

${RETURN_ORDER_REOPRT_SEARCH_INPUT}   xpath=//div[normalize-space()='Return Orders Report']/ancestor::div[contains(@class,'shadow')]//input[@type='search' and contains(@class,'rounded-lg')]

${RETURN_ORDER_REOPRT_EMPTY_STATE}    xpath=//div[normalize-space()='Return Orders Report']  /ancestor::div[contains(@class,'chart-bg')][1]  //tbody[not(tr)]


#---Coupon Module Elements---
${COUPON_LINK}   xpath=//a[@href='/coupon-performance' and normalize-space()='Coupon Performance']
${COUPON_EXPIRING_CARD}   xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='Coupons Expiring'] and .//div[normalize-space()='Coupons expiring in next 30 days'] and .//div[contains(@class,'font-bold')]]
${COUPONS_COUNT_CARD}   xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='Coupons Count'] and .//div[normalize-space()='Total Coupons Run Through'] and .//div[contains(@class,'font-bold')]]
${BUDGET_SPENT_CARD}   xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='Budget Spent'] and .//div[normalize-space()='Total Budget spent'] and .//div[contains(@class,'font-bold')]]
${BUDGET_SPENT_CARD_VALUE}   xpath=//div[text()='Budget Spent']/ancestor::div[contains(@class,'shadow')]//div[contains(@class,'font-bold')]

${COUPONS_ACTIVE_CARD}   xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='Coupons Active'] and .//div[normalize-space()='Total Coupons Active'] and .//div[contains(@class,'font-bold')]]
${COUPONS_CONVERSION_CARD}        xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='Coupons Conversion']  and .//div[normalize-space()='Coupons Conversion rate']  and .//div[contains(@class,'font-bold')]]
${COUPONS_CLICKS_CARD}        xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='Coupons Clicks'] and .//div[normalize-space()='Total Coupons clicks'] and .//div[contains(@class,'font-bold')]]
${SALES_GENERATED_CARD}    xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='Sales Generated'] and .//div[normalize-space()='Total Sales generated'] and .//div[contains(@class,'font-bold')]]

${ACOS_CARD}                xpath=//div[contains(@class,'rounded-xl') and contains(@class,'shadow') and .//div[normalize-space()='ACOS'] and .//div[normalize-space()='Advertising Cost of Sales'] and .//div[contains(@class,'font-bold')]]
${ACOS_CARD_VALUE}    xpath=//div[text()='ACOS']/ancestor::div[contains(@class,'shadow')]//div[contains(@class,'font-bold')]

#----
${LIST_OF_COUPONS_COUNT}  xpath=//div[.//h2[normalize-space()='List of Coupons Count'] and .//input[@placeholder='Search Here...'] and .//button[contains(.,'By')]]
${LIST_OF_COUPONS_COUNT_SEARCH_INPUT}     xpath=//h2[normalize-space()='List of Coupons Count']     /ancestor::div[contains(@class,'mb-5')]//input[@placeholder='Search Here...']
${COUPON_EMPTY_STATE}     xpath=//div[contains(@class,'chart-bg') and .//h3[normalize-space()='No Coupons Data Available']]



${LIST_OF_COUPONS_COUNT_TABLE}  xpath=//div[contains(@class,'flex-col') and contains(@class,'gap-5') and .//div[contains(@class,'chart-bg')]]

${LIST_OF_TOP_PERFORMING_COUPONS_TITLE}   xpath=//h2[normalize-space()='List of Top Performing Coupons']
${LIST_OF_TOP_PERFORMING_COUPONS_DATA}   xpath=//div[contains(@class,'rounded-lg') and contains(@class,'shadow-md') and .//h2[normalize-space()='List of Top Performing Coupons'] and .//table and .//thead and .//th[normalize-space()='Coupon ID'] and .//th[normalize-space()='Coupon Name'] and .//th[normalize-space()='Budget'] and .//th[normalize-space()='Sales'] and .//th[normalize-space()='Disc. Amt']]
${LIST_OF_TOP_PERFORMING_COUPONS_EMPTY}  xpath=//div[contains(@class,'rounded-lg') and contains(@class,'shadow-md') and .//h2[normalize-space()='List of Top Performing Coupons']and .//div[contains(normalize-space(),'No expiring coupons')]]

${LIST_OF_UNDER_PERFORMING_COUPONS_TITLE}     xpath=//h2[normalize-space()='List of Under Performing Coupons']
${LIST_OF_UNDER_PERFORMING_COUPONS_DATA}   xpath=//div[contains(@class,'rounded-lg') and contains(@class,'shadow-md') and .//h2[normalize-space()='List of Under Performing Coupons'] and .//table and .//thead and .//th[normalize-space()='Coupon ID'] and .//th[normalize-space()='Coupon Name'] and .//th[normalize-space()='Budget'] and .//th[normalize-space()='Sales'] and .//th[normalize-space()='Disc. Amt']]
${LIST_OF_UNDER_PERFORMING_COUPONS_EMPTY}   xpath=//div[contains(@class,'rounded-lg') and contains(@class,'shadow-md') and .//h2[normalize-space()='List of Under Performing Coupons']and .//div[contains(normalize-space(),'No expiring coupons')]]

${LIST_OF_COUPONS_NEARING_BUDGET_LIMIT_TITLE}   xpath=//h2[normalize-space()='Coupons nearing budget limit']
${LIST_OF_COUPONS_NEARING_BUDGET_LIMIT_DATA}   xpath=//div[contains(@class,'rounded-lg') and contains(@class,'shadow-md')  and .//h2[normalize-space()='Coupons nearing budget limit']  and .//table and .//thead and .//th[normalize-space()='Coupon ID']  and .//th[normalize-space()='Coupon Name']  and .//th[normalize-space()='Budget'] and .//th[normalize-space()='Budget Spent'] and .//th[normalize-space()='Budget Remaining'] and .//th[normalize-space()='Sales']  and .//th[normalize-space()='Disc. Amt']]
${LIST_OF_COUPONS_NEARING_BUDGET_LIMIT_EMPTY}   xpath=////div[contains(@class,'rounded-lg') and contains(@class,'shadow-md')  and .//h2[normalize-space()='Coupons nearing budget limit']and .//div[contains(normalize-space(),'No expiring coupons')]]

${COUPONS_EXPIRING_TITLE}     xpath=//h2[normalize-space()='Coupons Expiring']
${COUPONS_EXPIRING_DATA}  xpath=//div[contains(@class,'flex-1') and contains(@class,'rounded-lg') and contains(@class,'shadow-md') and .//h2[normalize-space()='Coupons Expiring'] and .//table and .//thead and .//th[normalize-space()='Coupon ID'] and .//th[normalize-space()='Coupon Name'] and .//th[normalize-space()='Start Date'] and .//th[normalize-space()='End Date'] and .//tbody/tr[td[normalize-space()]] and not(.//div[contains(normalize-space(),'No expiring coupons')])]
${COUPONS_EXPIRING_EMPTY}     xpath=//div[contains(@class,'flex-1') and contains(@class,'rounded-lg') and contains(@class,'shadow-md') and .//h2[normalize-space()='Coupons Expiring'] and .//div[contains(normalize-space(),'No expiring coupons')]]


#----Promotion Module Elements---
${PROMOTION_LINK}   xpath=//a[@href='/promotion-performance' and normalize-space()='Promotion Performance']

${TOTAL_REVENUE_CARD}   xpath=//div[contains(@class,'rounded') and contains(@class,'shadow')][.//div[normalize-space()='Total Revenue'] and .//div[normalize-space()='Total Revenue from promotions'] and .//div[contains(@class,'text-2xl') and normalize-space()!='']]
${TOTAL_REVENUE_VALUE}  xpath=//div[text()='Total Revenue']/ancestor::div[contains(@class,'rounded')]//div[contains(text(),'Total Revenue from promotions')]/preceding-sibling::div
${CONVERSION_RATE_CARD}   xpath=//div[contains(@class,'rounded') and contains(@class,'shadow')][.//div[normalize-space()='Conversion Rate'] and .//div[normalize-space()='Avg. Conversion rate'] and .//*[contains(normalize-space(),'%')]]
${CONVERSION_RATE_VALUE}   xpath=//div[normalize-space()='Conversion Rate']/ancestor::div[contains(@class,'rounded')]//div[contains(text(),'Conversion rate')]/preceding-sibling::div
${UNITS_SOLD_CARD}   xpath=//div[contains(@class,'rounded') and contains(@class,'shadow')][.//div[normalize-space()='Units Sold'] and .//div[normalize-space()='Units Sold from promotions'] and .//div[contains(@class,'text-2xl') and normalize-space()!='']]

${DEAL_ANALYSIS}    xpath=//div[contains(@class,'chart-bg')and .//span[normalize-space()='Deal Type']and .//span[normalize-space()='Deal Start Time']and .//span[normalize-space()='Glance Views']and .//span[normalize-space()='Units Sold']and .//span[normalize-space()='Revenue']and .//span[normalize-space()='Conversion Rate']and .//span[normalize-space()='Deal Status']]
${DEAL_ANALYSIS_EMPTY}     xpath=//div[normalize-space()='Deal Analysis']/ancestor::div[contains(@class,'mt-7')]//div[contains(@class,'chart-bg') and normalize-space()='No promotions have been executed for the selected date range.']

${DEAL_ANALYSIS_DOWNLOAD_BTN}         xpath=//div[normalize-space()='Deal Analysis']/parent::div//button[.//span[normalize-space()='Download Report']]
${SKU_WISE_ANALYSIS}   xpath=//div[normalize-space()='Sku Wise Analysis']/ancestor::div[contains(@class,'flex items-center')]/following-sibling::div[contains(@class,'mt-5')]//div[contains(@class,'chart-bg')]//div[.//span[normalize-space()='Glance Views' or normalize-space()='Units Sold' or normalize-space()='Revenue' or contains(normalize-space(),'Conversion Rate')]]//span[@class='text-sm font-normal text-[#353535]']//span[not(span)]
${SKU_EMPTY_STATE}    xpath=//div[normalize-space()='Sku Wise Analysis']/ancestor::div[contains(@class,'mt-7')]//div[contains(@class,'chart-bg') and contains(text(),'No promotions')]



${SKU_WISE_ANALYSIS_DOWNLOAD_BTN}    xpath=//div[text()='Sku Wise Analysis']/../div//span[text()='Download Report']/ancestor::button
${SKU_WISE_SORT_DROPDOWN}  xpath=//div[normalize-space()='Sku Wise Analysis']/parent::div//img[@alt='sort icon']/ancestor::div[contains(@class,'cursor-pointer')] 

${SKU_SORT_OPTION}       xpath=//div[normalize-space()='Sku Wise Analysis']/ancestor::div[contains(@class,'flex items-center')]//ul//span[normalize-space()='Revenue: High to Low']
                       

${SKU_SELECTED_VALUE}        xpath=//div[normalize-space()='Sku Wise Analysis']/parent::div//span[contains(@class,'font-medium')]


#---Analysis page elements---
${ANALYSIS_LINK}   xpath=//a[normalize-space()='Analysis' and @href='/analysis-reports']

${WEEKY_SALES_ANALYSIS_PDF_DOWNLOAD}   xpath=//button[.//span[normalize-space()='Download Weekly Sales Analysis PDF']]
${UNITS_SOLD_CHART}    xpath=//span[normalize-space()='Units Sold']/ancestor::div[contains(@class,'chart-bg')]//canvas

${REVENUE_CHART}    xpath=//span[normalize-space()='Revenue']/ancestor::div[contains(@class,'chart-bg')]//canvas
${ANALYSIS_DAY_OF_WEEK_CHART}       xpath=//span[normalize-space()='Day of The Week']/ancestor::div[contains(@class,'chart-bg')]//canvas        

${ANALYSIS_PERIOD_OF_DAY_CHART}     xpath=//span[normalize-space()='Period of The Day']/ancestor::div[contains(@class,'chart-bg')]//canvas    
${OVERALL_WEEKLY_REVENUE/_INVENTORY_CHART}   xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='Overall Weekly Revenue / Inventory']]//canvas
${STATE_WISE_TOP_CONTRIBUTORS_CHART}   xpath=//span[normalize-space()='State Wise Top Contributors']/ancestor::div[contains(@class,'chart-bg')]//canvas
${CITY_WISE_TOP_CONTRIBUTORS_CHART}   xpath=//span[normalize-space()='City Wise Top Contributors']/ancestor::div[contains(@class,'chart-bg')]//canvas
${CANCELLED_SKUS_CHART}   xpath=//span[normalize-space()='Cancelled Skus']/ancestor::div[contains(@class,'chart-bg')]//canvas

${RETURNED_SKU_CARD}  xpath=//div[contains(@class,'chart-bg')][.//span[@title='Returned Skus'] and .//canvas[@data-zr-dom-id]]

${ANALYSIS_SUMMARY_CARD}   xpath=//div[contains(@class,'chart-bg')][.//p[contains(@class,'whitespace-pre-wrap')]]


#--Projection Module Elements---
${PROJECTION_LINK}   xpath=//a[@href='/projection-sales' and normalize-space()='Projection']

${PROJECTION_PRESENT_TIMELINE_DROPDOWN}  xpath=//span[normalize-space()='Present Timeline']/following-sibling::div/div[contains(@class,'cursor-pointer') and contains(@class,'rounded-lg')]
${PROJECTION_PRESENT_TIMELINE_SELECTED}    xpath=//span[normalize-space()='Present Timeline']/following::span[contains(@class,'font-medium')][1]
${PROJECTION_PRESENT_TIMELINE_OPTION}     xpath=//span[normalize-space()='Present Timeline']/following::span[contains(@class,'filter-label') and normalize-space()='{{VALUE}}'][1]      

${PROJECTION_PROJECTED_TIMELINE_DROPDOWN}  xpath=//span[normalize-space()='Projected Timeline']/following::div[contains(@class,'cursor-pointer')][1]
${PROJECTION_PROJECTIED_TIMELINE_SELECTED}    xpath=//span[normalize-space()='Projected Timeline']/following::span[contains(@class,'font-medium')][1]
${PROJECTION_PROJECTIED_TIMELINE_OPTION}   xpath=//span[normalize-space()='Projected Timeline']/following::span[contains(@class,'filter-label') and normalize-space()='{{VALUE}}'][1]

${PROJECTION_SUBMIT_BUTTON}  xpath=//span[normalize-space()='Projected Timeline']/following::button[.//span[normalize-space()='Submit']][1]





${SALES_PROJECTION_REPORT_TABLE}      xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Sales Projection Report']  and .//table and .//th[normalize-space()='SKU'] and .//th[normalize-space()='Units'] and .//th[normalize-space()='Revenue'] and .//th[contains(normalize-space(),'Average Selling Units')] and .//th[contains(normalize-space(),'Average Selling Price')] and .//th[contains(normalize-space(),'Projected Revenue')] and .//th[contains(normalize-space(),'Projected Units')] and count(.//tbody/tr[.//td[normalize-space()!='']]) >= 1]
${SALES_PROJECTION_REPORT_EMPTY}    xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Sales Projection Report']]//div[normalize-space()='No Records Found']

${SALES_PROJECTION_REPORT_DOWNLOAD_REPORT}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Sales Projection Report']]//button[.//span[normalize-space()='Download Report'] or normalize-space()='Download Report']


#---Repeat Purchase Orders -----
${REPEAT_PURCHASE_ANALYSIS_LINK}        xpath=//a[@href='/purchase-analysis' and normalize-space()='Repeat Purchase Analysis']
${TOTAL_ORDERS_CARD}       xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Total Orders']][.//div[contains(@class,'text-md') and normalize-space()='Total Orders']]
${TOTAL_ORDERS_VALUE}        xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Total Orders']] //div[contains(@class,'text-2xl')]

${UNIQUE_CUSTOMER_CARD}     xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Unique Customers']][.//div[contains(@class,'text-md') and normalize-space()='Total no of Unique Customers']]
${UNIQUE_CUSTOMER_VALUE}   xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Unique Customers']]//div[contains(@class,'text-2xl')]

${REPEATED_CUSTOMER_CARD}    xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Repeated Customers']][.//div[contains(@class,'text-md') and normalize-space()='Total no of Repeate Customers']] 
${REPEATED_CUSTOMER_VALUE}    xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Repeated Customers']]//div[contains(@class,'text-2xl')]

${REPEAT_REVENUE_CARD}     xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Repeat Revenue']][.//div[contains(@class,'text-md') and normalize-space()='Total Repeat Value']]
${REPEAT_REVENUE_VALUE}    xpath=//div[contains(@class,'shadow')][.//div[contains(@class,'text-xl') and normalize-space()='Repeat Revenue']]//div[contains(@class,'text-2xl')]

${REPEAT_PURCHASE_REPEAT_CARD}   xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Repeat Purchase Report']]
${REPEAT_PURCHASE_REPEAT_DOWNLOAD_BTN}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Repeat Purchase Report']]//button[.//span[normalize-space()='Download Report']]

${REPEAT_PURCHASE_REPEAT_CARD_TABLE_DATA}   xpath=//div[contains(@class,'chart-bg')]   [.//div[normalize-space()='Repeat Purchase Report']]//tbody
${REPEAT_PURCHASE_REPEAT_CARD_TABLE_EMPTY}     xpath=//div[contains(@class,'chart-bg')]   [.//div[normalize-space()='Repeat Purchase Report']]//div[contains(@class,'justify-center') and normalize-space()='No Records Found']

#---Inventory-----


${INVENTORY_LABEL}   xpath=//button[.//span[normalize-space()='Inventory']]
${DASHBOARD_LINK}    xpath=//a[@href='/inventory-dashboard' and normalize-space()='Dashboard']

#--cards--
${NO_OF_SKUS_CARD}   xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='No. of SKUs']][.//div[normalize-space()='Total No. of SKUs']]
${INVENTORY_UNITS_CARD}   xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Inventory Units']][.//div[normalize-space()='Total Units of Inventory']]
${INVENTORY_VALUE_CARD}        xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Inventory Value']][.//div[normalize-space()='Total Value of Inventory']]
${INVENTORY_VALUE}  //div[normalize-space()='Inventory Value']
...    /ancestor::div[contains(@class,'shadow')]
...    //div[contains(@class,'text-2xl')]

${REVENUE_UNITS_VS_INVENTORY_CARD}          xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Revenue Units Vs Inventory'] and .//canvas]


${REVENUE_UNITS_VS_INVENTORY_DOWNLOAD_BTN}     xpath=//span[normalize-space()='Revenue Units Vs Inventory']/ancestor::div[contains(@class,'relative') and contains(@class,'col-span')]/div[contains(@class,'absolute') and contains(@class,'top-5')]//input[@role='combobox']

${REVENUE_UNITS_VS_INVENTORY_DROPDOWN}     xpath=//span[normalize-space()='Revenue Units Vs Inventory']/ancestor::div[contains(@class,'relative') and contains(@class,'col-span')]/div[contains(@class,'absolute') and contains(@class,'top-5')]//input[@role='combobox']

${REVENUE_UNITS_VS_INVENTORY_DROPDOWN_BTN}  xpath=//button[contains(@id,'headlessui-combobox-button')]
${REVENUE_UNITS_VS_INVENTORY_DROPDOWN_POPUP}    xpath=//ul[@role='listbox' and @data-headlessui-state='open']

${REVENUE_UNITS_VS_INVENTORY_DROPDOWN_OPTION}   xpath=( //div[contains(@class,'absolute') and contains(@class,'right-5')]  //following::ul[@role='listbox']  //li[@role='option'] )[2]
${REVENUE_UNITS_VS_INVENTORY_SHIMMER}        xpath=//div[contains(@class,'chart-bg')  and .//span[normalize-space()='Revenue Units Vs Inventory']  and not(.//canvas)]

${SKU_WISE_FBA_UNITS_CARD_CANVAS}      xpath=//div[contains(@class,'chart-bg')][.//span[@title='SKU Wise FBA Units']][.//canvas]
${SKU_WISE_FBA_UNITS_TOGGLE}    xpath=//span[@title='SKU Wise FBA Units']   /ancestor::div[contains(@class,'relative')]   //div[contains(@class,'absolute') and contains(@class,'flex')]   //input[contains(@class,'appearance-none')]
${SKU_WISE_FBM_UNITS_CARD_CANVAS}   xpath=//div[contains(@class,'chart-bg')][.//span[@title='SKU Wise FBM Units']][.//canvas]
${SKU_WISE_FBM_UNITS_TOGGLE}   xpath=//span[@title='SKU Wise FBM Units']   /ancestor::div[contains(@class,'relative')]   //div[contains(@class,'absolute') and contains(@class,'flex')]   //input[contains(@class,'appearance-none')]

${SKU_NET_MONTH_COVERAGE_CARD_CANVAS}   xpath=//div[contains(@class,'chart-bg')][.//span[@title='SKU Net Month Coverage']][.//canvas]
${SKU_NET_MONTH_COVERAGE_DOWNLOAD_BTN}   xpath=//span[normalize-space()='SKU Net Month Coverage']/ancestor::div[contains(@class,'chart-bg')]/following-sibling::div[contains(@class,'absolute')]//button
${SKU_NET_MONTH_COVERAGE_TOGGLE}   xpath=//span[@title='SKU Net Month Coverage']   /ancestor::div[contains(@class,'relative')]   //div[contains(@class,'absolute') and contains(@class,'flex')]   //input[contains(@class,'appearance-none')]
${SKU_NET_MONTH_COVERAGE_DROPDOWN}   xpath=(//div[contains(@class,'cursor-pointer') and .//span[contains(text(),'Month')]])[1]
${SKU_NET_MONTH_COVERAGE_DROPDOWN_POPUP}    xpath=(//div[contains(@class,'absolute') and .//li[contains(@class,'filter-li')]])[2]
${SKU_NET_MONTH_COVERAGE_DROPDOWN_OPTION}   xpath=//div[contains(@class,'shadow-default') and contains(@class,'block') and contains(@class,'z-100')][.//span[contains(text(),'Month')]]//ul//li[contains(@class,'filter-li')][2]
${SKU_NET_MONTH_COVERAGE_SHIMMER}   xpath=//span[normalize-space()='SKU Net Month Coverage']/ancestor::div[contains(@class,'chart-bg')]//*[contains(@class,'shimmer') or contains(@class,'skeleton') or contains(@class,'animate-pulse')]
                                            
${INVENTORY_DISTRIBUTION_COVERAGE_CARD_CANVAS}    xpath=//div[contains(@class,'chart-bg')][.//span[@title='Inventory Distribution Coverage (In Months)']][.//canvas]
${FBA_VS_FBM}     xpath=//div[contains(@class,'chart-bg')][.//span[@title='FBA Vs FBM']][.//canvas]

${INVENTORY_REPORT_CARD_TABLE}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Inventory Report']][.//table]
${INVENTORY_REPORT_DOWNLOAD_BTN}    xpath=//div[contains(@class,'chart-bg')][ .//div[normalize-space()='Inventory Report'] ]//button[.//span[normalize-space()='Download Report']]
${INVENTORY_REPORT_TABLE}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Inventory Report']]//table

${SKU_WISE_WEEK_OF_COVERAGE_CARD}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Sku Wise Week of Coverage']][count(.//table)>=2][.//span[normalize-space()='1 Week']]

${SKU_WISE_WEEK_OF_COVERAGE_DROPDOWN}    xpath=//div[contains(@class,'chart-bg')][ .//div[normalize-space()='Sku Wise Week of Coverage'] ]//div[contains(@class,'z-100') and contains(@class,'shadow')][.//span[contains(normalize-space(.),'Week')]]

${SKU_WISE_WEEK_OF_COVERAGE_DROPDOWN_POPUP}   xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Sku Wise Week of Coverage']]//div[contains(@class,'shadow-default') and contains(@class,'block')]


${SKU_WISE_WEEK_OF_COVERAGE_DROPDOWN_OPTION}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Sku Wise Week of Coverage']]//ul//li[contains(@class,'filter-li')][.//span[normalize-space()='2 Weeks']]
${SKU_WISE_WEEK_OF_COVERAGE_SHIMMER}       xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Sku Wise Week of Coverage']]//*[contains(@class,'shimmer')or contains(@class,'skeleton')or contains(@class,'animate-pulse')]

${SKU_WISE_WEEK_OF_COVERAGE_CARD_DATA}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Sku Wise Week of Coverage']][count(.//table)>=2][.//span[normalize-space()='1 Week']]
${SKU_WISE_WEEK_OF_COVERAGE_CARD_NO_DATA}   xpath=//div[contains(@class,'chart-bg')]//div[normalize-space()='No Records Found']


#---Inventory Projection----

${INVENTORY_PROJECTION_LINK}   xpath=//a[@href='/projection-inventory' and normalize-space()='Projection']
   
${INVENTORY_PROJECTION_REPORT_TABLE}      xpath=//table[.//th//span[normalize-space()='SKU'] and .//th//span[normalize-space()='Units Sold']]

${INVENTORY_PROJECTION_REPORT_EMPTY}    xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Sales Projection Report']]//div[normalize-space()='No Records Found']

${INVENTORY_PROJECTION_REPORT_DOWNLOAD_REPORT}  xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Inventory Projection Report']]//button[.//span[normalize-space()='Download Report']]


${INVENTORY_PROJECTION_REPORT_SHIMMER}   xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='Inventory Projection Report']and not(.//tbody/tr[.//td[normalize-space()!='']])]
${PAGINATION}   xpath=//ul[@role='navigation' and @aria-label='Pagination']//a[@aria-label='Page 2']




#--Inventory Overview---
${INVENTORY_OVERVIEW_LINK}      xpath=//a[@href='/inventory-overview' and normalize-space()='Overview']

${TOTAL_LTFS_CHARGE_CRAD}  xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Total Ltfs Charge']][.//div[normalize-space()='Total Ltfs For 5 Months']]
${STORAGE_FEES_CARD}    xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Storage Fees']][.//div[normalize-space()='Total Storage Fees']]

${INVENTORY_HEALTH}   xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Inventory Health']][.//div[normalize-space()='Avg Inventory Health Level']]
${TOTAL_INV_UNITS_AGE}     xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Total Inv-units Age']]
${INVENTORY_STATUS_CARD_CANVAS}    xpath=//div[contains(@class,'chart-bg') and .//span[@title='Inventory Status'] and .//canvas]

${INVENTORY_STATUS_REPORT_CARD}     xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Inventory Status Report']  and .//input[@type='search']  and .//button[.//span[normalize-space()='Download Report']] ]
${INVENTORY_STATUS_REPORT_TABLE_EMPTY}   xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Status Report'] and .//input[@type='search'] and .//button[.//span[normalize-space()='Download Report']] and .//table and .//th[normalize-space()='SKU'] and .//th[normalize-space()='Inbound Qty'] and .//th[normalize-space()='Inbound Working'] and .//th[normalize-space()='Inbound Shipped'] and .//th[normalize-space()='Inbound Received'] and .//th[normalize-space()='Reserved Qty'] and .//th[normalize-space()='Unfulfillable Qty'] and count(.//tbody/tr)=0]

${INVENTORY_STATUS_REPORT_TABLE_DATA}    xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Inventory Status Report']][.//table][.//th[normalize-space()='SKU']][.//th[normalize-space()='Inbound Qty']][.//th[normalize-space()='Inbound Working']][.//th[normalize-space()='Inbound Shipped']][.//th[normalize-space()='Inbound Received']][.//th[normalize-space()='Reserved Qty']][.//th[normalize-space()='Unfulfillable Qty']][count(.//tbody/tr) >= 1]
${INVENTORY_STATUS_REPORT_DOWNLOAD_BTN}    xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Status Report']]//button[.//span[normalize-space()='Download Report']]
${INVENTORY_STATUS_SEARCH}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Status Report']]//input[@type='search']


${INVENTORY_AGE_REPORT_CARD}   xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Inventory Age Report']  and .//input[@type='search']  and .//button[.//span[normalize-space()='Download Report']] ]
${INVENTORY_AGE_SEARCH}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Age Report']]//input[@type='search']
${INVENTORY_AGE_REPORT_TABLE_EMPTY}   xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Status Report'] and .//input[@type='search'] and .//button[.//span[normalize-space()='Download Report']] and .//table and .//th[normalize-space()='SKU'] and .//th[normalize-space()='Inbound Qty'] and .//th[normalize-space()='Inbound Working'] and .//th[normalize-space()='Inbound Shipped'] and .//th[normalize-space()='Inbound Received'] and .//th[normalize-space()='Reserved Qty'] and .//th[normalize-space()='Unfulfillable Qty'] and count(.//tbody/tr)=0]

${INVENTORY_AGE_REPORT_TABLE_DATA}    xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='Inventory Age Report']and .//table and .//th[normalize-space()='SKU']and .//th[normalize-space()='Inventory Age 0-90 days']and .//th[normalize-space()='Inventory Age 91-180 days']and .//th[normalize-space()='Inventory Age 181-270 days']and .//th[normalize-space()='Inventory Age 271-365 days']and .//th[normalize-space()='Inventory age more than 365 days']and .//th[normalize-space()='Quantity Charged ltsf for 5 months']and .//th[normalize-space()='Projected ltsf for 5 months']and .//th[normalize-space()='Quantity Charged ltsf for 12 months']and .//th[normalize-space()='Estimated ltsf next charge']and .//th[normalize-space()='Pending Removal Quantity']and .//th[normalize-space()='Healty Inventory Level']and .//th[normalize-space()='Estimated Excess Quantity'] and count(.//tbody/tr) >= 1]
${INVENTORY_AGE_REPORTT_DOWNLOAD_BTN}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Age Report']]//button[.//span[normalize-space()='Download Report']] 


${INVENTORY_STORAGE_REPORT_CARD}   xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Inventory Storage Report']  and .//input[@type='search']  and .//button[.//span[normalize-space()='Download Report']] ]
${INVENTORY_STORAGE_SEARCH}     xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Storage Report']]//input[@type='search']
${INVENTORY_STORAGE_REPORT_TABLE_EMPTY}   xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='Inventory Storage Report']and .//input[@type='search']and .//button[.//span[normalize-space()='Download Report']]]//table[.//th[normalize-space()='SKU']and .//th[normalize-space()='Estimated Monthly Storage Fee']and .//th[normalize-space()='Storage Fee Contribution']and .//th[normalize-space()='Sales Contribution']and count(.//tbody/tr) = 0]
${INVENTORY_STORAGE_REPORT_TABLE_DATA}    xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Inventory Storage Report']  and .//input[@type='search']  and .//button[.//span[normalize-space()='Download Report']] ]//table[.//th[normalize-space()='SKU']and .//th[normalize-space()='Estimated Monthly Storage Fee']and .//th[normalize-space()='Storage Fee Contribution']and .//th[normalize-space()='Sales Contribution']and count(.//tbody/tr) > 0]

${INVENTORY_STORAGE_REPORTT_DOWNLOAD_BTN}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Storage Report']]//button[.//span[normalize-space()='Download Report']] 


${INVENTORY_REMOVAL_REPORT_CARD}   xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Inventory Removal Report']  and .//input[@type='search']  and .//button[.//span[normalize-space()='Download Report']] ]
${INVENTORY_REMOVAL_SEARCH}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Removal Report']]//input[@type='search']
${INVENTORY_REMOVAL_REPORT_TABLE_EMPTY}   xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='Inventory Removal Report']and .//input[@type='search']and .//button[.//span[normalize-space()='Download Report']]and .//div[normalize-space()='No Records Found']]
${INVENTORY_REMOVAL_REPORT_TABLE_DATA}    xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Inventory Removal Report']  and .//input[@type='search']  and .//button[.//span[normalize-space()='Download Report']] ]//table
${INVENTORY_REMOVAL_REPORTT_DOWNLOAD_BTN}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Inventory Removal Report']]//button[.//span[normalize-space()='Download Report']] 


#---Inventory Suppressed-listings
${INVENTORY_SUPPRESSED_LISTINGS_LINK}  xpath=//a[@href='/suppressed-listings' and normalize-space()='Suppressed Listings']
${TOTAL_SUPRESSED_LISTINGS_CARD}  xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Total Suppressed Listings']][.//div[normalize-space()='Listings suppressed']]
${INVENTORY_QUANITY_CARD}  xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Inventory Quantity']]
${LOSS_OF_SALES_CARD}   xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Loss of Sales']]
${SUPRESSED_REASONS_GRAPH}  xpath=//div[contains(@class,'echarts-for-react') and contains(@class,'chart-bg')]
${SUPRESSED_REASONS_DROPDOWN_CARD}    xpath=//div[contains(@class,'chart-bg')][.//h2[normalize-space()='Suppressed Reason']and .//select]
${SUPRESSED_REASONS_DROPDOWN}  xpath=//select[contains(@class,'input-box')][.//option[normalize-space()='All']]
${SUPRESSED_LISTINGS_REPORT_CARD}   //div[contains(@class,'chart-bg')][.//div[normalize-space()='Suppressed Listings Report']][.//table]
    
${SUPRESSED_LISTINGS_REPORT_CARD_TABLE_DATA}  xpath=//div[normalize-space()='Suppressed Listings Report']/ancestor::div//table[.//th[normalize-space()='SKU'] and .//th[normalize-space()='Inventory Quantity'] and .//th[contains(normalize-space(),'Loss of sale')] and .//th[normalize-space()='Status'] and .//th[normalize-space()='Reason'] and .//th[normalize-space()='Suppressed Date'] and .//th[contains(normalize-space(),'No. of days')] and .//th[normalize-space()='Suppressed Issue']and count(.//tbody/tr) > 0]

${SUPRESSED_LISTINGS_REPORT_CARD_TABLE_EMPTY}   xpath=//table[preceding::div[normalize-space()='Suppressed Listings Report'] and .//th[normalize-space()='SKU'] and .//th[normalize-space()='Inventory Quantity'] and .//th[contains(normalize-space(),'Loss of sale')] and .//th[normalize-space()='Status'] and .//th[normalize-space()='Reason'] and .//th[normalize-space()='Suppressed Date'] and .//th[contains(normalize-space(),'No. of days')] and .//th[normalize-space()='Suppressed Issue'] and count(.//tbody/tr)=0]
${SUPPRESSED_LISTINGS_REPORT_SHIMMER}   xpath=//div[normalize-space()='Suppressed Listings Report']]//div[contains(@class,'animate') or contains(@class,'skeleton') or contains(@class,'shimmer')]
${SUPRESSED_LISTINGS_REPORT}  xpath=//div[contains(@class,'chart-bg')][.//div[normalize-space()='Suppressed Listings Report']]
${SUPRESSED_LISTINGS_REPORT_DOWNLOAD_BTN}    xpath=//div[.//div[normalize-space()='Suppressed Listings Report']]//button[.//span[normalize-space()='Download Report']]

#-----Business----
${BUSINESS_LINK}    xpath=//button[.//span[normalize-space()='Business']]
${STANDARD_REPORT_SUBMIT_CARD}  xpath=//div[contains(@class,'chart-bg')and .//span[normalize-space()='Select Time Period']and .//button[.//span[normalize-space()='Submit']]]
${UNITS_SOLD_DROPDOWN}   xpath=(//div[contains(@class,'rounded-lg')]//span[contains(@class,'font-medium')])[1]

${ALL_ASINS_DROPDOWN}   xpath=(//div[contains(@class,'rounded-lg')]//span[contains(@class,'font-medium')])[2]
${STANDARD_REPORT_SUMBIT_BTN}  xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Select Time Period']]//button[.//span[normalize-space()='Submit']]

${BUSINESS_CHART_CARD}  xpath=//div[contains(@class,'chart-bg')  and .//span[normalize-space()='Business Chart']  and .//canvas]
${BUSINESS_CHART_CARD_DOWNLOAD_BTN}    xpath=//button[.//span[normalize-space()='Download Report']]
${STANDARD_REPORT_CARD}   xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='Reports']and .//table]

${STANDARD_REPORT_CARD_TABLE_DATA}   xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Reports']]//table[.//th[.//span[normalize-space()='Date']] and .//th[.//span[normalize-space()='Units Sold']] and .//th[.//span[normalize-space()='Unit Refund']]]

${STANDARD_REPORT_CARD_TABLE_EMPTY}   xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Reports']]//table[.//tbody and not(.//tbody/tr)]
${BUSINESS_CHART_SHIMMER}   xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Business Chart']] //*[contains(@class,'animate-pulse') or contains(@class,'shimmer') or contains(@class,'skeleton') or contains(@class,'loading')]
${STANDARD_REPORT_SHIMMER}    xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Reports']]//*[contains(@class,'animate-pulse') or contains(@class,'shimmer') or contains(@class,'skeleton') or contains(@class,'loading')]


#---
${WEEK_WISE_COMPARISON_TAB}  xpath=//span[normalize-space()='Week Wise Comparison']
${SELECT_TYPE_OF_CARD}  xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Select Type of Report']]
${SELECT_TYPE_OF_DROPDOWN}   xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Select Type of Report']]//div[contains(@class,'rounded-lg')]

${WEEK_WISE_COMPARISON_REPORT_CARD}    xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Reports']  and .//button  and .//table]
${WEEK_WISE_COMPARISON_REPORT_DOWNLAOD_BTN}  xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Reports']]//button[.//span[normalize-space()='Download Report']]
${WEEK_WISE_COMPARISON_REPORT_SHIMMER}  xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Select Type of Report']]//*[contains(@class,'animate-pulse') or contains(@class,'shimmer') or contains(@class,'skeleton') or contains(@class,'loading')]

${TIME_SHEET_TAB}    xpath=//span[normalize-space()='Time Sheet']
${SELECT_TIME_PERIOD_CARD}    xpath=//div[contains(@class,'chart-bg')and .//span[normalize-space()='Select Time Period']and .//span[normalize-space()='Select SKUs:']and .//input[@readonly]and .//button[.//span[normalize-space()='Submit']]]
${SELECT_TIME_PERIOD_CARD_DROPDOWN}  xpath=//div[contains(@class,'chart-bg')]//span[normalize-space()='Select SKUs:']/following::div[contains(@class,'cursor-pointer')][1]
${SELECT_TIME_PERIOD_CARD_DATE_PICKER}  xpath=//span[normalize-space()='Select Time Period']/following::input[contains(@class,'datepicker-input-field')][1]
${SELECT_TIME_PERIOD_SUBMIT_BTN}  xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Select Time Period']]//button[.//span[normalize-space()='Submit']]

${UNITS_SOLD_PER_HOURS_CARD}  xpath=//div[contains(@class,'chart-bg')and .//span[normalize-space()='Units Sold Per Hour']and .//canvas]

${REVENUE_PER_HOUR_CARD}  xpath=//div[contains(@class,'chart-bg')  and .//span[normalize-space()='Revenue Per Hour']  and .//canvas]
${BUSINESS_TIME_SHEET_DATA_CARD}  xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='Business Time Sheet Data']and .//button[.//span[normalize-space()='Download Report']]and .//table]
${BUSINESS_TIME_SHEET_DATA_DOWNLOAD_BTN}   xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Business Time Sheet Data']]//button[.//span[normalize-space()='Download Report']]

${COMPARE_SALES_CARD}  xpath=//div[contains(@class,'chart-bg')  and .//div[normalize-space()='Compare Sales']  and .//button[.//span[normalize-space()='Download Report']]  and .//table]
${COMPARE_SALES_CARD_DOWNLOAD_BTN}   xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Compare Sales']]//button[.//span[normalize-space()='Download Report']]

${SELECT_TIME_PERIOD_CARD_SHIMMER}    xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Select Time Period']]//*[contains(@class,'shimmer') or contains(@class,'animate-pulse') or contains(@class,'skeleton') or contains(@class,'loading')]
${UNITS_SOLD_PER_HOURS_CARD_SHIMMER}    xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Units Sold Per Hour']]//*[contains(@class,'shimmer') or contains(@class,'animate-pulse') or contains(@class,'skeleton') or contains(@class,'loading')]
${REVENUE_PER_HOUR_CARD_SHIMMER}    xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Revenue Per Hour']]//*[contains(@class,'shimmer') or contains(@class,'animate-pulse') or contains(@class,'skeleton') or contains(@class,'loading')]
${BUSINESS_TIME_SHEET_DATA_CARD_SHIMMER}    xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Business Time Sheet Data']]//*[contains(@class,'shimmer') or contains(@class,'animate-pulse') or contains(@class,'skeleton') or contains(@class,'loading')]
${COMPARE_SALES_CARD_SHIMMER}    xpath=//div[contains(@class,'chart-bg') and .//div[normalize-space()='Compare Sales']]//*[contains(@class,'shimmer') or contains(@class,'animate-pulse') or contains(@class,'skeleton') or contains(@class,'loading')]


${PROFIT_AND_LOSS_TAB}    xpath=//span[normalize-space()='Profit & Loss']
${PNL_TOP_CARD}     xpath=//div[contains(@class,'chart-bg') and .//input[contains(@class,'datepicker-input-field')] and .//button[.//span[normalize-space()='Update Cogs']] and .//button[contains(.,'Download Reports')]]

${PROFIT_AND_LOSS_DATE_PICKER}   xpath=//div[contains(@class,'datepicker-main-container')]//input[@readonly]
${UPDATE_COGS_BTN}    xpath=//button[.//span[normalize-space()='Update Cogs']]

${PROFIT_AND_LOSS_DOWNLOAD_BTN}   xpath=//div[contains(@class,'chart-bg')]//button[contains(.,'Download Reports')]
${PNL_DOWNLOAD_PDF_BTN}  xpath=//div[contains(@class,'chart-bg')]//button[.//span[normalize-space()='PDF']]
${PNL_DOWNLOAD_CSV_BTN}  xpath=//div[contains(@class,'chart-bg')]//button[.//span[normalize-space()='CSV']]

${PNL_INCOME_EXPENSE_CARD}  xpath=//div[contains(@class,'chart-bg')and .//span[normalize-space()='PNL Income Expense']and .//canvas]
${PNL_REPORT_CARD}    xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='PNL Report']and .//span[normalize-space()='Income']and .//span[normalize-space()='Expense']and .//td[normalize-space()='Total Income']and .//td[normalize-space()='Total Expense']]


${PNL_REPORT_CARD_SHIMMER}  xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='PNL Report']]//div[contains(@class,'animate') or contains(@class,'shimmer')or contains(@class,'skeleton')]

${PNL_INCOME_EXPENSE_CARD_SHIMMER}  xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='PNL Income Expense']]//div[contains(@class,'animate') or contains(@class,'shimmer')]


#--update catelog---
${TOTAL_PRODUCTS_CARD}  xpath=//div[contains(@class,'relative')and contains(@class,'rounded')and contains(@class,'bg-white')][.//div[normalize-space()='Total Products']]
${UPDATED_PRODUCTS_CARD}    xpath=//div[contains(@class,'relative')and contains(@class,'rounded') and contains(@class,'bg-white')][.//div[normalize-space()='Updated Products']]
${REMAINING_PRODUCTS_TO_MAP_CARD}   xpath=//div[contains(@class,'relative')and contains(@class,'rounded')and contains(@class,'bg-white')][.//div[normalize-space()='Updated Products']]

${MAP_PRODUCT_COGS_CARD}   xpath=//div[contains(@class,'chart-bg')and .//div[normalize-space()='Map Product Cogs']and .//input[@type='search'and @placeholder='Search Here...']and .//button[.//span[normalize-space()='Upload Report']]and .//button[.//span[normalize-space()='Download Report']]]
${MAP_PRODUCT_COGS_SEARCH}  xpath=//input[@type='search' and @placeholder='Search Here...']
${MAP_PRODUCT_COGS_UPLOAD_BTN}   xpath=//button[contains(@class,'shadow')and contains(@class,'cursor-pointer')and .//span[normalize-space()='Upload Report']]
${MAP_PRODUCT_COGS_DOWNLOAD_BTN}  xpath=//button[contains(@class,'shadow')and contains(@class,'cursor-pointer')and .//span[normalize-space()='Download Report']]
${MAP_PRODUCT_COGS_TABLE}   xpath=//table[.//th[normalize-space()='SKU']and .//th[normalize-space()='Cogs']and .//th[normalize-space()='Update']]

${FIRST_ROW_COGS_INPUT}    xpath=(//input[@type='number' and @placeholder='Enter Amount'])[1]

${FIRST_ROW_UPDATE_BTN}    xpath=(//button[normalize-space()='UPDATE'])[1]


${NEXT_BTN}        xpath=//ul[@role='navigation']//a[@aria-label='Next page']
${PREVIOUS_BTN}    xpath=//ul[@role='navigation']//a[@aria-label='Previous page']
${ACTIVE_PAGE}     xpath=//ul[@role='navigation']//a[@aria-current='page']



#---Marketing----
#--Dashboard---
${MARKETING_LABEL}  xpath=//button[.//span[normalize-space()='Marketing']]
${MARKETING_DASHBOARD_LINK}  xpath=//a[@href='/marketing/dashboard' and normalize-space()='Dashboard']

${CREATE_NEW_CAMPAIGN_BTN}  xpath=//button[.//span[normalize-space()='Create New Campaign']]
${SPONSOR_TYPE_SELECTION_DROPDOWN}  xpath= //button[ .//span[normalize-space()='Sponsored Product'] and .//span[normalize-space()='Sponsored Brand'] and .//span[normalize-space()='Sponsored Display'] ]
${FILTER_SUBMIT_BUTTON}  xpath=//button[.//span[normalize-space()='Submit']]

${TOTAL_SALES_CARD}   xpath=//div[contains(@class,'shadow')][.//div[normalize-space()='Total Sales']][.//div[text()='Total Sales']]
${TOTAL_SALES_CARD_VALUE}   xpath=//div[normalize-space()='Total Sales']/ancestor::div[contains(@class,'shadow')]//div[contains(@class,'text-2xl')]

${TOTAL_AD_SALES_CARD}  xpath=//div[contains(@class,'shadow') and contains(@class,'p-4')][.//div[normalize-space()='Total Ad Sales']][.//div[text()='Total Ad Sales']]
${TOTAL_AD_SALES_CARD_VALUE}  xpath=//div[normalize-space()='Total Ad Sales']/ancestor::div[contains(@class,'shadow')]//div[contains(@class,'text-2xl')]

${TOTAL_AD_SPEND_CARD}   xpath=//div[contains(@class,'shadow') and contains(@class,'p-4')][.//div[normalize-space()='Total Ad Spend']][.//div[text()='Total Ad Spend']]
${TOTAL_AD_SPEND_CARD_VALUE}  xpath=//div[normalize-space()='Total Ad Spend']/ancestor::div[contains(@class,'shadow')]//div[contains(@class,'text-2xl')]


${IMPRESSIONS_CARD_WITH_VALUE}   xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Impressions'] and .//div[contains(@class,'font-semibold')]]

${CLICKS_CARD_WITH_VALUE}  xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Clicks'] and .//div[contains(@class,'font-semibold')]]

${ACOS_CARD_WITH_VALUE}   xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='ACOS'] and .//div[contains(@class,'font-semibold')]]

${TACOS_CARD_WITH_VALUE}   xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='TACOS'] and .//div[contains(@class,'font-semibold')]]

${ROAS_CARD_WITH_VALUE}  xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='ROAS'] and .//div[contains(@class,'font-semibold')]]

${CPC_CARD_WITH_VALUE}   xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='CPC'] and .//div[contains(@class,'font-semibold')]]
${CTR_CARD_WITH_VALUE}    xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='CTR'] and .//div[contains(@class,'font-semibold')]]
${ORDERS_CARD_WITH_VALUE}  xpath=//div[contains(@class,'shadow') and .//div[normalize-space()='Orders'] and .//div[contains(@class,'font-semibold')]]


${CATEGORY_PERFORMANCE_CHART_CARD}  xpath=//div[contains(@class,'chart-bg')][.//span[normalize-space()='Category Performance']][.//canvas]
${AD_VS_ORGANIC_SALES_CHART_CARD}  xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Ad Sales Vs Organic Sales'] and .//canvas]
${TRENDS_CHART_CARD}   xpath=//div[contains(@class,'chart-bg') and .//span[normalize-space()='Trends'] and .//canvas]

${TRENDS_SPEND_DROPDOWN}  xpath=//span[normalize-space()='Trends']/ancestor::div[contains(@class,'chart-bg')]//span[normalize-space()='Spend']/ancestor::div[not(contains(@class,'hidden'))]


${CAMPAIGN_REPORT_CARD}  xpath=//div[contains(@class,'pt-5') and .//div[normalize-space()='Campaign Report']]
${CAMPAIGN_REPORT_SEARCH}      xpath=//div[normalize-space()='Campaign Report']/ancestor::div[1]//input[@type='search']


${AD_WASTAGE_TAB}   xpath=//span[normalize-space()='Ad Wastage']
${AD_WASTAGE_TAB_SEARCH_INPUT}  xpath=//input[@placeholder='Search here...']

${RUN_DETECTION_BUTTON}  xpath=//button[.//span[normalize-space()='Run detection']]
${NO_RULES_CARD}  xpath=//p[contains(@class,'chart-bg') and contains(.,'You haven’t created any rules yet')]
${RULES_CARD}  xpath=//div[contains(@class,'chart-bg')]

#---Sponsored Brands----
#--Campaign---

${MARKETING_SPONSORED_BRANDS_LINK}  xpath=//a[contains(@href,'sponsored-brands') and normalize-space()='Sponsored Brands']

${NEW_TO_BRAND_INPUT}  xpath=//h1[normalize-space()='New To Brand']/following::input[@role='switch'][1]
${NEW_TO_BRAND_CONTAINER}  xpath=//h1[normalize-space()='New To Brand']/following::input[@role='switch'][1]/parent::div

${SEARCH_BOX}  id=default-search
${MARKETING_SPONSORED_BRANDS_DOWNLOAD_BTN}  xpath=//input[@type='search']/following::button
${CAMPAIGN_TABLE}  xpath=//table[.//th[normalize-space()='Campaign Name'] and .//tbody/tr]

${AD_GROUP_TAB}  xpath=//span[normalize-space()='Ad Group']

${AD_GROUP_NAME_TABLE}  xpath=//table[.//th[normalize-space()='Ad Group Name'] and .//tbody/tr]

${PLACEMENT_TAB}  xpath=//span[normalize-space()='Placement']

${PLACEMENT_TABLE}  xpath=//table[.//th[normalize-space()='Placement'] and .//tbody/tr]


${TARGET_TAB}  xpath=//span[normalize-space()='Target']

${TARGET_TABLE}  xpath=//table[.//th[normalize-space()='Target Text'] and .//tbody/tr]


${SEARCH_TERM_TAB}  xpath=//span[normalize-space()='Search Term']

${SEARCH_TERM_TABLE}  xpath=//table[.//th[normalize-space()='Search Term'] and .//tbody/tr]

${PURCHASE_TAB}  xpath=//span[normalize-space()='Purchase']

${PURCHASE_TERM_TABLE}  xpath=//table[.//th[normalize-space()='Campaign Name'] and .//tbody/tr]


#------Marketing ---Sponsored Product---
${MARKETING_SPONSORED_PRODUCT_LINK}  xpath=//a[contains(@href,'sponsored-product') and normalize-space()='Sponsored Products']

${GROUP_BUTTON}  xpath=//div[normalize-space()='Group' and contains(@class,'cursor-pointer')]
${UNGROUP_BUTTON}  xpath=//div[normalize-space()='Ungroup' and contains(@class,'cursor-pointer')]
${MARKETING_SPONSORED_PRODUCT_CAMPAIGN_TABLE}  xpath=//table[.//th[normalize-space()='Campaign Name'] and .//tbody/tr]

${MARKETING_SPONSORED_PRODUCT_AD_GROUP_TAB}  xpath=//span[normalize-space()='Ad Group']

${MARKETING_SPONSORED_PRODUCT_AD_GROUP_NAME_TABLE}  xpath=//table[.//th[normalize-space()='Ad Group Name'] and .//tbody/tr]

${MARKETING_SPONSORED_PRODUCT_AD_PRODUCT_TAB}  xpath=//span[normalize-space()='Ad Product']

${MARKETING_SPONSORED_PRODUCT_AD_PRODUCT_TABLE}  xpath=//table[.//th[normalize-space()='Sku']]

${MARKETING_SPONSORED_PRODUCT_TARGET_TAB}  xpath=//span[normalize-space()='Target']

${MARKETING_SPONSORED_PRODUCT_TARGET_TABLE}  xpath=//table[.//th[normalize-space()='Target'] and .//tbody/tr]

${MARKETING_SPONSORED_PRODUCT_PLACEMENT_TAB}  xpath=//span[normalize-space()='Placement']

${MARKETING_SPONSORED_PRODUCT_PLACEMENT_TABLE}  xpath=//table[.//th[normalize-space()='Campaign Name'] and .//tbody/tr]

${MARKETING_SPONSORED_PRODUCT_SEARCH_TERM_TAB}  xpath=//span[normalize-space()='Search Term']

${MARKETING_SPONSORED_PRODUCT_SEARCH_TERM_TABLE}  xpath=//table[.//th[normalize-space()='Search Term'] and .//tbody/tr]

${MARKETING_SPONSORED_PRODUCT_PURCHASE_TAB}  xpath=//span[normalize-space()='Purchase']

${MARKETING_SPONSORED_PRODUCT_PURCHASE_TERM_TABLE}  xpath=//table[.//th[normalize-space()='Campaign Name'] and .//tbody/tr]



#---Marketing Sponsored Display---
${MARKETING_SPONSORED_DISPLAY_LINK}  xpath=//a[contains(@href,'sponsored-display') and normalize-space()='Sponsored Display']
${MARKETING_SPONSORED_DISPLAY_AD_GROUP_NAME_TABLE}  xpath=//table[.//th[normalize-space()='Campaign Name'] and .//tbody/tr]

${MARKETING_SPONSORED_DISPLAY_AD_PRODUCT_TAB}  xpath=//span[normalize-space()='Ad Product']
${MARKETING_SPONSORED_DISPLAY_AD_GROUP_TABLE}  xpath=//table[.//th[normalize-space()='Campaign Name'] and .//tbody/tr]


#---Session----

${NEW_SESSION_BTN}  xpath=//div[contains(@class,'cursor-pointer') and .//text()='New Session']

#---Fulfillment ---
${FULFILLMENT_LABEL}  xpath=//button[.//span[normalize-space()='Fulfillment']]
${MULTI_CHANNEL_FULFILMENT_LINK}  xpath=//a[@href='/multi-channel-fulfilment' and normalize-space()='Multi Channel Fulfilment']
${FULFILLMENT_CENTER_LINK}  xpath=//a[@href='/fulfillment-center' and normalize-space()='Fulfillment Center']

${CANCELED_CARD}      xpath=//div[contains(@class,'relative') and .//div[text()='CANCELED']]
${CANCELED_CARD_VALUE1}   xpath=


${PENDING_CARD}       xpath=//div[contains(@class,'relative') and .//div[text()='PENDING']]
${PENDING_CARD_VALUE1}   xpath=//div[contains(@class,'relative') and .//div[text()='PENDING']]//div[contains(@class,'text-2xl')]

${SHIPPED_CARD}       xpath=//div[contains(@class,'relative') and .//div[text()='SHIPPED']]
${SHIPPED_CARD_VALUE}   xpath=//div[contains(@class,'relative') and .//div[text()='SHIPPED']]//div[contains(@class,'text-2xl')]



${NEW_ORDERS_TABLE}     xpath=//div[text()='New Orders']/ancestor::div[contains(@class,'chart-bg')]//table
${NEW_ORDERS_TABLE_DATA}     xpath=//div[text()='New Orders']/ancestor::div[contains(@class,'chart-bg')]//table
${NEW_ORDERS_TABLE_EMPTY}     xpath=//div[text()='New Orders']/ancestor::div[contains(@class,'chart-bg')]//div[@class='py-3']//div[text()='No Records Found']
${EMPTY_SEARCH}   xpath=//table[.//thead//th]
${EMPTY_SEARCH_NEW_ORDERS}    xpath=//div[.//div[normalize-space()='New Orders']]//table[.//thead and not(.//tbody//tr)]
${EMPTY_SEARCH_Tracking Details}  xpath=//div[.//div[normalize-space()='Completed Orders']]//div[text()='No Records Found']

${MULTI_CHANNEL_IN_PROCESS_ORDERS_TABLE_CARD}  xpath=//div[contains(@class,'chart-bg')]//div[text()='In Process']/ancestor::div[contains(@class,'chart-bg')]
${MULTI_CHANNEL_IN_PROCESS_ORDERS_TABLE_DATA}  xpath=
${MULTI_CHANNEL_IN_PROCESS_ORDERS_TABLE_EMPTY}  xpath=//div[normalize-space()='In Process']/ancestor::div[contains(@class,'chart-bg')]//div[@class='py-3']//div[text()='No Records Found']

${MULTI_CHANNEL_COMPLETED_ORDERS_TABLE_CARD}  xpath=//div[contains(@class,'chart-bg')]//div[text()='Completed Orders']/ancestor::div[contains(@class,'chart-bg')]
${MULTI_CHANNEL_COMPLETED_ORDERS_TABLE_DATA}  xpath=//div[contains(@class,'overflow-x-scroll')]//table
${MULTI_CHANNEL_COMPLETED_ORDERS_TABLE_EMPTY}  xpath=//div[normalize-space()='Completed Orders']/ancestor::div[contains(@class,'chart-bg')]//div[@class='py-3']//div[text()='No Records Found']
${SEARCH_BOX}    xpath=//input[@placeholder='Search Here...']
${RESULT_TEXT}     xpath=//table/tbody
${NEW_ORDERS_TAB}    xpath=//span[normalize-space()='New Orders']
${IMPORTED_ORDERS_TABLE}  xpath= //div[@class='chart-bg mx-5 mt-5'][.//div[normalize-space()='Imported Orders']]
${IMPORTED_ORDERS_TABLE_DOWNLOAD_BTN}  xpath=//div[@class='chart-bg mx-5 mt-5'][.//div[normalize-space()='Imported Orders']]//button[.//span[normalize-space()='Download Report']]


${IN_PROCESS_TAB}     xpath=//span[normalize-space()='In Process']
${IN_PROCESS_ORDERS_TABLE_CARD}  xpath=//div[@class='chart-bg'][.//div[normalize-space()='In Process Orders']]
${IN_PROCESS_ORDERS_DROPDOWN}   xpath=(//span[normalize-space()='Hold'])[1]

${TRACKING_TAB}       xpath=//span[normalize-space()='Tracking Details']
${TRACKING_DETAILS_TABLE_CARD}  xpath=//div[@class='chart-bg mx-5 mt-5'][.//div[normalize-space()='Tracking Details']]
${TRACKING_DETAILS_DROPDOWN}  xpath=//span[contains(@class,'font-medium') and text()='Complete']


#${SEARCH_BOX}         xpath=//input[@placeholder='Search Here...']
${ORDER_TABLE}        xpath=//table


#---Fulfillment ---
#---multichannel fulfillment---
*** Variables ***

${MERCHANT_FULFILLMENT_ORDER_ID}      xpath=//input[@placeholder='Enter Merchant Fulfillment OrderID']

${DISPLAYABLE_ORDER_DATE}             xpath=//input[@name='displayorderdate']
${MERCHANT_SKU_DROPDOWN}              xpath=//select[@name='merchantsku']
${QUANTITY_INPUT}                     xpath=//input[@placeholder='Enter Quantity']

${GIFT_MESSAGE}                       xpath=//input[@placeholder='Enter Gift Message']
${PER_UNIT_DECLARED_VALUE}    xpath=//input[@name='valuePerUnit']
${DELIVERY_SLA_DROPDOWN}    xpath=//select[@name='deliverysla']

${ADDRESS_FIELD_ONE}    xpath=//input[@name='addressfield1']
${ADDRESS_FIELD_THREE}    xpath=//input[@name='addFieldThree']
${STATE_CODE_INPUT}    xpath=//input[@name='addressstate']
${POSTAL_CODE_INPUT}    xpath=//input[@name='addresspostcode']
${NOTIFICATION_EMAIL_INPUT}    xpath=//input[@name='notificationEmail']
${CARRIER_PREFERENCES_DROPDOWN}    xpath=//select[@name='carrierPreferences']
${DISPLAYABLE_ORDER_ID}               xpath=//input[@placeholder='Enter Displayable OrderID']
${FULFILLMENT_MERCHANT_SKU_DROPDOWN}    xpath=//select[@name='merchantsku']
${MERCHANT_FULFILLMENT_ITEM_ID}    xpath=//input[@name='merchantfulfillitemid']

${DISPLAYABLE_COMMENT}                xpath=//input[@placeholder='Enter Displayable Comment']
${DISPLAYABLE_ORDER_COMMENT}    xpath=//input[@name='displayordercomment']
${RECIPIENT_NAME_INPUT}    xpath=//input[@name='addressname']
${ADDRESS_FIELD_TWO}    xpath=//input[@name='addFieldTwo']
${COUNTRY_CODE_INPUT}    xpath=//input[@name='addresscountrycode']
${CITY_INPUT}    xpath=//input[@name='addresscity']
${PHONE_NUMBER_INPUT}    xpath=//input[@name='addressPhoneNumber']
${FULFILLMENT_ACTION_DROPDOWN}    xpath=//select[@name='fulfillmentAction']

${MERCHANT_FULFILLMENT_ORDER_ITEM_ID}  xpath=//input[@placeholder='Enter Merchant Fulfillment Order ItemID']
${UPLOAD_BUTTON}   xpath=//button[.//span[normalize-space()='Upload']]






