#!/bin/bash

set -e

nasm -Worphan-labels -g -F dwarf -f macho64 main.asm -l main.lst
nasm -Worphan-labels -g -F dwarf -f macho64 stats1.asm -l stats1.lst
ld -e _start -static -o ../bin/ch12-1 main.o stats1.o