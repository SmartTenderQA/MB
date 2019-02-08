*** Settings ***


*** Variables ***
${EDS window}			//*[@id="eds_placeholder"]

*** Keywords ***
Підписати ЄЦП
	elements.Дочекатися відображення елемента на сторінці  ${EDS window}
	EDS_RMD.Вибрати ЦСК за назвою  Тестовий ЦСК АТ "ІІТ"
	EDS_RMD.Завантажити ключ
	EDS_RMD.Ввести пароль ключа
	EDS_RMD.Натиснути кнопку підписати


Вибрати ЦСК за назвою
	[Arguments]  ${csk_name}
	${locator}  Set Variable  ${EDS window}//*[contains(.,'ЦСК')]/following-sibling::*[@class='dhxform_control']
	Click Element  ${locator}
	${item}  Set Variable  ${locator}//*[contains(text(),'${csk_name}')]
	elements.Дочекатися відображення елемента на сторінці  ${EDS window}
	Click Element  ${item}
	Click Element  ${locator}


Завантажити ключ
	Choose File  ${EDS window}//input[@type='file']  ${EXECDIR}/src/pages_RMD/EDS_RMD/Key-6.dat
	elements.Дочекатися відображення елемента на сторінці  //*[contains(text(),'Key-6.dat')]  2


Ввести пароль ключа
	${password field}  Set Variable  ${EDS window}//*[contains(.,'Пароль ключа')]/following-sibling::*[@class='dhxform_control']//input
	Input Password  ${password field}  29121963


Натиснути кнопку підписати
	${locator}  Set Variable  ${EDS window}//*[@class='dhxform_btn_txt' and contains(text(),'Підписати')]
	elements.Дочекатися відображення елемента на сторінці  ${locator}
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки RMD
	Дочекатись закінчення загрузки сторінки RMD