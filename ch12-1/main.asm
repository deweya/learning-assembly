; Call the stats1 function

default     rel
extern      stats1

; *******************

section     .data

SUCCESS     equ     0
SYS_exit    equ     0x2000001

arr         dd      1000, 4512, 3290, 1004, 5683
            dd      9901, 2198, 5738, 5711, 2099

len         dd      10
sum         dd      0
ave         dd      0

; *******************

section     .text
global _start
_start:

    lea     rcx, ave
    lea     rdx, sum
    mov     esi, [len]
    lea     rdi, arr
    call    stats1

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall