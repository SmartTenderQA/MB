*** Settings ***
Documentation
Metadata  Задача в PLD
...  590425
Metadata  Название теста
...  БП Входящие документы
Metadata  Заявитель
...  КУЦАЯ
Metadata  Окружения
...  - chrome
...  - ff
Metadata  Команда запуска
...  robot --consolecolors on -L TRACE:INFO -d test_output -v platform:WIN10 -v browser:chrome -v env:BUHGOVA2_RMD suites/incoming_documents.robot
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v browser:firefox suites/incoming_documents.robot

Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***


*** Test Cases ***
Додати "Вхідний документ"
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити випадаючий список "Додати документ"
	tasks_RMD.Вибрати тип документа за назвою  Вхідні від АПУ, ВРУ, КМУ, РНБО
	Заповнити обов'язкові поля документа
	create_document_RMD.Натиснути "Додати"


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	${data}  Create Dictionary
	Set Global Variable  ${data}  ${data}


Заповнити обов'язкові поля документа
	Заповнити поле "Номер вихідного документа"
	Заповнити поле "Дата вихідного документа"
	create_document_RMD.Ввести значення в поле  Кореспондент  Міністерство Освіти України
	create_document_RMD.Ввести значення в поле  Адресати по документу  TEST_Адресат А.
	Заповнити поле "Зміст повідомлення"
	create_document_RMD.Ввести значення в поле  Вид доставки  Інше


Заповнити поле "Номер вихідного документа"
	${number}  random_number  1  99
	create_document_RMD.Ввести значення в поле  Номер вихідного документа  ${number}-${number}
	Set To Dictionary  ${data}  number  ${number}-${number}


Заповнити поле "Дата вихідного документа"
	${date}  Evaluate  '{:%d.%m.%Y}'.format(datetime.datetime.now())  datetime
	create_document_RMD.Ввести значення в поле з датою  Дата вихідного документа  ${date}
	Set To Dictionary  ${data}  date  ${date}


Заповнити поле "Зміст повідомлення"
	${text}  create_sentence  20
	create_document_RMD.Ввести значення в поле  Зміст  ${text}
	Set To Dictionary  ${data}  text  ${text}
