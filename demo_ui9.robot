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

          
    
*** Keywords ***
Open Webtoon Website and Validate
    Set Selenium Speed        0.5s    #delay all case
    Open Browser              https://www.webtoons.com/member/join?loginType=EMAIL    chrome
    Maximize Browser Window
   FOR  ${index}    IN RANGE    0    5
        Wait Until Element Is Visible            ${locator_email}    ${delay}       #ใช้ wait untill ทุกครั้งที่เปลี่ยนหน้า
        ${random_number}    Generate Random String    4    0123456789
        Input Text                       ${locator_email}                            Nan${index}@gmail.com   
        Input Text                       ${locator_password}                         Ab9584001    
        Input Text                       ${locator_confirm_password}                 Ab9584001     
        Input Text                       ${locator_nickname}                         robot${random_number}
   END



*** Test Cases ***
TC-01 Verify Register Webtoon Success
    Open Webtoon Website and Validate

