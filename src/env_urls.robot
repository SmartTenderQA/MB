*** Variables ***
&{env_urls}
#		Систематизация ссылок на тестовые клиенты продуктов линейки MASTER
#		Цели систематизации:
#		– выйти на единое понимание комплектов тестирования между командами разработки и тестирования UI
#		– минимизировать количество тестов (чтобы было минимальным, но достаточным)
#		Средство:
#		- опубликовать список комплектов на общедоступном и понятном для всех ресурсе
#		Хочу обратить внимание, что продукты линейки MASTER работают промышленно на украинском языке, комплекты в «копии» также содержат системные данные на украинском языке, при этом, разработка – ведется на русском и комплекты, которые в разработке, хранят эталонные данные на русском языке.
#		Нам необходимо иметь 1 комплект тестов на украинском языке, а не два (на русском и украинском). Поэтому и тестовые сценарии необходимо готовить на украинском. А, соответственно, и ссылки на комплекты должны быть приспособлены под эти ограничения.
#		Продукты линейки MASTER разделяются на два независимых направления:
#		- для коммерческих организаций (в дальнейшем, «коммерческие», «коммерция»)
#		- для бюджетных учреждений (в дальнейшем «бюджет»)
#		Оба направления разрабатываются отдельно и несовместимы друг с другом. Продукты внутри одного направления – могут быть совместимы друг с другом.
#		Каждое из направлений разделяется на две группы комплектов: разработка (или «текущие») и «продуктив» (или «копия», или «демо»). «Продуктивов» может быть несколько, т.к. они содержат в себе различия конфигурации, а именно содержат различные наборы продуктов и параметров настроек, предназначенные для решения различных практических задач.
#		Для некоторых комплектов необходим запуск RMD-интерфейса. Для этого в конце кода комплекта специально написано «RMD».
#		Ниже описана система ссылок на тестовые комплекты, которые используются для тестирования в разрезе направлений, актуальные на момент разработки документа. С течением времени система ссылок может расширяться и/или изменяться.
#		Доступные тестовые комплекты
#Коммерческие
#1)	Текущие (разработка)
...  BUHETLA2=https://m.it.ua/clientmaster?proj=K_BUHETLA2_UK&iconset=master
...  BUHETLA2_RU=https://m.it.ua/clientmaster?proj=K_BUHETLA2_RU&iconset=master  #(лучше бы не использовать)
...  BUHETLA2_RMD=https://webclient.it-enterprise.com/clientrmd?proj=K_BUHETLA2_UK&iconset=master
#2)	Копии («продуктив»)
...  MBDEMO_ALL=http://cpmb/wsmbdemo_all/client
...  MBTEST_ALL=http://cpmb/wsmbtest_all/client/?proj=it_RU&tz=3  #(? Зачем по-русски)
...  MBDEMO_BUHHR=http://cpmb/wsmbdemo_buhhr/client
...  MBDEMO_BUH=http://cpmb/wsmbdemo_buh/client
...  MBDEMO_ALL_RMD=http://cpmb/wsmbdemo_all/clientRMD
...  MBDEMO_DLP_RMD=http://cpmb/wsmbdemo_dlp/clientRMD
...  MBDEMOAGRO=http://cpmb/wsmbdemoagro/client
...  MBDEMO_GKH=http://cpmb/wsmbdemo_gkh/client
#3)	Копия (Тестирование SP)
...  MBSP_ALL=http://mastertest/Mbspall/client
...  MBSP_ALL_RMD=http://mastertest/MBSPALL/clientrmd
...  MBSPAGRO=http://mastertest/Mbspallagro/client
...  MBSPBASE=http://mastertest/MBSPBASE/client
...  MBSPBUH=http://MASTERTEST/MBSPBUH/client
#Бюджетные
#1)	Текущие (разработка)
...  BUHGOVA2=https://m.it.ua/clientmaster?proj=K_BUHGOVA2_UK&iconset=master
...  BUHGOVA2_RU=https://m.it.ua/clientmaster?proj=K_BUHGOVA2_UK&iconset=master  #(лучше бы не использовать)
...  BUHGOVA2_RMD=https://webclient.it-enterprise.com/clientrmd/?proj=K_BUHGOVA2_UK&iconset=master
#2)	Копии («продуктив»)
...  MBDEMOGOV_ALL=http://cpmb/wsmbdemogov/client
...  MBDEMOGOV_ALL_RMD=http://cpmb/wsmbdemogov/clientRMD
...  MBDEMOGOV_DLP_RMD=http://cpmb/wsmbdemogov_dlp/clientRMD
#3)	Копия (Тестирование SP)
...  MBSPGOV=http://mastertest/MBSPGOV/client
...  MBSPGOVBASE=http://MASTERTEST/MBSPGOVBASE/client
