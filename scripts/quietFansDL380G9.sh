# Must be run at every system boot
# Follow https://phoenixnap.com/kb/crontab-reboot to run at system boot

IP=192.168.1.123 # iLO IP
USER='ilo-user'
PWD='ilo-password'
OPT="-o KexAlgorithms=diffie-hellman-group14-sha1,diffie-hellman-group1-sha1 -o HostKeyAlgorithms=ssh-rsa,ssh-dss -o StrictHostKeyChecking=no"

sshpass -p $PWD ssh $OPT $USER@$IP 'fan g stop'
sshpass -p $PWD ssh $OPT $USER@$IP 'fan g start'

for sensor in {01..59}
do
  sshpass -p $PWD ssh $OPT $USER@$IP "fan pid $sensor lo 500"
done
