#!/bin/bash
# Simple assemble/link script

set -e

SYMBOL=""
if [ -z $2 ]; then
    SYMBOL="_start"
else
    SYMBOL=$2
fi

if [ -z $1 ]; then
    echo "Usage: ./asm64 <asmMinFile> (no extension)"
fi

# Verify no extensions were entered
if [ ! -e "$1/$1.asm" ]; then
    echo "Error, $1/$1.asm not found."
    echo "Note, do not enter file extensions."
    exit
fi

# Compile, assemble, and link
nasm -Worphan-labels -g -F dwarf -f macho64 $1/$1.asm -l $1/$1.lst -o $1/$1.o
ld -e $SYMBOL -static -o bin/$1 $1/$1.o