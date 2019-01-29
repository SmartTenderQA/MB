*** Settings ***
Documentation			Пейджа для сторінки аторизації  http://joxi.ru/nAydaPGUYE09j2


*** Variables ***
${choose user btn}				//*[@data-name="Login"]//td[@id]
${password field locator}		//input[@type='password']
${login btn}					//div/span[contains(text(), 'Увійти')]|//div/span[contains(text(), 'Войти')]


*** Keywords ***
Авторизуватися
	[Arguments]  ${user_name}
	${login}  src.Отримати дані користувача по полю  ${user_name}  login
	authentication.Вибрати користувача  ${login}
	${password}  src.Отримати дані користувача по полю  ${user_name}  password
	authentication.Ввести пароль  ${password}
	authentication.Натиснути "Увійти"
	Run Keyword And Ignore Error  authentication.Підтвердити вибір підприємства




#########################################################
#	                  Keywords							#
#########################################################
Вибрати користувача
	[Arguments]  ${user_name}
	Page Should Contain Element  ${choose user btn}
	Click Element  ${choose user btn}
	${user locator}  Set Variable  //td[text()="${user_name}"]
	Wait Until Element Is Visible  ${user locator}
	Click Element  ${user locator}


Ввести пароль
	[Arguments]  ${password}
	Run Keyword If  "${password}" != "''"
	...  Input Password  ${password field locator}  ${password}


Натиснути "Увійти"
	Wait Until Keyword Succeeds  10s  2s  Click Element  ${login btn}
	Wait Until Element Is Not Visible  ${login btn}  90


Підтвердити вибір підприємства
	${choose btn}  Set Variable  //span[contains(text(), 'Вибір')]|//span[contains(text(), 'Выбор')]
	Дочекатись закінчення загрузки сторінки
	Wait Until Element Is Visible  ${choose btn}  10
	Click Element  ${choose btn}
	Дочекатись закінчення загрузки сторінки



#Оставлю, вдруг будет еще актуально
Закрити привітання с днем народження
#актуально 12.12
  Дочекатись загрузки сторінки (МВ)
  Wait Until Page Contains Element  //div[@id="pcModalMode_HCB-1"]
  Click Element  //div[@id="pcModalMode_HCB-1"]
  Дочекатись загрузки сторінки (МВ)