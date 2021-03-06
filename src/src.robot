*** Settings ***
Library     Selenium2Library
Library     BuiltIn
Library     Collections
Library     DebugLibrary
Library     OperatingSystem
Library		RequestsLibrary

Library     Faker/faker.py
Library		service.py


Resource	open_browser.robot
Resource	env_urls.robot


Resource	common/authentication/authentication.robot
Resource	common/loading/loading.robot
Resource	common/elements/elements.robot


Resource	pages/start_page/start_page.robot
Resource	pages/start_page/administration/administration.robot
Resource	pages/start_page/catalogs/catalogs.robot
Resource	pages/start_page/stock/stock.robot
Resource	pages/start_page/sales/sales.robot
Resource	pages/main_menu/main_menu.robot
Resource	pages/resource_classifier/resource_classifier.robot
Resource	pages/documents_register/documents_register.robot
Resource    pages/supply_contracts/supply_contracts.robot
Resource    pages/(detail)Реестр документов/(detail)Реестр документов.robot


Resource	pages_RMD/main_menu_RMD/main_menu_RMD.robot
Resource	pages_RMD/start_page_RMD/start_page_RMD.robot
Resource	pages_RMD/tasks_RMD/tasks_RMD.robot
Resource	pages_RMD/tasks_detail_RMD/tasks_detail_RMD.robot
Resource	pages_RMD/create_document_RMD/create_document_RMD.robot
Resource	pages_RMD/create_task_RMD/create_task_RMD.robot
Resource	pages_RMD/staff_RMD/staff_RMD.robot
Resource	pages_RMD/EDS_RMD/EDS_RMD.robot
Resource	pages_RMD/Привязати_документ_RMD/Привязати_документ_RMD.robot


*** Variables ***
${alias}                            alias
${browser}                          chrome
${browser_version}
${platform}                         ANY
${hub}                              http://autotest.it.ua:4444/wd/hub
${headless}                         ${True}


${users_variables_path1}   /home/testadm/MB_users_variables.py
${users_variables_path2}   ${EXECDIR}/MB_users_variables.py


*** Keywords ***
Open Browser In Grid
	[Arguments]  ${browser}=${browser}  ${platform}=${platform}
	clear_test_output
	Set Global Variable  ${start_page}  ${env_urls.${env}}
    Run Keyword  Відкрити браузер ${browser.lower()}  ${alias}
	Run Keyword And Ignore Error  Handle Alert  action=DISMISS
	Дочекатись закінчення загрузки сторінки


Check Prev Test Status
  ${status}  Set Variable  ${PREV TEST STATUS}
  Run Keyword If  '${status}' == 'FAIL'  Fatal Error  Ой, щось пішло не так! Вимушена зупинка тесту.


Отримати дані користувача по полю
	[Arguments]  ${user}  ${key}
	${status}  Run Keyword And Return Status  Import Variables  ${users_variables_path1}
	Run Keyword If  ${status} == ${False}  Import Variables  ${users_variables_path2}
	${a}  Create Dictionary  a  ${users_variables}
	${users_variables}  Set Variable  ${a.a}
	[Return]  ${users_variables.${user}.${key}}




#########################################################
#	                  Keywords							#
#########################################################
Заповнити та перевірити текстове поле
	[Arguments]  ${selector}  ${text}
	Scroll Page To Element XPATH  ${selector}
	Click Element  ${selector}
	Sleep  .5
	Run Keyword And Ignore Error  Clear input By JS  ${selector}
	Input Text  ${selector}  ${text}
	${got}  Get Element Attribute  ${selector}  value
	Press Key  ${selector}  \\9
	Should Be Equal As Strings  ${got}  ${text}


Заповнити та перевірити поле з датою
	[Arguments]  ${selector}  ${text}
	Scroll Page To Element XPATH  ${selector}
	Click Element  ${selector}
	Sleep  .5
	Run Keyword And Ignore Error  Clear input By JS  ${selector}
	Input Text  ${selector}  ${text}
	${got}  Get Element Attribute  ${selector}  value
	Press Key  ${selector}  \\9
	Should Be Equal As Strings  ${got}  ${text[:2]}.${text[3:5]}.${text[-4:]}


Clear input By JS
    [Arguments]    ${xpath}
	${xpath}  Set Variable  ${xpath.replace("'", '"')}
	${xpath}  Set Variable  ${xpath.replace('xpath=', '')}
    Execute JavaScript
    ...  document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value=""


Scroll Page To Element XPATH
	[Arguments]  ${locator}
	${x}  Get Horizontal Position  ${locator}
	${y}  Get Vertical Position  ${locator}
	@{size}  Get Window Size
	${x}  Evaluate  ${x}-${size[0]}/2
	${y}  Evaluate  ${y}-${size[1]}/2
	Execute JavaScript  window.scrollTo(${x},${y});