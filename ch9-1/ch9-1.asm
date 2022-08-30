; Chapter 9, exercise 1
; A program that reverses a list of numbers

default rel

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables

lst         dd      1000, 1001, 1002, 1003, 1004
            dd      1005, 1006, 1007, 1008, 1009
            dd      1010, 1011, 1012, 1013, 1014
            dd      1015, 1016, 1017, 1018, 1019

len         db      20

; ***************************

section     .text
global _start
_start:

    mov     cl, [len]                       ; loop counter
    lea     r8, [lst]                       ; address of lst
    mov     r9, 0                           ; r9 is displacement

pushLoop:

    mov     eax, [r8 + r9*4]
    push    rax
    inc     r9
    loop    pushLoop
    mov     cl, [len]
    mov     r9, 0

popLoop:

    pop     qword [r8 + r9*4]
    inc     r9
    loop    popLoop

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall