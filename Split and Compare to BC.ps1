# You may have to load this if running first time
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

# Load Prerequisites
Import-Module 'C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\130\RoleTailored Client\NavModelTools.ps1' 

# Export objects from from base line
# Place original.txt as all baseline objects that are modified in MOD file
# Place modified.txt as baseline plus all modified objects that needs to be in extension
Split-NAVApplicationObjectFile -Source c:\al\original.txt -Destination 'c:\al\ORG' -Force
Split-NAVApplicationObjectFile -Source C:\al\modified.txt -Destination 'c:\al\MOD' -Force

# Compare
Compare-NAVApplicationObject -OriginalPath c:\al\ORG -ModifiedPath c:\al\MOD -DeltaPath c:\al\DELTA -Force -ExportToNewSyntax

# Create AL files
cd 'C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\130\RoleTailored Client'
.\txt2al.exe --source=c:\al\delta --target=c:\al\al
