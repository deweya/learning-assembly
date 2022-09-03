; Chapter 11, exercise 1
; Implement macros for finding (against a list of integers):
;   * average
;   * min
;   * max

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

; -----
; Find the minimum in a list of numbers
%macro  fMin    2
    lea     r8, [%2]
    mov     cl, [len]
    mov     r9, 0
%%loopMin:
    mov     ax, [r8 + r9*2]
    cmp     [%1], ax
    jg      %%setMin
%%incLoop:
    inc     r9
    loop    %%loopMin
    jmp     %%done
%%setMin:
    mov     [%1], ax
    jmp     %%incLoop
%%done:
%endmacro

; -----
; Find the maximum in a list of numbers
%macro  fMax    2
    lea     r8, [%2]
    mov     cl, [len]
    mov     r9, 0
%%loopMax:
    mov     ax, [r8 + r9*2]
    cmp     [%1], ax
    jl      %%setMax
%%incLoop:
    inc     r9
    loop    %%loopMax
    jmp     %%done
%%setMax:
    mov     [%1], ax
    jmp     %%incLoop
%%done:
%endmacro

; *********************

section     .data

SUCCESS     equ     0
SYS_exit    equ     0x2000001

lst         dw      100, 750, 22, 0, 555
len         db      5
avg         dw      0
min         dw      0x7fff
max         dw      0

; *********************

section     .text
global _start
_start:

    cAvg    avg, lst
    fMin    min, lst
    fMax    max, lst

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall