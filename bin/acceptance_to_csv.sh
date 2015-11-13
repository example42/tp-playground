#!/bin/bash
output=acceptance.csv
vms=$(ls -1 acceptance/)
vm_list="APP OK KO N/A $(for a in $vms; do echo "$a" ; done)"
echo $vm_list | sed 's/ /,/g'  > $output
for app in $(ls -1 modules/tinydata/data | grep -v default.yaml | grep -v test) ; do
  table_line=$(echo "$app"
  echo "$(find acceptance/ | grep "/$app$"  | grep "success/" | wc -l)"
  echo "$(find acceptance/ | grep "/$app$"  | grep "failure/" | wc -l)"
  echo "$(find acceptance/ | grep "/$app$"  | grep "na/" | wc -l)"
  for vm in $vms ; do
	  echo "$(find acceptance/$vm | grep "/$app$"  | cut -d '/' -f 3)" | sed "s/success/[OK](acceptance\/$vm\/success\/$app)/g" | sed "s/failure/[failure](acceptance\/$vm\/failure\/$app)/g"
  done
  )
  echo $table_line | sed 's/ /,/g' >> $output
done

echo $vm_list | sed 's/ /,/g'  >> $output

count_line_ok="SUCCESS - - - $(for vm in $vms ; do
  find acceptance/ | grep $vm  | grep success | wc -l | sed 's/\n/ /'
done)"
echo $count_line_ok | sed 's/ /,/g'  >> $output

count_line_ko="FAILURE - - - $(for vm in $vms ; do
  find acceptance/ | grep $vm  | grep failure | wc -l | sed 's/\n/ /'
done)"

echo $count_line_ko | sed 's/ /,/g'  >> $output


