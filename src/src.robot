*** Settings ***
Library     Selenium2Library
Library     BuiltIn
Library     Collections
Library     DebugLibrary
Library     OperatingSystem
Library		RequestsLibrary

Library     Faker/faker.py
Library		service.py
Library		data.py


Resource	common/authentication/authentication.robot
Resource	common/loading/loading.robot


Resource	pages/start_page/start_page.robot
Resource	pages/start_page/administration/administration.robot
Resource	pages/start_page/catalogs/catalogs.robot
Resource	pages/start_page/stock/stock.robot
Resource	pages/start_page/sales/sales.robot
Resource	pages/main_menu/main_menu.robot
Resource	pages/resource_classifier/resource_classifier.robot
Resource	pages/documents_register/documents_register.robot



*** Variables ***
${browser}							chrome
${platform}							ANY

${hub}                                http://autotest.it.ua:4444/wd/hub

&{url}
...									MBTEST_ALL=http://192.168.1.205/wsmbtest_all/client/?proj=it_RU&tz=3
...									MBDEMO_ALL=http://192.168.1.205/wsmbdemo_all/client/(S(4jfyvmpjrtsn2ggyct0l0rjc))/Splash?proj=it_UK&tz=3
...									BUHETLA2=https://webclient.it-enterprise.com/client/(S(3fxdkqyoyyvaysv2iscf02h3))/?proj=K_BUHETLA2_RU&dbg=1&win=1&tz=3
...									BUHGOVA2=https://webclient.it-enterprise.com/client/(S(lnutooqpvguwnrpuuz13utgd))/?proj=K_BUHGOVA2_RU&dbg=1&win=1&tz=3
...									WEBCLIENT=https://webclient.it-enterprise.com/client/(S(hmdkfxfl5ow4ejt5ptiszejh))/?proj=K_BUHETLA2_UK&Iconset=Master&win=1&tz=3
...									CPMB=http://192.168.1.205/wsmbdemo_all/client
...									BUHGOVA2_RMD=https://webclient.it-enterprise.com/clientrmd/(S(zba2cyntynq2odbobgibdsvn))/?promptLogin=1&proj=K_BUHGOVA2_UK&dbg=1&iconset=ms&ClientDevice=Desktop&isLandscape=true&tz=2


*** Keywords ***
Open Browser In Grid
	[Arguments]  ${browser}=${browser}  ${platform}=${platform}
	clear_test_output
	Open Browser  ${url.${env}}  ${browser}  alies  ${hub}  platformName:${platform}
	Run Keyword If  '${hub}' != 'none' and '${hub}' != 'NONE'
	...  Отримати та залогувати data_session
    Set Window Size  1280  1024
    Дочекатись закінчення загрузки сторінки


Check Prev Test Status
  ${status}  Set Variable  ${PREV TEST STATUS}
  Run Keyword If  '${status}' == 'FAIL'  Fatal Error  Ой, щось пішло не так! Вимушена зупинка тесту.




#########################################################
#	                  Keywords							#
#########################################################
Отримати та залогувати data_session
	${s2b}  get_library_instance  Selenium2Library
	${webdriver}  Call Method  ${s2b}  _current_browser
	Create Session  api  http://autotest.it.ua:4444/grid/api/testsession?session=${webdriver.__dict__['capabilities']['webdriver.remote.sessionid']}
	${data}  Get Request  api  \
	${data}  Set Variable  ${data.json()}
	Log  ${webdriver}
	Log  ${webdriver.__dict__}
	Log  ${webdriver.__dict__['capabilities']}
	Log  ${data}


Заповнити та перевірити текстове поле
	[Arguments]  ${selector}  ${text}
	Scroll Page To Element XPATH  ${selector}
	Click Element  ${selector}
	Sleep  .5
	Run Keyword And Ignore Error  Clear input By JS  ${selector}
	Input Text  ${selector}  ${text}
	${got}  Get Element Attribute  ${selector}  value
	Press Key  ${selector}  \\13
	Should Be Equal As Strings  ${got}  ${text}


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