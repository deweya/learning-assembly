; Chapter 10, exercise 1
; Convert an integer into a string

default rel

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
integer     db      123
length      db      0
b10         db      10

; ***************************

section     .bss

string      resb    0

; ***************************

section     .text
global _start
_start:

    mov     al, [integer]

divLoop:

    ; Get the length of the integer
    ; Push the individual digits to the stack

    mov     ah, 0
    inc     byte [length]
    div     byte [b10]
    mov     dl, ah
    push    rdx
    cmp     al, 0
    jne     divLoop

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall