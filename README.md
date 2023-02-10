# WinPerf-Agent

**Работает по принципу агента мониторинга, обрабатывает одно условие и отправляет развернутый отчет состояния системы на почту.** Проверяется 1 условие (`$trigger = 90%`) с указанным интервалом времени в секундах (`$sleep = 15`), если триггерное условие срабатывает, то перед отправкой на почту оно проверяется еще два раза с указанным интервалом выше. Вывод работы службы логируется.

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Logs.jpg)

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Report.jpg)

## Установка:

* Скопировать директория `WinPerf-Agent` в корень диски `C:\`
* **[Скачать NSSM-2.24.exe](https://www.nssm.cc/download)** и поместить в директорию `WinPerf-Agent`
* Создать службу:
`$powershell_Path = (Get-Command powershell).Source` /
`$NSSM_Path = (Get-Command "C:\WinPerf-Agent\NSSM-2.24.exe").Source` /
`$Script_Path = "C:\WinPerf-Agent\WinPerf-Agent-1.1.ps1"` /
`$Service_Name = "WinPerf-Agent"` /
`& $NSSM_Path install $Service_Name $powershell_Path -ExecutionPolicy Bypass -NoProfile -f $Script_Path` /
`& $NSSM_Path start $Service_Name` # запустить /
`& $NSSM_Path status $Service_Name` # статус
