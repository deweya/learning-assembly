; Chapter 11, exercise 1
; Implement a macro for finding the average of a list of numbers

default rel

; *********************

; -----
; Calculate the average of a list of numbers
; %1 - destination
; %2 - list of words
%macro  cAvg     2
    lea     r8, [%2]
    mov     rax, 0                      ; rax holds the sum
    mov     r9, 0
    mov     cl, [len]
%%loopSum:
    add     ax, [r8 + r9*2]
    inc     r9
    loop    %%loopSum
%%calcAvg:
    mov     rdx, 0                      ; make sure any weirdness won't happen when we divide
    mov     bx, [len]
    div     bx
    mov     [%1], ax
%endmacro

; *********************

section     .data

SUCCESS     equ     0
SYS_exit    equ     0x2000001

lst         dw      100, 750, 22, 0, 555
len         db      5
avg         dw      0

; *********************

section     .text
global _start
_start:

    cAvg    avg, lst

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall