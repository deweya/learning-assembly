default rel
extern  stats2

; **************************

section     .data

SUCCESS     equ     0
SYS_exit    equ     0x2000001

arr         dd      1000, 1010, 1020, 1030, 1040
            dd      1050, 1060, 1070, 1080, 1090, 1100

len         dd      11
min         dd      0
med         dd      0
max         dd      0
sum         dd      0
ave         dd      0

; **************************

section     .text
global _start
_start:

    lea     r10, [ave]
    push    r10
    mov     rbp, rsp
    push    rbp

    lea     r9, [sum]
    lea     r8, [max]
    lea     rcx, [med]
    lea     rdx, [min]
    mov     esi, [len]
    lea     rdi, [arr]
    call    stats2

exit:

    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall