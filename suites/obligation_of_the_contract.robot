*** Settings ***
Metadata  Команда запуска
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2 -v platform:WIN10 -v browser:chrome suites/obligation_of_the_contract.robot
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:MBDEMOGOV_ALL -v platform:WIN10 -v browser:chrome suites/obligation_of_the_contract.robot

Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  TestTeardown


*** Variables ***
&{data}
&{dog number}
...                BUHGOVA2=1621
...                MBDEMOGOV_ALL=214
&{user}
...                BUHGOVA2=Администратор
...                MBDEMOGOV_ALL=Адміністратор


*** Test Cases ***
Створити новий документ за зразком
    supply_contracts.Пошук по полю в основному вікні  Унік.номер  ${dog number['${env}']}
    supply_contracts.Вибрати рядок в основному вікні за номером  1
    supply_contracts.Активувати вкладку  В розрізі аналітик
    supply_contracts.Вибрати рядок "В разрезе аналитик" за номером  2
    main_menu.Натиснути кнопку в головному меню за назвою  На підставі (Shift+F7)
    main_menu.Натиснути на кнопку "Юридическое обязательтво"
    Вказати довільний номер документу
    Зберегти дані документу
    elements.Натиснути кнопку у вікні  Коригування  Зберегти
    main_menu.Вийти з функції


Знайти документ в "Реестр документов | Юридические обязательства"
    catalogs.Відкрити довідник за назвою  Юридичні/фінансові зобов'язання
	Очистити поля з датою
	elements.Операція над чекбоксом  Зобов'язання  							Select
	elements.Операція над чекбоксом  Зобов'язання 							Unselect
	elements.Операція над чекбоксом  Юридичні зобов'язання (_LEGAL_OBL)  	Select
	Перевірити що вибрано тільки один фільтр
	elements.Натиснути кнопку у вікні  Умова відбору документів  Встановити
    supply_contracts.Активувати вкладку  Реєстр документів | Юридичні зобов'язання
    documents_register.Пошук по полю в основному вікні  № документу  ${data['doc number']}
    documents_register.Вибрати рядок в основному вікні за номером  1
    Перевірити результат пошуку


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
	Перейти в інтерфейс "Договоры | Картотека"


Перейти в інтерфейс "Договоры | Картотека"
	start_page.Натиснути "Банк"
	catalogs.Відкрити довідник за назвою  Договори постачання
	supply_contracts.Активувати вкладку   Договори | Картотека


TestTeardown
	Run Keyword If Test Failed  Run Keywords
	...  Capture Page Screenshot  AND
	...  Log Location


Вказати довільний номер документу
    ${num}  service.get_some_uuid
    (detail)Реестр документов.Ввести значення в поле  Номер документа  ${num[:8]}


Зберегти дані документу
    ${doc number}  (detail)Реестр документов.Отримати значення поля  Номер документа
    ${doc date}    (detail)Реестр документов.Отримати значення поля  Документ от
    ${partner}     (detail)Реестр документов.Отримати значення поля  Контрагент
    Set To Dictionary  ${data}  doc number  ${doc number}
    Set To Dictionary  ${data}  doc date    ${doc date}
    Set To Dictionary  ${data}  partner     ${partner}


Очистити поля з датою
    Clear input By JS  //*[@data-name="DATEFROM"]//input
    Clear input By JS  //*[@data-name="DATETO"]//input


Перевірити що вибрано тільки один фільтр
    ${count}  Get Element Count  //*[@data-name="TREEKDMT"]//input[@type="checkbox"][@checked]
    Should Be Equal As Strings  ${count}  1  Вибрано більш ніж один фільтр


Перевірити результат пошуку
    main_menu.Натиснути кнопку в головному меню за назвою  Змінити (F4)
    ${doc number}  (detail)Реестр документов.Отримати значення поля  Номер документа
    ${doc date}    (detail)Реестр документов.Отримати значення поля  Документ от
    ${partner}     (detail)Реестр документов.Отримати значення поля  Контрагент
    Should Be Equal  ${data['doc number']}  ${doc number}
    Should Be Equal  ${data['doc date']}    ${doc date}
    Should Be Equal  ${data['partner']}     ${partner}
    elements.Натиснути кнопку у вікні  Коригування  Скасувати