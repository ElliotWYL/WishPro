#
# Install_Service.ps1
#

# Windows Service�Ŀ�ִ�г���·��
[string]$ServicePath = "D:\Services\xxx.exe"

if (-not (Test-Path -Path $ServicePath)) {
    Write-Error -Message "�����ִ�г���[$ServicePath]������"
    exit
}

$argumentList = New-Object -TypeName System.Collections.ArrayList

# PathName�п��ܴ�˫���ţ�������like
$service = Get-WmiObject win32_service | Where-Object {$_.PathName -like "*$ServicePath*"}

if ($service) {
    Write-Error "�����Ѱ�װ����Ҫ������������ж��!"
    exit
}

$argumentList.Add($ServicePath) | Out-Null
$installUtil = Join-Path $env:windir "Microsoft.NET\Framework\v4.0.30319\installutil.exe"

$process = Start-Process -FilePath $installUtil -ArgumentList $argumentList -Verb runas -WindowStyle Hidden -Wait -PassThru
Start-Sleep -Seconds 1
if($process){
	Stop-Process $process
}
Write-Host -ForegroundColor Green "�����Ѱ�װ�ɹ�"