; Chapter 9, exercise 2
; Determine if a string is a palindrome

default rel

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
string      db      "abcdefg", 0        ; The string that we will check if it's a palindrome
isPdrome    db      1

; ***************************

section     .text
global _start
_start:

    lea     r8, [string]
    mov     r11, 0                      ; displacement for compare
    mov     rcx, 0                      ; length of string

pushStart:

    mov     al, [r8 + rcx]
    push    rax

    cmp     rax, 0                      ; If we reached the null terminating char, then jump out of the loop
    je      popStart

    inc     rcx
    jmp     pushStart

popStart:

    pop     rax
    mov     bl, byte [r8 + rcx]
    cmp     al, bl
    jne     notPdrome
    
    cmp     rcx, 0
    je      exit
    dec     rcx
    jmp     popStart

notPdrome:

    mov     byte [isPdrome], 0

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall