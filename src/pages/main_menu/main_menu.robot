*** Settings ***
Documentation			Пейджа для компонента Головне меню сторінки(хедер)  http://joxi.ru/KAxWZPlHMal6z2


*** Variables ***


*** Keywords ***
Вибрати вкладку в головному меню за назвою
	[Arguments]  ${tab_name}
	${tab locator}  Set Variable  //*[@id='MainSted2Splitter_0']//span[contains(text(), '${tab_name}')]
	${is not checked}  Run Keyword And Return Status  Element Should Be Visible  ${tab locator}
	Run Keyword If  ${is not checked} == ${True}
	...  Click Element  ${tab locator}
	Дочекатись закінчення загрузки сторінки


Натиснути кнопку в головному меню за назвою
	[Arguments]  ${button_name}
	${btn locator}  Set Variable  //*[@title="${button_name}"]
	Wait Until Element Is Visible  ${btn locator}
	Click Element  ${btn locator}
	Дочекатись закінчення загрузки сторінки