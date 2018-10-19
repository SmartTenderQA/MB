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
  debug