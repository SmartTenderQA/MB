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
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити випадаючий список "Додати документ"
	tasks_RMD.Вибрати тип документа за назвою  Службові документи
	Заповнити обов'язкові поля документа
	create_document_RMD.Натиснути "Додати"
	tasks_RMD.Натиснути  На погодження
	elements.Натиснути в валідаційному вікні  Погодження. Реєстрація внутр.№  OK


Погодити документ підлеглим виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	#tasks_RMD.Натиснути  Погодити


Відправити документ на доопрацювання виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}


Подати другу версію "Вихідного докуманта"
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  Проекти документів
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}


Повторно погодити документ підлеглим виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}
	#tasks_RMD.Натиснути  Погодити


Погодити документ виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}
	#tasks_RMD.Натиснути  Погодити


Опрацювати документ помічником адресата
	authentication.Завершити сеанс
	authentication.Авторизуватися  assistant_addressee
	start_page_RMD.Натиснути "Завдання і документи"


Перевірити наявність документа адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"


Повернути документ адресату з вимогою змінити виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  co_performer_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}


Змінити виконавця адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Розписані резолюції на підлеглих
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}


Виконати завдання підлеглим виконавця до відома
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor_to_attention
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}


Виконати завдання підлеглим співвиконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_co_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду
	#tasks_RMD.Відкрити документ за змістом  ${data['text']}


Виконати завдання адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"


Перемістити документ в архів автором
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  На підтвердження


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  author
	${data}  Create Dictionary
	Set Global Variable  ${data}  ${data}


Заповнити обов'язкові поля документа
	create_document_RMD.Вибрати елемент з випадаючого списку  Адресати по документу  TEST_Адресат
	Заповнити поле "Зміст повідомлення"
	create_document_RMD.Вибрати елемент з випадаючого списку  Керівник  TEST_Підлеглий виконавця
	create_document_RMD.Вибрати елемент з випадаючого списку  Фінальний підписант  TEST_Виконавець 1-го рівня


Заповнити поле "Зміст повідомлення"
	${text}  create_sentence  20
	create_document_RMD.Ввести значення в поле  Зміст  ${text}
	Set To Dictionary  ${data}  text  ${text}