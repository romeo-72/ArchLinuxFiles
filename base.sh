#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Bucharest /etc/localtime
hwclock --systohc
sed -i '399s/.//' /etc/locale.gen
locale-gen
echo "LANG=ro_RO.UTF-8" >> /etc/locale.conf
echo "KEYMAP=uk" >> /etc/vconsole.conf
echo "legion" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 legion.localdomain legion" >> /etc/hosts
echo root:1972 | chpasswd
useradd -mG wheel romeo
echo romeo:1972 | chpasswd

reflector --verbose --country 'Romania' -l 5 --sort rate --save /etc/pacman.d/mirrorlist

pacman -Syy

pacman -S base-devel efibootmgr btrfs-progs firefox grub dhcpcd wget openssh reflector rsync networkmanager network-manager-applet pacman-contrib flatpak terminus-font

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo

grub-install --target=x86_64-efi --efi-directory=/efi --boot-directory=/boot --bootloader-id=GRUB 

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

#printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




