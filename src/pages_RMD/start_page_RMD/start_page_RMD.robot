*** Settings ***
Documentation			Пейджа для стартової сторінки, яка відкривається після авторизації  http://joxi.ru/EA43J8BcwV1032


*** Variables ***


*** Keywords ***
Натиснути "Завдання і документи"
	Дочекатись закінчення загрузки сторінки
	Дочекатись закінчення загрузки сторінки
	${tasks and docs btn}  Set Variable  //*[contains(@class,'splitter-panel')]//*[contains(text(),'Завдання і документи')]
	elements.Дочекатися відображення елемента на сторінці  ${tasks and docs btn}  15
	Click Element  ${tasks and docs btn}
	Дочекатись закінчення загрузки сторінки
	Дочекатись закінчення загрузки сторінки
