#!/bin/bash

PACKER_FILE1=nokovVM_createVM.json
PACKER_FILE2=nokovVM_provisionVM.json

CONTENT_DIR="contentForVM/"

OVA_FILE=NokovVM.ova

#Run packer
echo "Running packer..."
export PACKER_LOG=1

#If OVA already exists, skip VM creation step
if [ -f "output-virtualbox-iso/$OVA_FILE" ]
then
  echo "OVA file found. Skipping VM creation..."
else
  echo "OVA file not found. Starting VM creation..."
  export PACKER_LOG_PATH="packerlog_create.txt"
  packer build $PACKER_FILE1
fi
echo "Starting VM provisioning..."
export PACKER_LOG_PATH="packerlog_provision.txt"
packer build $PACKER_FILE2
