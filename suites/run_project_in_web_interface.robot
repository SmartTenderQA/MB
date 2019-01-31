*** Settings ***
Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***


#zapusk
#robot --consolecolors on -L TRACE:INFO -A suites/arguments.txt -v env:WEBCLIENT -v browser:chrome suites/run_project_in_web_interface.robot
#robot --consolecolors on -L TRACE:INFO -A suites/arguments.txt -v env:CPMB -v browser:chrome suites/run_project_in_web_interface.robot
#robot --consolecolors on -L TRACE:INFO -A suites/arguments.txt -v env:WEBCLIENT -v browser:firefox suites/run_project_in_web_interface.robot
#robot --consolecolors on -L TRACE:INFO -A suites/arguments.txt -v env:CPMB -v browser:firefox suites/run_project_in_web_interface.robot
#
*** Test Cases ***
Запуск проекта MASTER
	start_page.Натиснути "Адміністрування"
	administration.Натиснути "Користувачі та групи"


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  ${env}
