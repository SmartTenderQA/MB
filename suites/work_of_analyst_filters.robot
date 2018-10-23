*** Settings ***
Resource  ../src/keywords.robot
Library   ../src/data.py
Suite Setup  Preconditions
Suite Teardown  Postcondition
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Capture Page Screenshot



*** Test Cases ***
Відкрити сторінку MB та авторизуватися
  Відкрити сторінку MB
  Авторизуватися  ${login}  ${password}


Відкрити довідник "Группы товаров, продукции и услуг"
  Відкрити розділ довідники
  Відкрити потрібний довідник  Группы товаров, продукции и услуг


Відкрити "Классификатор ресурсов (весь)" та натиснути "Добавить"
  Відкрити закладку "Классификатор ресурсов (весь)"
  Натиснути "Добавить" в головному меню


Змінити поле "Счет хранения" на вкладці "Экономика (бух.учет)"
  Відкрити вкладку "Экономика (бух.учет)"
  Змінити значення поля "Счет хранения" на  3611 Расчеты с отечественными покупателями за ГП, ТМЦ
  Перевірити відповідність даних після зміни поля "Счет хранения"


Аналітика. Робота з полем "Контрагенты"
  Змінити значення поля "Контрагенты" на  ТОВ "Лілія"
  Перевірити відповідність даних після зміни поля "Контрагенты"


Аналітика. Робота з полем "Договоры". "Картотека договоров"
  Перейти в поле  Договоры
  Натиснути "Выбор из справочника F10" в полі  Договоры
  Перевірити в "Картотека договоров" наявність договорів з ID  53  54
  Закрити вікно "Картотека договоров"


Аналітика. Робота з полем "Договоры". "Поиск по фильтру"
  Перейти в поле  Договоры
  Натиснути "Поиск по фильтру" в полі  Договоры
  Перевірити в "Поиск по фильтру" наявність договорів з ID  53  54




*** Keywords ***
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
  Sleep  .5
  Press Key  xpath=//div[@data-name="BS"]//input[1]  \\13
  Sleep  1
  Дочекатись Загрузки Сторінки (МВ)
  ${new value}  Get Element Attribute  xpath=//div[@data-name="BS"]//input[1]  value
  Run Keyword If  "${text}" != "${new value}"  Змінити текст поля "Счет хранения"  ${text}

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
  Дочекатись загрузки сторінки (МВ)
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
