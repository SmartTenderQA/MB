*** Variables ***
${page}  //*[@id="pcModalMode_PW-1"]
${drop down element}  //*[@class="ade-list-back" and contains(@style, "display: block")]/div/div[contains(@class, "dhxcombo_option") and contains(., " ")]
&{data_name}
...  	Распорядитель=KCFO
...  	Банк1=NBNK2
...  	Контрагент=ORG
...  	Банк2=NBNK
...  	Сумма=SUMMA_1VAL
...  	Ставка НДС=NDS
...  	Код аналитики=ID_SETANLT
...  	КЕКВ=KAU5
...  	Тип документа=DOG_FLAG
...  	Номер документа=NDM
...     Контрагент=ORG
...     Документ от=DDM


*** Keywords ***
Вибрати любе доступне значення для поля
	[Arguments]  ${text}

	${input}  Set Variable  //*[@data-name="${data_name[u'${text}']}"]//input[1]
	${drop down}  Set Variable  //*[@data-name="${data_name[u'${text}']}"]//img[1]
	${search}  Set Variable  //*[@data-name="${data_name[u'${text}']}"]//img[2]

	Click Element  ${input}
	Run Keyword And Ignore Error  Wait Until Element Is Visible  ${drop down}  3
	Click Element  ${drop down}
	Run Keyword And Ignore Error  Wait Until Element Is Visible  ${drop down element}

	${n}  Get Element Count  ${drop down element}
	${random}  Run Keyword If  ${n} != 0  Evaluate  random.randint(1, ${n})  random
	Run Keyword If  ${n} != 0  Click Element  ${drop down element}\[${random}]
	# после выбора элемента значение в поле несколько раз меняется, нас интересует конечный вариант
	Sleep  2
	${get}  Run Keyword If  ${n} != 0  Get Element Attribute  ${input}  value
	...  ELSE  Set Variable  ${SPACE}
	[Return]  ${get}


Ввести значення в поле
	[Arguments]  ${field}  ${value}
	${input}  Set Variable  //*[@data-name="${data_name[u'${field}']}"]//input[1]
	Input Text  ${input}  ${value}
	${get}  Get Element Attribute  ${input}  value
	Should Be Equal  ${get}  ${value}


Вибрати елемент з фіксованого випадаючого списку
	[Arguments]  ${field}  ${text}
	${drop down}  Set Variable  //*[@data-name="${data_name[u'${field}']}"]//img[1]/..
	Click Element  ${drop down}
	${drop down element}  Set Variable  //td[contains(text(), '${text}')]
	Wait Until Element Is Visible  ${drop down element}
	Click Element  ${drop down element}


Вибрати випадковий елемент з фіксованого випадаючого списку
	[Arguments]  ${field}
	${drop down}  Set Variable  //*[@data-name="${data_name[u'${field}']}"]//img[1]/..
	${input}  Set Variable  (//*[@data-name="${data_name[u'${field}']}"]//input)[2]
	Click Element  ${drop down}
	${drop down element}  Set Variable  //*[contains(@style, "visibility: visible") and contains(@class, "dxpcDropDown")]//table/*[@class="dxeListBoxItemRow_DevEx"]
	Wait Until Element Is Visible  ${drop down element}
	${n}  Get Element Count  ${drop down element}
	${random}  Evaluate  random.randint(1, ${n})  random
	Click Element  ${drop down element}\[${random}]
	${get}  Get Element Attribute  ${input}  value
	[Return]  ${get}


Отримати значення поля
	[Arguments]  ${field}
	${n}  Set Variable If
	...  "${field}" == "Ставка НДС" or "${field}" == "Тип документа"  	2
	...  1
	${input}  Set Variable  (//*[@data-name="${data_name[u'${field}']}"]//input[1])[${n}]
	${value}  Get Element Attribute  ${input}  value
	[Return]  ${value}