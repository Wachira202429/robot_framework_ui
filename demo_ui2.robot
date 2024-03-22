*** Settings ***
Library     SeleniumLibrary
# Library     Builtin


*** Variables ***
${locator_profile}             id=login-title
#${locator_menu_list}          id=login-menu-list
${locator_menu_list}           css=#login-menu-list > div:nth-child(2)
${email}                       id=email4
${password}                    id=password
${confirm_password}            id=repassword
${web_name}                    id=nickname3
${register_button}             name=register
${delay}                       5s
${response_message}            id=response
${result_expected}             รหัสไม่ตรงกัน             

    
*** Keywords ***
Open website
    Open Browser         https://www.gconhub.com/        chrome        options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    #Set Selenium Speed        0.5s    #delay all case
    Maximize Browser Window

Click Profile Button
    Click Element    ${locator_profile} 

Click Register Form Button
    Wait Until Element Is Visible    ${locator_menu_list}    ${delay} 
    Click Element    ${locator_menu_list}

Input Keyword
    Wait Until Element Is Visible    ${email}    ${delay}       #ใช้ wait untill ทุกครั้งที่เปลี่ยนหน้า
    Wait Until Page Contains   สมัครสมาชิก    ${delay} 
    Input Text    ${email}        test@gmail.com
    Input Text    ${password}        12345
    Input Text    ${confirm_password}        123457
    Input Text    ${web_name}      Test By Nan
    Capture Page Screenshot

Click Register
    Click Element    ${register_button}  

Verify Response Error Message
    Wait Until Element Is Visible    ${response_message} 
    ${txt}=    Get Text    ${response_message}    #ประกาศตัวแปรมารับค่าที่ได้ ${txt}
    Should Be Equal   ${txt}    ${result_expected}

 #คำสั่งrun terminal เช็ค log ลึกๆ robot -L TRACE  demo_ui2.robot    
*** Test Cases ***
TC-01 Verify Register success
    [Documentation]    As condition
    ...    -logic    1+1
    ...    -logic    2+2
    [Tags]    Regression    high
    Open website
    Click Profile Button
    Click Register Form Button
    Input Keyword
    Click Register
    Verify Response Error Message

#run terminal by tag [robot -i Medium demo_ui2.robot] เอาแค่tag ชื่อนี้
#run terminal by tag [robot -e high  demo_ui2.robot] ไม่เอาtag ชื่อนี้
#robot -t TC-01* demo_ui2.robot


TC-02 test success
    [Documentation]    Tester
    [Tags]    Smoke    Medium
    Open website