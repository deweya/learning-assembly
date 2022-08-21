; Chapter 7, exercise 7
; Sum of squares program
;
; Compute the sum of squares from 1 to n

DEFAULT REL

; *************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
n           db      10
sum         dd      0

; *************************

section     .text
global _start
_start:

    mov     ecx, [n]                    ; Initialize counter register (decremented by loop)

startOfLoop:

    mov     eax, ecx                    ; Prepare to square n by moving the counter to eax
    mul     eax                         ; counter ^ 2
    add     dword [sum], eax            ; Add (counter ^ 2) to the total sum
    loop    startOfLoop

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall