*** Settings ***
Documentation			Пейджа для сторінки аторизації  http://joxi.ru/nAydaPGUYE09j2


*** Variables ***
${choose user btn}				//*[@data-name="Login"]//td[@id]|//*[@class='dhxcombo_select_button']
${password field locator}		//input[@type='password']|//input[@type='PASSWORD']
${login btn}					//div/span[contains(text(), 'Увійти')]|//div/span[contains(text(), 'Войти')]|//div[contains(text(), 'Увійти')]/..


*** Keywords ***
Авторизуватися
	[Arguments]  ${user_name}
	Wait Until Page Contains Element  ${login btn}  15
	${login}  src.Отримати дані користувача по полю  ${user_name}  login
	authentication.Вибрати користувача  ${login}
	${password}  src.Отримати дані користувача по полю  ${user_name}  password
	authentication.Ввести пароль  ${password}
	authentication.Натиснути "Увійти"
	Run Keyword If  '${env}' == 'WEBCLIENT'
	...  authentication.Підтвердити вибір підприємства


Завершити сеанс
	Run Keyword And Ignore Error  elements.Закрити всі сповіщення (за необхідністю)
	main_menu_RMD.Натиснути на іконку користувача
	Run Keyword And Ignore Error  elements.Закрити всі сповіщення (за необхідністю)
	main_menu_RMD.Натиснути "Змінити користувача"


Змінити Делеговані права
	[Arguments]  ${user_name}
	Run Keyword And Ignore Error  elements.Закрити всі сповіщення (за необхідністю)
	main_menu_RMD.Натиснути на іконку користувача
	Run Keyword And Ignore Error  elements.Закрити всі сповіщення (за необхідністю)
	main_menu_RMD.Натиснути "Делеговані права"  ${user_name}

#########################################################
#	                  Keywords							#
#########################################################
Вибрати користувача
	[Arguments]  ${login}
	Page Should Contain Element  ${choose user btn}
	Click Element  ${choose user btn}
	${all users popup locator}  Set Variable  //*[@class=" dhxform_obj_material"]|//*[@id="CustomDropDownContainer"]//*[@class="dxeListBox_DevEx"]
	Wait Until Element Is Visible  ${all users popup locator}
	${all users}  Get Text  ${all users popup locator}
	${user index}  Get Index From List  ${all users.split('\n')}  ${login}
	Log Many  ${login}  ${all users}
	${user locator}  Set Variable  (//*[@class="dhxcombo_option"])[${user index + 1}]|(//*[@class="dxeListBoxItemRow_DevEx" and not(@id)])[${user index + 1}]
	Wait Until Element Is Visible  ${user locator}
	Click Element  ${user locator}
	${login is}  Get Element Attribute  //input[@type='text' and @autocomplete]  value
	Run Keyword If  '${login is}' != '${login}'
	...  Run Keywords
	...  Capture Page Screenshot							AND
	...  authentication.Вибрати користувача  ${login}



Ввести пароль
	[Arguments]  ${password}
	Run Keyword If  "${password}" != "''"
	...  Input Password  ${password field locator}  ${password}


Натиснути "Увійти"
	Wait Until Keyword Succeeds  10s  2s  Click Element  ${login btn}
	Wait Until Keyword Succeeds  90s  1s  Element Should Not Be Visible  ${login btn}


Підтвердити вибір підприємства
	${choose btn}  Set Variable  //span[contains(text(), 'Вибір')]|//span[contains(text(), 'Выбор')]
	Дочекатись закінчення загрузки сторінки
	Wait Until Element Is Visible  ${choose btn}  10
	Click Element  ${choose btn}
	Дочекатись закінчення загрузки сторінки



#Оставлю, вдруг будет еще актуально
Закрити привітання с днем народження
#актуально 12.12
  Дочекатись закінчення загрузки сторінки RMD
  Wait Until Page Contains Element  //div[@id="pcModalMode_HCB-1"]
  Click Element  //div[@id="pcModalMode_HCB-1"]
  Дочекатись закінчення загрузки сторінки RMD