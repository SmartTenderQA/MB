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
#robot -L TRACE:INFO -d test_output -v browser:chrome -v env:BUHETLA2 suites/assign_BP_while_adding_doc_movement_forward_back.robot
*** Test Cases ***
Запустити функцію "Реализация товаров и услуг"
	start_page.Натиснути "Продажі"
	sales.Відкрити сторінку за назвою  Реалізація товарів та послуг


Заповнити поля в екрані додати документ
	${quantity}  documents_register.Отримати кількість документів
	Set Global Variable  ${initial_documents_quantity}   ${quantity}
	main_menu.Вибрати вкладку в головному меню за назвою  ГОЛОВНА
	main_menu.Натиснути кнопку в головному меню за назвою  Додати (F7)
	sales.Перевірити що активна вкладка "Документ"
	sales.Перевірити тип процессу за замовчуванням  Акт наданих послуг _ACTOUTS  Акт наданих послуг (_ACTOUTS)
	Створити документ
	${current_documents_quantity}  documents_register.Отримати кількість документів
	documents_register.Переконатися що в реєстрі з'явився новий документ  ${initial_documents_quantity}  ${current_documents_quantity}
	documents_register.Стадія поточного документа повинна бути  Введення


Проведення документу
	documents_register.Отримати номер доданого документу
	main_menu.Натиснути кнопку в головному меню за назвою  Провести (Alt+Right)
	documents_register.Перевірити проведення документу


Відмінення проведення документу
	main_menu.Натиснути кнопку в головному меню за назвою  Скасувати проведення (Alt+Left)
	documents_register.Перевірити відміну проведення


Видалення документу
	main_menu.Натиснути кнопку в головному меню за назвою  Видалити (F8)
	documents_register.Натиснути кнопку форми  Видалити
	documents_register.Перевірити видалення документу


*** Keywords ***
Suite Precondition
	src.Open Browser In Grid
	authentication.Авторизуватися  Главный_бухгалтер


Створити документ
	documents_register.Заповнити поле  Контрагент  13356
	documents_register.Заповнити поле  Договор  123  #TODO раньше тут вместо 123 был аргумент * (). Уточнить у Тищук
	documents_register.Натиснути кнопку форми  Додати
	documents_register.Обрати режим формування за назвою  Ввести вручную
	documents_register.Заповнити поле  Код ТМЦ  200200000000016
	documents_register.Заповнити поле  Кол.факт  1
	documents_register.Заповнити поле  ГРН  4000
	documents_register.Заповнити поле Статьи доходов/затрат  D0201
	documents_register.Натиснути кнопку форми  Додати