#####################################################
#
# Test remote server by https.
# Output server name when remoting server
#
#####################################################

$account = "DomainName\AccountName"
$password = "Password"
$serverIP = "10.139.168.1"

$securepwd = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential -ArgumentList $account, $securepwd


$session = New-PSSession -ComputerName $serverIP -Credential $credential -UseSSL

Invoke-Command -Session $session -ThrottleLimit 1 -ScriptBlock {
    # Todo on the remote server.

	# Output remote server name
    Write-Host -ForegroundColor Green (hostname)
}

Remove-PSSession $session