*** Settings ***
Documentation  http://joxi.ru/zANOKR9TBD9wLr


*** Variables ***
${add doc popup}				//*[@id="TBCASE____SHIFT-F7popup-menu"]


*** Keywords ***
Відкрити випадаючий список "Додати документ"
	${add doc btn}  Set Variable  //div[@title='Додати документ (Shift+F7)']
	Wait Until Page Contains Element  ${add doc btn}
	Click Element  ${add doc btn}
	Дочекатись закінчення загрузки сторінки
	Wait Until Element Is Visible  ${add doc popup}


Вибрати тип документа за назвою
	[Arguments]  ${doc_type}
	Wait Until Element Is Visible  ${add doc popup}
	Click Element  ${add doc popup}//*[contains(text(),'${doc_type}')]
	Дочекатись закінчення загрузки сторінки


Відкрити папку завдань і документів за назвою
	[Arguments]  ${folder_name}
	${locator}  Set Variable  //*[@title='${folder_name}']
	Wait Until Element Is Visible  ${locator}  3
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки


Відкрити документ за змістом
	[Arguments]  ${text}
	${locator}  Set Variable
	...  //*[@class="objbox selectable objbox-scrollable"]//table[@class="obj"]/tbody/tr[contains(.,"${text}")]
	elements.Дочекатися відображення елемента на сторінці  ${locator}
	Run Keyword And Ignore Error  Click Element  ${locator}
	Sleep  .2
	Run Keyword And Ignore Error  Click Element  ${locator}   #иногда на ff есть трудности с двойнім кликов
	Дочекатись закінчення загрузки сторінки
	${status}  Run Keyword And Return Status  Page Should Not Contain Element  //*[@class="menu-item-text" and contains(.,'Мої завдання і документи')]
	Run Keyword If  ${status} == ${false}
	...  tasks_RMD.Відкрити документ за змістом  ${text}


Перевірити статус задачі
	[Arguments]  ${text}  ${status}
	${locator}  Set Variable
	...  //*[@class="objbox selectable objbox-scrollable"]//table[@class="obj"]/tbody/tr[contains(.,"${text}")]
	Element Should Contain  ${locator}  ${status}  Oops! Статус задачі не ${status}


Додати об'єкт до задачі з випадаючого списку
	[Arguments]  ${name}
	click element  //*[@title="Додати (F7)"]//i
	${object}  set variable  //ul[contains(@id,"F7")]//*[@class="menu-item-text"]
	elements.Дочекатися відображення елемента на сторінці  ${object}\[contains(text(),"${name}")]
	click element  ${object}\[contains(text(),"${name}")]
	Дочекатись закінчення загрузки сторінки
	select frame  //*[@class="dashboard pdf-viewer-ex"]//iframe
	wait until page contains element  //*[@id="divDocViewer"]  10
	unselect frame




#В панелі інструментів для фрейма документа натиснути
#	[Arguments]  ${btn_name}
#	${panel locator}  Set Variable  //*[@class="frame-header"]
#	Wait Until Element Is Visible  ${panel locator}																		#todo понять что єто и зачем
#	Click Element  ${panel locator}//*[contains(text(),'${btn_name}')]/..
#	Дочекатись закінчення загрузки сторінки
