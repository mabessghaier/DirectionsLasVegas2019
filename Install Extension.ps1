# This should be run on the service tier

# App name
$AppName="App Name"
$OldVersion= "1.0.0.0"
$NewVersion = "1.0.0.1"

# Change path and file name if needed
$NewAppFile= "C:\apps\SimCrest_"+$AppName+"_"+$NewVersion+".app"
# Change Server Instance to the instance you use
$ServInstance= "BC130"

# Change the path to the RTC client as needed
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\130\RoleTailored Client\NavModelTools.ps1' 

# First uninstall old version
UnInstall-NAVApp -ServerInstance $ServInstance -Name $AppName -Force
UnPublish-NAVApp -ServerInstance $ServInstance -Name $AppName -Version $OldVersion
# Upgrade to new version
Publish-NAVApp -ServerInstance $ServInstance -Path $NewAppFile -SkipVerification
Sync-NAVApp -ServerInstance $ServInstance -Name $AppName  # -Mode Development
# Only use if -Mode Development is used
# Install-NAVApp -ServerInstance $ServInstance -Name $AppName -Version $NewVersion
Start-NavAppDataUpgrade -ServerInstance $ServInstance -Version $NewVersion -Name $AppName

# List Apps on Service Tier
Get-NAVAppInfo -ServerInstance $ServInstance