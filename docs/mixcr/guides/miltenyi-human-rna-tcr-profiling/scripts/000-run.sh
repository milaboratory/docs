#!/bin/sh

rerun=false

if $rerun; then
  rm -rf results pa figs
fi

for file in *.sh
do
  if ! grep -q "000-run.sh" $file; then
    if ! grep -q "download" $file; then
          ./$file
    fi
  fi
done;
