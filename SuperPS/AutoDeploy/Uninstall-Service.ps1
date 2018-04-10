#
# Uninstall_Service.ps1
#

[string]$ServicePath = "D:\Services\xxx.exe"

if (-not (Test-Path -Path $ServicePath)) {
    Write-Error -Message "服务可执行程序[$ServicePath]不存在"
    exit
}

$argumentList = New-Object -TypeName System.Collections.ArrayList

# PathName有可能带双引号，所以用like
$service = Get-WmiObject win32_service | Where-Object {$_.PathName -like "*$ServicePath*"}

if (-not($service)) {
    Write-Error "服务不存在!"
    exit
}
$argumentList.Add("/u") | Out-Null
$argumentList.Add($ServicePath) | Out-Null
$installUtil = Join-Path $env:windir "Microsoft.NET\Framework\v4.0.30319\installutil.exe"

$process = Start-Process -FilePath $installUtil -ArgumentList $argumentList -Verb runas -WindowStyle Hidden -Wait -PassThru
Start-Sleep -Seconds 1
if($process){
	Stop-Process $process
}
Write-Host -ForegroundColor Green "服务已卸载成功"