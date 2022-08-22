; Chapter 8, exercise 1
; Sum a list of numbers

DEFAULT REL

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
nums        db      1,  2,  3,  4,  5
            db      6,  7,  8,  9,  10
            db      11, 12, 13, 14, 15
            db      16, 17, 18, 19, 20

len         db      20
sum         dw      0

; ***************************

section     .text
global _start
_start:

    mov     cl, [len]                       ; loop "len" number of times
    mov     rax, 0                          ; rax is our displacement
    lea     rsi, [nums]                     ; rsi contains the base address of nums
                                            ;   this is needed to avoid the "Mach-O 64-bit format does not support 32-bit absolute addresses" error

sumLoop:

    mov     bl, byte [rsi+rax]
    add     [sum], bl
    inc     rax
    loop    sumLoop

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall
