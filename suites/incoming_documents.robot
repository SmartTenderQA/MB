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
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v platform:WIN10 -v browser:chrome -v env:BUHGOVA2_RMD suites/incoming_documents.robot
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v browser:firefox suites/incoming_documents.robot
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v env:MBDEMOGOV_DLP -v browser:chrome -v env:BUHGOVA2_RMD suites/incoming_documents.robot
...  - robot --consolecolors on -L TRACE:INFO -d test_output -v env:MBDEMOGOV_DLP -v browser:firefox suites/incoming_documents.robot

Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***


*** Test Cases ***
Додати "Вхідний документ" Автором
	authentication.Авторизуватися  author
	start_page_RMD.Натиснути "Завдання і документи"
	main_menu_RMD.Вибрати вкладку в головному меню за назвою  Задачі
	tasks_RMD.Відкрити випадаючий список "Додати документ"
	tasks_RMD.Вибрати тип документа за назвою  Вхідні від АПУ, ВРУ, КМУ, РНБО
	Заповнити обов'язкові поля документа
	create_document_RMD.Натиснути "Додати"
	Натиснути "Скасувати" друк штрих-коду
	tasks_detail_RMD.Натиснути з умовою  Додати (F7)  Вхідний лист (INBOX)
	Додати файл "Вхідний лист (INBOX)"
	tasks_detail_RMD.Натиснути передати  На резолюцію


Додати задачу та опрацювати документ Помічником адресата
	authentication.Завершити сеанс
	authentication.Авторизуватися  assistant_addressee
	authentication.Змінити Делеговані права  TEST_Адресат
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На резолюцію
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Додати задачу
	create_task_RMD.Заповнити поле "Зміст задачі" випадковим текстом
	create_task_RMD.Ввести текст в поле "Виконавець"  TEST_Виконавець 1-го рівня
	create_task_RMD.Ввести текст в поле "Співвиконавці"  TEST_Cпіввиконавець 1-го рівня
	create_task_RMD.Ввести текст в поле "До відома"  TEST_До відома 1-го рівня
	create_task_RMD.Натиснути "Додати"
	tasks_detail_RMD.Натиснути кнопку  Опрацьовано помічником


Повернути документ помічнику адресата Адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На резолюцію
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Скасувати обробку помічником


Змінити зміст задачі Помічником адресата
	authentication.Завершити сеанс
	authentication.Авторизуватися  assistant_addressee
	#authentication.Змінити Делеговані права  TEST_Адресат
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На резолюцію
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Відкрити документ за змістом  ${data['task']['text']}
	create_task_RMD.Заповнити поле "Зміст задачі" випадковим текстом
	create_task_RMD.Натиснути "Додати"
	tasks_detail_RMD.Натиснути кнопку  Опрацьовано помічником


Погодити документ Адресатом
	authentication.Завершити сеанс
	authentication.Авторизуватися  addressee
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На резолюцію
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути передати  Підписати
	EDS_RMD.Підписати ЄЦП
	#todo blocker


Поставити на контроль документ Контролюючим
	authentication.Завершити сеанс
	authentication.Авторизуватися  supervisory
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  Постановка на контроль
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_RMD.Відкрити документ за змістом  ${data['task']['text']}
	create_task_RMD.Поставити задачу на контроль
	create_task_RMD.Натиснути "Додати"
	tasks_detail_RMD.Натиснути передати  На виконання



Додати дочірну задачу та виконати головну задачу Виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Додати задачу
	create_task_RMD.Заповнити поле "Зміст задачі" випадковим текстом
	create_task_RMD.Ввести текст в поле "Виконавець"  TEST_Підлеглий виконавця
	create_task_RMD.Ввести текст в поле "До відома"  TEST_Підлеглий виконавця до відома
	create_task_RMD.Натиснути "Додати"
	tasks_detail_RMD.Натиснути кнопку  Виконати
	Element Should Be Visible  //div[@class="message" and contains(.,'Завдання буде закрито автоматично після виконання завдань підлеглими!')]


Додати дочірну задачу Співвиконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  co_performer_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Додати задачу
	create_task_RMD.Заповнити поле "Зміст задачі" випадковим текстом
	create_task_RMD.Ввести текст в поле "Виконавець"  TEST_Підлеглий співвиконавця
	create_task_RMD.Натиснути "Додати"


Виконати задачу Підлеглим співвиконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_co_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати


Виконати задачу Співвиконавцем
	authentication.Завершити сеанс
	authentication.Авторизуватися  co_performer_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати


Виконати задачу Підлеглим виконавця
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати
	Element Should Be Visible  //div[@class="message" and contains(.,'Завдання буде закрито автоматичн')]
	tasks_detail_RMD.Натиснути кнопку  Прив'язати документ
	#todo


Виконати задачу Підлеглим виконавця до відома
	authentication.Завершити сеанс
	authentication.Авторизуватися  subordinate_executor_to_attention
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати


Повернути документ виконавцю 1-го рівня Контролюючим
	authentication.Завершити сеанс
	authentication.Авторизуватися  supervisory
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На підтвердження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Відхилити
	tasks_detail_RMD.Заповнити поле "Примітка"
	elements.Натиснути в валідаційному вікні  Примітка  OK


Виконати задачу Виконавцем 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  executor_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Перевірити статус задачі  ${data['document']['text']}  Виконано підлеглим
	tasks_RMD.Перевірити статус задачі  ${data['document']['text']}  Відхилено контролюючим
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати


Затвердити документ Контролюючим
	authentication.Завершити сеанс
	authentication.Авторизуватися  supervisory
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  На підтвердження
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	#todo


Виконати документ До відома 1-го рівня
	authentication.Завершити сеанс
	authentication.Авторизуватися  to_attention_1
	start_page_RMD.Натиснути "Завдання і документи"
	tasks_RMD.Відкрити папку завдань і документів за назвою  До розгляду / виконання / ознайомлення
	tasks_RMD.Відкрити документ за змістом  ${data['document']['text']}
	tasks_detail_RMD.Натиснути кнопку  Виконати


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
	create_document_RMD.Заповнити поле "Номер вихідного документа" випадковими даними
	create_document_RMD.Заповнити поле "Дата вихідного документа" сьогоднішньою датою
	create_document_RMD.Ввести значення в поле  Кореспондент  Міністерство Освіти України
	create_document_RMD.Вибрати елемент з випадаючого списку  Адресати по документу  TEST_Адресат
	create_document_RMD.Заповнити поле "Зміст документа" випадковим текстом
	create_document_RMD.Ввести значення в поле  Вид доставки  Інше


Натиснути "Скасувати" друк штрих-коду
	${message box}  Set Variable  //*[@class='message-box-wrapper']
	elements.Дочекатися відображення елемента на сторінці  ${message box}
	elements.Дочекатися відображення елемента на сторінці  ${message box}//*[contains(text(),'Скасувати')]
	Click Element  ${message box}//*[contains(text(),'Скасувати')]
	Sleep  .5
	Click Element  ${message box}//*[contains(text(),'Скасувати')]
	Дочекатись закінчення загрузки сторінки RMD


Додати файл "Вхідний лист (INBOX)"
	${add doc box}  Set Variable  //*[@class="dhxwin_active menuget"]
	elements.Дочекатися відображення елемента на сторінці  ${add doc box}
	${doc}  create_fake_doc
	Choose File  ${add doc box}//input[@id='fileUpload']  ${doc[0]}
	elements.Дочекатися відображення елемента на сторінці  ${add doc box}//*[contains(text(),'${doc[1]}')]
	Click Element  ${add doc box}//*[contains(text(),'OK')]
	Дочекатись закінчення загрузки сторінки RMD