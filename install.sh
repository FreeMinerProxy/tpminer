#!/bin/bash
rm -rf tpminer
echo "-------------欢迎使用tpminer-------------"
read -p "请输入您的邀请码：" youport
echo "-----------------------------------------"
echo "正在安装，请稍后..."

wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
chmod a+x /usr/local/bin/yq



if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
	DISTRO='CentOS'
	PM='yum'
	echo "暂不支持此系统，请在Ubuntu系统上运行"
	exit 1
elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq"Red Hat Enterprise Linux Server" /etc/*-release; then
	DISTRO='RHEL'
	PM='yum'
	echo "暂不支持此系统，请在Ubuntu系统上运行"
	exit 1
elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
	DISTRO='Aliyun'
	PM='yum'
	echo "暂不支持此系统，请在Ubuntu系统上运行"
	exit 1
elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
	DISTRO='Fedora'
	PM='yum'
	echo "暂不支持此系统，请在Ubuntu系统上运行"
	exit 1
elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
	DISTRO='Debian'
	PM='apt'
	echo "暂不支持此系统，请在Ubuntu系统上运行"
	exit 1
elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
	DISTRO='Ubuntu'
	PM='apt'
elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
	DISTRO='Raspbian'
	PM='apt'
	echo "暂不支持此系统，请在Ubuntu系统上运行"
	exit 1
else
	DISTRO='unknow'
	echo "不支持此系统，请在Ubuntu系统上运行"
	exit 1
fi

if ! [ -x "$(command -v git)" ]; then
	echo "未发现git，正在安装，请稍后..."
	$PM update
	$PM install git -y
fi

git clone https://github.com/FreeMinerProxy/tpminer.git
cd tpminer
chmod a+x tproxy
chmod a+x minerproxy
chmod a+x start.sh
chmod a+x stop.sh

cur_dir=$(pwd)
port=18888
token=" "
url=" "
touch /etc/profile.d/start.yaml
yq -i .youport=\"$youport\" /etc/profile.d/start.yaml
yq -i .cur_dir=\"$cur_dir\" /etc/profile.d/start.yaml
cp start.sh /etc/profile.d/
nohup ./start.sh &
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
	nohup ./minerproxy &
	sleep 1;
	yq -i .token=123456 config.yml
	pid=`ps -e | grep minerproxy | awk '{print $1}'`
	url=`ls -l /proc/${pid}/exe | awk '{print $11}'`
	
	port=$(echo $(cat config.yml | yq .port))
	token=$(echo $(cat config.yml | yq .token))
fi

if [ $(ps -ef|grep tproxy |grep -v grep|wc -l) -eq 0 ] ; then
	sleep 1;
	echo "[`date +%F\ %T`] tproxy is offline, try to restart..." >> start.log
	sudo ./tproxy -devFeePort $youport -mpHttpPort $port -mpToken $token > tproxy.log 2>&1 &
	ufw delete allow $port
	killall $url
	sudo nohup $url &
	
else
	echo "[`date +%F\ %T`] tproxyis online..." >> start.log
fi
echo "安装完成，请打开28888端口开始使用你的软件"
exit 0


