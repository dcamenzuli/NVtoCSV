# Required Variables for all stuff
$fileInput = Get-Content .\sample.txt
$fileSize = $fileInput.Length
$fileOutput = @()

# Loop for all items in Array
for($i = 0; $i -lt $fileSize; ++$i)
{
	$decode = ''
	$tcpSocket = ''
	$udpSocket = ''
	$tcpPort = ''
	$udpPort = ''
	$ipAddress = ''
	$urlPath = ''
	$rdbName = ''
	$citrixServer = ''
	$ofr = ''
	$guid = ''
	$rpc = ''
	
	$write = 0
	
	# If it's not an AppName, put it in the correct category
	Switch -regex ($fileInput[$i])
	{
		"....DATE=.*"{}
		"....SERVER=.*"{}
		"....TRACKUSAGE=.*"{}
		"....DISABLE=.*"{}
		"....RESPONSECALC=.*"{}
		""{}
		"\[.*\].*"
		{
			# Remove the [] around the AppName 
			$fileInput[$i] = $fileInput[$i] -Replace '[][]', ''
			# Remove the description following the App Name
			$AppName = $fileInput[$i] -Replace ".#.*", ''
		}
		"....DECODE=.*"
		{
			$decode = $fileInput[$i] -Replace ".*=", ''
		}
		"....TCPSOCKET=.*"
		{
			$tcpSocket = $fileInput[$i] -Replace ".*=", ''
		}
		"....UDPSOCKET=.*"
		{
			$udpSocket = $fileInput[$i] -Replace ".*=", ''
		}
		"....TCP=.*"
		{
			$tcpPort = $fileInput[$i] -Replace ".*=", ''
		}
		"....UDP=.*"
		{
			$udpPort = $fileInput[$i] -Replace ".*=", ''
		}
		"....ADDRESS=.*"
		{
			$ipAddress = $fileInput[$i] -Replace ".*=...", ''
		}
		"....URL=.*"
		{
			$urlPath = $fileInput[$i] -Replace ".*=", ''
		}
		"....RDBNAME=.*"
		{
			$rdbName = $fileInput[$i] -Replace ".*=", ''
		}
		"....CITRIXSERVER=.*"
		{
			$citrixServer = $fileInput[$i] -Replace ".*=", ''
		}
		"....OFR=.*"
		{
			$ofr = $fileInput[$i] -Replace ".*=", ''
		}
		"....GUID=.*"
		{
			$guid = $fileInput[$i] -Replace ".*=", ''
		}
		"....RPC=.*"
		{
			$guid = $fileInput[$i] -Replace ".*=", ''
		}
	}
	
	# Create the Row object and set the column values
	$row = New-Object PSObject
	$row | Add-Member -MemberType NoteProperty -Name 'Application Name' -Value $AppName
	$row | Add-Member -MemberType NoteProperty -Name 'Decode' -Value $decode
	$row | Add-Member -MemberType NoteProperty -Name 'TCP Socket' -Value $tcpSocket
	$row | Add-Member -MemberType NoteProperty -Name 'UDP Socket' -Value $udpSocket
	$row | Add-Member -MemberType NoteProperty -Name 'TCP Port' -Value $tcpPort
	$row | Add-Member -MemberType NoteProperty -Name 'UDP Port' -Value $udpPort
	$row | Add-Member -MemberType NoteProperty -Name 'IP Address' -Value $ipAddress
	$row | Add-Member -MemberType NoteProperty -Name 'URL Path' -Value $urlPath
	$row | Add-Member -MemberType NoteProperty -Name 'RDB Name' -Value $rdbName
	$row | Add-Member -MemberType NoteProperty -Name 'Citrix Server' -Value $citrixServer
	$row | Add-Member -MemberType NoteProperty -Name 'OFR' -Value $ofr
	$row | Add-Member -MemberType NoteProperty -Name 'GUID' -Value $guid
	$row | Add-Member -MemberType NoteProperty -Name 'RPC' -Value $rpc
	$fileOutput += $row
}

# Create the CSV from the $row object
$fileOutput | Export-CSV -Path .\sample.csv


