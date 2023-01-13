#!/bin/bash
rm -rf ttcms.sh
if [ `cat /proc/version | grep -e Ubuntu -e Debian | wc -l` -gt 0 ];then
apt-get install git -y
else
yum install git -y
fi
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
systemctl enable docker && systemctl restart docker
mkdir -p /usr/local/html && cd /usr/local/html && rm -rf cms
git clone https://taxijun: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@github.com/taxijun/ncys.git cms
chmod -R 777 /usr/local/html/cms
docker stop ttcms >/dev/null 2>&1
docker rm ttcms >/dev/null 2>&1
docker login -u karolynpabelickdhj54 -p 354067c5-f883-4607-8cf0-8fac700bc237
docker run -itd --name ttcms -p 80:80 -p 443:443 -v /usr/local/html/cms:/usr/local/html/cms -v /sys/fs/cgroup:/sys/fs/cgroup --restart=always --privileged=true karolynpabelickdhj54/ttcms:1.3 /usr/sbin/init
echo "Everything is ok!"
echo "Open the website: http://`hostname -I|awk '{print $1}'`"