mkdir -p raw
aria2c -c -s 16 -x 16 -k 1M -j 8 -i download-list.txt