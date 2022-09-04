#!/bin/bash
# Simple assemble/link script
# Used for standalone asm files that do not need to be linked with other files
# For more complex compilation and linking, use the scripts included in the respective exercise's folder

set -e

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
ld -e _start -static -o bin/$1 $1/$1.o