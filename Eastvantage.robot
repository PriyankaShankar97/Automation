*** Settings ***
Documentation       QA Application Assignment for Eastvantage
Library             SeleniumLibrary
Library             XML

Test Setup          Open
Test Teardown       Close

*** Variables ***
${Url}              https://automationinterface1.front.staging.optimy.net/en/
${Browser}          Firefox
${firstname}        Preetham
${lastname}         chandru
${address}          goa
${pin}              1000
${country}          India

*** Test Cases ***
Assignment
    NewApplication
    Form
    Validate

*** Keywords ***
Open
    Open Browser       ${Url}       ${Browser}
Close
    Close Browser

NewApplication
    Maximize Browser Window
    ${val}=    Run Keyword And Return Status    Get Element       .btn.btn-primary.btn-lg.col-md-auto
    IF    ${val} == False
        Click Element           css=#cookie-allow-necessary-button
    ELSE
        Log    "Cookies not provided"
    END
    Set Selenium Speed       2
    Click Element         css=.ml-auto.btn.btn-outline-primary
Form
    Input Text    css=#login-email    optimyautomationtester@gmail.com
    Input Text    css=#login-password    yRMhojb7
    Click Element    css=.btn.btn-lg.btn-primary.col-12.mt-1.mt-md-2
    Click Element    css=.btn.btn-primary.btn-lg.col-md-auto
    ${val}=    Run Keyword And Return Status    Page Should Contain    Continue with the submission of an application?
    IF    ${val} == True
        Click Element    css=a.btn.btn-outline-primary
        Input Text    css=body > div:nth-child(1) > main:nth-child(6) > div:nth-child(1) > div:nth-child(1) > div:nth-child(31) > div:nth-child(1) > form:nth-child(1) > div:nth-child(4) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > fieldset:nth-child(1) > div:nth-child(2) > div:nth-child(1) > fieldset:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)    ${firstname}
        Input Text    css=body > div:nth-child(1) > main:nth-child(6) > div:nth-child(1) > div:nth-child(1) > div:nth-child(31) > div:nth-child(1) > form:nth-child(1) > div:nth-child(4) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > fieldset:nth-child(1) > div:nth-child(2) > div:nth-child(1) > fieldset:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > input:nth-child(1)    ${lastname}
        Input Text    css=.form-control.d-block          ${address}
        Input Text    css=.form-control.ui-autocomplete-input          ${pin}
        Mouse Over    css=.ui-autocomplete.ui-menu.ui-widget.ui-widget-content.ui-corner-all
        Press Keys   css=.ui-autocomplete.ui-menu.ui-widget.ui-widget-content.ui-corner-all    ENTER
        Select From List By Label      a4486775-94c7-5a9e-9f67-24c21c95f025::7e595970-fc12-558c-9eaf-385735fcae6b       ${country}
        Wait Until Page Contains Element    css=input[type='file']        60s
        Choose File      css=input[type='file']    ${CURDIR}\\sample.png
        Click Element    css=label[aria-label='Prefer not to answer']
        Select From List By Index      f801d7d8-0762-5407-95f9-b8c3a793157c        3
        Click Element    css=#container_3fe36edc-80b0-5574-b7ad-7cfe074acfc1
        Click Element    css=#container_92dcaa01-633c-5db1-ac87-e003906567ea
        Click Element    css=#container_773e5289-f4b3-5d6d-ac81-5c99e2b39acd
        Select Frame    css=.cke_wysiwyg_frame.cke_reset
        Execute JavaScript    document.body.innerHTML = 'Want to be Automation tester'
        ${text}=     Get Text    css=body.cke_editable.cke_editable_themed.cke_contents_ltr.cke_show_borders
        Log    ${text}
        Unselect Frame
        Click Element    css=.btn.btn-primary.ml-auto
    END
Validate
    Run Keyword And Return Status    Page Should Not Contain Element    css=.alert.alert-danger.alert-dismissible.fade.show
    Wait Until Page Contains Element    css=body > div:nth-child(1) > main:nth-child(6) > div:nth-child(1) > div:nth-child(1) > div:nth-child(32) > div:nth-child(1) > form:nth-child(1) > div:nth-child(4) > div:nth-child(2) > div:nth-child(4) > div:nth-child(2) > button:nth-child(1)
    Click Element    css=body > div:nth-child(1) > main:nth-child(6) > div:nth-child(1) > div:nth-child(1) > div:nth-child(32) > div:nth-child(1) > form:nth-child(1) > div:nth-child(4) > div:nth-child(2) > div:nth-child(4) > div:nth-child(2) > button:nth-child(1)
    Sleep    5
    #Page Should Contain    Thank you for submitting your project
    ${success}=    Get Text    css=h1[class='h1 text-center']
    IF    '${success}'=='Thank you for submitting your project'
        Log    Application submitted successfully
    ELSE
        Log    Application Error
    END