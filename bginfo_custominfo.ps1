<#
    Description: get network interface info and write it to a file
    Brian T. Gil 10/23/2022
#>


$nic_macs = @()  #add mac strings here
$format_str = "`n"
$path = "$($env:USERPROFILE)\bginfo_custom_info.txt"
$longest_key_size = 16


$keys = @(
            "Interface",     
            "MAC",      
            "Speed",   
            "IP Address",      
            "Subnet Mask",    
            "Default Gateway", 
            "DNS Servers",    
            "DHCP Enabled",   
            "DHCP servers"
        )


#get key: value spacing
$diffs = @()
foreach ($key in $keys){
    $diffs += $longest_key_size - $key.Length
}


#get info for each interface and build formated string
Get-NetAdapter | ? {
                      $_.MacAddress -in $nic_macs -and $_.Status -eq "Up"    
                     } | % {
                              $values = @()

                              $index = $_.InterfaceIndex

                              $values += $_.InterfaceDescription
                              $values += $_.MacAddress
                              $values += $_.LinkSpeed
                                                
                              $config = (Get-WmiObject Win32_NetworkAdapterConfiguration | ? {$_.InterfaceIndex -eq $index})
                                                
                              $values += $config.IpAddress[0]
                              $values += $config.IPSubnet[0]
                              $values += $config.DefaultIPGateway[0]
                              $values += $config.DNSServerSearchOrder -join ", "
                              $values += $config.IPEnabled
                              $values += $config.DHCPServer
                                                
                              for ($i=0; $i -lt $items.Length; $i++){
                                  $format_str += "$($keys[$i]):$(" " * $diffs[$i])$($values[$i])`n"
                              }

                             }


#write format string to file for bginfo
try {
    Set-Content -path $path -value $format_str  #creates file if it does not exist
}
catch {
    Write-Host $_  #error object
}
