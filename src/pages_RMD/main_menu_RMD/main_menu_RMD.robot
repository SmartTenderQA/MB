*** Settings ***
Documentation			Пейджа для компонента Головне меню сторінки(хедер)  http://joxi.ru/KAxWZPlHMal6z2


*** Variables ***
${user panel}					//*[@class="user-account-panel "]


*** Keywords ***
Вибрати вкладку в головному меню за назвою
	[Arguments]  ${tab_name}
	${tab locator}  Set Variable  //*[@id="top-toolbar"]//*[@data-page and contains(.,'${tab_name}')]
	${is checked}  Run Keyword And Return Status  Page Should Contain Element  //*[@id="top-toolbar"]//*[@data-page and contains(@class,'active-item') and contains(.,'${tab_name}')]
	Run Keyword If  ${is checked} == ${false}
	...  Click Element  ${tab locator}
	Дочекатись закінчення загрузки сторінки RMD


Натиснути на іконку користувача
	${locator}  Set Variable  //*[@help-id="USERICONWRAPPER"]
	Wait Until Element Is Visible  ${locator}  2
	Click Element  ${locator}
	Wait Until Element Is Visible  ${user panel}


Натиснути "Змінити користувача"
	Click Element  ${user panel}//*[@id="ChangeUser"]
	elements.Натиснути в повідомленні  Завершити роботу із системою і зареєструватися під іншим ім'ям?  Так