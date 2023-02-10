# WinPerf-Agent

- [Установка](#Установка)

**Работает по принципу агента мониторинга по сбору метрик, обрабатывает одно условие в указанный промежуток времени (в секундах, по умолчанию 15), где нагрузка на CPU превышает 90%,  если триггерное условие срабатывает, то оно проверяется еще два раза с указанным интервалом выше, в итоге отправляет развернутый отчет состояния системы на почту. Вывод работы логируется.** 

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Logs.jpg)

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Report.jpg)

## Установка:

* Скопировать директорию **[WinPerf-Agent](https://github.com/Lifailon/WinPerf-Agent/releases)** в корень диски `C:\`
* **[Скачать NSSM-2.24.exe](https://www.nssm.cc/download)** и поместить в директорию `WinPerf-Agent`
* Создать службу: \
`$powershell_Path = (Get-Command powershell).Source` \
`$NSSM_Path = (Get-Command "C:\WinPerf-Agent\NSSM-2.24.exe").Source` \
`$Script_Path = "C:\WinPerf-Agent\WinPerf-Agent-1.1.ps1"` \
`$Service_Name = "WinPerf-Agent"` \
`& $NSSM_Path install $Service_Name $powershell_Path -ExecutionPolicy Bypass -NoProfile -f $Script_Path` \
`& $NSSM_Path start $Service_Name` # запустить \
`& $NSSM_Path status $Service_Name` # статус
