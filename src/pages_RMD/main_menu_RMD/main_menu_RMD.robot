*** Settings ***
Documentation			Пейджа для компонента Головне меню сторінки(хедер)  http://joxi.ru/KAxWZPlHMal6z2


*** Variables ***
${user panel}					//*[@class="user-account-panel "]


*** Keywords ***
Вибрати вкладку в головному меню за назвою
	[Arguments]  ${tab_name}
	${tab locator}  Set Variable  //*[@id="top-toolbar"]//*[@data-page and contains(.,'${tab_name}')]
	${is checked}  Run Keyword And Return Status  Page Should Contain Element  //*[@id="top-toolbar"]//*[@data-page and contains(@class,'active-item') and contains(.,'${tab_name}')]
	Run Keyword If  ${is checked} == ${false}  Run Keywords
	...  elements.Дочекатися відображення елемента на сторінці  ${tab locator}  AND
	...  Click Element  ${tab locator}
	Дочекатись закінчення загрузки сторінки RMD


Натиснути на іконку користувача
	elements.Закрити всі сповіщення (за необхідністю)
	${locator}  Set Variable  //*[@help-id="USERICONWRAPPER"]
	Wait Until Element Is Visible  ${locator}  2
	Click Element  ${locator}
	Wait Until Element Is Visible  ${user panel}


Натиснути "Змінити користувача"
	elements.Закрити всі сповіщення (за необхідністю)
	Click Element  ${user panel}//*[@id="ChangeUser"]
	elements.Натиснути в повідомленні  Завершити роботу із системою і зареєструватися під іншим ім'ям?  Так


Натиснути "Делеговані права"
	[Arguments]  ${user_name}
	elements.Закрити всі сповіщення (за необхідністю)
	Click Element  ${user panel}//*[@id='AddDelegateRigths']
	${delegated rights}  Set Variable  //*[@class="uap-submenu"]
	elements.Дочекатися відображення елемента на сторінці  ${delegated rights}
	Click Element  ${delegated rights}//*[contains(text(),'${user_name}')]
	Дочекатись закінчення загрузки сторінки RMD
	Дочекатись закінчення загрузки сторінки