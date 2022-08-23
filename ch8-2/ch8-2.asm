; Chapter 8, exercise 1
; Sum a list of numbers

DEFAULT REL

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
nums        db      1,  5,  20,  4,  100
            db      6,  7,  50,  9,  30

len         db      10
sum         dw      0
max         db      0
min         db      0
avg         dw      0

; ***************************

section     .text
global _start
_start:

    mov     cl, [len]                       ; loop "len" number of times
    mov     rax, 0                          ; rax is our displacement
    lea     rsi, [nums]                     ; rsi contains the base address of nums
                                            ;   this is needed to avoid the "Mach-O 64-bit format does not support 32-bit absolute addresses" error

numLoop:

    mov     bl, byte [rsi+rax]              ; Calculate sum
    add     [sum], bl
    cmp     bl, [max]                       ; Check if this is the largest number
    jg      setMax

return:

    inc     rax                             ; Increment displacement
    loop    numLoop
    jmp     exit

setMax:

    mov     [max], bl
    jmp     return

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall
