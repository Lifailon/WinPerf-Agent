$trigger = 90 # >%
$sleep = 15 # x3
$hostname = $env:computername
$Log_Path = "C:\WinPerf-Agent\WinPerf-Log\"

function Send-Yandex ($mess) {
$srv_smtp = "smtp.yandex.ru" 
$port = "587"
$from = "login@yandex.ru" 
$to = "login@yandex.ru" 
$user = "login"
$pass = "password"
$subject = "Performance CPU over 90% on Host: $hostname"
$Message = New-Object System.Net.Mail.MailMessage
$Message.From = $from
$Message.To.Add($to) 
$Message.Subject = $subject 
$Message.IsBodyHTML = $true 
$Message.Body = "<h1> $mess </h1>"
$smtp = New-Object Net.Mail.SmtpClient($srv_smtp, $port)
$smtp.EnableSSL = $true 
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);
$smtp.Send($Message) 
}

function proc-count {
[int32](Get-Counter "\Процессор(_Total)\% загруженности процессора").CounterSamples.CookedValue
#[int32](Get-Counter "\Processor(_Total)\% Processor Time").CounterSamples.CookedValue
}

function check-count {
$Log_Name = Get-Date -Format dd-MM-yyyy
$Log = "$Log_Path\$Log_Name.txt"
if (!(Test-Path $Log)) {
New-Item -Path $Log -ItemType File
}
$log_date = Get-Date -Format hh:mm:ss
$proc_count_1 = proc-count
"$log_date  1 Check  CPU Performance: $proc_count_1%" >> $Log
if ($proc_count_1 -gt $trigger) {
sleep $sleep
$log_date = Get-Date -Format hh:mm:ss
$proc_count_2 = proc-count
"$log_date  2 Check  CPU Performance: $proc_count_2%" >> $Log
} 
if ($proc_count_2 -gt $trigger) {
$proc_count_2 = 0
sleep $sleep
$log_date = Get-Date -Format hh:mm:ss
$proc_count_3 = proc-count
"$log_date  3 Check  CPU Performance: $proc_count_3%" >> $Log
} 
if ($Proc_count_3 -gt $trigger) {
$proc_count_3 = 0
"$log_date  Send Report to email" >> $Log
$out = @('<h3> <font color="#00BFFF"> State Process: </font> </h3>')
$out += Get-Process | Sort-Object -Descending CPU | select -first 10 ProcessName,
@{Name="CPU"; Expression={[int]$_.CPU}},
@{Name="Memory"; Expression={[string]([int]($_.WS / 1024kb))+"MB"}},
@{Label="Running Time"; Expression={((Get-Date) - $_.StartTime) -replace "\.\d+$"}} | ConvertTo-Html
$out += @('<h3> <font color="#00BFFF"> State Established TCP Connection: </font> </h3>')
$out += Get-NetTCPConnection -State Established | select CreationTime,LocalAddress,LocalPort,RemotePort,
RemoteAddress,@{name="RemoteHostName";expression={((nslookup $_.RemoteAddress)[3]) -replace ".+:\s+"}},
@{name="ProcessName";expression={(Get-Process -Id $_.OwningProcess).ProcessName}},
@{name="ProcessPath";expression={(Get-Process -Id $_.OwningProcess).Path}} | ConvertTo-Html
Send-Yandex $out
$out = $null
sleep ($sleep * 10) # x10
check-count
} else {
"$log_date  Recheck" >> $Log
sleep $sleep
check-count
}
}

check-count