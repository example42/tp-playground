#!/bin/bash
role=$1
facts_dir=$(puppet config print pluginfactdest)
mkdir -p $facts_dir
echo "role=${role}" > $facts_dir/facts.txt
