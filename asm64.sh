#!/bin/bash
# Simple assemble/link script

set -e

if [ -z $1 ]; then
    echo "Usage: ./asm64 <asmMinFile> (no extension)"
fi

# Verify no extensions were entered
if [ ! -e "$1.asm" ]; then
    echo "Error, $1.asm not found."
    echo "Note, do not enter file extensions."
    exit
fi

# Compile, assemble, and link
nasm -Worphan-labels -g -F dwarf -f macho64 $1.asm -l $1.lst
ld -e _start -static -o $1 $1.o