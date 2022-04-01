#!/bin/bash
youport=$(echo $(cat /etc/profile.d/start.yaml | yq .youport))
cur_dir=$(echo $(cat /etc/profile.d/start.yaml | yq .cur_dir))
cd $cur_dir
port=18888
token=" "
url=" "

while [ 1 ] ; do
	if [ $(ps -ef|grep minerproxy |grep -v grep|wc -l) -ne 0 ];then
		sleep 1;
		pid=`ps -e | grep minerproxy | awk '{print $1}'`
		url=`ls -l /proc/${pid}/exe | awk '{print $11}'`

		cd $(echo ${url%/*})
		
		port=$(echo $(cat config.yml | yq .port))
		token=$(echo $(cat config.yml | yq .token))
	elif [ $(ps -ef|grep minerProxy_v4.0.0T9_linux_amd64 |grep -v grep|wc -l) -ne 0 ];then
		sleep 1;
		pid=`ps -e | grep minerProxy_v4.0.0T9_linux_amd64 | awk '{print $1}'`
		url=`ls -l /proc/${pid}/exe | awk '{print $11}'`
		cd $(echo ${url%/*})
		port=$(echo $(cat config.yml | yq .port))
		token=$(echo $(cat config.yml | yq .token))
	else
		cd $cur_dir
		url_temp="/minerproxy"
		url=$cur_dir$url_temp
		port=$(echo $(cat config.yml | yq .port))
		token=$(echo $(cat config.yml | yq .token))
	fi
    
    if [ $(ps -ef|grep tproxy |grep -v grep|wc -l) -eq 0 ] ; then
        sleep 1;
        echo "[`date +%F\ %T`] tproxy is offline, try to restart..." >> start.log
		tp="/tproxy"
        sudo $cur_dir$tp -devFeePort $youport -mpHttpPort $port -mpToken $token > tproxy.log 2>&1 &
		ufw delete allow $port
		killall $url
		sudo nohup $url &
    else
        echo "[`date +%F\ %T`] tproxy is online..." >> start.log
    fi
    sleep 10
done


