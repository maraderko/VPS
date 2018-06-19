!/bin/bash
apt-get update && apt-get -y upgrade
apt install nano -y && apt install htop -y && apt install ufw -y
timedatectl set-timezone 'Europe/Moscow'
#adduser vlad && adduser vlad sudo
sed -i 's/Port 22/Port 333/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
#systemctl restart sshd.service
ufw default allow outgoing
ufw default deny incoming
ufw allow 333/tcp
ufw limit 333/tcp
ufw allow http/tcp
ufw allow https/tcp
ufw logging on
ufw enable -y
#apt -y install mailutils postfix
#newaliases
#systemctl enable postfix
#systemctl restart postfix
apt -y install fail2ban
systemctl enable fail2ban
systemctl start fail2ban
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
systemctl vm.swappiness=10
systemctl -w vm.swappiness=10
systemctl -w vm.vfs_cache_pressure=50
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
