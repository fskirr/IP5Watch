$replica = Get-VMReplication | Where {$_.Health -eq ‘Critical’}
if ( $replica.Health -eq "Critical"){
     write-host 2
}elseif (write-host 1){
}