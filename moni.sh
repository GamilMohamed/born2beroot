arch=$(uname -a)
cpuphysique=$(cat /proc/cpuinfo | grep "physical id" | wc -l)
cpuvirtuel=$(cat /proc/cpuinfo | grep "processor" | wc -l)
memusage=$(free -m | grep Mem | awk '{printf("%s/%sMB (%.2f%%)\n", $3, $2, ($3/$2)*100)}')
diskusage=$(df -h --total | grep total | awk '{printf("%.1f/%.fGb (%s)\n", $3, $2, $5)}')
cpuload=$(top -bn1 | grep Cpu | awk '{printf("%.1f%%\n", $2 + $4)}')
lastboot=$(uptime -s | awk '{printf("%s %s\n", $1, substr($2, 1, length($2) - 3))}')
lvm=$(lsblk | grep "lvm" | wc -l | awk '{if ($1){printf("yes\n"); exit;} else print "no\n"}')
tcp=$(netstat -an | grep "ESTABLISHED" | wc -l)
userlog=$(users | wc -w)
ip=$(cat /sys/class/net/enp3s0f0/address)
host=$(hostname -I | awk '{print $1}')
#NOM ARCHITECHTURE
echo "#ARCHITECTURE: $arch"

# #NB DE CPU PHYSIQUE
echo "#CPU physiques: $cpuphysique"

#NB DE CPU VIRTUELS
echo "#CPU virtuels: $cpuvirtuel"
# #UTILISATION MEMOIRE
echo "#Memory Usage: $memusage"

# UTILISATION DISQUE
echo "#Disk Usage: $diskusage"
# UTILISATION CPU
echo "#CPU load: $cpuload"

# #DERNIER REBOOT
echo "#Last boot: $lastboot"
# #VERIFICATION LVM ACTIVE OU NON
echo "#LVM use: $lvm"

# #NOMBRE DE CONNEXIONS TCP
echo "#Connections TCP : $tcp"
# #NOMBRE USERS UTILISANTS LE SERVER
echo "#User log: $userlog"

# #ADRESSE MAC ET NOM
echo "#Network: IP $host $ip"
# #NOMBRE DE COMMANDES SUDO
# journalctl _COMM=sudo | grep "COMMAND" | wc -l


