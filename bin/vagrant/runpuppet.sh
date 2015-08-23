#!/bin/bash

echo "## Running Puppet version $(puppet --version) on /vagrant/manifests/site.pp"

puppet --version | grep "^4" > /dev/null

if [ "x$?" == "x0" ] ; then
  /vagrant/bin/papply4_vagrant.sh
  exitcode=$?
else
  /vagrant/bin/papply_vagrant.sh
  exitcode=$?
fi

if [ "x$exitcode" == "x0" ] || [ "x$exitcode" == "x2" ] ; then
  exit 0
else
  exit 1
fi
