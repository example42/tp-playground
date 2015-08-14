#!/bin/bash
if [ ! -f /opt/puppetlabs/bin/facter ]; then
  apt-get update >/dev/null
  apt-get install -y facter >/dev/null
fi

codename=$(/opt/puppetlabs/bin/facter lsbdistcodename)

cd /root

  if [ ! -f "puppetlabs-release-pc1-${codename}.deb" ] ; then 
    echo "## Installing Puppetlabs repository"
    wget -q http://apt.puppetlabs.com/puppetlabs-release-pc1-${codename}.deb >/dev/null 
    dpkg -i puppetlabs-release-pc1-${codename}.deb >/dev/null 
    apt-get update >/dev/null 
  fi

echo "## Installing Puppet and its dependencies"
dpkg -s puppet >/dev/null 2>&1 || apt-get update >/dev/null 2>&1 ; apt-get install puppet-agent -y >/dev/null 

#[ -f /opt/puppetlabs/bin/puppet ] || ln -s /opt/puppetlabs/bin/puppet /usr/bin/puppet
#ln -s /opt/puppetlabs/bin/facter /usr/bin/facter
#ln -s /opt/puppetlabs/bin/hiera /usr/bin/hiera

echo "## Running /vagrant/bin/papply4_vagrant.sh"

/vagrant/bin/papply4_vagrant.sh
exit $?

