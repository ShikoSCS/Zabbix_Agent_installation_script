# Set the download URL and output file path
$url = "https://cdn.zabbix.com/zabbix/binaries/stable/6.4/6.4.13/zabbix_agent-6.4.13-windows-amd64-openssl.msi"
$outputFile = "zabbix_agent.msi"

# Download the Zabbix agent MSI installer
Invoke-WebRequest -Uri $url -OutFile $outputFile

# Define the installation parameters
$installParams = @{
    FilePath     = "msiexec.exe"
    ArgumentList = @(
        "/i"
        "$outputFile"
        "/qn"
        "LOGTYPE=file"
        "LOGFILE=`"C:\Program Files\Zabbix Agent\zabbix_agentd.log`""
        "SERVER=192.168.10.210,192.168.10.126"
        "LISTENPORT=10050"
        "SERVERACTIVE=192.168.10.210,192.168.10.126"
        "HOSTNAME=Windows-Host"
    )
    Wait         = $true
    PassThru     = $true
}

# Install the Zabbix agent silently
$installProcess = Start-Process @installParams

# Wait for the installation to complete
$installProcess.WaitForExit()