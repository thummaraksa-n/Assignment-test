*** Settings ***
Library     BuiltIn
Library     Collections
Library     Browser

Resource    ${CURDIR}/../Repositories/assignment.resource
Resource    ${CURDIR}/../Variables/assignment2.resource
Resource    ${CURDIR}/../Keywords/assignment2.resource


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
    @{all_paths}    Create List    ${username_path}    ${password_path}    ${submit_btn_path}
    Recheck Elements by path    @{all_paths}
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
    @{all_paths}    Create List    ${username_path}    ${password_path}    ${submit_btn_path}
    Recheck Elements by path    @{all_paths}
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
    @{all_paths}    Create List    ${username_path}    ${password_path}    ${submit_btn_path}
    Recheck Elements by path    @{all_paths}
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
