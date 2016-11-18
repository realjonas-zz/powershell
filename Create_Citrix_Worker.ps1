# ------------------------------------------------------------------------------
# Create Clon of Citrix Worker
# ------------------------------------------------------------------------------


$VM = Get-SCVirtualMachine -VMMServer fascvm01 -Name (Read-Host "Worker so skall Clonas")
$NewVM = (Read-Host "Namn på Ny Worker")

$Cloud = Get-SCCloud -VMMServer fascvm01 | where {$_.Name -eq "Citrix - Workload"}

New-SCVirtualMachine -VM $VM -Name $NewVM -Description "" -UseDiffDiskOptimization -RunAsynchronously -Cloud $Cloud -StartAction NeverAutoTurnOnVM -StopAction ShutdownGuestOS 

# Körs när clonen e klar

$VirtualNetworkAdapter = Get-SCVirtualMachine -VMMServer fascvm01 -Name $NewVM | Get-SCVirtualNetworkAdapter
$VMNetwork = Get-SCVMNetwork -VMMServer fascvm01 -Name "Citrix (VLAN1178)"

Set-SCVirtualNetworkAdapter -VirtualNetworkAdapter $VirtualNetworkAdapter -VMNetwork $VMNetwork -VLanEnabled $true -VLanID 1178 -VirtualNetwork "UplinkSwitch" -MACAddress "00:00:00:00:00:00" -MACAddressType Static -IPv4AddressType Dynamic -IPv6AddressType Dynamic -NoPortClassification


# testar att editerat med git hub

#lägger till en rad till  asdasa