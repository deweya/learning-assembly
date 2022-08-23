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
    
    mov     bl, byte [rsi]                  ; Set min to the first element of nums
    mov     [min], bl

loopStart:

    mov     bl, byte [rsi+rax]              ; Calculate sum
    add     [sum], bl

checkMax:

    cmp     bl, [max]
    jg      setMax

checkMin:

    cmp     bl, [min]
    jl      setMin

loopEnd:

    inc     rax                             ; Increment displacement
    loop    loopStart
    jmp     exit

setMax:

    mov     [max], bl
    jmp     checkMin

setMin:

    mov     [min], bl
    jmp     loopEnd

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall
