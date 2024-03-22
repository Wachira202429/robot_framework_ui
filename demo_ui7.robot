*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn
Library                     String


*** Variables ***
${locator_profile}             id=login-title
#${locator_menu_list}          id=login-menu-list
${locator_menu_list}           css=#login-menu-list > div:nth-child(2)
${locator_email}               id=email4
${locator_password}                    id=password
${locator_confirm_password}            id=repassword
${web_name}                    id=nickname3
${register_button}             name=register
${delay}                       5s
${response_message}            id=response
${result_expected}             รหัสไม่ตรงกัน             

    
*** Keywords ***
Open Website and Input Data
    [Arguments]    ${EMAIL}   ${PASSWORD}     ${REPASS}     ${NICK}
    Open Browser         https://www.gconhub.com/        chrome        options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    Set Selenium Speed        0.5s    #delay all case
    Maximize Browser Window
    Click Element                               ${locator_profile} 
    Wait Until Element Is Visible               ${locator_menu_list}                ${delay} 
    Click Element                               ${locator_menu_list}
    #Sleep                                        10s
    Wait Until Element Is Visible               ${locator_email}                    ${delay}       #ใช้ wait untill ทุกครั้งที่เปลี่ยนหน้า
    Wait Until Page Contains   สมัครสมาชิก        ${delay} 
    Input Text                                  ${locator_email}                    ${EMAIL}    
    Input Text                                  ${locator_password}                 ${PASSWORD}    
    Input Text                                  ${locator_confirm_password}         ${REPASS}    
    Input Text                                  ${web_name}                         ${NICK}
    Click Element                               ${register_button}  

# Verify Response Error Message
#     Wait Until Element Is Visible    ${response_message} 
#     ${txt}=    Get Text    ${response_message}    #ประกาศตัวแปรมารับค่าที่ได้ ${txt}
#     Should Be Equal   ${txt}    ${result_expected}

 #คำสั่งrun terminal เช็ค log ลึกๆ robot -L TRACE  demo_ui2.robot    
*** Test Cases ***
TC-01 Verify Register success
    [Template]    Open Website and Input Data
    Nantest@gmail.com        pass001    pass001    nickname01
    ไทย@gmail.com            ไทย        ไทย        วชิรา
    123@gmail.com            123        123        55555



