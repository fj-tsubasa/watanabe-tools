#!/bin/bash

podman rm -fa
podman rmi -fa

rm -f testfile1
rm -f Dockerfile
rm -f testcnt.tar

if [[ -f prevent_error_tarball ]];then
  rm -f prevent_error_tarball
fi

