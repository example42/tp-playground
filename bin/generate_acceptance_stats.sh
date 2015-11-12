#!/bin/bash
# Requires: pip3 install csvtomd

output=acceptance.md
vms=$(ls -1 acceptance/)
bin/acceptance_to_csv.sh

echo "# Tiny Puppet acceptance test results" > $output
echo "### Generated: $(date)" >> $output
csvtomd acceptance.csv >> $output



