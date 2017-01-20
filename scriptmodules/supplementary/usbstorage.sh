#!/usr/bin/env bash

# Script made by Riccardo Bux as part of RetroPie project
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#

rp_module_id="usbstorage"
rp_module_desc="Configure usb"
rp_module_section="config"

function install_usbstorage() {
apt-get update
apt-get install -y ntfs-3g exfat-fuse usbmount
mkdir /mnt/usb
}

function remove_fstab(){
if grep -q "/mnt/usb" "/etc/fstab"; then
sed -i "s/UUID=.*/ /g" /etc/fstab
printMsgs "dialog" "Usb removed"
else
printMsgs "dialog" "Nothing to remove"
fi
}

function usb_share(){
local options=(
1 "Set usb for samba shares"
2 "No thanks, I will use it without network sharing"
)
local cmd=(dialog --backtitle "$__backtitle" --menu "Do you want to share usb in your local network? (Need Samba installed)" 22 86 16)
local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
[[ "$choice" -eq 1 ]] && cp /etc/samba/smb.conf /etc/samba/smb.conf.bak && write_shares 
[[ "$choice" -eq 2 ]] && return
}
function write_shares(){
if grep -q "/mnt/usb" "/etc/samba/smb.conf"; then
printMsgs "dialog" "Usb already setted in /etc/samba/smb.conf, if doesn't work as you expect: restore backup from previous menu, or remove manually part from [usb] to force user=pi in your /etc/smb/smb.conf file and try again"
else
cat >>/etc/samba/smb.conf <<_EOF_
[usb]
comment = usb share
path = /mnt/usb
writable = yes
guest ok = yes
create mask = 0644
directory mask = 0755
force user = pi
_EOF_
fi
} 

function set_usb(){
usb_path_from_rp="$usb_path/configs/from_retropie"
usb_path_to_rp="$usb_path/configs/to_retropie"
local usb_path
    usb_path1="$(choose_usb)"
if [[ "$usb_path1" == "" ]]; then
printMsgs "dialog" "No usb drive detected"
return
fi
	fs=$(eval $(blkid /dev/$usb_path1 | awk '{print $3}'); echo $TYPE)
	umount /dev/$usb_path1
	umount /mnt/usb
	mount /dev/$usb_path1 /mnt/usb
	uuid=$(blkid /dev/$usb_path1 -sUUID | cut -d'"' -f2)
        

function write_fstab(){

if grep -q "/mnt/usb" "/etc/fstab"; then
sed -i "s/UUID=.*/UUID=$uuid \/mnt\/usb $fs noauto/g" /etc/fstab
else
echo "UUID=$uuid /mnt/usb $fs noauto" >> /etc/fstab
fi
}

usb_path=/mnt/usb
if [[ -d $usb_path/retropie ]]; then
local options=(
1 "Continue and use this usb anyway"
2 "Exit"
)

local cmd=(dialog --backtitle "$__backtitle" --menu "It seems that this usb was already used with retrorangepi" 22 86 16)
local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
[[ "$choice" -eq 1 ]] && mkdir -p "$usb_path/retropie/"{roms,BIOS} "$usb_path_from_rp" "$usb_path_to_rp" && mkdir -p "$usb_path/retropie/roms/"{amiga,amstradcpc,apple2,arcade,atari2600,atari5200,atari7800,atari800,atarilynx,atarist,c64,coco,coleco,crvision,daphne,dragon32,dreamcast,fba,fds,gameandwatch,gamegear,gb,gba,gbc,genesis,intellivision,kodi,love,macintosh,mame-advmame,mame-libretro,mame-mame4all,mastersystem,megadrive,msx,n64,neogeo,nes,ngp,ngpc,pc,pcengine,ports,psp,psx,scummvm,sega32x,segacd,sg-1000,snes,vectrex,videopac,virtualboy,wonderswan,wonderswancolor,zmachine,zxspectrum} && rm -rf /home/$user/RetroPie/roms/amiga/usb && mount --bind $usb_path/retropie/roms/amiga /home/$user/RetroPie/roms/amiga/usb && rm -rf /home/$user/RetroPie/roms/nes/usb && mount --bind $usb_path/retropie/roms/nes/ /home/$user/RetroPie/roms/nes/usb && rm -rf /home/$user/RetroPie/roms/amstradcpc/usb && rm -rf /home/$user/RetroPie/roms/apple2/usb && rm -rf /home/$user/RetroPie/roms/arcade/usb && rm -rf /home/$user/RetroPie/roms/atari2600/usb && rm -rf /home/$user/RetroPie/roms/atari5200/usb && rm -rf /home/$user/RetroPie/roms/atari7800/usb && rm -rf /home/$user/RetroPie/roms/atari800/usb && rm -rf /home/$user/RetroPie/roms/atarilynx/usb && rm -rf /home/$user/RetroPie/roms/atarist/usb && rm -rf /home/$user/RetroPie/roms/c64/usb && rm -rf /home/$user/RetroPie/roms/coco/usb && rm -rf /home/$user/RetroPie/roms/coleco/usb && rm -rf /home/$user/RetroPie/roms/crvision/usb && rm -rf /home/$user/RetroPie/roms/daphne/usb && rm -rf /home/$user/RetroPie/roms/dragon32/usb && rm -rf /home/$user/RetroPie/roms/dreamcast/usb && rm -rf /home/$user/RetroPie/roms/fba/usb && rm -rf /home/$user/RetroPie/roms/fds/usb && rm -rf /home/$user/RetroPie/roms/gameandwatch/usb && rm -rf /home/$user/RetroPie/roms/gamegear/usb && rm -rf /home/$user/RetroPie/roms/gb/usb && rm -rf /home/$user/RetroPie/roms/gba/usb && rm -rf /home/$user/RetroPie/roms/gbc/usb && rm -rf /home/$user/RetroPie/roms/genesis/usb && rm -rf /home/$user/RetroPie/roms/intellivision/usb && rm -rf /home/$user/RetroPie/roms/kodi/usb && rm -rf /home/$user/RetroPie/roms/love/usb && rm -rf /home/$user/RetroPie/roms/macintosh/usb && rm -rf /home/$user/RetroPie/roms/mame-advmame/usb && rm -rf /home/$user/RetroPie/roms/mame-libretro/usb && rm -rf /home/$user/RetroPie/roms/mame-mame4all/usb && rm -rf /home/$user/RetroPie/roms/mastersystem/usb && rm -rf /home/$user/RetroPie/roms/megadrive/usb && rm -rf /home/$user/RetroPie/roms/msx/usb && rm -rf /home/$user/RetroPie/roms/n64/usb && rm -rf /home/$user/RetroPie/roms/neogeo/usb && rm -rf /home/$user/RetroPie/roms/ngp/usb && rm -rf /home/$user/RetroPie/roms/ngpc/usb && rm -rf /home/$user/RetroPie/roms/pc/usb && rm -rf /home/$user/RetroPie/roms/pcengine/usb && rm -rf /home/$user/RetroPie/roms/ports/usb && rm -rf /home/$user/RetroPie/roms/psp/usb && rm -rf /home/$user/RetroPie/roms/psx/usb && rm -rf /home/$user/RetroPie/roms/scummvm/usb && rm -rf /home/$user/RetroPie/roms/sega32x/usb && rm -rf /home/$user/RetroPie/roms/segacd/usb && rm -rf /home/$user/RetroPie/roms/sg-1000/usb && rm -rf /home/$user/RetroPie/roms/snes/usb && rm -rf /home/$user/RetroPie/roms/vectrex/usb && rm -rf /home/$user/RetroPie/roms/videopac/usb && rm -rf /home/$user/RetroPie/roms/virtualboy/usb && rm -rf /home/$user/RetroPie/roms/wonderswan/usb && rm -rf /home/$user/RetroPie/roms/wonderswancolor/usb && rm -rf /home/$user/RetroPie/roms/zmachine/usb && rm -rf /home/$user/RetroPie/roms/zxspectrum/usb && mount --bind $usb_path/retropie/roms/amstradcpc/ /home/$user/RetroPie/roms/amstradcpc/usb && mount --bind $usb_path/retropie/roms/apple2/ /home/$user/RetroPie/roms/apple2/usb && mount --bind $usb_path/retropie/roms/arcade/ /home/$user/RetroPie/roms/arcade/usb && mount --bind $usb_path/retropie/roms/atari2600/ /home/$user/RetroPie/roms/atari2600/usb && mount --bind $usb_path/retropie/roms/atari5200/ /home/$user/RetroPie/roms/atari5200/usb && mount --bind $usb_path/retropie/roms/atari7800/ /home/$user/RetroPie/roms/atari7800/usb && mount --bind $usb_path/retropie/roms/atari800/ /home/$user/RetroPie/roms/atari800/usb && mount --bind $usb_path/retropie/roms/atarilynx/ /home/$user/RetroPie/roms/atarilynx/usb && mount --bind $usb_path/retropie/roms/atarist/ /home/$user/RetroPie/roms/atarist/usb && mount --bind $usb_path/retropie/roms/c64/ /home/$user/RetroPie/roms/c64/usb && mount --bind $usb_path/retropie/roms/coco/ /home/$user/RetroPie/roms/coco/usb && mount --bind $usb_path/retropie/roms/coleco/ /home/$user/RetroPie/roms/coleco/usb && mount --bind $usb_path/retropie/roms/crvision/ /home/$user/RetroPie/roms/crvision/usb && mount --bind $usb_path/retropie/roms/daphne/ /home/$user/RetroPie/roms/daphne/usb && mount --bind $usb_path/retropie/roms/dragon32/ /home/$user/RetroPie/roms/dragon32/usb && mount --bind $usb_path/retropie/roms/dreamcast/ /home/$user/RetroPie/roms/dreamcast/usb && mount --bind $usb_path/retropie/roms/fba/ /home/$user/RetroPie/roms/fba/usb && mount --bind $usb_path/retropie/roms/fds/ /home/$user/RetroPie/roms/fds/usb && mount --bind $usb_path/retropie/roms/gameandwatch/ /home/$user/RetroPie/roms/gameandwatch/usb && mount --bind $usb_path/retropie/roms/gamegear/ /home/$user/RetroPie/roms/gamegear/usb && mount --bind $usb_path/retropie/roms/gb/ /home/$user/RetroPie/roms/gb/usb && mount --bind $usb_path/retropie/roms/gba/ /home/$user/RetroPie/roms/gba/usb && mount --bind $usb_path/retropie/roms/gbc/ /home/$user/RetroPie/roms/gbc/usb && mount --bind $usb_path/retropie/roms/genesis/ /home/$user/RetroPie/roms/genesis/usb && mount --bind $usb_path/retropie/roms/intellivision/ /home/$user/RetroPie/roms/intellivision/usb && mount --bind $usb_path/retropie/roms/kodi/ /home/$user/RetroPie/roms/kodi/usb && mount --bind $usb_path/retropie/roms/love/ /home/$user/RetroPie/roms/love/usb && mount --bind $usb_path/retropie/roms/macintosh/ /home/$user/RetroPie/roms/macintosh/usb && mount --bind $usb_path/retropie/roms/mame-advmame/ /home/$user/RetroPie/roms/mame-advmame/usb && mount --bind $usb_path/retropie/roms/mame-libretro/ /home/$user/RetroPie/roms/mame-libretro/usb && mount --bind $usb_path/retropie/roms/mame-mame4all/ /home/$user/RetroPie/roms/mame-mame4all/usb && mount --bind $usb_path/retropie/roms/mastersystem/ /home/$user/RetroPie/roms/mastersystem/usb && mount --bind $usb_path/retropie/roms/megadrive/ /home/$user/RetroPie/roms/megadrive/usb && mount --bind $usb_path/retropie/roms/msx/ /home/$user/RetroPie/roms/msx/usb && mount --bind $usb_path/retropie/roms/n64/ /home/$user/RetroPie/roms/n64/usb && mount --bind $usb_path/retropie/roms/neogeo/ /home/$user/RetroPie/roms/neogeo/usb && mount --bind $usb_path/retropie/roms/ngp/ /home/$user/RetroPie/roms/ngp/usb && mount --bind $usb_path/retropie/roms/ngpc/ /home/$user/RetroPie/roms/ngpc/usb && mount --bind $usb_path/retropie/roms/pc/ /home/$user/RetroPie/roms/pc/usb && mount --bind $usb_path/retropie/roms/pcengine/ /home/$user/RetroPie/roms/pcengine/usb && mount --bind $usb_path/retropie/roms/ports/ /home/$user/RetroPie/roms/ports/usb && mount --bind $usb_path/retropie/roms/psp/ /home/$user/RetroPie/roms/psp/usb && mount --bind $usb_path/retropie/roms/psx/ /home/$user/RetroPie/roms/psx/usb && mount --bind $usb_path/retropie/roms/scummvm/ /home/$user/RetroPie/roms/scummvm/usb && mount --bind $usb_path/retropie/roms/sega32x/ /home/$user/RetroPie/roms/sega32x/usb && mount --bind $usb_path/retropie/roms/segacd/ /home/$user/RetroPie/roms/segacd/usb && mount --bind $usb_path/retropie/roms/sg-1000/ /home/$user/RetroPie/roms/sg-1000/usb && mount --bind $usb_path/retropie/roms/snes/ /home/$user/RetroPie/roms/snes/usb && mount --bind $usb_path/retropie/roms/vectrex/ /home/$user/RetroPie/roms/vectrex/usb && mount --bind $usb_path/retropie/roms/virtualboy/ /home/$user/RetroPie/roms/virtualboy/usb && mount --bind $usb_path/retropie/roms/wonderswan/ /home/$user/RetroPie/roms/wonderswan/usb && mount --bind $usb_path/retropie/roms/wonderswancolor/ /home/$user/RetroPie/roms/wonderswancolor/usb && mount --bind $usb_path/retropie/roms/zmachine/ /home/$user/RetroPie/roms/zmachine/usb && mount --bind $usb_path/retropie/roms/zxspectrum/ /home/$user/RetroPie/roms/zxspectrum/usb && write_fstab && usb_share

[[ "$choice" -eq 2 ]] && return
else
usb_path=/mnt/usb
mkdir -p "$usb_path/retropie/"{roms,BIOS} "$usb_path_from_rp" "$usb_path_to_rp"
mkdir -p "$usb_path/retropie/roms/"{amiga,amstradcpc,apple2,arcade,atari2600,atari5200,atari7800,atari800,atarilynx,atarist,c64,coco,coleco,crvision,daphne,dragon32,dreamcast,fba,fds,gameandwatch,gamegear,gb,gba,gbc,genesis,intellivision,kodi,love,macintosh,mame-advmame,mame-libretro,mame-mame4all,mastersystem,megadrive,msx,n64,neogeo,nes,ngp,ngpc,pc,pcengine,ports,psp,psx,scummvm,sega32x,segacd,sg-1000,snes,vectrex,videopac,virtualboy,wonderswan,wonderswancolor,zmachine,zxspectrum} && rm -rf /home/$user/RetroPie/roms/amiga/usb && mount --bind $usb_path/retropie/roms/amiga /home/$user/RetroPie/roms/amiga/usb && rm -rf /home/$user/RetroPie/roms/nes/usb && mount --bind $usb_path/retropie/roms/nes/ /home/$user/RetroPie/roms/nes/usb && rm -rf /home/$user/RetroPie/roms/amstradcpc/usb && rm -rf /home/$user/RetroPie/roms/apple2/usb && rm -rf /home/$user/RetroPie/roms/arcade/usb && rm -rf /home/$user/RetroPie/roms/atari2600/usb && rm -rf /home/$user/RetroPie/roms/atari5200/usb && rm -rf /home/$user/RetroPie/roms/atari7800/usb && rm -rf /home/$user/RetroPie/roms/atari800/usb && rm -rf /home/$user/RetroPie/roms/atarilynx/usb && rm -rf /home/$user/RetroPie/roms/atarist/usb && rm -rf /home/$user/RetroPie/roms/c64/usb && rm -rf /home/$user/RetroPie/roms/coco/usb && rm -rf /home/$user/RetroPie/roms/coleco/usb && rm -rf /home/$user/RetroPie/roms/crvision/usb && rm -rf /home/$user/RetroPie/roms/daphne/usb && rm -rf /home/$user/RetroPie/roms/dragon32/usb && rm -rf /home/$user/RetroPie/roms/dreamcast/usb && rm -rf /home/$user/RetroPie/roms/fba/usb && rm -rf /home/$user/RetroPie/roms/fds/usb && rm -rf /home/$user/RetroPie/roms/gameandwatch/usb && rm -rf /home/$user/RetroPie/roms/gamegear/usb && rm -rf /home/$user/RetroPie/roms/gb/usb && rm -rf /home/$user/RetroPie/roms/gba/usb && rm -rf /home/$user/RetroPie/roms/gbc/usb && rm -rf /home/$user/RetroPie/roms/genesis/usb && rm -rf /home/$user/RetroPie/roms/intellivision/usb && rm -rf /home/$user/RetroPie/roms/kodi/usb && rm -rf /home/$user/RetroPie/roms/love/usb && rm -rf /home/$user/RetroPie/roms/macintosh/usb && rm -rf /home/$user/RetroPie/roms/mame-advmame/usb && rm -rf /home/$user/RetroPie/roms/mame-libretro/usb && rm -rf /home/$user/RetroPie/roms/mame-mame4all/usb && rm -rf /home/$user/RetroPie/roms/mastersystem/usb && rm -rf /home/$user/RetroPie/roms/megadrive/usb && rm -rf /home/$user/RetroPie/roms/msx/usb && rm -rf /home/$user/RetroPie/roms/n64/usb && rm -rf /home/$user/RetroPie/roms/neogeo/usb && rm -rf /home/$user/RetroPie/roms/ngp/usb && rm -rf /home/$user/RetroPie/roms/ngpc/usb && rm -rf /home/$user/RetroPie/roms/pc/usb && rm -rf /home/$user/RetroPie/roms/pcengine/usb && rm -rf /home/$user/RetroPie/roms/ports/usb && rm -rf /home/$user/RetroPie/roms/psp/usb && rm -rf /home/$user/RetroPie/roms/psx/usb && rm -rf /home/$user/RetroPie/roms/scummvm/usb && rm -rf /home/$user/RetroPie/roms/sega32x/usb && rm -rf /home/$user/RetroPie/roms/segacd/usb && rm -rf /home/$user/RetroPie/roms/sg-1000/usb && rm -rf /home/$user/RetroPie/roms/snes/usb && rm -rf /home/$user/RetroPie/roms/vectrex/usb && rm -rf /home/$user/RetroPie/roms/videopac/usb && rm -rf /home/$user/RetroPie/roms/virtualboy/usb && rm -rf /home/$user/RetroPie/roms/wonderswan/usb && rm -rf /home/$user/RetroPie/roms/wonderswancolor/usb && rm -rf /home/$user/RetroPie/roms/zmachine/usb && rm -rf /home/$user/RetroPie/roms/zxspectrum/usb && mount --bind $usb_path/retropie/roms/amstradcpc/ /home/$user/RetroPie/roms/amstradcpc/usb && mount --bind $usb_path/retropie/roms/apple2/ /home/$user/RetroPie/roms/apple2/usb && mount --bind $usb_path/retropie/roms/arcade/ /home/$user/RetroPie/roms/arcade/usb && mount --bind $usb_path/retropie/roms/atari2600/ /home/$user/RetroPie/roms/atari2600/usb && mount --bind $usb_path/retropie/roms/atari5200/ /home/$user/RetroPie/roms/atari5200/usb && mount --bind $usb_path/retropie/roms/atari7800/ /home/$user/RetroPie/roms/atari7800/usb && mount --bind $usb_path/retropie/roms/atari800/ /home/$user/RetroPie/roms/atari800/usb && mount --bind $usb_path/retropie/roms/atarilynx/ /home/$user/RetroPie/roms/atarilynx/usb && mount --bind $usb_path/retropie/roms/atarist/ /home/$user/RetroPie/roms/atarist/usb && mount --bind $usb_path/retropie/roms/c64/ /home/$user/RetroPie/roms/c64/usb && mount --bind $usb_path/retropie/roms/coco/ /home/$user/RetroPie/roms/coco/usb && mount --bind $usb_path/retropie/roms/coleco/ /home/$user/RetroPie/roms/coleco/usb && mount --bind $usb_path/retropie/roms/crvision/ /home/$user/RetroPie/roms/crvision/usb && mount --bind $usb_path/retropie/roms/daphne/ /home/$user/RetroPie/roms/daphne/usb && mount --bind $usb_path/retropie/roms/dragon32/ /home/$user/RetroPie/roms/dragon32/usb && mount --bind $usb_path/retropie/roms/dreamcast/ /home/$user/RetroPie/roms/dreamcast/usb && mount --bind $usb_path/retropie/roms/fba/ /home/$user/RetroPie/roms/fba/usb && mount --bind $usb_path/retropie/roms/fds/ /home/$user/RetroPie/roms/fds/usb && mount --bind $usb_path/retropie/roms/gameandwatch/ /home/$user/RetroPie/roms/gameandwatch/usb && mount --bind $usb_path/retropie/roms/gamegear/ /home/$user/RetroPie/roms/gamegear/usb && mount --bind $usb_path/retropie/roms/gb/ /home/$user/RetroPie/roms/gb/usb && mount --bind $usb_path/retropie/roms/gba/ /home/$user/RetroPie/roms/gba/usb && mount --bind $usb_path/retropie/roms/gbc/ /home/$user/RetroPie/roms/gbc/usb && mount --bind $usb_path/retropie/roms/genesis/ /home/$user/RetroPie/roms/genesis/usb && mount --bind $usb_path/retropie/roms/intellivision/ /home/$user/RetroPie/roms/intellivision/usb && mount --bind $usb_path/retropie/roms/kodi/ /home/$user/RetroPie/roms/kodi/usb && mount --bind $usb_path/retropie/roms/love/ /home/$user/RetroPie/roms/love/usb && mount --bind $usb_path/retropie/roms/macintosh/ /home/$user/RetroPie/roms/macintosh/usb && mount --bind $usb_path/retropie/roms/mame-advmame/ /home/$user/RetroPie/roms/mame-advmame/usb && mount --bind $usb_path/retropie/roms/mame-libretro/ /home/$user/RetroPie/roms/mame-libretro/usb && mount --bind $usb_path/retropie/roms/mame-mame4all/ /home/$user/RetroPie/roms/mame-mame4all/usb && mount --bind $usb_path/retropie/roms/mastersystem/ /home/$user/RetroPie/roms/mastersystem/usb && mount --bind $usb_path/retropie/roms/megadrive/ /home/$user/RetroPie/roms/megadrive/usb && mount --bind $usb_path/retropie/roms/msx/ /home/$user/RetroPie/roms/msx/usb && mount --bind $usb_path/retropie/roms/n64/ /home/$user/RetroPie/roms/n64/usb && mount --bind $usb_path/retropie/roms/neogeo/ /home/$user/RetroPie/roms/neogeo/usb && mount --bind $usb_path/retropie/roms/ngp/ /home/$user/RetroPie/roms/ngp/usb && mount --bind $usb_path/retropie/roms/ngpc/ /home/$user/RetroPie/roms/ngpc/usb && mount --bind $usb_path/retropie/roms/pc/ /home/$user/RetroPie/roms/pc/usb && mount --bind $usb_path/retropie/roms/pcengine/ /home/$user/RetroPie/roms/pcengine/usb && mount --bind $usb_path/retropie/roms/ports/ /home/$user/RetroPie/roms/ports/usb && mount --bind $usb_path/retropie/roms/psp/ /home/$user/RetroPie/roms/psp/usb && mount --bind $usb_path/retropie/roms/psx/ /home/$user/RetroPie/roms/psx/usb && mount --bind $usb_path/retropie/roms/scummvm/ /home/$user/RetroPie/roms/scummvm/usb && mount --bind $usb_path/retropie/roms/sega32x/ /home/$user/RetroPie/roms/sega32x/usb && mount --bind $usb_path/retropie/roms/segacd/ /home/$user/RetroPie/roms/segacd/usb && mount --bind $usb_path/retropie/roms/sg-1000/ /home/$user/RetroPie/roms/sg-1000/usb && mount --bind $usb_path/retropie/roms/snes/ /home/$user/RetroPie/roms/snes/usb && mount --bind $usb_path/retropie/roms/vectrex/ /home/$user/RetroPie/roms/vectrex/usb && mount --bind $usb_path/retropie/roms/virtualboy/ /home/$user/RetroPie/roms/virtualboy/usb && mount --bind $usb_path/retropie/roms/wonderswan/ /home/$user/RetroPie/roms/wonderswan/usb && mount --bind $usb_path/retropie/roms/wonderswancolor/ /home/$user/RetroPie/roms/wonderswancolor/usb && mount --bind $usb_path/retropie/roms/zmachine/ /home/$user/RetroPie/roms/zmachine/usb && mount --bind $usb_path/retropie/roms/zxspectrum/ /home/$user/RetroPie/roms/zxspectrum/usb
write_fstab
usb_share
fi

}

function choose_usb(){

local options=()
    local i=0

devs=`ls -al /dev/disk/by-path/*usb*part* 2>/dev/null | awk '{print($11)}'`; 
for dev in $devs; 
do dev=${dev##*\/};
mount /dev/$dev /media/usb$i
dim=$(df -Ph /dev/$dev | tail -1 | awk '{print $4}')
options+=("$dev" "Usb$i Size $dim")
((i++)) 
done



#if [[ $i != 0 ]]; then
local cmd=(dialog --backtitle "$__backtitle" --menu "Choose Usb." 22 76 16)
   local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    	[[ -n "$choice" ]] && echo "${options[choice]}"

}

function gui_usbstorage(){
while true; do
local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option. $user" 22 76 16)
local options=(
1 "Install usb filesystems (exfat, ntfs)"
2 "Choose your usb drive"
3 "Remove setted usb"
)

        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
		install_usbstorage
                    ;;
		2)
		set_usb
		   ;;
		3)
		remove_fstab
		;;
esac
else
break
fi
done
}