; Chapter 8, exercise 6
; Implement the BubbleSort algorithm

default rel

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
nums        db      8,  3,  7,  2,  10      ; List of numbers to sort
            db      12, 0,  1,  7,  5

len         db      10                      ; Length of the array

; ***************************

section     .text
global _start
_start:

    lea     r8, [nums]                      ; Address of nums
    mov     r9, 0                           ; Displacement for j
    mov     al, [len]                       ; Set up for(i = (len-1) to 0)

forI:

    dec     al                              ; i--
    cmp     al, 0
    jl      exit

forJ:

    mov     bl, al                          ; Set up for(j = 0 to i-1)
    dec     bl
    mov     r9, 0

comparison:                                 ; if (nums(j) > nums(j+1))

    cmp     r9b, bl
    jg      forI                            ; Jump early if we've already iterated through j values           
    mov     r10b, [r8 + r9]                 ; nums(j)
    mov     r11b, [r8 + r9+1]               ; nums(j+1)
    cmp     r10, r11
    jg      swap
    inc     r9
    jmp     comparison

swap:

    mov     cl, r10b                        ; cl is "tmp"
    mov     [r8 + r9], r11b
    mov     [r8 + r9+1], cl
    inc     r9
    jmp     comparison

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall