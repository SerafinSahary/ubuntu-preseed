#!/bin/bash

WORKINGDIR=~/tmp/ubuntu-mini-iso
IMAGE=custom.iso

sudo mount -o loop mini.iso /mnt/iso/

sudo rm -r $WORKINGDIR
mkdir $WORKINGDIR
rsync -a /mnt/iso/* $WORKINGDIR

chown -R serafin:serafin $WORKINGDIR

rm -fv $WORKINGDIR/txt.cfg
cp -vf txt.cfg $WORKINGDIR/txt.cfg

chmod -v u+w $WORKINGDIR/boot/grub/
rm -fv $WORKINGDIR/boot/grub/grub.cfg
cp -vf grub.cfg $WORKINGDIR/boot/grub/grub.cfg

chmod -v u+w $WORKINGDIR/isolinux.bin

mkisofs -r -V "Serafin Ubuntu Install CD" \
  -cache-inodes -J -l \
  -b isolinux.bin -c boot.cat \
  -no-emul-boot -boot-load-size 4 -boot-info-table \
  -o $IMAGE $WORKINGDIR
