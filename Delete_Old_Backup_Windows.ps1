# Effacer les anciens clich�s instantan�s.
$shadowCopies = Get-WMIObject -Class Win32_ShadowCopy
$OutFile = @()
$DateToday = Get-Date -Format dd_MM_yyyy_HH_mm
foreach ($shadowCopy in $shadowCopies)
{
    $dateWmi = $shadowCopy.InstallDate
    $datePourConvertion = ($dateWmi.split('.'))[0]
    $date = [datetime]::ParseExact($datePourConvertion,"yyyyMMddHHmmss", $null)
    if ($date -lt (([datetime]::now).adddays(-90)))
        {
        $shadowCopy.delete()
        write-host "Suppression du clich� du $date"
        $OutFile += "Suppression du clich� du $date"
        }
}
$OutFile | Out-File "C:\Tools\Log\Delete_Backup_Windows_$DateToday.txt"
