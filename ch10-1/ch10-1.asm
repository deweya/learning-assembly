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

string      resb    4

; ***************************

section     .text
global _start
_start:

    mov     al, [integer]
    lea     r8, [string]

divLoop:

    ; Get the length of the integer
    ; Push the individual digits to the stack

    mov     ah, 0
    inc     byte [length]
    div     byte [b10]
    mov     dl, ah                  ; Move remainder to dl and push to stack
    push    rdx
    cmp     al, 0                   ; If integer == 0, then we have finished dividing
    jne     divLoop
    mov     cl, [length]            ; Set up loop counter

convert:

    pop     rax
    add     al, 48
    mov     [r8 + r9], al
    inc     r9
    loop    convert

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall