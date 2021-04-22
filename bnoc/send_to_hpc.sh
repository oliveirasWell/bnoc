#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

rm -rf bnoc.simg
sudo singularity build -F bnoc.simg Singularity


