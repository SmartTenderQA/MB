*** Settings ***
Metadata  Команда запуска
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_new -v platform:WIN10 -v browser:chrome suites/obligation_of_the_contract.robot

Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location

*** Variables ***
&{data}


*** Test Cases ***
Створити новий документ за зразком
    supply_contracts.Пошук по полю "Уникальный номер договора"  1606
    supply_contracts.Активувати вкладку  В разрезе аналитик
    supply_contracts.Вибрати рядок "В разрезе аналитик" за номером  2
    main_menu.Натиснути кнопку в головному меню за назвою  На основании (Shift+F7)
    main_menu.Натиснути на кнопку "Юридическое обязательтво"
    Зберегти дані документу
    elements.Натиснути "Сохранить" у вікні  Корректировка
    main_menu.Натиснути кнопку в головному меню за назвою  Выход из функции


Знайти документ в "Реестр документов | Юридические обязательства"
    catalogs.Відкрити довідник за назвою  Финансовые обязательства






*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  BUHGOVA2_new
	Перейти в інтерфейс "Договоры | Картотека"


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



