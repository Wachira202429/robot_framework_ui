*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn
Library                     String

*** Variables ***
${locator_profile}             id=login-title
#${locator_menu_list}          id=login-menu-list
${locator_menu_list}           css=#login-menu-list > div:nth-child(2)
${locator_email}               id=email4
${locator_password}            id=password
${confirm_password}            id=repassword
${locator_web_name}            id=nickname3
${register_button}             name=register
${delay}                       5s
${response_message}            id=response
${result_expected}             รหัสไม่ตรงกัน       
${URL}                         https://www.gconhub.com/
${Browser}                     chrome

    
*** Keywords ***
Open website by default
    [Arguments]    ${timeout}    ${URL_Arg}=https://www.gconhub.com/    ${Browser_Arg}=chrome      #ประกาศargument
    Open Browser         ${URL}    ${Browser}            options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    Set Selenium Speed        ${delay}    #delay all case
    Maximize Browser Window
Open website
    [Arguments]    ${delay}    ${URL}    ${Browser}      #ประกาศargument
    Open Browser         ${URL}    ${Browser}            options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    Set Selenium Speed        ${delay}    #delay all case
    Maximize Browser Window
    
Input Keyword
    [Arguments]    ${timeout}     ${pass_arg}    ${pass_confirm_arg}    ${web_name_arg}    ${email_arg}=nan001@gmail.com
    Wait Until Element Is Visible    ${locator_email}    ${delay}       #ใช้ wait untill ทุกครั้งที่เปลี่ยนหน้า
    Wait Until Page Contains   สมัครสมาชิก    ${delay} 

    #${random_string_email}                    Generate Random String    5    [LOWER]
    Input Text    ${locator_email}                    ${pass_arg}

    ${random_string_password}                 Generate Random String    5    [NUMBERS]abpx
    Input Text    ${locator_password}                 ${pass_arg}

    Input Text    ${confirm_password}         ${pass_confirm_arg}
    Input Text    ${web_name}                 Test By Nan${random_string_password}
    Capture Page Screenshot

Click Profile Button
    Click Element    ${locator_profile} 

Click Register Form Button
    Wait Until Element Is Visible    ${locator_menu_list}    ${delay} 
    Click Element    ${locator_menu_list}

Click Register
    Click Element    ${register_button}  

Verify Response Error Message
    Wait Until Element Is Visible    ${response_message} 
    ${txt}=    Get Text    ${response_message}    #ประกาศตัวแปรมารับค่าที่ได้ ${txt}
    Should Be Equal   ${txt}    ${result_expected}


 #คำสั่งrun terminal เช็ค log ลึกๆ robot -L TRACE  demo_ui2.robot    
*** Test Cases ***
TC-01 Verify  value to open website success
    Open website                        0.2s            https://www.gconhub.com/        gc
    Click Profile Button
    Click Register Form Button
    Input Keyword                       ${email}    ${password}    ${confirm_password}    ${web_name}
    Click Register


TC-02 Verify default value to open website success
    Open website by default              0.2s
    Click Profile Button
    Click Register Form Button
    Input Keyword                        10s        1234       1234      Nanatest       
    Click Register



