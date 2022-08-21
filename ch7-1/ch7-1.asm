; Chapter 7, exercise 1
; Unsigned arithmetic
;
; bAns1 = bNum1 + bNum2
; bAns2 = bNum1 + bNum3
; bAns3 = bNum3 + bNum4
; bAns6 = bNum1 - bNum2
; bAns7 = bNum1 - bNum3
; bAns8 = bNum2 - bNum4
; wAns11 = bNum1 * bNum3
; wAns12 = bNum2 * bNum2
; wAns13 = bNum2 * bNum4

DEFAULT REL

; *************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Answers
bAns1       db      0
bAns2       db      0
bAns3       db      0
bAns6       db      0
bAns7       db      0
bAns8       db      0
wAns11      dw      0
wAns12      dw      0
wAns13      dw      0

; Operands
bNum1       db      5
bNum2       db      10
bNum3       db      15
bNum4       db      20

; *************************

section     .text
global _start
_start:

add:

; -----
; bAns1 = bNum1 + bNum2

    mov     al, [bNum1]
    add     al, [bNum2]
    mov     [bAns1], al

; -----
; bAns2 = bNum1 + bNum3

    mov     al, [bNum1]
    add     al, [bNum3]
    mov     [bAns2], al

; -----
; bAns3 = bNum3 + bNum4

    mov     al, [bNum3]
    add     al, [bNum4]
    mov     [bAns3], al

subtract:

; -----
; bAns6 = bNum1 - bNum2

    mov     al, [bNum1]
    sub     al, [bNum2]
    mov     [bAns6], al

; -----
; bAns7 = bNum1 - bNum3

    mov     al, [bNum1]
    sub     al, [bNum3]
    mov     [bAns7], al

; -----
; bAns8 = bNum2 - bNum4

    mov     al, [bNum2]
    sub     al, [bNum4]
    mov     [bAns8], al

multiply:

; -----
; wAns11 = bNum1 * bNum3

    mov     ax, 0                   ; Need to zero out entire word
    mov     al, [bNum1]
    imul    byte [bNum3]
    mov     [wAns11], ax

divide:

last:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall
