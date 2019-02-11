*** Settings ***


*** Variables ***
${notice message}					//*[@id="instant-messages-container"]


*** Keywords ***
Дочекатися відображення елемента на сторінці
	[Documentation]  timeout=...s/...m
	[Arguments]  ${locator}  ${timeout}=10s
	Wait Until Keyword Succeeds  ${timeout}  .5  Element Should Be Visible  ${locator}


Натиснути в валідаційному вікні
	[Arguments]  ${window_name}  ${text}
	${locator}  Set Variable  //*[@class="dhxwin_active menuget"]
	Wait Until Keyword Succeeds  5s  1s  Element Should Be Visible  ${locator}
	Page Should Contain Element  ${locator}//*[contains(@class,'header-text') and text()='${window_name}']
	Click Element  ${locator}//*[contains(text(),'${text}')]
	Дочекатись закінчення загрузки сторінки RMD


Натиснути в повідомленні
	[Arguments]  ${message_name}  ${text}
	${locator}  Set Variable  //*[@class='message-box']
	Wait Until Keyword Succeeds  5s  1s  Element Should Be Visible  ${locator}//*[contains(text(),"${message_name}")]
	Click Element  ${locator}//*[text()='Так']
	Дочекатись закінчення загрузки сторінки


Закрити всі сповіщення (за необхідністю)
	Execute Javascript  var messages = document.getElementById('instant-messages-container'); messages.parentNode.removeChild(messages);


Натиснути кнопку у вікні
    [Arguments]  ${title}  ${key}
    ${btn}  Set Variable
    ...  //*[contains(@id,"ModalMode")][contains(text(),"${title}")]/ancestor::div[contains(@class,"mainDiv")]//a[@title="${key}"]
    Click Element  ${btn}
    Дочекатись закінчення загрузки сторінки
    Element Should Not Be Visible  ${btn}


Операція над чекбоксом
    [Arguments]  ${name}  ${action}=Select
    ${check box}  Set Variable  //label[contains(text(),"${name}")]/preceding-sibling::input[@type="checkbox"]
    Element Should Be Visible  ${check box}
    Run Keyword  ${action} Checkbox  ${check box}
    # Видимо графическая часть отстает от уи, добавил сон что бы не городить сложную логику
    Sleep  3
    #######################################################################################
    Run Keyword If
    ...  "${action}" == "Select"  	Wait Until Keyword Succeeds  10  .5  Checkbox Should Be Selected  		${check box}  ELSE IF
    ...  "${action}" == "Unselect"  Wait Until Keyword Succeeds  10  .5  Checkbox Should Not Be Selected  	${check box}