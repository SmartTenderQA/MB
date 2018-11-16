*** Settings ***
Resource  ../src/keywords.robot
Library   ../src/data.py
Suite Setup  Preconditions
Suite Teardown  Postcondition
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Capture Page Screenshot


# команда для запуска через консоль
# robot -L TRACE:INFO -A suites/arguments.txt -v browser:chrome -v env:BUHGOVA2 suites/assignment_of_BP_when_adding_document.robot
*** Test Cases ***
Відкрити сторінку MB та авторизуватись
  Відкрити сторінку MB
  Авторизуватися  ${login}  ${password}


Запустити функцію "Оприходования ТМЦ"
  Обрати категорію меню     Склад
#  Обрати категорію меню     Документы
  Обрати категорію підменю  Оприходование ТМЦ
  Підтвердити "Условия отбора" за необхіднітсю
  Перевірити найменування інтерфейсу "Оприходование ТМЦ"


Відкрити вікно додавання документа
  Натиснути кнопку  Добавить (F7)
  Перевірити вікно додавання документа в "Реестр документов"


Заповнити поля на вкладці "Документ"
  Підрахувати початкову кількість документів
  Заповнити поле  Склад       21
  Заповнити поле  Контрагент  89
  Заповнити поле  Договор     01256
  Натиснути кнопку форми  Добавить


Заповнити поля у вікні "Добавление. Строки"
  Обрати режим формування  Ввести вручную
  Заповнити поле  Код ТМЦ     1812000000000AP
  Заповнити поле  Кол.факт    10
  Заповнити поле  ГРН:        52
  Заповнити код   Программная классиф. расходов и кредитов. бюджета  6121010
  Заповнити код   Фонд  01
  Заповнити код   Коды экономической классификации расходов  2210


Додати документ та перевірити успішність його створення
  Натиснути кнопку форми  Добавить
  Підрахувати поточну кількість документів
  Перевірити що в реєстрі документів з'явилась нова строка
  Перевірити що стадія поточного документу  Ввод


Стати курсором на додану строку в закладці «Реестр документов»
  Обрати доданий документ


Провести поточний документ
  Отримати номер доданого документу
  Натиснути Кнопку  Провести
  Перевірити проведення документу


Відмінення проведення документу
  Натиснути кнопку  Отменить проведение (Alt+Left)
  Перевірити відміну проведення


Видалення документу
  Натиснути кнопку  Удалить (F8)
  Натиснути кнопку форми  Удалить
  Перевірити видалення документу



*** Keywords ***
Перевірити найменування інтерфейсу "Оприходование ТМЦ"
  Wait Until Page Contains Element  //td[contains (@valign, "top") and contains(text(), "Реестр документов")]  20


Підтвердити "Условия отбора" за необхіднітсю
  ${status}  Run Keyword And Return Status  Wait Until Page Contains  Условие отбора  1
  Run Keyword If  '${status}' == 'True'  Click Element  xpath=//*[@title="Установить"]
  Дочекатись загрузки сторінки (МВ)


Перевірити вікно додавання документа в "Реестр документов"
  Перевірити що активна вкладка "Документ"
  Перевірити тип процессу за замовчуванням


Перевірити що активна вкладка "Документ"
  Page Should Contain Element  xpath=//*[contains(@class, 'activeTab')]//*[text()='Документ']


Перевірити тип процессу за замовчуванням
  ${type text}  Get Element Attribute  xpath=//*[@data-name="KDMT"]//input[@type="text"]  value
  Should Contain Any  ${type text}  Приход ТМЦ от поставщика _COM_SUPBG  Приход ТМЦ от поставщика (_COM_SUPBG)


Заповнити поле
  [Arguments]  ${field}  ${text}
  ${locators}  Create Dictionary  #ставим обратную косую перед знаком равно  (\=)
  ...  Склад         xpath\=//*[@data-name\="CEH_K"]//input[@type\="text"]
  ...  Контрагент    xpath\=//*[@data-name\="ORG"]//input[@type\="text"]
  ...  Договор       xpath\=//*[@data-name\="UNDOG"]//input[@type\="text"]
  ...  Код ТМЦ       xpath\=//*[@data-name\="KMAT"]//input[@type\="text"]
  ...  Кол.факт      xpath\=//*[@data-name\="KOL"]//input[@type\="text"]
  ...  ГРН:          xpath\=//*[@data-name\="CENA_1VAL"]//input[@type\="text"]
  ${selector}  Get From Dictionary  ${locators}  ${field}
  Wait Until Keyword Succeeds  10  2  Click Element  ${selector}
  Sleep  .5
  Input Text  ${selector}  ${text}
  Sleep  .5
  Press Key  ${selector}  \\09
  Sleep  .5


Заповнити код
  [Arguments]  ${field}  ${value}
  ${selector}  Set Variable  xpath=(//*[contains(text(), "${field}")]/following-sibling::td)[2]
  Click Element  ${selector}
  Sleep  .5
  Click Element  ${selector}
  Sleep  .5
  Input Text  ${selector}//input  ${value}

Підрахувати початкову кількість документів
  ${quantity}  Get Element Count
  ...  //td[contains (@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "Row")]
  Set Global Variable  ${initial_documents_quantity}  ${quantity}


Підрахувати поточну кількість документів
  ${quantity}  Get Element Count
  ...  //td[contains (@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "Row")]
  Set Global Variable  ${current_documents_quantity}  ${quantity}


Перевірити що в реєстрі документів з'явилась нова строка
  Should Be True  ${current_documents_quantity} == (${initial_documents_quantity} + 1)


Перевірити що стадія поточного документу
  [Arguments]  ${status}
  Set Global Variable  ${active_row_selector}
  ...  //td[contains(@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "rowselected")]/td[2]
  ${text}  Get Text  ${active_row_selector}
  Should Be True  '${text}' == '${status}'


Обрати режим формування
  [Arguments]  ${mode}
  ${status}  Run Keyword And Return Status  Wait Until Page Contains Element  //span[contains(text(), '${mode}')]  2
  Run Keyword If  ${status} == ${True}  Run Keywords
  ...  Click Element  //span[contains(text(), '${mode}')]
  ...  AND  Дочекатись загрузки сторінки (WB)

Перевірити проведення документу
  Дочекатись загрузки сторінки (MB)
  Перевірити що стадія поточного документу  Проведен
  Перевірити відсутність кнопки  Провести (Alt+Right)


Перевірити відміну проведення
  Дочекатись загрузки сторінки (MB)
  Перевірити що стадія поточного документу  Ввод
  Перевірити відсутність кнопки  Отменить проведение (Alt+Left)
  Page Should Contain Element  //*[@title="Провести (Alt+Right)"]


Перевірити видалення документу
  Підрахувати поточну кількість документів
  Should Be True  ${current_documents_quantity} == ${initial_documents_quantity}
  ${dock_number}  Get Text  ${active_row_selector}/following-sibling::*[3]
  Should Be True  ${added_dock_number} != ${dock_number}


Обрати доданий документ
  Click Element  ${active_row_selector}


Отримати номер доданого документу
  ${current_dock number}  Get Text  ${active_row_selector}/following-sibling::*[3]
  Set Global Variable  ${added_dock_number}   ${current_dock number}
