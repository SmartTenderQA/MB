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
  Open Browser  ${url.${env}}  ${browser}  ${alies}  ${hub}  #platformName:${platform}
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
  Wait Until Page Contains  Вход в систему  60
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
  Wait Until Element Is Visible  //*[contains(@title,'${button_name}')]  30
  Wait Until Keyword Succeeds  10  2  Click Element  //*[contains(@title,'${button_name}')]
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
  Дочекатись загрузки сторінки (MB)


Перевірити що статус поточного документу
  [Arguments]  ${status}
  Set Global Variable  ${active_row_selector}
  ...  //td[contains(@valign, "top") and contains(text(), "Строки")]/preceding::tr[contains(@class, "rowselected")]/td[3]
  ${text}  Get Text  ${active_row_selector}
  Should Be True  '${text}' == '${status}'


Input Type Flex
  [Arguments]    ${locator}    ${text}
  [Documentation]    write text letter by letter
  ${items}    Get Length    ${text}
  : FOR    ${item}    IN RANGE    ${items}
  \    Press Key    ${locator}    ${text[${item}]}
