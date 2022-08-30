; Chapter 9, exercise 2
; Determine if a string is a palindrome

default rel

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
string      db      "racecar", 0        ; The string that we will check if it's a palindrome
isPdrome    db      0

; ***************************

section     .bss

compare     resb    50                  ; The comparison string, to help determine if the original string is a palindrome

; ***************************

section     .text
global _start
_start:

    lea     r8, [string]
    mov     r9, 0                       ; displacement for string
    lea     r10, [compare]
    mov     r11, 0                      ; displacement for compare
    mov     rcx, 0                      ; length of string

pushStart:

    mov     al, [r8 + r9]
    push    rax
    inc     rcx

    cmp     rax, 0
    je      popStart

    inc     r9
    jmp     pushStart

popStart:

    pop     rax
    cmp     rax, 0                      ; We don't want to push the null terminating character to "compare"
    jne     addToCompare
    loop    popStart

addToCompare:

    mov     [r10 + r11], rax
    inc     r11
    loop    popStart

determinePdrome:

    mov     rax, [r8]
    cmp     rax, [compare]
    je      setPdrome
    jne     exit

setPdrome:

    mov     byte [isPdrome], 1

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall