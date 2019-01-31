*** Settings ***
Documentation			Пейджа для стартової сторінки, яка відкривається після авторизації  http://joxi.ru/EA43J8BcwV1032


*** Variables ***


*** Keywords ***
Натиснути "Адміністрування"
	${administration btn}  Set Variable  //*[@data-key="AD.ADM"]
	Wait Until Element Is Visible  ${administration btn}  5
	Click Element  ${administration btn}
	Дочекатись закінчення загрузки сторінки
	Page Should Contain Element  //*[@class='menulistitem-module-title' and contains(text(),'Адміністрування')]


Натиснути "Довідники"
	${catalogs btn}  Set Variable  //div[contains(@class, 'TreeViewContainer')]//*[contains(text(), 'Справочники')]|//div[contains(@class, 'TreeViewContainer')]//*[contains(text(), 'Довідники')]
	Wait Until Element Is Visible  ${catalogs btn}  5
	Click Element  ${catalogs btn}
	Дочекатись закінчення загрузки сторінки
	Page Should Contain Element  //div[@class="menulistview-header"]//*[contains(text(), 'Справочники')]|//div[@class="menulistview-header"]//*[contains(text(), 'Довідники')]


Натиснути "Склад"
	${stock btn}  Set Variable  //div[contains(@class, 'TreeViewContainer')]//*[contains(text(), 'Склад')]
	Wait Until Element Is Visible  ${stock btn}  5
	Click Element  ${stock btn}
	Дочекатись закінчення загрузки сторінки
	Page Should Contain Element  //div[@class="menulistview-header"]//*[contains(text(), 'Склад')]


Натиснути "Продажі"
	${stock btn}  Set Variable  //div[contains(@class, 'TreeViewContainer')]//*[contains(text(), 'Продажі')]|//div[contains(@class, 'TreeViewContainer')]//*[contains(text(), 'Продажи')]
	Wait Until Element Is Visible  ${stock btn}  5
	Click Element  ${stock btn}
	Дочекатись закінчення загрузки сторінки
	Page Should Contain Element  //div[@class="menulistview-header"]//*[contains(text(), 'Продажі')]|//div[@class="menulistview-header"]//*[contains(text(), 'Продажи')]