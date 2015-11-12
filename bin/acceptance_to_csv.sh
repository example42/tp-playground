#!/bin/bash
output=acceptance.csv
vms=$(ls -1 acceptance/)
vm_list="APP OKs $(for a in $vms; do echo "$a" ; done)"
echo $vm_list | sed 's/ /,/g'  > $output
for app in $(ls -1 modules/tinydata/data | grep -v default.yaml | grep -v test) ; do
  table_line=$(echo "$app"
  echo "$(find acceptance/ | grep "/$app$"  | grep "success/" | wc -l)"
  for vm in $vms ; do
    echo "$(find acceptance/$vm | grep "/$app$"  | cut -d '/' -f 3)" | sed 's/success/OK/g'
  done
  )
  echo $table_line | sed 's/ /,/g' >> $output
done

count_line_ok="OK - $(for vm in $vms ; do
  find acceptance/ | grep $vm  | grep success | wc -l | sed 's/\n/ /'
done)"
echo $count_line_ok | sed 's/ /,/g'  >> $output

count_line_ko="KO - $(for vm in $vms ; do
  find acceptance/ | grep $vm  | grep failure | wc -l | sed 's/\n/ /'
done)"

echo $count_line_ko | sed 's/ /,/g'  >> $output

echo $vm_list | sed 's/ /,/g'  >> $output

