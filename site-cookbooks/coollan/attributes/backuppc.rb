default["coollan"]["backuppc"]["path_sendmail"] = "/usr/bin/sendmail"
default["coollan"]["backuppc"]["mail_from"] = "backuppc@itmood.ru"
default["coollan"]["backuppc"]["mail_to"] = "oleg.selin@gmail.com"

default["coollan"]["backuppc"]["backup"]["from"] = [ "/etc", "/home" ]
default["coollan"]["backuppc"]["backup"]["device"] = "phy1fs1.local:/mnt/nfs/backups"
default["coollan"]["backuppc"]["backup"]["fstype"] = "nfs"
