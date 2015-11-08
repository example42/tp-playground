#!/bin/bash
vm_list="Centos7 Centos6 Ubuntu1404 Ubuntu1204 Debian8_P3 Debian7 Debian6"
if [ "x$1" == "x" ]; then
  app='all'
else
  app=$1
fi

for vm in $vm_list ; do
  vagrant up $vm
done

bin/test.sh $app all acceptance

