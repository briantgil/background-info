<#
    Description: get network interface info and write it to a file
    Brian T. Gil 10/23/2022
#>


$nic_macs = @()  #add mac strings here
$format_str = ""
$path = "$($env:USERPROFILE)\bginfo_custom_info.txt"
$longest_word_size = 16


$words = @(
            "Interface",
            "Speed",     
            "MAC",         
            "IP Address",      
            "Subnet Mask",    
            "Default Gateway", 
            "DNS Servers",    
            "DHCP Enabled",   
            "DHCP servers"
        )


foreach ($word in $words){
    $diffs += $longest_word_size - $word.Length
    #write-host "$($word): $($diffs[-1])"
}


Get-NetAdapter | ? {$_.MacAddress -in $nic_macs -and $_.Status -eq "Up"} | % {

                                                $index = $_.InterfaceIndex
                                                $name = $_.InterfaceDescription
                                                $mac = $_.MacAddress
                                                $speed = $_.LinkSpeed
                                                $config = (Get-WmiObject Win32_NetworkAdapterConfiguration | ? {$_.InterfaceIndex -eq $index})
                                                $ipaddr = $config.IpAddress[0]
                                                $mask = $config.IPSubnet[0]
                                                $dg = $config.DefaultIPGateway[0]
                                                $nameservers = $config.DNSServerSearchOrder -join ", "
                                                $mac = $config.MACAddress
                                                $is_dhcp = $config.IPEnabled
                                                $dhcp_server  = $config.DHCPServer
                                                $format_str += @"
`n$($words[0]):$(" " * $diffs[0])$name
$($words[1]):$(" " * $diffs[1])$speed
$($words[2]):$(" " * $diffs[2])$mac
$($words[3]):$(" " * $diffs[3])$ipaddr
$($words[4]):$(" " * $diffs[4])$mask
$($words[5]):$(" " * $diffs[5])$dg
$($words[6]):$(" " * $diffs[6])$nameservers
$($words[7]):$(" " * $diffs[7])$is_dhcp
$($words[8]):$(" " * $diffs[8])$dhcpservers`n
"@
}


#$format_str
try {
    Set-Content -path $path -value $format_str  #creates file if it does not exist
}
catch {
    Write-Host $_
}
