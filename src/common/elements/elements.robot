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
	${notice close btn}  Set Variable  ${notice message}//i[contains(@class,'imcls') and not(@id)]
	Wait Until Element Is Visible  ${notice message}
	Click Element  ${notice message}
	Wait Until Element Is Visible  ${notice close btn}  2
	Click Element  ${notice close btn}
	${page does not contains notice}  Run Keyword And Return Status
	...  Run Keyword And Expect Error  *is not clickable*
	...  Click Element  ${notice message}
	Run Keyword If  ${page does not contains notice} == ${False}
	...  elements.Закрити всі сповіщення (за необхідністю)
