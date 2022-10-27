<#
    Description: get network interfaces and write them to a file
    Brian T. Gil 10/27/2022
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
$spaces = @()
foreach ($key in $keys){
    $spaces += $longest_key_size - $key.Length
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
                              $values += $config.DHCPEnabled
                              $values += $config.DHCPServer
                                                
                              for ($i=0; $i -lt $values.Length; $i++){
                                  $format_str += "$($keys[$i]):$(" " * $spaces[$i])$($values[$i])`n"
                              }

                             }


if ($format_str -eq "`n"){
    $format_str += "WARNING: No MACs defined in list ($($PSCommandPath))`n"
}


#write format string to file
try {
    Set-Content -path $path -value $format_str  #creates file if it does not exist
}
catch {
    Write-Host $_  #error object
}
