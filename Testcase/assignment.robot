*** Settings ***
Library     BuiltIn
Library     Collections
Library     Browser

Resource    ${CURDIR}/../Repositories/assignment.resource
Resource    ${CURDIR}/../Variables/assignment.resource
Resource    ${CURDIR}/../Keywords/assignment.resource

*** Test Cases ***
Testing Assignment
    [Tags]    TestCase1
    # 1. เปิดเว็บ https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
    Open Web Browser    ${testsite_url}

   # 2. ตรวจสอบหน้า Login (Elements ต่างๆที่อยู่ในหน้าจอ)
    Recheck Elements
   
    # 3. Login ด้วย Username = Admin และ Password = admin123
    Input Text    ${username_path}    ${username}
    Input Text    ${surname_path}     ${password}
    Take Screenshot
    Click    ${submit_btn_path}
    Take Screenshot

    # 4. ไปที่เมนู PIM → Add Employee
    Wait For Elements State    ${PIM_path}            visible
    Click    ${PIM_path}
    Wait For Elements State    ${PIM_add_btn_path}    visible
    Click    ${PIM_add_btn_path}

    # 5. ใส่ First Name = Robot, Last Name = Framework
    Input Text    ${PIM_input_name_path}       ${name}
    Input Text    ${PIM_input_surname_path}    ${surname}
    # 6. Save แล้วตรวจสอบว่ามี Employee ID ถูกสร้าง และเก็บค่า Employee ID ไว้
    ${employee_id}=    Get Property    ${PIM_input_employee_id_path}    value
    Input Text    ${PIM_input_employee_id_path}    ${employee_id}
    Take Screenshot
    Log    ${employee_id}    console=yes
    Click    ${submit_btn_path}
    Sleep  3s
    Wait For Elements State    ${PIM_employee_img_path}   visible
    Take Screenshot

    # 7. กลับไปที่ Employee List
    Click    ${employee_list_path}
    Wait For Elements State    ${PIM_input_employee_id_path}   visible
    Take Screenshot

    # 8. ค้นหา Employee ID จากที่เก็บมาในสเตป 6
    Input Text    ${PIM_input_employee_id_path}    ${employee_id}
    Click    ${employee_search_path}
    
    # 9. ตรวจสอบว่ามีพนักงานคนนี้อยู่จริง (id , First Name , Last Name)
    Wait For Elements State    //div[contains(text(),"${employee_id}")]    visible    10s
    Log    found ID    console=yes
    Wait For Elements State    //div[contains(text(),"${name}")]    visible    10s
    Log    name    console=yes
    Wait For Elements State    //div[contains(text(),"${surname}")]    visible    10s
    Log    found ID    console=yes
    Take Screenshot

    # 10. Logout
    Click     ${profile_img_path} 
    Click     ${logout_path} 
    Take Screenshot
    
    # 11. ตรวจสอบหน้า Login (Elements ต่างๆที่อยู่ในหน้าจอ)
    Recheck Elements
    Take Screenshot

Toggle Checkbox
    [Tags]    TestCase2
    Open Web Browser    ${testcheckbox_url}
    # เปิดปุ่ม expand ทั้งหมด ดูว่ากดผ่านชื่อได้จริงหรือเปล่า
    Click               //button[@class="rct-option rct-option-expand-all"]

    # ลองใส่ชื่อผ่าน Keyword 
    Checkbox by name    Home 
    Take Screenshot
    Checkbox by name    Documents
    Take Screenshot
    Checkbox by name    Commands
    Take Screenshot
    