*** Keywords ***
Пошук по полю в основному вікні
    [Arguments]  ${field}  ${value}
    ${input}  Set Variable
    ...  (//*[@class="hdr"]//td/input)[count(//*[@data-placeid="DOG"]//div[contains(text(), '${field}')]/ancestor::td[1]/preceding-sibling::*)]
    Scroll Page To Element XPATH  ${input}
    Input Text  ${input}  ${value}
    Press Key  ${input}  \\13


Активувати вкладку
    [Arguments]  ${title}
    ${status}  Run Keyword And Return Status  Element Should Be Visible  //*[contains(@class,"active-tab")]//td[contains(text(),"${title}")]
    Run Keyword If  '${status}' == 'False'  Run Keywords
    ...  elements.Дочекатися відображення елемента на сторінці  //td[contains(text(),"${title}")]  AND
    ...  Click Element  //td[contains(text(),"${title}")]  AND
    ...  elements.Дочекатися відображення елемента на сторінці  //*[contains(@class,"active-tab")]//td[contains(text(),"${title}")]


Вибрати рядок "В разрезе аналитик" за номером
    [Arguments]  ${i}
    ${row}  Set Variable  //*[@data-placeid="SPEC"]//tr[contains(@class,"Row")]
    elements.Дочекатися відображення елемента на сторінці  ${row}
    Click Element  (${row})[${i}]
    elements.Дочекатися відображення елемента на сторінці  (${row})[${i}][contains(@class,"selected")]


Вибрати рядок в основному вікні за номером
    [Arguments]  ${i}
    ${row}  Set Variable  //*[@data-placeid="DOG"]//tr[contains(@class,"Row")]
    elements.Дочекатися відображення елемента на сторінці  ${row}
    Wait Until Keyword Succeeds  6  2  Click Element  (${row})[1]
    elements.Дочекатися відображення елемента на сторінці  (${row})[${i}][contains(@class,"selected")]


Закрити інформаційне сповіщення (за необхідністю)
    ${notice}            Set Variable  //*[@class="instantMessage"]
	${notice close btn}  Set Variable  //*[@class="instantMessageClose"]
	${status}  Run Keyword And Return Status  elements.Дочекатися відображення елемента на сторінці  ${notice}  2
	Run Keyword If  '${status}' == 'True'  Run Keywords
	...  Mouse Over  ${notice}  AND
	...  elements.Дочекатися відображення елемента на сторінці  ${notice close btn}  2  AND
	...  Click Element  ${notice close btn}
	${status}  Run Keyword And Return Status  Element Should Not Be Visible  ${notice close btn}
	Run Keyword If  '${status}' == 'False'  Закрити інформаційне сповіщення (за необхідністю)