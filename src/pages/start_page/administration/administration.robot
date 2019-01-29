*** Settings ***
Documentation			Пейджа для сторінки Адміністрування  http://joxi.ru/LmGdY6BUeaPY72


*** Variables ***


*** Keywords ***
Натиснути "Користувачі та групи"
	Wait Until Element Is Visible  //div[@data-itemkey and contains(., "Користувачі та групи")]
	Click Element  //div[@data-itemkey and contains(., "Користувачі та групи")]
	Дочекатись закінчення загрузки сторінки
	Wait Until Page Contains Element  //*[@data-placeid="TBN"]//td[text()="Користувачi"]
	Page Should Contain Element  //*[@class="dx-vam" and contains(text(), "РОЗРОБНИК")]




