; Chapter 7, exercise 1
; Unsigned arithmetic
;
; bAns1 = bNum1 + bNum2
; bAns2 = bNum1 + bNum3
; bAns3 = bNum3 + bNum4

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

; Operands
bNum1       db      5
bNum2       db      10
bNum3       db      15
bNum4       db      20

; *************************

section     .text
global _start
_start:

; -----
; bAns1 = bNum1 + bNum2

    mov     rax, 0
    add     rax, [bNum1]
    add     rax, [bNum2]
    mov     [bAns1], rax

; -----

last:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall
