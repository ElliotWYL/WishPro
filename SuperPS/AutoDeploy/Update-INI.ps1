#
# Update_INI.ps1
#

Param(
    [string]$filePath,
    [string]$section,
    [string]$key,
    [string]$val
)

#加载winapi  
$ini = Add-Type -MemberDefinition @"  
[DllImport("Kernel32")]  
public static extern long WritePrivateProfileString (  
string section ,  
string key ,   
string val ,   
string filePath );  
[DllImport("Kernel32")]  
public static extern int GetPrivateProfileString (  
string section ,    
string key ,   
string def ,   
StringBuilder retVal ,    
int size ,   
string filePath );   
"@ -PassThru -Name MyPrivateProfileString -UsingNamespace System.Text  
 
$retVal = New-Object System.Text.StringBuilder(500)  
 
#生成或修改配置文件  
$null = $ini::WritePrivateProfileString($section, $key, $val, $filePath)  
 
#查看配置文件  
$null = $ini::GetPrivateProfileString($section, $key, "", $retVal, 500, $filePath)  
Write-Host -ForegroundColor Green "[Modify]" $key "=" $retVal.ToString()