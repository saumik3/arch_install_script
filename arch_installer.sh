echo "Enter the efi partiton:"

read efi_part

echo "Enter root partiton:"

read root_part

echo "Enter the swap partition:"

read swap_part

mkfs.fat -F 32 $efi_part

mkfs.ext4 $root_part

mkswap $swap_part

mount $root_part /mnt

mount --mkdir $efi_part /mnt/boot

swapon $swap_part

pacstrap -K /mnt base linux linux-firmware grub Network-Manager iwd

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Region/City /etc/localtime

hwclock --systohc

nano /etc/locale.gen

locale-gen


echo LANG=en_US.UTF-8 > /etc/locale.conf

nano /etc/hostname

mkinitcpio -P

passwd

grub-install /dev/sda

grub-mkconfig -o /boot/grub/grub.cfg

umount -a 

reboot




