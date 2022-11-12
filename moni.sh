# NOM ARCHITECHTURE
arch=$(uname -a)
#uname -a = all informations
# NB DE CPU PHYSIQUE
cpuphysique=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
# NB DE CPU VIRTUELS
cpuvirtuel=$(cat /proc/cpuinfo | grep "processor" | wc -l)
# UTILISATION MEMOIRE
memusage=$(free -m | grep Mem | awk '{printf("%s/%sMB (%.2f%%)\n", $3, $2, ($3/$2)*100)}')
#free -m =  display in mebibytes
#printf("%s/%sMB (%.2f%%)\n", $3, $2, ($3/$2)*100)
# UTILISATION DISQUE
diskusage=$(df -h --total | grep total | awk '{printf("%.1f/%.fGb (%s)\n", $3, $2, $5)}')
#df -h          print en puissance de 1024 pr meilleur lecture
#df --total     affiche un grand total
#printf affiche la taille utilisee sur la taille totale et le pourcentage.
# UTILISATION CPU
cpuload=$(top -bn1 | grep Cpu | awk '{printf("%.1f%%\n", $2 + $4)}')
#top -bn1
# -b affiche top par lots selon les linites de -n
# 
# DERNIER REBOOT
lastboot=$(uptime -s | awk '{printf("%s %s\n", $1, substr($2, 1, length($2) - 3))}')
#uptime -s s pour since, depuis
#le printf retire les secondes, substring le deuxieme argument, de la longueur de l'argument moins 3
# VERIFICATION LVM ACTIVE OU NON
lvm=$(lsblk | grep "lvm" | wc -l | awk '{if ($1){printf("yes\n"); exit;} else print "no\n"}')
#assez facile a comprendre
# NOMBRE DE CONNEXIONS TCP
tcp=$(netstat | grep "ESTABLISHED" | wc -l)
# #NOMBRE USERS UTILISANTS LE SERVER
userlog=$(users | wc -w)
# -w compte les mots
# -l compte les lignes
# ADRESSE MAC ET NOM
ip=$(cat /sys/class/net/enp3s0f0/address)
host=$(hostname -I | awk '{print $1}')
# NOMBRE DE COMMANDES SUDO
journalctl _COMM=sudo | grep "COMMAND" | wc -l
echo "#ARCHITECTURE: $arch"
echo "#CPU physiques: $cpuphysique"
echo "#CPU virtuels: $cpuvirtuel"
echo "#Memory Usage: $memusage"
echo "#Disk Usage: $diskusage"
echo "#CPU load: $cpuload"
echo "#Last boot: $lastboot"
echo "#LVM use: $lvm"
echo "#Connections TCP : $tcp"
echo "#User log: $userlog"
echo "#Network: IP $host $ip"
echo "#Sudo : $sudo cmd"

