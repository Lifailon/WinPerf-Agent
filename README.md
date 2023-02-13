# WinPerf-Agent

[Установка](#Установка)

**Агент мониторинга по сбору метрик в виде службы**. Версия 1.1 обрабатывает одно условие в указанный промежуток времени (в секундах, по умолчанию 15), где нагрузка на CPU превышает 90%,  если триггерное условие срабатывает, то оно проверяется еще два раза с указанным интервалом выше. Если три проверки подряд вернули результат выше тригерного значения, отправляет развернутый отчет состояния системы на почту, в котором можно инициализировать процессы, которые вызвали данную нагрузку и список установленных сетевых соединений, с которым их можно сопоставить и выявить удаленный источник нагрузки. Вывод измерений логируется.

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Logs.jpg)

![Image alt](https://github.com/Lifailon/WinPerf-Agent/blob/rsa/Screen/Report.jpg)

## Установка:

* Скопировать директорию **[WinPerf-Agent](https://github.com/Lifailon/WinPerf-Agent/releases)** в корень диски `C:\`
* **[Скачать NSSM-2.24.exe](https://www.nssm.cc/download)** и поместить в директорию `C:\WinPerf-Agent\NSSM-2.24.exe`
* Создать службу: \
`$powershell_Path = (Get-Command powershell).Source` \
`$NSSM_Path = (Get-Command "C:\WinPerf-Agent\NSSM-2.24.exe").Source` \
`$Script_Path = "C:\WinPerf-Agent\WinPerf-Agent-1.1.ps1"` \
`$Service_Name = "WinPerf-Agent"` \
`& $NSSM_Path install $Service_Name $powershell_Path -ExecutionPolicy Bypass -NoProfile -f $Script_Path` \
`& $NSSM_Path start $Service_Name` \
`& $NSSM_Path status $Service_Name`
