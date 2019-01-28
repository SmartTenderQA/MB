*** Settings ***
Resource  ../src/src.robot
Suite Setup  Suite Precondition
Suite Teardown  Close All Browsers
Test Setup  Check Prev Test Status
Test Teardown  Run Keyword If Test Failed  Run Keywords
...  Capture Page Screenshot  AND
...  Log Location


*** Variables ***
&{user}
...								BUHGOVA2=Главный бухгалтер


#zapusk
#robot -L TRACE:INFO -A suites/arguments.txt -v capability:chrome -v env:BUHGOVA2 suites/assignment_of_BP_when_adding_document.robot
*** Test Cases ***
Запустити функцію "Оприходования ТМЦ"
	start_page.Натиснути "Склад"
	stock.Відкрити сторінку за назвою  Оприходование ТМЦ


Відкрити вікно додавання документа
	main_menu.Вибрати вкладку в головному меню за назвою  ГЛАВНАЯ
	main_menu.Натиснути кнопку в головному меню за назвою  Добавить (F7)
	stock.Перевірити вікно додавання документа в "Реестр документов"


Додати документ та перевірити успішність його створення
	${quantity}  documents_register.Отримати кількість документів
	Set Global Variable  ${initial_documents_quantity}   ${quantity}
	Створити документ
	${current_documents_quantity}  documents_register.Отримати кількість документів
	documents_register.Переконатися що в реєстрі з'явився новий документ  ${initial_documents_quantity}  ${current_documents_quantity}
	documents_register.Стадія поточного документа повинна бути  Ввод


Провести поточний документ
	documents_register.Отримати номер доданого документу
	main_menu.Натиснути кнопку в головному меню за назвою  Провести (Alt+Right)
	documents_register.Перевірити проведення документу


Відмінення проведення документу
	main_menu.Натиснути кнопку в головному меню за назвою  Отменить проведение (Alt+Left)
	documents_register.Перевірити відміну проведення


Видалення документу
	main_menu.Натиснути кнопку в головному меню за назвою  Удалить (F8)
	documents_register.Натиснути кнопку форми  Удалить
	documents_register.Перевірити видалення документу



*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  ${user.${env}}


Створити документ
	documents_register.Заповнити поле  Склад  21
	documents_register.Заповнити поле  Контрагент  89
	documents_register.Заповнити поле  Договор  *
	documents_register.Натиснути кнопку форми  Добавить
	documents_register.Обрати режим формування за назвою  Ввести вручную
	documents_register.Заповнити поле  Код ТМЦ  1812000000000AP
	documents_register.Заповнити поле  Кол.факт  10
	documents_register.Заповнити поле  ГРН  52
	documents_register.Заповнити поле  Программная классиф.  6121010
	documents_register.Заповнити поле  Фонд  01
	documents_register.Заповнити поле  Коды экономической классификации  2210
	documents_register.Натиснути кнопку форми  Добавить