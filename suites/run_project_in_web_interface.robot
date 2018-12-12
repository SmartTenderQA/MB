*** Settings ***
Resource  ../src/keywords.robot
Library   ../src/data.py
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Capture Page Screenshot

*** Variables ***
${webclient_start_page}      https://webclient.it-enterprise.com/client/(S(hmdkfxfl5ow4ejt5ptiszejh))/?proj=K_BUHETLA2_UK&Iconset=Master&win=1&tz=3
${cpmb_start_page}           http://192.168.1.205/wsmbdemo_all/client



*** Test Cases ***
Запуск проекта MASTER
  Run Keyword And Ignore Error  Закрити привітання с днем народження
  Натиснути адміністрування
  Натиснути Користувачі та групи
  Перевірити відкриту сторінку


*** Keywords ***
Suite Precondition
  ${start_page}  Отримати стартовий URL
  Start
  Set Window Size  945  1079
  Set Window Position  3  28
  Дочекатись загрузки сторінки (МВ)
  Авторизуватися
  Run Keyword If  "${start_from}" == "webclient"  Run Keywords
  ...  Wait Until Element Is Visible  //span[contains(text(), 'Вибір')]  60
  ...  AND  Дочекатись загрузки сторінки (МВ)
  ...  AND  Click Element  //span[contains(text(), 'Вибір')]
  ...  AND  Дочекатись загрузки сторінки (МВ)


Start
  Open Browser  ${start_page}  ${browser}  alies


Отримати стартовий URL
  ${start_page}  Run Keyword If  "${start_from}" == "webclient"  Set Variable  ${webclient_start_page}
  ...  ELSE  Set Variable  ${cpmb_start_page}
  Set Global Variable  ${start_page}
  [Return]  ${start_page}


Test Postcondition
  Run Keyword If Test Failed  Capture Page Screenshot


Авторизуватися
  Run Keyword  Вибрати Ім'я користувача ${start_from}
  Ввести пароль
  Натиснути Увійти


Вибрати Ім'я користувача webclient
  Wait Until Page Contains Element  //*[@data-name="Login"]//td[@id]  30
  Click Element  //*[@data-name="Login"]//td[@id]
  Sleep  1
  Click Element  //*[contains(text(), "Главный бухгалтер")]


Вибрати Ім'я користувача cpmb
  Wait Until Page Contains Element  //*[@data-name="Login"]//td[@id]  30
  Click Element  //*[@data-name="Login"]//td[@id]
  Sleep  1
  Click Element  //*[contains(text(), "Головний бухгалтер")]


Ввести пароль
  No Operation


Натиснути Увійти
  Click Element  //div[@class='dxb' and contains(., 'Увійти')]
  Дочекатись загрузки сторінки (МВ)


Натиснути адміністрування
  Wait Until Element Is Visible  //*[@data-key="AD.ADM"]  60
  Sleep  2
  Click Element  //*[@data-key="AD.ADM"]
  Дочекатись загрузки сторінки (МВ)


Натиснути користувачі
  Click Element  //div[@data-key and contains(., "Користувачi")]


Натиснути Користувачі та групи
  Wait Until Element Is Visible  //div[@data-itemkey and contains(., "Користувачі та групи")]
  Sleep  2
  Double Click Element  //div[@data-itemkey and contains(., "Користувачі та групи")]
  Дочекатись загрузки сторінки (МВ)
  Sleep  3
  Wait Until Page Does Not Contain Element  //div[@data-itemkey and contains(., "Користувачі та групи")]


Перевірити відкриту сторінку
  Element Should Be Visible  //*[@data-placeid="TBN"]//td[text()="Користувачi"]
  Element Should Be Visible  //*[@class="dx-vam" and contains(text(), "РОЗРОБНИК")]
