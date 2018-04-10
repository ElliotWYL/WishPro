#
# Script1.ps1
#

$config = "C:\Users\elliot.wang\Desktop\Web.config"
$doc = New-Object System.Xml.XmlDocument
$doc.Load($config)

$doc.get_DocumentElement().applicationSettings."GroupM.Minder.Web.Properties.Settings".setting.SerializeAs = "modify name."
$doc.SelectSingleNode("configuration/appSettings/add[@key='UseWebService']").Value="modify appSetting - UseWebService"

# DBConnection
$dataSourceParttern = "source=.*?;"
$dbNameParttern = "catalog=.*?;"
$connectionNode = $doc.SelectSingleNode("configuration/connectionStrings/add[@name='MOOC_OTVDB']")
$connectionNode.ConnectionString = $connectionNode.ConnectionString -replace $dataSourceParttern,("source="+$DataSource+";") -replace $dbNameParttern,("catalog="+$DBName+";")

$doc.Save($config)