*** Settings ***
Library     BuiltIn
Library     Collections
Library     Browser

Resource    ${CURDIR}/../Repositories/assignment.resource
Resource    ${CURDIR}/../Variables/assignment.resource

*** Keywords ***
Open Web Browser
    [Arguments]    ${page_url}
    New Browser     chromium    headless=False
    New Context     viewport={"width": ${testsite_width} , "height": ${testsite_height}}    ignoreHTTPSErrors=True
    New Page        ${page_url} 

Input Text
    [Arguments]    ${xpath}    ${text}
    Fill Text    ${xpath}    ${text}

Recheck Elements
    Wait For Elements State   ${username_path}     visible    10s
    Wait For Elements State   ${surname_path}      visible    10s
    Wait For Elements State   ${submit_btn_path}   visible    10s
    Log    Found all element    console=yes

Checkbox by name
    [Arguments]    ${textname}
    Click    //span[contains(text(),'${textname}')]