*** Variables ***
${loading}							//table[contains(@id, 'LoadingPanel')]
${loading rmd}						//div[contains(@class,'loading-panel')]
${blocker}                          //*[@id="adorner"]

${loadings}                         ${loading}|${loading rmd}|${blocker}


*** Keywords ***
Дочекатись закінчення загрузки сторінки
	Sleep  1
	elements.Дочекатися зникнення елемента зі сторінки  ${loadings}  120
	Sleep  .5
	${is visible}  Run Keyword And Return Status  Element Should Be Visible  ${loadings}
	Run Keyword If  ${is visible}
	...  Дочекатись закінчення загрузки сторінки
	elements.Закрити всі сповіщення (за необхідністю)


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
