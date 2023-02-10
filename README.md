# WinPerf-Agent
Service for measuring increased CPU performance and sending a report to the email

**Работает по принципу агента мониторинга, обрабатывает одно условие и отправляет развернутый отчет состояния системы на почту.** Проверяется 1 условие (`$trigger = 90%`) с указанным интервалом времени в секундах (`$sleep = 15`), если триггерное условие срабатывает, то перед отправкой на почту оно проверяется еще два раза с указанным интервалом выше. Вывор работы службы логируется.

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Logs.jpg)

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Report.jpg)

## Установка:

* Скопировать директория `WinPerf-Agent` в корень диски `C:\`
* **[Скачать NSSM-2.24.exe](https://www.nssm.cc/download)** и поместить в директорию `WinPerf-Agent`
* Создать службу:
