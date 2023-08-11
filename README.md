# Nokov Virtual Machine

This project contains scripts and templates to automatically create the Nokov VM with [Packer](https://www.packer.io).
It's also used for tracking issues and improvements.

The Nokov VM contains everything you need for running the Bitcraze projects and doing development for them. It's a great way to quickly get started without having the hassle of installing dependencies and setting up the development environment.

Here is a non-exhaustive list of what's included:

* Xubuntu 20.04 pre-configured
* VirtualBox guest additions pre-installed
* udev rules and pre-configured USB filtering for the Crazyradio and it's bootloader (NRF BOOT)
* Most of our projects pre-cloned
* QTCreator
* Firefox
* KiCad
* vscode prepared for compiling/debugging/flashing the Crazyflie firmware
* SDCC 3.2 for compiling of Crazyradio firmware
* Ros1 & Ros2 & Crazyswarm1/2

Downloading
-----------
The Nokov VM can be downloaded via the [Github Release Page](https://github.com/NOKOV-MOCAP/nokov-vm/releases)

Installing
----------
The virtual appliance can be imported into [VirtualBox](https://www.virtualbox.org/ "VirtualBox"). You will need the extention package of virtual box to be able to use the USB device. Go to [Oracles download page](https://www.oracle.com/virtualization/technologies/vm/downloads/virtualbox-downloads.html?msclkid=be59f68fcf9f11ec801dcf4ea944dd1d) to install both virtual box and the expansion pack.

It can be used with other virtual machine manager however setting up the guest addition might be required. The following have been tested 

* [Gnome Boxes](https://wiki.gnome.org/Apps/Boxes)
* [VM Player](http://www.vmware.com/products/player/ "WM Player")

Using the virtual machine
-------------------------
After importing just run the machine. It logs in automatically but use the following credentials if needed:
```
User: nokov
Pass: nokovflie
```

In the virtual machine double click the **“update all projects”** icon on the desktop. This pulls down the latest source code from GitHub for all projects.

install hardware
-------------------------

Insert Crazyradio PA in a USB port.
Insert game controller in a USB port.

Optimizing for Use
-------------------------
For faster USB connection with the Crazyradio PA it is advised to filter the USB device at startup of the VM. Go to *settings->USB*, make sure that USB 3.0 is enabled and add a USB device filter for the Crazyflie PA, which should be called 'Bitcraze Crazyradio PA USB Dongle [9955]'.

Also just to be sure, install the guest addition pack from inside the VM by typing: 
`sudo apt-get install virtualbox-guest-additions-iso`

For the rest of the performance of your VM, you can try to increase the base memory (Settings/System/Motherboard), the CPU's available (Settings/System/Processor), enable hardware acceleration and select Hyper-V (Settings/System/Acceleration) or increase the video memory with 3D acceleration enabled (Settings/Display/Screen). This requires some adjusting as this could be different per system you are running the VM from.

# How to build the Nokov VM image

## Pre-requisites

* This script has only been tested on a Linux machine, therefore it's recommended to use Linux to build the Nokov VM
* VirtualBox must be installed as well as the VirtualBox Extension Pack
* Virtual box guest additions
* [Packer](https://www.packer.io)  (can be installed with `apt install packer`)

## Local build

1. Run ```createNokovVM.sh```
2. Wait 40-60 minutes depending on machine and internet connection speed

### What does createNokovVM.sh do?
Run the two [Packer](https://www.packer.io) templates
    * Create the VM and run a preseeded installation (```nokovVM_createVM.json```)
    * Provision the VM (```nokogVM_provisionVM.json```)

### Why are there two packer templates?

To separate the VM creation and installation from the provisioning.
If there is a problem during provisioning, the whole process does not have to start from scratch again.
This saves a lot of time.

### What do the packer templates do?

#### nokovVM_createVM.json

1. Download an ISO and create a VirtualBox image
2. Start the so-called "preseeding", which automatically runs the Ubuntu installer
3. Export VM image to OVA file

#### nokovVM_provisionVM.json
Copy the files specified in the JSON template to the VM and run the `provision.sh` script so setup the image.

### Help! Something does not work.

Please take a look at the log files ```packerlog_create.txt``` and ```packerlog_provision.txt```.


## Contribute
Go to the [contribute page](https://www.bitcraze.io/contribute/) on our website to learn more.

## Summary of common compilation errors
1.nokov@ubuntu:~/Desktop/projects/nokov-vm$ ./createNokovVM.sh  
Running packer...  
OVA file not found. Starting VM creation...  
virtualbox-iso output will be in this color.  
1 error(s) occurred:  
The iso_checksum_type must be specified.  
Starting VM provisioning...  
virtualbox-ovf output will be in this color.  
1 error(s) occurred:  
Source file 'file://./output-virtualbox-iso/NokovVM.ova' needs to exist at time of config validation!  
**Workaround: Update packer version 1.6.0 and above**

2.Build 'virtualbox-iso' errored after 1 millisecond 626 microseconds: Failed creating VirtualBox driver: exec: "VBoxManage": executable file not found in $PATH    
**Workaround: install gueset-additions package**  
`sudo apt-get install virtualbox-guest-additions-iso`    

3.==> virtualbox-iso: Error starting VM: VBoxManage error: VBoxManage: error: VT-x is not available (VERR_VMX_NO_VMX)  
==> virtualbox-iso: VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component ConsoleWrap, interface IConsole    
**Workaround：**  
1）Switch to a VMWare VM   
2）bcdedit /set hypervisorlaunchtype off  
3）VMWareSettings->CPU->Virtualization engine->Check Virtualization InterVT-x option  

4.Still cannot copy and paste vmwaretools after VMWare is installed   
**Workaround:  Execute the following command**    
`sudo apt-get update`    
`sudo apt install open-vm-tools`    
`sudo apt install open-vm-tools-desktop`    
`reboot`   
