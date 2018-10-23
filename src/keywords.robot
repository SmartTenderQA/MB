*** Settings ***
Library     Selenium2Library
Library     BuiltIn
Library     Collections
Library     DebugLibrary
Library     OperatingSystem
Library     Faker/faker.py



*** Variables ***
${browser}                            chrome
&{url}
...                                   MBTEST_ALL=http://192.168.1.205/wsmbtest_all/client/?proj=it_RU&tz=3
...                                   MBDEMO_ALL=http://192.168.1.205/wsmbdemo_all/client/(S(4jfyvmpjrtsn2ggyct0l0rjc))/Splash?proj=it_UK&tz=3
...                                   BUHETLA2=https://webclient.it-enterprise.com/client/(S(3fxdkqyoyyvaysv2iscf02h3))/?proj=K_BUHETLA2_RU&dbg=1&win=1&tz=3
...                                   BUHGOVA2=https://webclient.it-enterprise.com/client/(S(lnutooqpvguwnrpuuz13utgd))/?proj=K_BUHGOVA2_RU&dbg=1&win=1&tz=3
${loading}                            xpath=//table[contains(@id, 'LoadingPanel')]
${catalogs}                           xpath=//div[contains(@class, 'TreeViewContainer')]//*[contains(text(), 'Справочники')]
${add_in_main_menu}                   xpath=(//*[contains(@class, 'dxr-groupList')])[1]//*[contains(text(), 'Добавить')]
${login_field}                        xpath=//*[@data-name="Login"]//input[not(@type="hidden")]
${pass_field}                         xpath=//*[@data-name="Password"]//input[not(@type='hidden')]

${alies}                              alies
${hub}                                http://autotest.it.ua:4444/wd/hub
${platform}                           ANY



*** Keywords ***
Preconditions
  ${login}  ${password}  Отримати дані проекту  ${env}
  Open Browser  ${url.${env}}  ${browser}  #${alies}  ${hub}  #platformName:${platform}
  Run Keyword If  '${browser}' != 'edge'  Set Window Size  1280  1024


Postcondition
  Close All Browsers


Check Prev Test Status
  ${status}  Set Variable  ${PREV TEST STATUS}
  Run Keyword If  '${status}' == 'FAIL'  Fatal Error  Ой, щось пішло не так! Вимушена зупинка тесту.


Отримати дані проекту
  [Arguments]  ${env}
  ${login}=     get_env_variable  ${env}  login
  Set Global Variable  ${login}
  ${password}=  get_env_variable  ${env}  password
  Set Global Variable  ${password}
  [Return]  ${login}  ${password}


Відкрити сторінку MB
  Go To  ${url.${env}}
  Run Keyword If  '${env}' == 'MBTEST_ALL'  Location Should Contain  /wsmbtest_all/
  Run Keyword If  '${env}' == 'BUHETLA2'    Location Should Contain  _BUHETLA2_
  Run Keyword If  '${env}' == 'BUHGOVA2'    Location Should Contain  _BUHGOVA2_
  Run Keyword If  '${env}' == 'MBDEMO_ALL'  debug


Авторизуватися
  [Arguments]  ${login}  ${password}=None
  Run Keyword  Авторизуватися ${env}  ${login}  ${password}


Авторизуватися BUHETLA2
  [Arguments]  ${login}  ${password}=None
  Wait Until Page Contains  Вход в систему  60
  Вибрати користувача  ${login}
  Ввести пароль  ${password}
  Натиснути кнопку вхід
  Дочекатись загрузки сторінки (MB)


Авторизуватися BUHGOVA2
  [Arguments]  ${login}  ${password}=None
  Wait Until Page Contains  Вход в систему  60
  Вибрати користувача  ${login}
  Ввести пароль  ${password}
  Натиснути кнопку вхід
  Дочекатись загрузки сторінки (MB)


Авторизуватися MBTEST_ALL
  [Arguments]  ${login}  ${password}=None
  Wait Until Page Contains  Вход в систему  30
  Вибрати користувача  ${login}
  Ввести пароль  ${password}
  Натиснути кнопку вхід
  Дочекатись загрузки сторінки (МВ)


Вибрати користувача
  [Arguments]  ${login}
  Input Text  ${login_field}  ${login}
  Press Key  ${login_field}  \\13
  Sleep  .5

Ввести пароль
  [Arguments]  ${password}
  Input Password  ${pass_field}  ${password}


Натиснути кнопку вхід
  Run Keyword  Натиснути кнопку вхід ${env}


Натиснути кнопку вхід BUHETLA2
  Click Element At Coordinates  xpath=(//*[contains(text(), 'Войти')])[1]  -40  0


Натиснути кнопку вхід BUHGOVA2
  Click Element At Coordinates  xpath=(//*[contains(text(), 'Войти')])[1]  -40  0


Натиснути кнопку вхід MBTEST_ALL
  Click Element At Coordinates  xpath=(//*[contains(text(), 'Войти')])[1]  -40  0


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


Scroll Page To Element XPATH
  [Arguments]  ${xpath}
  Run Keyword And Ignore Error  Execute JavaScript  document.evaluate('${xpath.replace("xpath=", "")}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({behavior: 'auto', block: 'center', inline: 'center'});
  Run Keyword And Ignore Error  Execute JavaScript  document.evaluate("${xpath.replace('xpath=', '')}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({behavior: 'auto', block: 'center', inline: 'center'});


Дочекатись загрузки сторінки (MB)
  ${loading_selector}  Set Variable  //img[contains(@class, "loadingImage")]  #//span[@id="LoadingPanel_TL"]  //table[@id="LoadingPanel"]
  ${status}  ${message}  Run Keyword And Ignore Error  Wait Until Element Is Visible  ${loading_selector}  5
  Run Keyword If  "${status}" == "PASS"  Run Keyword And Ignore Error  Wait Until Element Is Not Visible  ${loading_selector}  120


Натиснути кнопку "Выбор"
  Wait Until Page Contains Element  //*[contains(@class, "Text") and contains(text(), "Выбор")]  30
  Click Element  //*[contains(@class, "Text") and contains(text(), "Выбор")]


Обрати категорію меню
  [Arguments]  ${item}
  Wait Until Page Contains Element  //label[contains(@style, "vertical-align") and contains(text(), '${item}')]
  Click Element  //label[contains(text(), '${item}')]


Обрати категорію підменю
  [Arguments]  ${item}
  Wait Until Page Contains Element   //label[contains(@style, "vertical-align") and contains(text(), '${item}')]  30
  Double Click Element  //label[contains(@style, "vertical-align") and contains(text(), '${item}')]
  Дочекатись загрузки сторінки (MB)


Натиснути кнопку
  [Arguments]  ${button_name}
  Wait Until Page Contains Element  //*[@title='${button_name}']  30
  Wait Until Element Is Visible  //*[@title='${button_name}']  30
  Click Element  //*[@title='${button_name}']
  Дочекатись загрузки сторінки (MB)


Перевірити відсутність кнопки
  [Arguments]  ${button_name}
  Page Should Not Contain Element  //*[@title='${button_name}']


Натиснути кнопку форми
  [Arguments]  ${button}  ${window}=${EMPTY}
  ${selector}  Set Variable  ${window}//*[@title='${button}']
  Wait Until Element Is Visible  ${selector}  30
  Sleep  .5
  Click Element  ${selector}
  #Sleep  5
  Дочекатись загрузки сторінки (MB)
  #${status}  Run Keyword And Return Status  Wait Until Element Is Not Visible    ${selector}
  #Run Keyword If  ${status} == ${False}  Натиснути кнопку форми  ${button}


Перевірити що статус поточного документу
  [Arguments]  ${status}
  Set Global Variable  ${active_row_selector}
  ...  //td[contains(@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "rowselected")]/td[3]
  ${text}  Get Text  ${active_row_selector}
  Should Be True  '${text}' == '${status}'


