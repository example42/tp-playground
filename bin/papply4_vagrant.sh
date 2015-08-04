#!/bin/sh

if [ $1  ]; then
  manifest=$1
else
  manifest="/vagrant/vagrant/manifests/site.pp"
fi

puppet apply --trace --verbose --report --show_diff --pluginsync --summarize --modulepath "/vagrant/modules_local:/vagrant/modules:/etc/puppet/modules" --hiera_config=/vagrant/vagrant/hiera.yaml --detailed-exitcodes $manifest

