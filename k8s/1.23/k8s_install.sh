
systemctl start chronyd
systemctl enable chronyd
date 
systemctl stop firewalld
systemctl disable firewalld
sed -i 's/enforcing/disabled/' /etc/selinux/config # 重启后生效
sed -i '/\/dev\/mapper\/centos-swap/ s/^/#/' /etc/fstab

reboot

