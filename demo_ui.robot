*** Setting ***
Library     SeleniumLibrary

*** Variable ***
${locator_search_box}        id=APjFqb
${locator_search_button}       name=btnK
# ${locator_search_box}        id=input
# ${locator_search_box}        name=q
# ${locator_search_box}        css=#input
# ${locator_search_box}        xpath=//*[@id="input"]

*** Keyword ***
Open google website
    Open Browser         http://www.google.co.th         chrome        options=add_experimental_option("detach", True)   #optionนี้เพื่อไม่ให้ปิดเว็บกลังจาก runจบ
    #Set Selenium Speed        0.5s    #delay all case
    Maximize Browser Window
    
Input Keyword
    Input Text    ${locator_search_box}     art toy
    Capture Page Screenshot

Click Search Button
    Click Element    ${locator_search_button} 


*** Test Cases ***
TC-01 Verify search data on google success
    Open google website
    Input Keyword
    Click Search Button
    