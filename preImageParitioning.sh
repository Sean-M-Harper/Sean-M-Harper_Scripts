#!/bin/bash

diskID=$(diskUtil list | awk ‘/GUID_partition_scheme/ { print $5 }’)

diskUtil partitionDisk $diskID 3 GPT JHFS+ “Macintosh HD” 100G JHFS+ “Recovery HD” 850M JHFS+ “Users HD” R
