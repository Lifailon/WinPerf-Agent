$WARNING = 29
$CRITICAL = 49
$TransferRate = ((get-counter "\сетевой интерфейс(realtek 8822ce wireless lan 802.11ac pci-e nic)\всего байт/с"
).countersamples | select -ExpandProperty CookedValue)*8
$NetworkUtilisation = [math]::round($TransferRate/1000000000*100,2)
if ($NetworkUtilisation -gt $CRITICAL){
Write-Output "CRITICAL: $($NetworkUtilisation) % Network utilisation, $($TransferRate.ToString('N0')) b/s"   
#exit 2		
}
if ($NetworkUtilisation -gt $WARNING){
Write-Output "WARNING: $($NetworkUtilisation) % Network utilisation, $($TransferRate.ToString('N0')) b/s"
#exit 1
}
Write-Output "OK: $($NetworkUtilisation) % Network utilisation, $($TransferRate.ToString('N0')) b/s"   
#exit 0
#Get-NetAdapterStatistics