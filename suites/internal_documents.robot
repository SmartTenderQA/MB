*** Settings ***
Documentation
Metadata  Задача в PLD
...  590425
Metadata  Название теста
...  БП Внутренние документы
Metadata  Заявитель
...  КУЦАЯ
Metadata  Окружения
...  - chrome
...  - ff
Metadata  Команда запуска
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v browser:chrome suites/internal_documents.robot
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v browser:firefox suites/internal_documents.robot

Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***


*** Test Cases ***
Додати "Службовий документ"
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити випадаючий список "Додати документ"
	tasks_RMD.Вибрати тип документа за назвою  Службові документи
	Заповнити обов'язкові поля документа
	create_document_RMD.Натиснути "Додати"
	tasks_RMD.Натиснути передати  На погодження
	elements.Натиснути в валідаційному вікні  Погодження. Реєстрація внутр.№  OK


Погодити документ підлеглим виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути передати  Погодити
	EDS.Підписати ЄЦП


Відправити документ на доопрацювання виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути передати  На доопрацювання проекту
	Заповнити поле "Зауваження"
	elements.Натиснути в валідаційному вікні  Зауваження  OK


Подати другу версію "Вихідного докуманта"
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  Проекти документів
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Відкрити папку завдань і документів за назвою  Узгодження
	Page Should Contain Element  //*[@class="frame-header"]//*[contains(text(),'Нова версія')]/..
	tasks_RMD.Натиснути передати  На погодження


Повторно погодити документ підлеглим виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути передати  Погодити
	#EDS.Підписати ЄЦП


Погодити документ виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути передати  Погодити
	#EDS.Підписати ЄЦП


Опрацювати документ помічником адресата
	authentication.Завершити сеанс
	authentication.Авторизуватися  assistant_addressee
	start_page_RMD.Натиснути "Завдання і документи"
	authentication.Змінити Делеговані права  TEST_Адресат
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути передати кнопку  Додати задачу
	Заповнити обов'язкові поля задачі
	create_document_RMD.Натиснути "Додати"
	tasks_RMD.Натиснути кнопку  Опрацьовано помічником


Перевірити наявність документа адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Розписані резолюції на підлеглих
	tasks_RMD.Перевірити статус задачі  ${data['document']['text']}  Опрацьовано помічником


Повернути документ адресату з вимогою змінити виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  co_performer_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути  Повернути ініціатору  Змінити виконавця
	Заповнити поле "Примітка"
	elements.Натиснути в валідаційному вікні  Примітка  OK
	tasks_RMD.Перевірити статус задачі  ${data['task']['text']}  Повернуто ініціатору


Змінити виконавця адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Розписані резолюції на підлеглих
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Виконати дію для задачі  ${data['task']['text']}  Зміна виконавця
	elements.Натиснути в валідаційному вікні  Зміна виконавця  Змінити виконавця
	Press Key  //td[contains(text(),'TEST_Підлеглий співвиконавця')]  \13


Виконати завдання підлеглим виконавця до відома
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor_to_attention
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути кнопку  Виконати


Виконати завдання підлеглим співвиконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_co_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути кнопку  Виконати
	Заповнити поле "Примітка"
	elements.Натиснути в валідаційному вікні  Примітка  OK


Виконати завдання адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Розписані резолюції на підлеглих
	tasks_RMD.Перевірити статус задачі  ${data['document']['text']}  Опрацьовано помічником
	tasks_RMD.Перевірити статус задачі  ${data['document']['text']}  Виконано підлеглим
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути кнопку  Виконати


Перемістити документ в архів автором
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	#main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  На підтвердження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Натиснути передати  В архів


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	${data}  Create Dictionary
	${document}  Create Dictionary
	${task}  Create Dictionary
	Set To Dictionary  ${data}  document  ${document}
	Set To Dictionary  ${data}  task  ${task}
	Set Global Variable  ${data}  ${data}


Заповнити обов'язкові поля документа
	create_document_RMD.Вибрати елемент з випадаючого списку  Адресати по документу  TEST_Адресат
	Заповнити поле "Зміст повідомлення"
	create_document_RMD.Вибрати елемент з випадаючого списку  Керівник  TEST_Підлеглий виконавця
	create_document_RMD.Вибрати елемент з випадаючого списку  Фінальний підписант  TEST_Виконавець 1-го рівня


Заповнити поле "Зміст повідомлення"
	${text}  create_sentence  20
	create_document_RMD.Ввести значення в поле  Зміст  ${text}
	Set To Dictionary  ${data['document']}  text  ${text}


Заповнити поле "Зауваження"
	${remark_text}  create_sentence  10
	tasks_RMD.Заповнити поле зауваження  ${remark_text}
	Set To Dictionary  ${data['document']}  remark  ${remark_text}


Заповнити обов'язкові поля задачі
	Заповнити поле "Зміст задачі"
	Click Element  //*[@title="Потребує введення коментаря"]
	Заповнити поле "Виконавець" для задачі
	create_document_RMD.Ввести значення в поле  Виконавець  TEST_Cпіввиконавець 1-го рівня
	Заповнити поле "До відома" для задачі


Заповнити поле "Зміст задачі"
	${text}  create_sentence  20
	${input}  Set Variable  //input[@placeholder="Введіть опис..."]
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${input}  ${text}
	Set To Dictionary  ${data['task']}  text  ${text}


Заповнити поле "До відома" для задачі
	${locator}  Set Variable  //*[contains(text(),'відома')]/..//following-sibling::*//*[@data-caption="+ Додати"]//input[@type='text']
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  TEST_Підлеглий виконавця до відома


Заповнити поле "Виконавець" для задачі
	${locator}  Set Variable  //*[contains(text(),'Виконавець')]/..//following-sibling::*//*[@data-caption="+ Додати"]//input[@type='text']
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  TEST_Cпіввиконавець 1-го рівня


Заповнити поле "Примітка"
	${remark_text}  create_sentence  10
	${locator}  Set Variable  //*[@class="dhxwin_active menuget"]//textarea
	Wait Until Keyword Succeeds  30  5  Заповнити та перевірити текстове поле  ${locator}  ${remark_text}
	Set To Dictionary  ${data['task']}  remark  ${remark_text}

