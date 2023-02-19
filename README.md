# BackupDate

![BackupDate](https://github.com/DrM4CH1N3/BackupDate/blob/Shell/BD_icon.png)

Simple script of Daily Versioning Backup

          This PowerShell backup script allows you to create a backup of recently modified or created files. 
          It uses the "Get-ChildItem" command to search for all files and folders in the specified source directory, 
          and then uses the "LastWriteTime" property to determine if the file has been modified since the last backup.
          If so, the file is downloaded to the specified backup location.

          The script is designed to only download files that have been modified or created since the last backup,
          which minimizes the time required to perform the backup and reduces the use of backup storage space.
          The script can be configured to run automatically at regular intervals using the Windows Task Scheduler.

          The script is easily customizable to include or exclude certain files or folders based on your needs.
          
          
          
          
          
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
