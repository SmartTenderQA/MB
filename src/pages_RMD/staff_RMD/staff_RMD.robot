*** Settings ***
Documentation  http://joxi.ru/RmzLRPGT0y48pA

*** Variables ***


*** Keywords ***
Вибрати користувача
	[Arguments]  ${feature}  ${text}
	staff_RMD.Знайти дані за ознакою  ${feature}  ${text}
	Click Element  //*[@id="Choice"]|//*[text()='Вибір']
	Дочекатись закінчення загрузки сторінки


Знайти дані за ознакою
	[Arguments]  ${feature}  ${text}
	${feature input locator}  Set Variable
	...  (//*[@class="xhdr xhdrScrollable"]//input)[count(//div[contains(text(), '${feature}')]/ancestor::td[@draggable]/preceding-sibling::*)]
	Click Element  //*[@title="Фільтр"]/div
	Wait Until Element Is Visible  ${feature input locator}
	Input Text  ${feature input locator}  ${text}
	Press Key  ${feature input locator}  \\13
	Дочекатись закінчення загрузки сторінки
	Click Element  //td[text()='${text[:-3]}']|//td[text()='${text}']
	Дочекатись закінчення загрузки сторінки