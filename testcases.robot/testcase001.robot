*** Settings ***
Library                     SeleniumLibrary
Library                     BuiltIn
Library                     String
Resource                    ${CURDIR}/../variables.robot/variables.robot
Resource                    ${CURDIR}/../keywords/keywords.robot


*** Test Cases ***
TC-01 Verify Register success
    Open website
