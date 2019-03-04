*** Settings ***


*** Variables ***


*** Keywords ***
Відкрити сторінку за назвою
	[Arguments]  ${page_name}
	Click Element  xpath=//*[contains(@class, 'menulistitem')]//*[contains(text(), '${page_name}')]
	Дочекатись закінчення загрузки сторінки
	Wait Until Page Contains Element  //td[contains (@valign, "top") and contains(text(), "Реестр документов"|"Реєстр документів")]  5


Перевірити що активна вкладка "Документ"
	Page Should Contain Element  xpath=//*[contains(@class, 'activeTab')]//*[text()='Документ']


Перевірити тип процессу за замовчуванням
    [Arguments]  @{text}
	${type}  Get Element Attribute  xpath=//*[@data-name="KDMT"]//input[@type="text"]  value
	Should Contain Any  ${type}  @{text}
