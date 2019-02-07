*** Settings ***


*** Variables ***
${add doc popup}				//*[@id="TBCASE____SHIFT-F7popup-menu"]


*** Keywords ***
Відкрити випадаючий список "Додати документ"
	${add doc btn}  Set Variable  //div[@title='Додати документ (Shift+F7)']
	Wait Until Page Contains Element  ${add doc btn}
	Click Element  ${add doc btn}
	Wait Until Element Is Visible  ${add doc popup}


Вибрати тип документа за назвою
	[Arguments]  ${doc_type}
	Wait Until Element Is Visible  ${add doc popup}
	Click Element  ${add doc popup}//*[contains(text(),'${doc_type}')]
	Дочекатись закінчення загрузки сторінки RMD


Натиснути передати
	[Arguments]  ${text}
	${locator}  Set Variable  //*[contains(@title,'${text}')]/*[@class="split-button-container"]
	elements.Дочекатися відображення елемента на сторінці  ${locator}
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD


Натиснути
	[Arguments]  ${btn_name}  ${reason}
	${btn locator}  Set Variable  //*[@title="${btn_name}"]/*[@class="sb-dd"]
	elements.Дочекатися відображення елемента на сторінці  ${btn locator}
	Click Element  ${btn locator}
	${reason locator}  Set Variable  //*[@class="item-control-popup-menu"]//*[contains(text(),'${reason}')]
	elements.Дочекатися відображення елемента на сторінці  ${reason locator}
	Click Element  ${reason locator}
	Дочекатись закінчення загрузки сторінки RMD


Натиснути кнопку
	[Arguments]  ${text}
	${locator}  Set Variable  //*[contains(@title,'${text}')]
	elements.Дочекатися відображення елемента на сторінці  ${locator}
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD


Відкрити папку завдань і документів за назвою
	[Arguments]  ${folder_name}
	${locator}  Set Variable  //*[@title='${folder_name}']
	Wait Until Element Is Visible  ${locator}  3
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD


Відкрити документ за змістом
	[Arguments]  ${text}
	${locator}  Set Variable
	...  //*[@class="objbox selectable objbox-scrollable"]//table[@class="obj"]/tbody/tr[contains(.,"${text}")]
	elements.Дочекатися відображення елемента на сторінці  ${locator}
	Click Element  ${locator}
	Sleep  .2
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD
	${status}  Run Keyword And Return Status  Page Should Not Contain Element  //*[@class="menu-item-text" and contains(.,'Мої завдання і документи')]
	Run Keyword If  ${status} == ${false}
	...  tasks_RMD.Відкрити документ за змістом  ${text}


Перевірити статус задачі
	[Arguments]  ${text}  ${status}
	${locator}  Set Variable
	...  //*[@class="objbox selectable objbox-scrollable"]//table[@class="obj"]/tbody/tr[contains(.,"${text}")]
	Element Should Contain  ${locator}  ${status}  Oops! Статус задачі не ${status}


Заповнити поле зауваження
	[Arguments]  ${text}
	${remark window locator}  Set Variable  //*[@class="dhxwin_active menuget"]
	Wait Until Keyword Succeeds  5s  1s  Element Should Be Visible  ${remark window locator}
	Page Should Contain Element  ${remark window locator}//*[contains(@class,'header-text') and text()='Зауваження']
	Select Frame  ${remark window locator}//iframe
	Wait Until Keyword Succeeds  30  5  tasks_RMD.Ввести текст зауваження  ${text}
	Unselect Frame


Ввести текст зауваження
	[Arguments]  ${text}
	Click Element  //body
	Input Text  //body  ${text}
	${got text}  Get Text  //body
	Should Be Equal As Strings  ${got text}  ${text}


В панелі інструментів для фрейма документа натиснути
	[Arguments]  ${btn_name}
	${panel locator}  Set Variable  //*[@class="frame-header"]
	Wait Until Element Is Visible  ${panel locator}
	Click Element  ${panel locator}//*[contains(text(),'${btn_name}')]/..
	Дочекатись закінчення загрузки сторінки RMD


Виконати дію для задачі
	[Arguments]  ${task_text}  ${action}
	${btn more locator}  Set Variable  //tr[contains(.,'Звідси колода ве') and @class]//i[@class="material-icons"]
	elements.Дочекатися відображення елемента на сторінці  ${btn more locator}
	Click Element  ${btn more locator}
	${action locator}  Set Variable  //*[@class="sub_item_text" and contains(text(),'Зміна виконавця')]
	elements.Дочекатися відображення елемента на сторінці  ${action locator}
	Click Element  ${action locator}
	Дочекатись закінчення загрузки сторінки RMD
