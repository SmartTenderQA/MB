*** Settings ***
Documentation
Metadata  Задача в PLD
...  590425
Metadata  Название теста
...  Обработка клавиш полем ввода в экране, когда поверх него открыто другое окно.
Metadata  Заявитель
...  КУЦАЯ
Metadata  Окружения
...  - chrome
...  - ff
Metadata  Команда запуска
...  robot --consolecolors on -L TRACE:INFO -d test_output -v env:BUHGOVA2_RMD -v capability:chrome  -v hub:none suites/incoming_documents/suite.robot

Resource  ../../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***


*** Test Cases ***



*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  ${env}
