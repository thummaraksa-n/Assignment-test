*** Settings ***
Library     BuiltIn
Library     Collections
Library     Browser

Resource    ${CURDIR}/../Repositories/assignment2.resource
Resource    ${CURDIR}/../Variables/assignment2.resource

*** Keywords ***
Open Web Browser
    [Arguments]    ${page_url}
    New Browser     chromium    headless=False
    New Context     viewport={"width": ${testsite_width} , "height": ${testsite_height}}    ignoreHTTPSErrors=True
    New Page        ${page_url}  

Recheck Elements by path
    [Arguments]    @{multi_paths}
    FOR    ${path}    IN    @{multi_paths}
        Wait For Elements State   ${path}     visible    10s
        Log    ✅Found ${path} element    console=yes     
    END