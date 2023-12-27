@echo off

set PACKER_FILE1=nokovVM_createVM.json
set PACKER_FILE2=nokovVM_provisionVM.json

set CONTENT_DIR=contentForVM\

set VMX_FILE=NokovVM.vmx

rem Run packer
echo Running packer...
set PACKER_LOG=1

rem If VMX already exists, skip VM creation step
if exist "output-vmware-iso\%VMX_FILE%" (
  echo VMX file found. Skipping VM creation...
) else (
  echo VMX file not found. Starting VM creation...
  set PACKER_LOG_PATH=packerlog_create.txt
  packer build %PACKER_FILE1%
)
echo Starting VM provisioning...
set PACKER_LOG_PATH=packerlog_provision.txt
packer build %PACKER_FILE2%