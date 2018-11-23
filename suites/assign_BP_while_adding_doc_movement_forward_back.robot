*** Settings ***
Resource  ../src/keywords.robot
Library   ../src/data.py
Suite Setup  Preconditions
Suite Teardown  Postcondition
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Capture Page Screenshot


# команда для запуска через консоль
# robot -L TRACE:INFO -A suites/arguments.txt -v browser:chrome -v env:BUHETLA2 suites/assign_BP_while_adding_doc_movement_forward_back.robot
*** Test Cases ***
Відкрити сторінку MB та авторизуватись
  Відкрити сторінку MB
  Дочекатись загрузки сторінки (MB)
  Авторизуватися  ${login}  ${password}


Обрати об'єкт
  Натиснути кнопку "Выбор"
  Дочекатись загрузки сторінки (МВ)


Запустити функцію "Реализация товаров и услуг"
  Обрати категорію меню  Продажи
#  Обрати категорію меню  Документы
  Обрати категорію підменю  Реализация товаров и услуг
  Перевірити найменування інтерфейсу "Реализация товаров и услуг"


Заповнити поля в екрані додати документ
  Підрахувати початкову кількість документів
  Натиснути кнопку  Добавить (F7)
  Дочекатись загрузки сторінки (MB)
  Перевірка сторінки додавання документу
  Заповнити поля для додавання документу
  Натиснути кнопку форми  Добавить  //*[@id="pcModalMode_PW-1" and contains(., 'Добавление. Реестр документов')]
  Обрати режим формування  Ввести вручную
  Перевірити що відкрито форму "Добавление. Строки"


Заповнити поля в екрані "Добавление Строки"
  Ввести дані в поле "Код ТМЦ"
  Ввести кількість
  Ввести вартість
  Ввести код
  Натиснути кнопку форми  Добавить
  Перевірити найменування інтерфейсу "Реализация товаров и услуг"
  Підрахувати поточну кількість документів
  Перевірити що в реєстрі документів з'явилась нова строка
  Перевірити що статус поточного документу  Ввод


Стати курсором на додану строку в закладці «Реестр документов»
  Обрати доданий документ


Проведення документу
  Отримати номер доданого документу
  Натиснути кнопку  Провести (Alt+Right)
  Перевірити проведення документу


Відмінення проведення документу
  Натиснути кнопку  Отменить проведение (Alt+Left)
  Перевірити відміну проведення


Видалення документу
  Натиснути кнопку  Удалить (F8)
  Натиснути кнопку форми  Удалить
  Перевірити видалення документу


*** Keywords ***
Перевірити найменування інтерфейсу "Реализация товаров и услуг"
  Wait Until Page Contains Element  //td[contains (@valign, "top") and contains(text(), "Реестр документов")]  30


Перевірка сторінки додавання документу
  Wait Until Page Contains Element  //li[contains(@class, "activeTab")]/a/span[contains(text(), "Документ")]  30
  ${value}  Get Element Attribute  //span[contains(., "Тип процесса")]/following-sibling::div//input  value
  ${list}  Create List  Акт оказанных услуг _ACTOUTS  Акт оказанных услуг (_ACTOUTS)
  Should Contain Any  ${list}  ${value}


Заповнити поля для додавання документу
  Заповнити поле Контр агента
  Заповнити поле Договір
  Вибрати відповідального


Заповнити поле Контр агента
  ${contractor_selector}  Set Variable  //span[contains(., "Контрагент")]/following-sibling::div//input
  Input Text  ${contractor_selector}  13356
  Press Key  ${contractor_selector}  \\09
   Дочекатись загрузки сторінки (МВ)


Заповнити поле Договір
  ${agreement_selector}  Set Variable  //span[contains(., "Договор")]/following-sibling::div//input
  Input Text  ${agreement_selector}  *
  Press Key  ${agreement_selector}  \\09
  Sleep  .5


Вибрати відповідального
  ${responsible_selector}  Set Variable  //span[contains(., "Ответственный")]/following-sibling::div//input
  ${responsible_dropdown_selector}  Set Variable
  ...  //span[contains(., "Ответственный")]/following-sibling::div//td[contains(@title, "Поиск элементов по введенному")]
  ${cell_selector}  Set Variable  //div[contains(@class, "combo_cell_text")]
  Wait Until Keyword Succeeds  15  3  Click Element  ${responsible_selector}
  Wait Until Element Is Visible  ${responsible_dropdown_selector}  15
  Sleep  .5
  :FOR  ${i}  IN RANGE  10
  \  Wait Until Keyword Succeeds  16  2  Click Element  ${responsible_dropdown_selector}
  \  ${status}  Run Keyword And Return Status  Wait Until Element Is Visible  ${cell_selector}
  \  Exit For Loop If  ${status} == ${True}
  Sleep  2
  Click Element  ${cell_selector}
  Sleep  1
  Дочекатись загрузки сторінки (MB)


Обрати режим формування
  [Arguments]  ${mode}
  ${status}  Run Keyword And Return Status  Wait Until Page Contains Element  //span[contains(text(), '${mode}')]  2
  Run Keyword If  ${status} == ${True}  Run Keywords
  ...  Click Element  //span[contains(text(), '${mode}')]
  ...  AND  Дочекатись загрузки сторінки (WB)


Підрахувати початкову кількість документів
  ${quantity}  Get Element Count
  ...  //td[contains (@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "Row")]
  Set Global Variable  ${initial_documents_quantity}  ${quantity}


Перевірити що відкрито форму "Добавление. Строки"
  Wait Until Page Contains Element  //span[contains(., "Добавление. Строки")]  45
  Click Element  (//li/a/span[contains(., "Параметры")])[2]
  ${value}  Get Element Attribute  (//span[contains(., "Тип строки")]/following-sibling::table//input)[2]  value
  Should Be Equal  Услуги оказанные  ${value}


Ввести дані в поле "Код ТМЦ"
  ${TMC_code_selector}  Set Variable  (//table[@class="dhxcombo_outer"])[3]//input
  Wait Until Page Contains Element  ${TMC_code_selector}  30
  Input Text  ${TMC_code_selector}  200200000000016
  Sleep  2
  Press Key  ${TMC_code_selector}  \\09
  Sleep  3
  ${TMC_code}  Get Element Attribute  ${TMC_code_selector}  value
  ${status}  Run Keyword And Return Status  Should Be Equal  '${TMC_code}'  'Аренда помещения (200200000000016)'
  Run Keyword If  ${status} == ${False}  Ввести дані в поле "Код ТМЦ"


Ввести кількість
  ${quantity_selector}  Set Variable  //table[@data-name="KOL"]//input
  Wait Until Element Is Visible  ${quantity_selector}  30
  Input Text  ${quantity_selector}  1
  Press Key  ${quantity_selector}  \\09
  Дочекатись загрузки сторінки (MB)
  Sleep  2


Ввести вартість
  ${price_selector}  Set Variable  //table[@data-name="CENA_1VAL"]//input
  Input Text  ${price_selector}  4000
  Sleep  1
  Press Key  ${price_selector}  \\09
  Sleep  2
  Дочекатись загрузки сторінки (MB)


Ввести код
  ${code_selector}  Set Variable  (//td[contains(@class, "editable")])//input
  Wait Until Element Is Visible  (//td[@class="cellselected"])[3]  30
  :FOR  ${i}  IN RANGE  10
  \  Click Element  (//td[@class="cellselected"])[3]
  \  Sleep  1
  \  ${status}  Run Keyword And Return Status  Wait Until Element Is Visible  ${code_selector}
  \  Exit For Loop If  ${status} == ${true}
  Wait Until Element Is Enabled  ${code_selector}  30
  Input Text  ${code_selector}  D0201
  Press Key  ${code_selector}  \\09
  Sleep  4


Підрахувати поточну кількість документів
  ${quantity}  Get Element Count
  ...  //td[contains (@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "Row")]
  Set Global Variable  ${current_documents_quantity}  ${quantity}


Перевірити що в реєстрі документів з'явилась нова строка
  Should Be True  ${current_documents_quantity} == (${initial_documents_quantity} + 1)


Перевірити проведення документу
  Дочекатись загрузки сторінки (MB)
  Перевірити що статус поточного документу  Проведен
  Перевірити відсутність кнопки  Провести (Alt+Right)


Перевірити відміну проведення
  Дочекатись загрузки сторінки (MB)
  Перевірити що статус поточного документу  Ввод
  Перевірити відсутність кнопки  Отменить проведение (Alt+Left)
  Page Should Contain Element  //*[@title="Провести (Alt+Right)"]


Перевірити видалення документу
  Підрахувати поточну кількість документів
  Should Be True  ${current_documents_quantity} == ${initial_documents_quantity}
  ${dock_number}  Get Text  ${active_row_selector}/following-sibling::*[32]
  Should Be True  ${added_dock_number} != ${dock_number}


Обрати доданий документ
  Click Element  ${active_row_selector}


Отримати номер доданого документу
  ${current_dock number}  Get Text  ${active_row_selector}/following-sibling::*[32]
  Set Global Variable  ${added_dock_number}   ${current_dock number}
