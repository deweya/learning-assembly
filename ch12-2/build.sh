#!/bin/bash

set -e

nasm -Worphan-labels -g -F dwarf -f macho64 main.asm -l main.lst
nasm -Worphan-labels -g -F dwarf -f macho64 stats2.asm -l stats2.lst
ld -e _start -static -o ../bin/ch12-2 main.o stats2.o