#!/bin/sh
# Using this script because github action passess the arguments as strings
# instead of array
echo ">>> Running sls $@"
sls $@
echo ">>> Compleated"
