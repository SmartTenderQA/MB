*** Settings ***
Documentation			Пейджа для сторінки Реєстру документів  http://joxi.ru/eAOnZ39CxBO9K2


*** Variables ***


*** Keywords ***
Пошук по полю в основному вікні
    [Arguments]  ${field}  ${value}
    ${input}  Set Variable
    ...  (//*[@class="hdr"]//td/input)[count(//*[@data-placeid="DMZ"]//div[contains(text(), '${field}')]/ancestor::td[1]/preceding-sibling::*)]
    Input Text  ${input}  ${value}
    Press Key  ${input}  \\13


Вибрати рядок в основному вікні за номером
    [Arguments]  ${i}
    ${row}  Set Variable  //*[@data-placeid="DMZ"]//tr[contains(@class,"Row")]
    elements.Дочекатися відображення елемента на сторінці  ${row}
    Click Element  (${row})[1]
    elements.Дочекатися відображення елемента на сторінці  (${row})[${i}][contains(@class,"selected")]


Отримати кількість документів
	${quantity}  Get Element Count
	...  //td[contains (@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "Row")]
	[Return]  ${quantity}


Заповнити поле
	[Arguments]  ${field_name}  ${text}
	Run Keyword  Заповнити поле ${field_name}  ${text}


Заповнити поле Склад
	[Arguments]  ${text}
	${locator}  Set Variable  //*[@data-name="CEH_K"]//input[@type="text"]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле Контрагент
	[Arguments]  ${text}
	${locator}  Set Variable  //*[@data-name="ORG"]//input[@type="text"]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле Договор
	[Arguments]  ${text}
	${locator}  Set Variable  //*[@data-name="UNDOG"]//input[@type="text"]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле Код ТМЦ
	[Arguments]  ${text}
	${locator}  Set Variable  //*[@data-name="KMAT"]//input[@type="text"]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле Кол.факт
	[Arguments]  ${text}
	${locator}  Set Variable  //*[@data-name="KOL"]//input[@type="text"]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле ГРН
	[Arguments]  ${text}
	${locator}  Set Variable  //*[@data-name="CENA_1VAL"]//input[@type="text"]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${text}
	Дочекатись закінчення загрузки сторінки


Натиснути кнопку форми
	[Arguments]  ${button_name}
	${locator}  Set Variable  //*[@title='${button_name}']
	Wait Until Element Is Visible  ${locator}  15
	Click Element  ${locator}
	Дочекатись закінчення загрузки сторінки


Обрати режим формування за назвою
	[Arguments]  ${mode}
	${status}  Run Keyword And Return Status  Wait Until Page Contains Element  //span[contains(text(), '${mode}')]  2
	Run Keyword If  ${status} == ${True}  Run Keywords
	...  Click Element  //span[contains(text(), '${mode}')]
	...  AND  Дочекатись закінчення загрузки сторінки


Заповнити поле Программная классиф.
	[Arguments]  ${text}
	${locator}  Set Variable  (//*[contains(text(), "Программная классиф.")]/following-sibling::td)[2]
	documents_register.Встановити фокус в поле  ${locator}
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}//input  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле Фонд
	[Arguments]  ${text}
	${locator}  Set Variable  (//*[contains(text(), "Фонд")]/following-sibling::td)[2]
	documents_register.Встановити фокус в поле  ${locator}
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}//input  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле Коды экономической классификации
	[Arguments]  ${text}
	${locator}  Set Variable  (//*[contains(text(), "Коды экономической классификации")]/following-sibling::td)[2]
	documents_register.Встановити фокус в поле  ${locator}
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}//input  ${text}
	Дочекатись закінчення загрузки сторінки


Заповнити поле Статьи доходов/затрат
	[Arguments]  ${text}
	${locator}  Set Variable  (//*[contains(text(), "Статьи доходов/затрат")]/following-sibling::td)[1]
	documents_register.Встановити фокус в поле  ${locator}
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}//input  ${text}
	Дочекатись закінчення загрузки сторінки


Стадія поточного документа повинна бути
	[Arguments]  ${status}
	Set Global Variable  ${active_row_selector}
	...  //tr[@class="evenRow rowselected"]//td[count(//div[contains(text(), 'Стадия')]/ancestor::td[@draggable]/preceding-sibling::*)+1]
	${text}  Get Text  ${active_row_selector}
	Should Be True  '${text}' == '${status}'


Встановити фокус в поле
	[Arguments]  ${locator}
	Click Element  ${locator}
	Sleep  .5
	Click Element  ${locator}
	Sleep  .5


Отримати номер доданого документу
	Click Element  ${active_row_selector}
	${current_dock number}  Get Text  ${active_row_selector}/following-sibling::*[3]
	Set Global Variable  ${added_dock_number}   ${current_dock number}
	Дочекатись закінчення загрузки сторінки


Перевірити проведення документу
	Дочекатись закінчення загрузки сторінки
	Run Keyword And Expect Error  *not visible*  main_menu.Натиснути кнопку в головному меню за назвою  Провести (Alt+Right)
	documents_register.Стадія поточного документа повинна бути  Проведен


Перевірити відміну проведення
	Дочекатись закінчення загрузки сторінки
	Run Keyword And Expect Error  *not visible*  main_menu.Натиснути кнопку в головному меню за назвою  Отменить проведение (Alt+Left)
	documents_register.Стадія поточного документа повинна бути  Ввод


Перевірити видалення документу
	${current_documents_quantity}  Отримати кількість документів
	Should Be True  ${current_documents_quantity} == ${initial_documents_quantity}


Переконатися що в реєстрі з'явився новий документ
	[Arguments]  ${initial_documents_quantity}  ${current_documents_quantity}
	Should Be True  ${current_documents_quantity} == (${initial_documents_quantity} + 1)