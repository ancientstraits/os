#!/bin/sh

sudo apt update
yes | sudo apt install \
    nasm \
    qemu-system-i386
