*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn
Library                     String

*** Keywords ***
Open website
    Open Browser         https://www.gconhub.com/        chrome        options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    Set Selenium Speed        0.5s    #delay all case
    Maximize Browser Window