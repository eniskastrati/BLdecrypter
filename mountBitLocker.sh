#!/bin/bash
#asking user what to do?
echo "- Type 1 to mount a device"
echo "- Type 2 to unmoun a device"
echo 
echo -n "Your INPUT: "
read choice;
echo

if [ "$choice" = "1" ]; then
    #Ask user for the mount partition
    echo "Creating needed Folders in this PC"
    mkdir -p /media/decrypt;
    mkdir -p /media/windows-mount;
    echo
    sudo fdisk -l | tail -2;
    echo -n "Please type in the partition that you want to mount (just the id after /dev/): ";
    #reading the user input to get the device path
    read mountDevice;
    echo
    echo -n Password:
    read -s password;
    echo
    echo "1.******Decryping device into /media/decrypt/";
    sudo dislocker /dev/$mountDevice -u"$password" -- /media/decrypt/;
    echo "2.******Mounting decrypted device into /media/windows-mount/";
    sudo mount -o loop /media/decrypt/dislocker-file /media/windows-mount/;
    echo "******Succesfully mounted******";
fi

if [ "$choice" = "2" ]; then
    #Ask user for the mount partition
    sudo umount /media/windows-mount/
    sudo umount /media/decrypt/
    echo "Succesfully unmounted the device from /media/windows-mount/"
fi

