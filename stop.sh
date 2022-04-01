
while [ 1 ] ; do
	if [ $(ps -ef|grep start.sh |grep -v grep|wc -l) -ne 0 ];then
		pid=`ps -e | grep start.sh | awk '{print $1}'`
		kill $pid
	else
		break
	fi
done
killall minerproxy 
killall tproxy 