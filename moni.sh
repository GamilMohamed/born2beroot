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
# -b affiche top par lots selon les limites de -n
# printf additionne les colonnes du 2ieme arg et 4ieme arg
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
journalctl -q _COMM=sudo | grep "COMMAND" | wc -l
# -q retire le message d'avertissement
# _COMM permet de recuperer la commande desiree
wall echo "#ARCHITECTURE: $arch
#CPU physiques: $cpuphysique
#CPU virtuels: $cpuvirtuel
#Memory Usage: $memusage
#Disk Usage: $diskusage
#CPU load: $cpuload
#Last boot: $lastboot
#LVM use: $lvm
#Connections TCP : $tcp
#User log: $userlog
#Network: IP $host ($ip)
#Sudo : $sudo cmd"

