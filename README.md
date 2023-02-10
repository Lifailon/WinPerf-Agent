# WinPerf-Agent
Service for measuring increased CPU performance and sending a report to the email

*Работает по принципу агента Zabbix, обрабатывает одно условие и отправляет развернутый отчет состояния системы на почту.* Проверяется 1 условие (`$trigger = 90%`) с указанным интервалом времени в секундах (`$sleep = 15`), если триггерное условие срабатывает, то перед отправкой на почту оно проверяется еще два раза с указанным интервалом выше. Вывор работы службы логируется.

![Image alt](https://github.com/Lifailon/Remote-Shadow-Administrator/blob/rsa/Image/Interface-1.4.jpg)

![Image alt](https://github.com/Lifailon/Remote-Shadow-Administrator/blob/rsa/Image/Interface-1.4.jpg)

## Установка:

