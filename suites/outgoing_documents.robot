*** Settings ***
Documentation
Metadata  Задача в PLD
...  590425
Metadata  Название теста
...  БП Исходящие документы
Metadata  Заявитель
...  КУЦАЯ
Metadata  Окружения
...  - chrome
...  - ff
Metadata  Команда запуска
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v browser:chrome suites/outgoing_documents.robot
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v browser:firefox suites/outgoing_documents.robot

Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***


*** Test Cases ***
Подати "Вихідний документ"
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити випадаючий список "Додати документ"
	tasks_RMD.Вибрати тип документа за назвою  Вихідні документи
	Заповнити обов'язкові поля документа
	create_document_RMD.Натиснути "Додати"
	tasks_RMD.Натиснути  На погодження
	elements.Натиснути в валідаційному вікні  Погодження  OK


Відхилити документ виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	tasks_RMD.Натиснути  Відхилити
	Заповнити поле "Зауваження"
	elements.Натиснути в валідаційному вікні  Зауваження  OK


Подати другу версію "Вихідного докуманта"
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  Проекти документів
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	Page Should Contain Element  //*[@class="frame-header"]//*[contains(text(),'Нова версія')]/..
	tasks_RMD.Натиснути  На погодження


Погодити документ виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На погодження
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	tasks_RMD.Натиснути  Погодити
	EDS.Підписати ЄЦП


Опрацювати документ помічником адресата
	authentication.Завершити сеанс
	authentication.Авторизуватися  assistant_addressee
	authentication.Змінити Делеговані права  TEST_Адресат
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На підпис
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	tasks_RMD.Натиснути кнопку  Опрацьовано помічником


Підписати документ адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На підпис
	tasks_RMD.Перевірити статус задачі  ${data['text']}  Опрацьовано помічником
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	tasks_RMD.Натиснути  Підписати
	EDS.Підписати ЄЦП


Відправити документ помічником адресата
	authentication.Завершити сеанс
	authentication.Авторизуватися  assistant_addressee
	authentication.Змінити Делеговані права  TEST_Помічник адресата
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Друк та підпис
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	Номер та дата документа повинні відповідати шаблону
	tasks_RMD.Натиснути  На відправку


Перемістити документ в архів автором
	authentication.Завершити сеанс
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити папку завдань і документів за назвою  На відправку
	tasks_RMD.Відкрити документ за змістом  ${data['text']}
	tasks_RMD.Натиснути  В архів


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	${data}  Create Dictionary
	Set Global Variable  ${data}  ${data}


Заповнити обов'язкові поля документа
	create_document_RMD.Ввести значення в поле  Кореспондент  Міністерство Освіти України
	create_document_RMD.Вибрати елемент з випадаючого списку  Фінальний підписант  TEST_Адресат
	create_document_RMD.Вибрати елемент з випадаючого списку  Автор  TEST_Автор
	create_document_RMD.Вибрати елемент з випадаючого списку  Керівник  TEST_Виконавець 1-го рівня
	Заповнити поле "Зміст повідомлення"


Заповнити поле "Зміст повідомлення"
	${text}  create_sentence  20
	create_document_RMD.Ввести значення в поле  Зміст  ${text}
	Set To Dictionary  ${data}  text  ${text}


Заповнити поле "Зауваження"
	${remark_text}  create_sentence  10
	tasks_RMD.Заповнити поле зауваження  ${remark_text}
	Set To Dictionary  ${data}  remark  ${remark_text}


Номер та дата документа повинні відповідати шаблону
	Select Frame  //*[@class="text-viewer"]/iframe
	${number and status}  Get Text  //table[not(@style)]//td//div[@style]
	${date}  Evaluate  '{:%d.%m.%Y}'.format(datetime.datetime.now())  datetime
	${is match}  Evaluate  re.search(r'№[0-9]+/[0-9]+-[0-9]+ від ${date}', '${number and status}') is not None  re
	Should Be True  ${is match}  Oops! Номер та дата документа не відповідає шаблону