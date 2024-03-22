*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn
# Suite Teardown             Close Browser    
#Library                     FakerLibrary
Library                     String


*** Variables ***
${URL}                       https://www.webtoons.com/th/
${locator_login}             id=btnLogin
${locator_sign_up}           id=btnSignUp
${email}                     id=email
${password}                  id=pw
${confirm_password}          id=retype_pw
${nickname}                  id=nickname
${register_now_button}       css=#content > div > div.inner_wrap > div > a
${delay}                     0.5s
${popup_msg_expected}        xpath=//div[@class='ly_sign_up']/h2[text()='ส่งอีเมลยืนยัน']
${confirm_button}            xpath=//*[@id="wrap"]/div[5]/div[2]/div/div/a

          
    
*** Keywords ***
Open Webtoon Website
    Open Browser         ${URL}        chrome       #options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    #Set Selenium Speed        0.5s    #delay all case
    Maximize Browser Window


Input Keyword
    Wait Until Element Is Visible    ${email}    ${delay}       #ใช้ wait untill ทุกครั้งที่เปลี่ยนหน้า
    Wait Until Page Contains   สมัครสมาชิก    ${delay} 

    ${random_string_email}            Generate Random String    5    [LOWER]
    Input Text    ${email}            test${random_string_email}@gmail.com

    ${random_string_password}         Generate Random String    5    [NUMBERS]abpx
    Input Text    ${password}         Wachira${random_string_password}

    Input Text    ${confirm_password}        Wachira${random_string_password}
    Input Text    ${nickname}                Nanniiiiii${random_string_password}
    Capture Page Screenshot

Click Login Button
    Click Element    ${locator_login} 

Click Register Button On Form 
    Wait Until Element Is Visible    ${locator_sign_up}    ${delay} 
    Click Element    ${locator_sign_up}

Click Register
    Click Element    ${register_now_button}  

Verify Response Popup Message
    Wait Until Element Is Visible    ${response_message}     5s
    ${txt}=    Get Text    ${response_message}    #ประกาศตัวแปรมารับค่าที่ได้ ${txt}
    Should Be Equal   ${txt}    ${popup_msg_expected}

Click Confirm Button
    Wait Until Element Is Visible      ${popup_msg_expected}     5s
    Click Element    ${confirm_button}  

*** Test Cases ***
TC-01 Verify Register Webtoon Success
    [Documentation]    TestWebToon
    [Tags]    SmokeTest    high
    Open Webtoon Website
    Click Login Button
    Click Register Button On Form 
    Input Keyword
    Click Register
    Click Confirm Button
    Close Browser


