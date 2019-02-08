*** Settings ***
Documentation  http://joxi.ru/gmv5LPBSLXo0Xr


*** Variables ***


*** Keywords ***
Натиснути передати
	[Arguments]  ${text}
	${locator}  Set Variable  //*[contains(@title,'${text}')]/*[@class="split-button-container"]
	elements.Дочекатися відображення елемента на сторінці  ${locator}
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD


Натиснути з умовою
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
	${locator}  Set Variable  //*[contains(@title,"${text}")]
	elements.Дочекатися відображення елемента на сторінці  ${locator}
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD


Виконати дію для задачі
	[Arguments]  ${task_text}  ${action}
	${btn more locator}  Set Variable  //tr[contains(.,'${task_text}') and @class]//i[@class="material-icons"]
	elements.Дочекатися відображення елемента на сторінці  ${btn more locator}
	Click Element  ${btn more locator}
	${action locator}  Set Variable  //*[@class="sub_item_text" and contains(text(),'${action}')]
	elements.Дочекатися відображення елемента на сторінці  ${action locator}
	Click Element  ${action locator}
	Дочекатись закінчення загрузки сторінки RMD


Заповнити поле "Примітка"
	${remark_text}  create_sentence  10
	${remark input}  Set Variable  //*[@class="dhxwin_active menuget"]//textarea
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${remark input}  ${remark_text}


Заповнити поле "Зауваження"
	${remark_text}  create_sentence  10
	${remark window locator}  Set Variable  //*[@class="dhxwin_active menuget"]
	elements.Дочекатися відображення елемента на сторінці  ${remark window locator}  5
	Page Should Contain Element  ${remark window locator}//*[contains(@class,'header-text') and text()='Зауваження']
	Select Frame  ${remark window locator}//iframe
	Wait Until Keyword Succeeds  30  5  Input Text  //body  ${remark_text}
	Unselect Frame

