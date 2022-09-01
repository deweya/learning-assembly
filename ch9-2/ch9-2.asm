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
isPdrome    db      1

; ***************************

section     .text
global _start
_start:

    lea     r8, [string]
    mov     rcx, 0

pushStart:

    mov     al, [r8 + rcx]
    push    rax                         ; Push character to stack

    cmp     rax, 0                      ; If we reached the null terminating char, then jump out of the loop
    je      resetCounter

    inc     rcx
    jmp     pushStart

resetCounter:

    pop     rax                         ; Pop the null terminating char, since we won't use it
    mov     rdx, rcx                    ; rdx is the len of the string (excluding null-terminating char)
    mov     rcx, 0                      ; Reset the counter so we can read the original string front-to-back

popStart:

    pop     rax
    mov     bl, byte [r8 + rcx]
    cmp     al, bl
    jne     notPdrome                   ; As soon as a char doesn't match, short circuit and exit

    inc     rcx
    cmp     rcx, rdx                    ; If we reached the length of the original string, then exit
    je      exit

    jmp     popStart

notPdrome:

    mov     byte [isPdrome], 0

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall