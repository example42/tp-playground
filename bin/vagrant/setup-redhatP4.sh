#!/bin/bash
cd /root

echo "## Ensuring Puppet 4 existence"

rpm -qi epel-release >/dev/null
if [ "x$?" == "x1" ] ; then
  rpm -ivh http://ftp-stud.hs-esslingen.de/pub/epel/6/i386/epel-release-6-8.noarch.rpm >/dev/null # 2>&1
fi

rpm -qi puppetlabs-release-pc1 >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  yum localinstall -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
fi

rpm -qi puppet >/dev/null 2>&1
if [ "x$?" == "x1" ] ; then
  yum install -y puppet >/dev/null # 2>&1
fi

[ -x /usr/bin/puppet ] || ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet

my_exit = $?
puppet --version

exit $my_exit
