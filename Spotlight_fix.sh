#!/bin/sh

rm -rf /.metadata_never_index
rm -rf /.Spotlight-V100

sleep 1

mdutil -i on -a

exit 0
