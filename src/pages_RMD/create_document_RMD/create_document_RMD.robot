*** Settings ***


*** Variables ***
${create doc form}					//*[@class="dhx_cell_cont_wins"]
${create doc field}					//*[contains(@class,'dhxform_item_absolute')]
${notice msg locator}				//*[@class="message-box"]
${popup locator}					//*[@class="ade-list-back" and not(contains(@style,'display: none'))]


*** Keywords ***
Ввести значення в поле
	[Arguments]  ${field_name}  ${text}
	${field locator}  Set Variable  ${create doc field}//*[contains(@title,'${field_name}')]/preceding-sibling::*
	${field input locator}  Set Variable  ${field locator}//input|${field locator}//textarea
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${field input locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Ввести значення в поле з датою
	[Arguments]  ${field_name}  ${text}
	${field locator}  Set Variable  ${create doc field}//*[contains(@title,'${field_name}')]/preceding-sibling::*
	${field input locator}  Set Variable  ${field locator}//input|${field locator}//textarea
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити поле з датою  ${field input locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Вибрати елемент з випадаючого списку
	[Arguments]  ${field_name}  ${text}
	${field locator}  Set Variable  ${create doc field}//*[contains(@title,'${field_name}')]/preceding-sibling::*
	Click Element  ${field locator}
	Дочекатись закінчення загрузки сторінки
	create_document_RMD.Відкрити сторінку "Довідник персоналу"
	staff_RMD.Вибрати користувача  Прізвище  ${text}


Відкрити сторінку "Довідник персоналу"
	elements.Дочекатися відображення елемента на сторінці  //*[@id='HelpF10']
	Click Element  //*[@id='HelpF10']
	Дочекатись закінчення загрузки сторінки
	Page Should Contain Element  //div[contains(@title,'Довідник персоналу.')]


Натиснути "Додати"
	${add btn}  Set Variable  ${create doc form}//*[contains(text(),'Додати')]
	Element Should Be Visible  ${add btn}
	Wait Until Keyword Succeeds  10s  2s  Click Element  ${add btn}
	Дочекатись закінчення загрузки сторінки


Заповнити поле "Зміст документа" випадковим текстом
	${text}  create_sentence  20
	create_document_RMD.Ввести значення в поле  Зміст  ${text}
	Set To Dictionary  ${data['document']}  text  ${text}


Заповнити поле "Номер вихідного документа" випадковими даними
	${first number}  random_number  100  999
	${second number}  random_number  100  999
	create_document_RMD.Ввести значення в поле  Номер вихідного документа  ${first number}-${second number}
	Set To Dictionary  ${data['document']}  number  ${first number}-${second number}


Заповнити поле "Дата вихідного документа" сьогоднішньою датою
	${date}  Evaluate  '{:%d.%m.%Y}'.format(datetime.datetime.now())  datetime
	create_document_RMD.Ввести значення в поле з датою  Дата вихідного документа  ${date}
	Set To Dictionary  ${data['document']}  date  ${date}


#Натиснути "Ок" в валідаційному вікні
#	Wait Until Element Is Visible  ${notice msg locator}
#	${ok btn}  Set Variable  ${notice msg locator}//*[text()='ОК']														#todo понять что єто и зачем
#	Click Element  ${ok btn}
#	Дочекатись закінчення загрузки сторінки