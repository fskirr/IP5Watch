# Script que verifica se existe algum tipo de Snapshot (Checkpoint) nas VMs ligadas
# e escreve o seguinte retorno para o Zabbix buscar:
#   0 - Sem Snapshot nas VMs
#   1 - snapshot com menos de 3 dias
#   2 - Snapshot entre 3 a 6 dias
#   3 - Snaphost com 6 dias ou mais
#   99 - erro na consulta
# Criado Por Luiz H. Ignacio Jr
# editado 28/01/21
# Versao 3
Clear-Host

$ResultadoSnap = 0
Try {
    $Vms = Get-VM -ErrorAction Stop | Where-Object {$_.State -eq 'Running'} 
    $VMArray = @{ }
    $CountArray = 0   
    ForEach ($Vm in $Vms) {
        $VMSnap = (Get-VMSnapshot -VMName $Vm.name | Select-Object VMName, Name, SnapshotType, CreationTime, ComputerName)

        IF (($null -ne $VMSnap.CreationTime ) -and ($VMSnap.SnapshotType -eq 'Standard') -and ($ResultadoSnap -lt 3)) {
            $TempoSnap = new-timespan $VMSnap.CreationTime (get-date)
            $VMArray[$Vm.name] += @{NomeVM = $VMSnap.VMName; NomeSnap = $VMSnap.Name; Tipo = $VMSnap.SnapshotType; Data = $VMSnap.CreationTime; Host = $VMSnap.ComputerName; Tempo = $temposnap; }
            
            switch (($VMArray[$Vm.name].tempo.days)) {
                { $_ -lt 3 }  { if ($ResultadoSnap -lt 2) {$ResultadoSnap = 1}}
                { $_ -ge 3 -and $_ -lt 5 } { if ($ResultadoSnap -lt 3) {$ResultadoSnap = 2}}
                { $_ -ge 5 } { $ResultadoSnap = 3}
            } 
            $CountArray += 1

        }
        $VMSnap = ""
    }
}        
Catch {
    $ResultadoSnap = 99
}
Write-Host $ResultadoSnap