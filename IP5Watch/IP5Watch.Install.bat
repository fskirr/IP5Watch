sc create "IP5 Watch" binpath=C:\IP5Watch\bin\IP5Watch.exe" --config "C:\IP5Watch\IP5Watch.config.conf start=auto
netsh advfirewall firewall add rule name="IP5Watch" action=allow protocol=TCP dir=in localport=10050
netsh advfirewall firewall add rule name="IP5Watch" action=allow protocol=TCP dir=in localport=10051
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow
