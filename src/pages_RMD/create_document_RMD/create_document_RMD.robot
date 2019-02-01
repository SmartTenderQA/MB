*** Settings ***


*** Variables ***
${create doc form}					//*[@class="dhx_cell_cont_wins"]
${create doc field}					//*[contains(@class,'dhxform_item_absolute')]
${notice msg locator}				//*[@class="message-box"]
${popup locator}					//*[@class="ade-list-back" and not(contains(@style,'display: none'))]


*** Keywords ***
Ввести значення в поле
	[Arguments]  ${field_name}  ${text}
	${field}  Set Variable  ${create doc field}//*[contains(@title,'${field_name}')]/preceding-sibling::*
	${locator}  Set Variable  ${field}//input|${field}//textarea
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки RMD


Ввести значення в поле з датою
	[Arguments]  ${field_name}  ${text}
	${field}  Set Variable  ${create doc field}//*[contains(@title,'${field_name}')]/preceding-sibling::*
	${locator}  Set Variable  ${field}//input|${field}//textarea
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити поле з датою  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки RMD


Вибрати елемент з випадаючого списку
	[Arguments]  ${field_name}  ${text}
	${locator}  Set Variable  ${create doc field}//*[contains(@title,'${field_name}')]/preceding-sibling::*
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD
	Click Element  //*[@id='HelpF10']
	Дочекатись закінчення загрузки сторінки RMD
	create_document_RMD.Знайти дані за назвою поля  Прізвище  ${text}
	Click Element  //*[@id="Choice"]
	Дочекатись закінчення загрузки сторінки RMD


Натиснути "Додати"
	${add btn}  Set Variable  ${create doc form}//*[contains(text(),'Додати')]
	Element Should Be Visible  ${add btn}
	Wait Until Keyword Succeeds  10s  2s  Click Element  ${add btn}
	Дочекатись закінчення загрузки сторінки RMD


Натиснути "Ок" в валідаційному вікні
	Wait Until Element Is Visible  ${notice msg locator}
	${ok btn}  Set Variable  ${notice msg locator}//*[text()='ОК']
	Click Element  ${ok btn}
	Дочекатись закінчення загрузки сторінки RMD


Знайти дані за назвою поля
	[Arguments]  ${field_name}  ${text}
	${locator}  Set Variable
	...  (//*[@class="xhdr xhdrScrollable"]//input)[count(//div[contains(text(), '${field_name}')]/ancestor::td[@draggable]/preceding-sibling::*)]
	Click Element  //*[@title="Фільтр"]/div
	Wait Until Element Is Visible  ${locator}
	Input Text  ${locator}  ${text}
	Press Key  ${locator}  \\13
	Дочекатись закінчення загрузки сторінки RMD
	Click Element  //*[text()='${text}']
	Дочекатись закінчення загрузки сторінки RMD