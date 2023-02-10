$keyEnglish        = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\009'
$keyLocalized      = 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Perflib\CurrentLanguage'
$countersEnglish   = (Get-ItemProperty -Path $keyEnglish -Name Counter).Counter
$countersLocalized = (Get-ItemProperty -Path $keyLocalized -Name Counter).Counter

$perfCountersEng = new-object "System.Collections.Generic.Dictionary[[int],[string]]"
$countersEnglishCount = $countersEnglish.Count / 2
for($num = 1; $num -le $countersEnglishCount; $num++)
{
    $indexId = $num * 2
    $indexName = $indexId - 1   
    $counterId = $countersEnglish[$indexId] 
    $counterName = $countersEnglish[$indexName]

    if($perfCountersEng.ContainsKey($counterId))
    {
    } else
    {
        $perfCountersEng.Add($counterId, $counterName) | Out-Null
    }
}

$perfCountersLocalized = new-object "System.Collections.Generic.Dictionary[[int],[string]]"
$countersLocalizedCount = $countersLocalized.Count / 2
for($num = 1; $num -le $countersLocalizedCount; $num++)
{
    $indexId = $num * 2
    $indexName = $indexId - 1   
    $counterId = $countersLocalized[$indexId] 
    $counterName = $countersLocalized[$indexName]

    if($perfCountersLocalized.ContainsKey($counterId))
    {
        # Ничего не делаем
    } else
    {
        $perfCountersLocalized.Add($counterId, $counterName) | Out-Null
    }
}

$allPerfCounter = new-object "System.Collections.Generic.Dictionary[[int],[object]]"
foreach ($key in $perfCountersLocalized.Keys) { 
    $allPerfCounter.Add($key,
    [pscustomobject]@{
        NameRus=$perfCountersLocalized[$key];
        NameEng=""
    })
} 
foreach ($key in $perfCountersEng.Keys) { 
    if($allPerfCounter.ContainsKey($key))
    {
        $allPerfCounter[$key].NameEng = $perfCountersEng[$key]
    } else
    {
        $allPerfCounter.Add($key,
        [pscustomobject]@{
            NameLocalized= "";
            NameEng=$perfCountersEng[$key]
        })
    }    
} 

$allPerfCounter | Out-GridView
pause

#$csvData = New-Object Collections.Generic.List[object]
#foreach ($key in $allPerfCounter.Keys) { 
#    $objectInfo = [pscustomobject]@{
#        Id=$key
#        NameLocalized= $allPerfCounter[$key].NameLocalized
#        NameEng=$allPerfCounter[$key].NameEng
#    }
#
#    $csvData.Add($objectInfo)
#}
#
#$csvData | Export-Csv -Path "$env:USERPROFILE\desktop\Perf-Counter-ID.csv" -Delimiter ';'