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
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${executant input}  ${text}


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
	Element Should Be Visible  ${add btn}
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