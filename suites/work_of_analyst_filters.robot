*** Settings ***
#Resource  ../src/keywords.robot
Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***


#zapusk
#robot --consolecolors on -L TRACE:INFO -d test_output -v browser:chrome -v env:MBTEST_ALL suites/work_of_analyst_filters.robot
*** Test Cases ***
Відкрити довідник "Группы товаров, продукции и услуг"
	start_page.Натиснути "Довідники"
	catalogs.Відкрити довідник за назвою  Группы товаров, продукции и услуг


Відкрити "Классификатор ресурсов (весь)" та натиснути "Добавить"
	resource_classifier.Відкрити закладку за назвою  Классификатор ресурсов (весь)
	main_menu.Вибрати вкладку в головному меню за назвою  ГЛАВНАЯ
	main_menu.Натиснути кнопку в головному меню за назвою  Добавить (F7)


Змінити поле "Счет хранения" на вкладці "Экономика (бух.учет)"
	resource_classifier.Відкрити вкладку в вікні за назвою  Экономика(бух.учет)
	resource_classifier.Заповнити значення поля "Счет хранения"  3611 Расчеты с отечественными покупателями за ГП, ТМЦ
	Перевірити відповідність даних після зміни поля "Счет хранения"


Аналітика. Робота з полем "Контрагенты"
	Run Keyword And Ignore Error  Закрити вспливаюче повідомлення якщо необхідно
	resource_classifier.Заповнити значення поля "Контрагенты"  ТОВ "Лілія"
	Перевірити відповідність даних після зміни поля "Контрагенты"


Аналітика. Робота з полем "Договоры". "Картотека договоров"
	resource_classifier.Натиснути "Выбор из справочника F10" для поля  Договоры
	resource_classifier.Перевірити в "Картотека договоров" наявність договору з ID  53
	resource_classifier.Перевірити в "Картотека договоров" наявність договору з ID  54
	Run Keyword And Ignore Error  Закрити вспливаюче повідомлення якщо необхідно
	resource_classifier.Закрити вікно "Картотека договоров"


Аналітика. Робота з полем "Договоры". "Поиск по фильтру"
	resource_classifier.Натиснути "Поиск по фильтру" в полі  Договоры
	resource_classifier.Перевірити в "Поиск по фильтру" наявність договору з ID  53
	resource_classifier.Перевірити в "Поиск по фильтру" наявність договору з ID  54


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  Адміністратор


Перевірити відповідність даних після зміни поля "Счет хранения"
	${analytics}  Create List  Контрагенты  Договоры  Документы
	${len_parent}  Get Element Count  xpath=//*[@data-name="ANALYTICS_STORAGE"]//div[contains(text(), 'Аналитика')]/ancestor::td/preceding-sibling::*
	${len_parent}  Evaluate  int(${len_parent}) + 1
	${list}  Create List
	:FOR  ${i}  IN RANGE  ${len_parent}
	\  ${i}  Evaluate  int(${i}) + 1
	\  ${value}  Get Text  xpath=((//*[@data-name="ANALYTICS_STORAGE"]//tbody)[2]/tr[@class]//td[${len_parent}])[${i}]
	\  Append To List  ${list}  ${value}
	log  ${list}
	Should Be Equal  ${analytics}  ${list}


Перевірити відповідність даних після зміни поля "Контрагенты"
	${title}  Get Text  xpath=//td[contains(text(), 'Контрагенты')]/following-sibling::td
	Should Be Equal  ${title}  Львів ТОВ "Лілія" (83)


Закрити вспливаюче повідомлення якщо необхідно
	${notification}  Set Variable  //*[@class="instantMessage"]
	${close_btn}  Set Variable  //*[@class="instantMessageClose"]
	Wait Until Element Is Visible  ${notification}
	Mouse Over  ${notification}
	Wait Until Element Is Visible  ${close_btn}
	Click Element  ${close_btn}
