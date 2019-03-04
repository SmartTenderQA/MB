*** Settings ***
Documentation			Пейджа для сторінки Довідники  http://joxi.ru/zANOKR9TBMPx0r


*** Variables ***


*** Keywords ***
Відкрити довідник за назвою
	[Arguments]  ${catalog}
	Click Element  xpath=//*[contains(@class, 'menulistitem')]//*[contains(text(), "${catalog}")]
	Дочекатись закінчення загрузки сторінки
