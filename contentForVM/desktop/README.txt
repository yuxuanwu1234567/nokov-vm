Welcome to the Nokov VM
==========================

The purpose of this virtual machine is to quickly get started with development
and usage of various Bitcraze projects. It has all of the requirements for
running and developing pre-installed as well as some other useful tools.

For more information about how to get Started with the Crazyflie and other
Bitcraze project, you can look at https://bitcraze.io/start.

The virtual machine
-------------------

 * The username is: nokov
 * The password is: nokovflie
 * The virtual machine has 30GB drive and 2 GB of RAM
 * The virtual machine is using Xubuntu 20.04 LTS Core (minimal) install.

Installed software
------------------
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
 * Ros Noetic
 * Ros2 galactic

For a more detailed description of what is being installed on top of an Xubuntu
core install, you can look at the provision.sh script in the Nokov VM git
repos: https://github.com/NOKOV-MOCAP/nokov-vm/blob/master/provision.sh

Projects
--------
The following projects have been pre-cloned into the /home/nokov/projects 
directory:
 * crazyflie-pc-client
 * crazyflie-firmware
 * crazyflie-bootloader
 * crazyradio-firmware
 * crazyradio-electronics
 * crazyflie2-nrf-firmware
 * crazyflie2-stm-firmware
 * crazyflie2-stm-bootloader
 * crazyswarm
 * crazyswarm2
 * motion_capture_tracking
 * mocap_nokov

How to run the Crazyflie PC client
----------------------------------
The Crazyflie PC client can be run by using the following command:

python3 -m cfclient.gui

Or by using the shortcut on the desktop.

How to update to the latest versions of the repositories
--------------------------------------------------------
Updating to the latest versions of all the repositories can be done
by using the following command:

/home/nokov/update_all_projects.sh

Or using the shortcut on the desktop.

How to Switch the ros version to the ros2
--------------------------------------------------------
default is the ros noetic because the source command has been added to the bashrc file,
by using the following command:

source /opt/ros/galactic/setup.bash
