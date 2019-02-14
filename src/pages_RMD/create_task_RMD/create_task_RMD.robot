*** Settings ***


*** Variables ***


*** Keywords ***
Ввести текст в поле "Зміст задачі"
	[Arguments]  ${text}
	${contents of the task input}  Set Variable  //input[@placeholder="Введіть опис..."]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${contents of the task input}  ${text}


Ввести текст в поле "Виконавець"
	[Arguments]  ${text}
	${executant input}  Set Variable  //div[contains(text(),'Виконавець')]/..//following-sibling::*//*[@data-caption="+ Додати"]//input[@type='text']
	Click Element  ${executant input}
	Дочекатись закінчення загрузки сторінки RMD
	create_task_RMD.Відкрити сторінку "Довідник персоналу"
	staff_RMD.Вибрати користувача  ${EMPTY}  ${text}


Відкрити сторінку "Довідник персоналу"
	elements.Дочекатися відображення елемента на сторінці  //*[@id='HelpF10']
	Click Element  //*[@id='HelpF10']
	Дочекатись закінчення загрузки сторінки RMD
	Page Should Contain Element  //*[@class="float-container-header-text" and contains(.,'Виконавець для Smart Manager')]


Ввести текст в поле "До відома"
	[Arguments]  ${text}
	${to attention input}  Set Variable  //div[contains(text(),'відома')]/..//following-sibling::*//*[@data-caption="+ Додати"]//input[@type='text']
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${to attention input}  ${text}


Ввести текст в поле "Співвиконавці"
	[Arguments]  ${text}
	${collaborators input}  Set Variable  //div[contains(text(),'Співвиконавці')]/..//following-sibling::*//*[@data-caption="+ Додати"]//input[@type='text']
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${collaborators input}  ${text}


Натиснути "Додати"
	${add btn}  Set Variable  ${create doc form}//*[contains(text(),'Додати')]|${create doc form}//*[contains(text(),'Зберегти')]
	elements.Дочекатися відображення елемента на сторінці  ${add btn}
	Wait Until Keyword Succeeds  10s  2s  Click Element  ${add btn}
	Дочекатись закінчення загрузки сторінки RMD


Поставити задачу на контроль
	${requires control checkbox}  Set Variable  //*[@title="Вимагає контролю"]
	elements.Дочекатися відображення елемента на сторінці  ${requires control checkbox}
	Click Element  ${requires control checkbox}


Заповнити поле "Зміст задачі" випадковим текстом
	${text}  create_sentence  20
	create_task_RMD.Ввести текст в поле "Зміст задачі"  ${text}
	Set To Dictionary  ${data['task']}  text  ${text}


Перейти на вкладку
	[Arguments]  ${tab_name}
	${tab locator}  Set Variable  //li[contains(.,'${tab_name}')]
	elements.Дочекатися відображення елемента на сторінці  ${tab locator}
	Click Element  ${tab locator}
	Дочекатись закінчення загрузки сторінки RMD
	${tab class}  Get Element Attribute  ${tab locator}  class
	Should Contain  ${tab class}  -active


Ввести значення в поле з датою контролю
	[Arguments]  ${text}
	${field input locator}  Set Variable  ${create doc field}//*[contains(@title,'Дата зняття з контролю')]/preceding-sibling::*//input
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити поле з датою  ${field input locator}  ${date}
	Дочекатись закінчення загрузки сторінки RMD


Заповнити поле "Дата зняття з контролю" сьогоднішньою датою
	${date}  Evaluate  '{:%d.%m.%Y}'.format(datetime.datetime.now())  datetime
	create_task_RMD.Ввести значення в поле з датою контролю  ${date}
