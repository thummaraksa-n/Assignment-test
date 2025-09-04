*** Settings ***
Library     BuiltIn
Library     Collections
Library     Browser

Resource    ${CURDIR}/../Repositories/assignment.resource
Resource    ${CURDIR}/../Variables/assignment.resource
Resource    ${CURDIR}/../Keywords/assignment.resource

*** Variables ***
${Web_Testing_Url}    https://the-internet.herokuapp.com/login
${secure_page}        https://the-internet.herokuapp.com/secure

${username_alert}     Your username is invalid!
${password_alert}     Your password is invalid!

${username}           tomsmith
${password}           SuperSecretPassword!
${username_wrong}     abc
${password_wrong}     123456

${username_path}      //input[@id='username']
${password_path}      //input[@id='password']
${submit_btn_path}    //button[@type='submit']
${flash_error}        //div[@class='flash error']

*** Keywords ***
Open Web Browser
    [Arguments]    ${page_url}
    New Browser     chromium    headless=False
    New Context     viewport={"width": ${testsite_width} , "height": ${testsite_height}}    ignoreHTTPSErrors=True
    New Page        ${page_url}  

Recheck Elements by path
    [Arguments]    ${path}
    Wait For Elements State   ${path}     visible    10s
    Log    ✅Found ${path} element    console=yes

*** Test Cases ***
# TC1 Login is valid
    # [Documentation]    ***Owner : Kachain. ***
    # ...    ${\n}
    # ...    ***Test Step Description*** ${\n}
    # ...    1. Open Website: https://the-internet.herokuapp.com/login ${\n}
    # ...    2. Verify Login Page${\n}
    # ...    - Label: Login Page${\n}
    # ...    - Message: This is where you can log into the secure area...${\n}
    # ...    - Textbox: Username${\n}
    # ...    - Textbox: Password${\n}
    # ...    - Button: Login${\n}
    # ...    3. Input Username: tomsmith ${\n}
    # ...    4. Input Password: SuperSecretPassword! ${\n}
    # ...    5. Click Login Button${\n}
    # ...    ${\n}
    # ...    ***Expected Result***
    # ...    1. Login is correct
    # ...    2. The website navigates to the Secure Area page
    # ...    ${\n}
Login is valid
    [Tags]    TestCase1
    Open Web Browser            ${Web_Testing_Url}
    Recheck Elements by path    ${username_path}
    Recheck Elements by path    ${password_path}
    Recheck Elements by path    ${submit_btn_path}
    Log   found all login elements    console=yes
    Type Text    ${username_path}    ${username}
    Type Text    ${password_path}    ${password}
    Click        ${submit_btn_path}
    ${current_url}  Get Url
    IF    '${current_url}' == '${secure_page}'
        Log    Login is correct and navigate to Secure Area    console=yes
    ELSE
        Fail
    END

# TC2 Login Fails With Invalid Username
Login Fails with Invalid Username
    [Tags]   TestCase2
    Open Web Browser            ${Web_Testing_Url}
    Recheck Elements by path    ${username_path}
    Recheck Elements by path    ${password_path}
    Recheck Elements by path    ${submit_btn_path}
    Log   found all login elements    console=yes
    Type Text    ${username_path}    ${username_wrong}
    Type Text    ${password_path}    ${password}
    Click        ${submit_btn_path}
    Recheck Elements by path    ${flash_error}
    ${msg}  Get Text  ${flash_error}
    Should Contain    ${msg}    ${username_alert}    msg="Not Match"
    
    # [Documentation]    ***Owner : Kachain. ***
    # ...    ${\n}
    # ...    ***Test Step Description*** ${\n}
    # ...    1. Open Website: https://the-internet.herokuapp.com/login ${\n}
    # ...    2. Verify Login Page${\n}
    # ...    - Label: Login Page${\n}
    # ...    - Message: This is where you can log into the secure area...${\n}
    # ...    - Textbox: Username${\n}
    # ...    - Textbox: Password${\n}
    # ...    - Button: Login${\n}
    # ...    3. Input Username: abc ${\n}
    # ...    4. Input Password: SuperSecretPassword! ${\n}
    # ...    5. Click Login Button${\n}
    # ...    ${\n}
    # ...    ***Expected Result***
    # ...    1. Login is incorrect
    # ...    2. The website show message "Your username is invalid!"
    # ...    ${\n}

# TC3 Login Fails With Invalid Password
Login Fails with Invalid Password
    [Tags]   TestCase3
    Open Web Browser            ${Web_Testing_Url}
    Recheck Elements by path    ${username_path}
    Recheck Elements by path    ${password_path}
    Recheck Elements by path    ${submit_btn_path}
    Log   found all login elements    console=yes
    Type Text    ${username_path}    ${username}
    Type Text    ${password_path}    ${password_wrong}
    Click        ${submit_btn_path}
    Recheck Elements by path    ${flash_error}
    ${msg}  Get Text  ${flash_error}
    Should Contain    ${msg}    ${password_alert}    msg="Not Match"
    
    # [Documentation]    ***Owner : Kachain. ***
    # ...    ${\n}
    # ...    ***Test Step Description*** ${\n}
    # ...    1. Open Website: https://the-internet.herokuapp.com/login ${\n}
    # ...    2. Verify Login Page${\n}
    # ...    - Label: Login Page${\n}
    # ...    - Message: This is where you can log into the secure area...${\n}
    # ...    - Textbox: Username${\n}
    # ...    - Textbox: Password${\n}
    # ...    - Button: Login${\n}
    # ...    3. Input Username: tomsmith ${\n}
    # ...    4. Input Password: 123456 ${\n}
    # ...    5. Click Login Button${\n}
    # ...    ${\n}
    # ...    ***Expected Result***
    # ...    1. Login is incorrect
    # ...    2. The website show message "Your password is invalid!"
    # ...    ${\n}