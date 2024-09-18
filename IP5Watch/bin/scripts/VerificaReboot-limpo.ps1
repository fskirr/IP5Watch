cls
    $computernames = & hostname
#Write-Host "STATUS                           SERVIDOR" -backgroundcolor "White" -ForegroundColor BLUE
    foreach ($computername in $computernames)
{
try  {
    $basekey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey("LocalMachine",$computername)
    $key= $basekey.OpenSubKey("Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\")
    $subkeys = $key.GetSubKeyNames()
    $key.Close()
    $basekey.Close()
If ($subkeys | Where {$_ -eq "RebootPending"})
{
Write-Host "1" 
}
Else
{
Write-Host "2" 
}
}
catch {
Write-Host "3" 
}
}