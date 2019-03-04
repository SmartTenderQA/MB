*** Settings ***
Metadata  Команда запуска
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2 -v platform:WIN10 -v browser:chrome suites/creation_document_of_legal_obligation_by_estimate.robot
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:MBDEMOGOV_ALL -v platform:WIN10 -v browser:chrome suites/creation_document_of_legal_obligation_by_estimate.robot

Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  TestTeardown


*** Variables ***
&{test_data}
&{user}
...                BUHGOVA2=Администратор
...                MBDEMOGOV_ALL=Адміністратор


*** Test Cases ***
Створити документ
	supply_contracts.Активувати вкладку  Реєстр документів | Юридичні зобов'язання

	${value}  Evaluate  str(float('{:.2f}'.format(random.uniform(0.01, 99999.99))))  random
	${doc number}   service.get_some_uuid

	main_menu.Натиснути кнопку в головному меню за назвою  Додати (F7)
	(detail)Реестр документов.Ввести значення в поле  Номер документа  ${doc number}

	${stewerd}  		Вибрати любе доступне значення для поля  Распорядитель
	${bank1}  			Вибрати любе доступне значення для поля  Банк1
	${counterparty}  	Вибрати любе доступне значення для поля  Контрагент
	${bank2}  			Вибрати любе доступне значення для поля  Банк2

						Вибрати елемент з фіксованого випадаючого списку  Тип документа  Кошторис
						wait until keyword succeeds  10  .5  (detail)Реестр документов.Ввести значення в поле  Сумма  ${value}
	${NDS}  			Вибрати випадковий елемент з фіксованого випадаючого списку  Ставка НДС
	${analytics code}  	Вибрати любе доступне значення для поля  Код аналитики
	${KEKB}  			Вибрати любе доступне значення для поля  КЕКВ

	Set To Dictionary  ${test_data}
	...  Номер документа=${doc number}
	...  Распорядитель=${stewerd}
	...  Банк1=${bank1}
	...  Банк2=${bank2}
	...  Контрагент=${counterparty}
	...  Тип документа=Кошторис
	...  Сумма=${value}
	...  Ставка НДС=${NDS}
	...  Код аналитики=${analytics code}
	...  КЕКВ=${KEKB}
	Log  ${test_data}
	Capture Page Screenshot
	elements.Натиснути кнопку у вікні  Додавання. Реєстр документів  Додати


Перевірка данних створеного документа
	documents_register.Пошук по полю в основному вікні  № документу  ${test_data[u'Номер документа']}
    documents_register.Вибрати рядок в основному вікні за номером  1
	main_menu.Натиснути кнопку в головному меню за назвою  Змінити (F4)
	:FOR  ${field}  IN
	...  Номер документа
	...  Распорядитель
	...  Банк1
	...  Банк2
	...  Контрагент
	...  Тип документа
	...  Сумма
	...  Ставка НДС
	...  Код аналитики
	...  КЕКВ
	\  ${got value}  (detail)Реестр документов.Отримати значення поля  ${field}
	\  Should Be Equal  "${test_data[u"${field}"]}"  "${got value}"
	elements.Натиснути кнопку у вікні  Коригування. Реєстр документів  Скасувати
	[Teardown]  Run Keyword If Test Failed  Run Keywords
	...  TestTeardown  AND
	...  elements.Натиснути кнопку у вікні  Коригування. Реєстр документів  Скасувати  AND
	...  main_menu.Натиснути кнопку в головному меню за назвою  Видалити (F8)  AND
    ...  elements.Натиснути кнопку у вікні  Видалення. Реєстр документів  Видалити



Перевести документ по стадіям
    main_menu.Натиснути кнопку в головному меню за назвою  Надіслати вперед (Alt+Right)
	documents_register.Стадія поточного документа повинна бути  Виконання
    main_menu.Натиснути кнопку в головному меню за назвою  Повернути назад (Alt+Left)
	documents_register.Стадія поточного документа повинна бути  Проект
	[Teardown]  Run Keyword If Test Failed  Run Keywords
	...  TestTeardown  AND
	...  main_menu.Натиснути кнопку в головному меню за назвою  Видалити (F8)  AND
    ...  elements.Натиснути кнопку у вікні  Видалення. Реєстр документів  Видалити


Видалення документа
    main_menu.Натиснути кнопку в головному меню за назвою  Видалити (F8)
    elements.Натиснути кнопку у вікні  Видалення. Реєстр документів  Видалити
    Run Keyword And Expect Error  *not found*  documents_register.Вибрати рядок в основному вікні за номером  1


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  ${user['${env}']}
	start_page.Натиснути "Банк"
	catalogs.Відкрити довідник за назвою  Юридичні/фінансові зобов'язання
	Очистити поля з датою
	Операція над списком чекбоксів   Розгорнути
	elements.Операція над чекбоксом  Зобов'язання  							Select
	elements.Операція над чекбоксом  Зобов'язання 							Unselect
	elements.Операція над чекбоксом  Юридичні зобов'язання (_LEGAL_OBL)  	Select
	Перевірити що вибрано тільки один фільтр
	elements.Натиснути кнопку у вікні  Умова відбору документів  Встановити
	Wait Until Keyword Succeeds  10  .5
	...  Page Should Contain  Реєстр документів | Юридичні зобов'язання


TestTeardown
	Run Keyword If Test Failed  Run Keywords
	...  Capture Page Screenshot  AND
	...  Log Location


Перейти в інтерфейс "Договоры | Картотека"
	start_page.Натиснути "Банк"
	catalogs.Відкрити довідник за назвою  Договоры поставок
	supply_contracts.Активувати вкладку   Договоры | Картотека


Зберегти дані документу
    ${doc number}  Get Element Attribute  //*[@data-name="NDM"]//input  value
    ${doc date}    Get Element Attribute  //*[@data-name="DDM"]//input  value
    ${partner}     Get Element Attribute  //*[@data-name="ORG"]//input[not(@type="hidden")]  value
    Set To Dictionary  ${data}  doc number  ${doc number}
    Set To Dictionary  ${data}  doc date    ${doc date}
    Set To Dictionary  ${data}  partner     ${partner}


Очистити поля з датою
    Clear input By JS  //*[@data-name="DATEFROM"]//input
    Clear input By JS  //*[@data-name="DATETO"]//input


Перевірити що вибрано тільки один фільтр
    ${count}  Get Element Count  //*[@data-name="TREEKDMT"]//input[@type="checkbox"][@checked]
    Should Be Equal As Strings  ${count}  1  Вибрано більш ніж один фільтр


Операція над списком чекбоксів
	[Arguments]  ${action}
	${locator}
	...  run keyword if  '${action}' == 'Розгорнути'  set variable  //*[@alt="[Розгорнути]"]
	...  ELSE IF         '${action}' == 'Згорнути'    set variable  //*[@alt="[Колапс]"]
	${status}  run keyword and return status  element should be visible  ${locator}
	run keyword if  ${status}  run keywords
	...  click element  ${locator}  AND
	...  wait until page does not contain element  ${locator}


