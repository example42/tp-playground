#!/bin/bash
output=acceptance.md
vms=$(ls -1 acceptance/)

header=$(cat <<EOF
# Tiny Puppet acceptance test results

### Generated: `date`
EOF
)

table_head=$(
  echo " | APP " ;
  for a in $vms; do
    echo "| " ; echo $a ; echo " "
  done
  echo "|"
  echo)

echo $header > $output
echo $table_head >> $output

  for app in $(ls -1 modules/tinydata/data | grep -v default.yaml | grep -v test) ; do
    table_line=$(echo "| $app "
    for vm in $vms ; do
      echo "| "
      echo $(find acceptance/$vm | grep "/$app$"  | cut -d '/' -f 3)
      echo " " 
      echo
    done
    echo "|\n"
    echo)
    echo $table_line >> $output
  done




