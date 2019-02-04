*** Settings ***
Documentation			Пейджа для сторінки "Групи товарів, продукції і послуги"  http://joxi.ru/D2PXaO9CpLPYB2


*** Variables ***


*** Keywords ***
Відкрити закладку за назвою
	[Arguments]  ${tab_name}
	${tab locator}  Set Variable  //*[@id='MainSted2PageControl_KSM_TC']//div[contains(text(), '${tab_name}')]
	Wait Until Keyword Succeeds  5  .5  Click Element  ${tab locator}
	Дочекатись закінчення загрузки сторінки


Відкрити вкладку в вікні за назвою
	[Arguments]  ${tab_name}
	${tab locator}  Set Variable  //*[contains(text(), '${tab_name}')]
	Click Element  ${tab locator}
	Дочекатись закінчення загрузки сторінки


Заповнити значення поля "Счет хранения"
	[Arguments]  ${text}
	${locator}  Set Variable  //div[@data-name="BS"]//input[1]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити значення поля "Контрагенты"
	[Arguments]  ${text}
	Click Element  xpath=//td[contains(text(), 'Контрагенты')]/following-sibling::td
	Sleep  .5
	${locator}  Set Variable  xpath=//td[contains(text(), 'Контрагенты')]/following-sibling::td//input
  	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Натиснути "Выбор из справочника F10" для поля
	[Arguments]  ${title}
	${field}  Set Variable  xpath=//td[contains(text(), '${title}')]/following-sibling::td
	Click Element  ${field}
	Sleep  .5
	Click Element  ${field}
	Wait Until Keyword Succeeds  30s  3s  Click Element  xpath=//td[contains(text(), '${title}')]/following-sibling::td//*[contains(@title, 'Выбор из спра')]
	Дочекатись закінчення загрузки сторінки


Перевірити в "Картотека договоров" наявність договору з ID
	[Arguments]  ${id}
	Wait Until Page Contains  Картотека договоров  30
	Wait Until Element Is Visible  xpath=//*[contains(@title, 'Уник.номер')]/ancestor::*[contains(@class, 'gridbox-main')]//*[contains(text(), '${id}')]


Закрити вікно "Картотека договоров"
	Click Element  xpath=//*[@alt='Close'][1]
	Дочекатись закінчення загрузки сторінки


Натиснути "Поиск по фильтру" в полі
	[Arguments]  ${title}
	${field}  Set Variable  xpath=//td[contains(text(), '${title}')]/following-sibling::td
	Click Element  ${field}
	Sleep  .5
	Wait Until Keyword Succeeds  30s  3s  Click Element  xpath=//td[contains(text(), '${title}')]/following-sibling::td//*[contains(@title, 'Поиск элементов')]
	Дочекатись закінчення загрузки сторінки


Перевірити в "Поиск по фильтру" наявність договору з ID
	[Arguments]  ${id}
	Wait Until Element Is Visible  xpath=(//*[contains(text(), 'Уник.номер')]/ancestor::*[@class="ade-list-back"]//*[contains(text(), '${id}')])[1]