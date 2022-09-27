#***************************************************************************************************************
# Tool: Search PS1 history
# Author: Damien VAN ROBAEYS
# Website: http://www.systanddeploy.com
# Twitter: https://twitter.com/syst_and_deploy
#***************************************************************************************************************

param(
[string]$String,
[switch]$Exportfile,
[switch]$OutGridview
)

If($String -eq "")
	{
		write-warning "String parameter is mandatory"
		EXIT
	}

$Get_History_file = Get-PSReadLineOption | select -ExpandProperty HistorySavePath
$Get_History_Content = Get-Content $Get_History_file
$Get_String = ($Get_History_Content | select-string $String)

If($Exportfile)
	{
		$Exported_File = "$env:temp\PS1_History_File.txt"
		If(test-path $Exported_File){remove-item $Exported_File -force}
		$Get_String | out-file $Exported_File
		invoke-item $Exported_File
	}
	
If($OutGridview)
	{
		$Get_String | out-gridview
	}

If((!($Exportfile)) -and (!($OutGridview)))	
	{
		$Get_String
	}
