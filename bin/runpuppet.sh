#!/bin/bash
if [ $1  ]; then
  manifest=$1
else
  manifest="/vagrant/manifests/site.pp"
fi
echo "## Running Puppet version $(puppet --version) on ${manifest}"

puppet --version | grep "^4" > /dev/null

if [ "x$?" == "x0" ] ; then
  /vagrant/bin/papply4_vagrant.sh $manifest
  exitcode=$?
else
  /vagrant/bin/papply_vagrant.sh $manifest
  exitcode=$?
fi

if [ "x$exitcode" == "x0" ] || [ "x$exitcode" == "x2" ] ; then
  exit 0
else
  exit 1
fi
