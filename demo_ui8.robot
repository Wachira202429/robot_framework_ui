*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn
Library                     String


*** Variables ***
${URL}                               https://www.webtoons.com/th/
${locator_login}                     id=btnLogin
${locator_sign_up}                   id=btnSignUp
${locator_email}                     id=email
${locator_password}                  id=pw
${locator_confirm_password}          id=retype_pw
${locator_nickname}                  id=nickname
${register_now_button}               css=#content > div > div.inner_wrap > div > a
${delay}                             0.5s
${locator_popup_msg_expected}        xpath=//div[@class='ly_sign_up']/h2[text()='ส่งอีเมลยืนยัน']
${confirm_button}                    xpath=//*[@id="wrap"]/div[5]/div[2]/div/div/a
${locator_err_msg_email}             xpath=//*[@id="emailArea"]/p
${locator_err_msg_nickname}          xpath=//*[@id="content"]/div/div[1]/div/div[4]/p

          
    
*** Keywords ***
Open Webtoon Website and Validate
    [Arguments]    ${EMAIL}   ${PASSWORD}     ${REPASS}     ${NICK}
    Open Browser         ${URL}        chrome       options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    Set Selenium Speed        0.5s    #delay all case
    Maximize Browser Window
    Click Element                    ${locator_login}

    # Wait Until Element Is Visible    ${locator_sign_up}                          ${delay} 
    Click Element                    ${locator_sign_up}

    Wait Until Element Is Visible    ${locator_email}                            ${delay}       #ใช้ wait untill ทุกครั้งที่เปลี่ยนหน้า
    Wait Until Page Contains   สมัครสมาชิก    ${delay} 
    Input Text                       ${locator_email}                            ${EMAIL}   
    Input Text                       ${locator_password}                         ${PASSWORD}     
    Input Text                       ${locator_confirm_password}                 ${REPASS}     
    Input Text                       ${locator_nickname}                         ${NICK}
    Click Element                    ${register_now_button}  

    # Wait Until Element Is Visible    ${response_message}                         ${delay} 
    # ${txt}=    Get Text              ${response_message}    #ประกาศตัวแปรมารับค่าที่ได้ ${txt}
    # Should Be Equal   ${txt}         ${locator_popup_msg_expected}

    Wait Until Element Is Visible         ${register_now_button}         ${delay} 
    ${txt_msg}=    Get Text               ${locator_err_msg_email}      
    RUN KEYWORD IF    '${txt}'    == 'อีเมลนี้ถูกใช้ลงทะเบียนแล้ว กรุณาใช้อีเมลอื่น'
    ...    Should Be    Equal As Strings    ${txt_msg}    อีเมลนี้ถูกใช้ลงทะเบียนแล้ว กรุณาใช้อีเมลอื่น
    ...    ELSE IF    '${txt}'    == 'มีผู้ใช้ชื่อเล่นนี้แล้ว'
    ...    Should Be    Equal As Strings    ${txt_msg}    มีผู้ใช้ชื่อเล่นนี้แล้ว
    ...    ELSE  log     PASSED

    Wait Until Element Is Visible          ${locator_popup_msg_expected}     ${delay} 
    Click Element    ${confirm_button}  


*** Test Cases ***
TC-01 Verify Register Webtoon Success
    [Template]    Open Webtoon Website and Validate
    Test001@gmail.com        Wachira90001    Wachira90001    Nickname01
   # Test002@gmail.com        Wachira90002    Wachira90002    Nickname02


