###############################################
#           --SCRIPT BACKUPDATE--             #
#---------------------------------------------#
# Creator : Cedric H.                         #
# Version : 1.2                               #
# Last Update : 30/01/2023                    #
#---------------------------------------------#
# Download only the files/folders             #
# that have been recently                     #
# modified or created and keeps a copy of     #
# each version of each file                   #
#---------------------------------------------#
#             /!\ SECURITY /!\                #
# 1-Use an IPSEC VPN for remote servers.      #
# 2-Create a Special user for shared folders. #
#---------------------------------------------#
#               Backup Schema                 #
#---------------------------------------------#
#                                             #
# BACKUP_2022/January/01-01-2022              #
#                    /02-01-2022              #
#                    /03-01-2022              #
#                    **-**-*****              #
#            /Febuary/01-02-2022              #
#                    /02-02-2022              #
#                    /**-**-****              #
# BACKUP_2023/January/01-01-2022              #
#                    /02-01-2022              #
#                    /03-01-2022              #
#                    /**-**-****              #
#                                             #
###############################################
cls
Write-Host "----------------------------------"
Write-Host "-------- BACKUPDATE-V1.2 ---------"
Write-Host "----------------------------------"
#$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

################ Variables ####################
#Path to Backup
$BackPath = "B:\BACKUPS"## /!\ CHANGE ME /!\
###############################################


#Annual Folder
$year = (get-date).ToString("yyyy")
$checkpathyear = Test-Path $BackPath\Backup_$year

if( $checkpathyear -eq "True" )
{
Write-Host "Backup_$year exist"	
}
else
{
Write-Host "New Folder : Backup_$year"

#Monthly Folder
New-Item -Force -Path "$BackPath\Backup_$year" -ItemType Directory
}
$month = (get-date).ToString("MMMM")
$checkpathmonth = Test-Path $BackPath\Backup_$year\$month 

if( $checkpathmonth -eq "True" )
{
Write-Host "$month exist"	
}
else
{
Write-Host "New Folder : $month"
$month = (get-date).ToString("MMMM")
New-Item -Force -Path "$BackPath\Backup_$year\$month" -ItemType Directory
}

#Dayly Folder
$dd = (get-date).ToString("dd-MM-yyyy")## /!\ CHANGE ME /!\ --> 01-01-2023
$checkpathday = Test-Path $BackPath\Backup_$year\$month\$dd
if( $checkpathday -eq "True" )
{
Write-Host "$dd exist"	
}
else
{

Write-Host "New Folder : $dd " 
New-Item -Force -Path "$BackPath\Backup_$year\$month\$dd" -ItemType Directory
}

##########################################################################
########################### START BACKUP  ################################

#List of folders you want to backup 
$Path1 = "YourFolder1" ## /!\ CHANGE ME /!\
$Path2 = "YourFolder2" ## /!\ CHANGE ME /!\
$Path3 = "YourFolder3" ## /!\ CHANGE ME /!\
$Path4 = "YourFolder4" ## /!\ CHANGE ME /!\
$Path5 = "YourFolder5" ## /!\ CHANGE ME /!\
$Path6 = "YourFolder6" ## /!\ CHANGE ME /!\
$Folder_to_Back = "$Path1","$Path2","$Path3","$Path4","$Path5","$Path6"
$x=0

while ($x -lt $Folder_to_Back.Count)
{
		#Path to server
		$Path_To_Server = "\\Your\Shared\Folder\On\Server\" ## /!\ CHANGE ME /!\
		$Folder_To_Server = ""
		#Path to Backup
		$Path_To_Backup = "B:\BACKUPS\Backup_$year\$month\$dd\OVH-WEB\WEB\" 
		
        $Folder_To_Backup = $Folder_to_Back[$x]
		Write-Host "------------------------------------------------------"
		Write-Host "Backupdate to : " $Folder_to_Back[$x]
		Write-Host "From : "$Path_To_Server$Folder_To_Backup
		Write-Host "To : "$Path_To_Backup$Folder_To_Backup
		Write-Host "------------------------------------------------------"

		#Selection of folder and sub-folders
		Write-Host "STEP 1 : Retrieving file names in $Path_To_Server$Folder_To_Backup"
		$getfile4a = Get-ChildItem -Path $Path_To_Server$Folder_To_Backup -Recurse

		#Selection of last modification time : example : -22 since 22H
		$DatedeDerniereModif = (Get-date).AddHours(-24)## /!\ CHANGE ME /!\

		#List of files to ignore compared to  "$DatedeDerniereModif"
		Write-Host "STEP 2 : Retrieving the date of last modification"
		$oldfilelist4 = $getfile4a | Where-Object LastWriteTime -lt $DatedeDerniereModif

		#Retrieving the size of the 2 folders to compare them (if the size is equal, no action).
		Write-Host "STEP 3 : Creation of the backup folders"
		New-Item -Force -Path "$BackPath\Backup_$year\$month\$dd\$Folder_To_Backup" -ItemType Directory

			Write-Host "STEP 4 : Copying recently modified files and folders"
			$output4 = 
			foreach ($File in $getfile4a) 
			{
				if ($File.LastWriteTime -gt $DatedeDerniereModif)
				{    
				Write-Output "$File <-----Copying"
				}
				else 
				{
				#Nothing
				}
			}
			Write-Host $output4
		
		#Copying files/folders while excluding the list of files that haven't been modified in the past 24H.
		Copy-Item -Path "$Path_To_Server$Folder_To_Backup\*" -Destination "$Path_To_Backup$Folder_To_Backup" -Exclude $oldfilelist4.Name -Recurse -Force

		$x++	
}

################################ END #####################################
##########################################################################
exit 0
