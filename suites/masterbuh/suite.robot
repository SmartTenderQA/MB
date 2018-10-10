*** Settings ***
Documentation    MasterBuh

Library     Selenium2Library
Library     BuiltIn
Library     Collections
Library     DebugLibrary

Suite Setup  Preconditions
Suite Teardown  Postcondition
Test Teardown  Run Keyword If Test Failed  Capture Page Screenshot


*** Variables ***
${browser}                            chrome
${start_page}                         http://192.168.1.205/wsmbtest_all/client/?proj=it_RU&tz=3
${username}                           Адміністратор
${password}
${loading}                            xpath=//table[contains(@id, 'LoadingPanel')]
${catalogs}                           xpath=//div[contains(@class, 'TreeViewContainer')]//*[contains(text(), 'Справочники')]
${add_in_main_menu}                   xpath=(//*[contains(@class, 'dxr-groupList')])[1]//*[contains(text(), 'Добавить')]



*** Test Cases ***
Відкрити сторінку MB та авторизуватися
  [Tags]  analytic_filter
  Відкрити сторінку MB
  Авторизуватися  ${username}  ${password}

Відкрити довідник "Группы товаров, продукции и услуг"
  [Tags]  analytic_filter
  Відкрити розділ довідники
  Відкрити потрібний довідник  Группы товаров, продукции и услуг

Відкрити "Классификатор ресурсов (весь)" та натиснути "Добавить"
  [Tags]  analytic_filter
  Відкрити закладку "Классификатор ресурсов (весь)"
  Натиснути "Добавить" в головному меню

Змінити поле "Счет хранения" на вкладці "Экономика (бух.учет)"
  [Tags]  analytic_filter
  Відкрити вкладку "Экономика (бух.учет)"
  Змінити значення поля "Счет хранения" на  3611 Расчеты с отечественными покупателями за ГП, ТМЦ
  Перевірити відповідність даних після зміни поля "Счет хранения"

Аналітика. Робота з полем "Контрагенты"
  [Tags]  analytic_filter
  Змінити значення поля "Контрагенты" на  ТОВ "Лілія"
  Перевірити відповідність даних після зміни поля "Контрагенты"

Аналітика. Робота з полем "Договоры". "Картотека договоров"
  [Tags]  analytic_filter
  Перейти в поле  Договоры
  Натиснути "Выбор из справочника F10" в полі  Договоры
  Перевірити в "Картотека договоров" наявність договорів з ID  53  54
  Закрити вікно "Картотека договоров"

Аналітика. Робота з полем "Договоры". "Поиск по фильтру"
  [Tags]  analytic_filter
  Перейти в поле  Договоры
  Натиснути "Поиск по фильтру" в полі  Договоры
  Перевірити в "Поиск по фильтру" наявність договорів з ID  53  54



*** Keywords ***
Preconditions
  ${data}  Create Dictionary
  Set Global Variable  ${data}
  Open Browser  ${start_page}  ${browser}

Postcondition
  Close All Browsers

Відкрити сторінку MB
  Go To  ${start_page}
  Location Should Contain  /wsmbtest_all/

Авторизуватися
  [Arguments]  ${username}  ${password}=None
  Вибрати користувача  ${username}
  Ввести пароль  ${password}
  Натиснути кнопку вхід
  Дочекатись загрузки сторінки (МВ)

Вибрати користувача
  [Arguments]  ${username}
  Розкрити список користувачів та вибрати  ${username}

Розкрити список користувачів та вибрати
  [Arguments]  ${username}
  Wait Until Page Contains  Вход в систему  30
  Click Element  xpath=//*[contains(@data-name, 'Login')]
  Wait Until Keyword Succeeds  30s  2s  Click Element  xpath=//*[contains(@class, 'dxeListBoxItem') and contains(text(), '${username}')]

Ввести пароль
  [Arguments]  ${password}
  No Operation
  #Input Text  xpath=//*[contains(@data-name, 'Password')]//input  ${password}

Натиснути кнопку вхід
  Click Element  xpath=//*[contains(text(), 'Войти')]

Дочекатись загрузки сторінки (МВ)
  ${status}  ${message}  Run Keyword And Ignore Error  Wait Until Element Is Visible  ${loading}  5
  Run Keyword If  "${status}" == "PASS"  Run Keyword And Ignore Error  Wait Until Element Is Not Visible  ${loading}  120

Відкрити розділ довідники
  Wait Until Page Contains Element  xpath=//div[@class="TreeViewContainer "]
  Click Element  ${catalogs}
  Wait Until Page Contains Element  xpath=//div[@class="menulistview-header"]//*[contains(text(), 'Справочники')]

Відкрити потрібний довідник
  [Arguments]  ${catalog}
  Click Element  xpath=//*[contains(@class, 'menulistitem')]//*[contains(text(), '${catalog}')]
  Дочекатись загрузки сторінки (МВ)

Натиснути "Добавить" в головному меню
  Click Element  ${add_in_main_menu}
  Дочекатись Загрузки Сторінки (МВ)
  Wait Until Page Contains  Добавление

Відкрити закладку "Классификатор ресурсов (весь)"
  Wait Until Keyword Succeeds  30  3  Click Element  xpath=//div[contains(text(), 'Классификатор ресурсов (весь)')]
  Дочекатись загрузки сторінки (МВ)
  ${status}  Run Keyword And Return Status  Wait Until Element Is Visible  xpath=//*[contains(text(), 'Классификатор ресурсов (весь)')]/ancestor::div[contains(@class, 'active')]  30s
  Run Keyword If  '${status}' == 'True'
  ...  No Operation
  ...  ELSE  Відкрити закладку "Классификатор ресурсов (весь)"


Відкрити вкладку "Экономика (бух.учет)"
  Click Element  xpath=(//*[contains(text(), 'Экономика(бух.учет)')])[1]
  ${status}  Run Keyword And Return Status  Wait Until Element Is Visible  xpath=(//*[contains(text(), 'Экономика(бух.учет)')])[2]  30s
  Run Keyword If  '${status}' == 'True'
  ...  No Operation
  ...  ELSE  Click Element  xpath=(//*[contains(text(), 'Экономика(бух.учет)')])[1]

Змінити значення поля "Счет хранения" на
  [Arguments]  ${text}
  Змінити текст поля "Счет хранения"  ${text}

Змінити текст поля "Счет хранения"
  [Arguments]  ${text}
  Wait Until Keyword Succeeds  30s  3s  Input Text  xpath=//div[@data-name="BS"]//input[1]  ${text}
  Press Key  xpath=//div[@data-name="BS"]//input[1]  \\13
  Дочекатись Загрузки Сторінки (МВ)

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

Змінити значення поля "Контрагенты" на
  [Arguments]  ${text}
  ${field}  Set Variable  xpath=//td[contains(text(), 'Контрагенты')]/following-sibling::td
  ${input_field}  Set Variable  xpath=//td[contains(text(), 'Контрагенты')]/following-sibling::td//input
  Click Element  ${field}
  Sleep  1s
  Click Element  ${field}
  Input Text  ${input_field}  ${text}
  Press Key  ${input_field}  \\13
  Дочекатись Загрузки Сторінки (МВ)

Перевірити відповідність даних після зміни поля "Контрагенты"
  ${title}  Get Text  xpath=//td[contains(text(), 'Контрагенты')]/following-sibling::td
  Should Be Equal  ${title}  Львів ТОВ "Лілія" (83)

Перейти в поле
  [Arguments]  ${title}
  ${field}  Set Variable  xpath=//td[contains(text(), '${title}')]/following-sibling::td
  Click Element  ${field}
  Sleep  1s
  Click Element  ${field}

Натиснути "Выбор из справочника F10" в полі
  [Arguments]  ${title}
  Wait Until Keyword Succeeds  30s  3s  Click Element  xpath=//td[contains(text(), '${title}')]/following-sibling::td//*[contains(@title, 'Выбор из спра')]

Натиснути "Поиск по фильтру" в полі
  [Arguments]  ${title}
  Wait Until Keyword Succeeds  30s  3s  Click Element  xpath=//td[contains(text(), '${title}')]/following-sibling::td//*[contains(@title, 'Поиск элементов')]

Перевірити в "Картотека договоров" наявність договорів з ID
  [Arguments]  ${arg1}  ${arg2}
  Wait Until Page Contains  Картотека договоров  30
  Wait Until Element Is Visible  xpath=//*[contains(@title, 'Уник.номер')]/ancestor::*[contains(@class, 'gridbox-main')]//*[contains(text(), '${arg1}')]
  Wait Until Element Is Visible  xpath=//*[contains(@title, 'Уник.номер')]/ancestor::*[contains(@class, 'gridbox-main')]//*[contains(text(), '${arg2}')]

Закрити вікно "Картотека договоров"
  Click Element  xpath=//*[@alt='Close'][1]
  Дочекатись Загрузки Сторінки (МВ)
  Wait Until Page Contains  Добавление

Перевірити в "Поиск по фильтру" наявність договорів з ID
  [Arguments]  ${arg1}  ${arg2}
  Wait Until Element Is Visible  xpath=(//*[contains(text(), 'Уник.номер')]/ancestor::*[@class="ade-list-back"]//*[contains(text(), '${arg1}')])[1]
  Wait Until Element Is Visible  xpath=(//*[contains(text(), 'Уник.номер')]/ancestor::*[@class="ade-list-back"]//*[contains(text(), '${arg2}')])[1]