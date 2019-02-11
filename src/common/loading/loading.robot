*** Settings ***
Documentation			Пейджа для компонента загрузки  http://joxi.ru/5mdalbLIkGWJe2


*** Variables ***
${loading}							xpath=//table[contains(@id, 'LoadingPanel')]
${loading rmd}						xpath=//div[contains(@class,'loading-panel')]


*** Keywords ***
Дочекатись закінчення загрузки сторінки
	Дочекатись закінчення загрузки сторінки по елементу  ${loading}


Дочекатись закінчення загрузки сторінки RMD
	Дочекатись закінчення загрузки сторінки по елементу  ${loading rmd}
	elements.Закрити всі сповіщення (за необхідністю)



#########################################################
#	                  Keywords							#
#########################################################
Дочекатись закінчення загрузки сторінки по елементу
    [Arguments]  ${locator}
    ${status}  ${message}  Run Keyword And Ignore Error
    ...  Wait Until Element Is Visible
    ...  ${locator}
    ...  3
    Run Keyword If  "${status}" == "PASS"
    ...  Run Keyword And Ignore Error
    ...  Wait Until Element Is Not Visible
    ...  ${locator}
    ...  120