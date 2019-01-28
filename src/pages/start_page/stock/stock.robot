*** Settings ***
Documentation			Пейджа для сторінки склад  http://joxi.ru/krD5PVBSEDYYqm


*** Variables ***


*** Keywords ***
Відкрити сторінку за назвою
	[Arguments]  ${page_name}
	Click Element  xpath=//*[contains(@class, 'menulistitem')]//*[contains(text(), '${page_name}')]
	Дочекатись закінчення загрузки сторінки
	stock.Підтвердити "Умови відбору" за необхіднітсю
	Wait Until Page Contains Element  //td[contains (@valign, "top") and contains(text(), "Реестр документов")]  5


Підтвердити "Умови відбору" за необхіднітсю
	${status}  Run Keyword And Return Status  Wait Until Page Contains  Условие отбора документов  2
	Run Keyword If  '${status}' == 'True'  Run Keywords
	...  Click Element  xpath=//*[@title="Установить"]  AND
	...  Дочекатись закінчення загрузки сторінки


Перевірити вікно додавання документа в "Реестр документов"
	stock.Перевірити що активна вкладка "Документ"
	stock.Перевірити тип процессу за замовчуванням


Перевірити що активна вкладка "Документ"
	Page Should Contain Element  xpath=//*[contains(@class, 'activeTab')]//*[text()='Документ']


Перевірити тип процессу за замовчуванням
	${type}  Get Element Attribute  xpath=//*[@data-name="KDMT"]//input[@type="text"]  value
	Should Contain Any  ${type}  Приход ТМЦ от поставщика _COM_SUPBG  Приход ТМЦ от поставщика (_COM_SUPBG)
