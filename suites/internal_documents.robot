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
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v platform:WIN10 -v browser:chrome suites/internal_documents.robot
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v browser:firefox suites/internal_documents.robot
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v env:MBDEMOGOV_DLP -v platform:WIN10 -v browser:chrome suites/internal_documents.robot
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v env:MBDEMOGOV_DLP -v browser:firefox suites/internal_documents.robot

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
	tasks_detail_RMD.Натиснути передати  На погодження
	elements.Натиснути в валідаційному вікні  Погодження. Реєстрація внутр.№  OK


Погодити документ підлеглим виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути передати  Погодити
	EDS_RMD.Підписати ЄЦП


Відправити документ на доопрацювання виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути передати  На доопрацювання проекту
	tasks_detail_RMD.Заповнити поле "Зауваження"
	elements.Натиснути в валідаційному вікні  Зауваження  OK


Подати другу версію "Вихідного докуманта"
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  Проекти документів
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	Page Should Contain Element  //*[@class="frame-header"]//*[contains(text(),'Нова версія')]/..
	tasks_detail_RMD.Натиснути передати  На погодження


Повторно погодити документ підлеглим виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути передати  Погодити
	#EDS_RMD.Підписати ЄЦП


Погодити документ виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути передати  Погодити
	#EDS_RMD.Підписати ЄЦП


Опрацювати документ помічником адресата
	authentication.Завершити сеанс
	authentication.Авторизуватися  assistant_addressee
	authentication.Змінити Делеговані права  TEST_Адресат
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Додати задачу
	create_task_RMD.Заповнити поле "Зміст задачі" випадковим текстом
	Click Element  //*[@title="Потребує введення коментаря"]   #это тут необходимо
	create_task_RMD.Ввести текст в поле "До відома"  TEST_Підлеглий виконавця до відома
	create_task_RMD.Ввести текст в поле "Виконавець"  TEST_Cпіввиконавець 1-го рівня
	create_task_RMD.Натиснути "Додати"
	tasks_detail_RMD.Натиснути кнопку  Опрацьовано помічником


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
	tasks_detail_RMD.Натиснути з умовою  Повернути ініціатору  Змінити виконавця
	tasks_detail_RMD.Заповнити поле "Примітка"
	elements.Натиснути в валідаційному вікні  Примітка  OK
	tasks_RMD.Перевірити статус задачі  ${data['task']['text']}  Повернуто ініціатору


Змінити виконавця адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Розписані резолюції на підлеглих
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Виконати дію для задачі  ${data['task']['text']}  Зміна виконавця
	elements.Натиснути в валідаційному вікні  Зміна виконавця  Змінити виконавця
	Press Key  //td[contains(text(),'TEST_Підлеглий співвиконавця')]  \13


Виконати завдання підлеглим виконавця до відома
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor_to_attention
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати


Виконати завдання підлеглим співвиконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_co_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати
	tasks_detail_RMD.Заповнити поле "Примітка"
	elements.Натиснути в валідаційному вікні  Примітка  OK


Виконати завдання адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Розписані резолюції на підлеглих
	tasks_RMD.Перевірити статус задачі  ${data['document']['text']}  Опрацьовано помічником
	tasks_RMD.Перевірити статус задачі  ${data['document']['text']}  Виконано підлеглим
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати


Перемістити документ в архів автором
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	#main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  На підтвердження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути передати  В архів


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
	create_document_RMD.Заповнити поле "Зміст документа" випадковим текстом
	create_document_RMD.Вибрати елемент з випадаючого списку  Керівник  TEST_Підлеглий виконавця
	create_document_RMD.Вибрати елемент з випадаючого списку  Фінальний підписант  TEST_Виконавець 1-го рівня