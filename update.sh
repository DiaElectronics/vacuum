#!/bin/bash

if [ -f ./firmware.exe ]; then
  echo "copying firmware..."
  cp firmware.exe firmware.exe_
fi

git reset --hard
git pull

