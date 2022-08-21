; Chapter 7, exercise 9
; Iteratively find the nth Fibonacci number
;
; For example, the 10th Fibonacci number is 55
;              the 5th Fibonacci number is 5

DEFAULT REL

; *********************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
n           db      10                  ; Argument to fib(n)
fibnum      dd      0                   ; The nth Fibonacci number

; *********************

section     .text
global _start
_start:

    mov     eax, 0                      ; eax will contain the (latest - 1) Fibonacci number
    mov     ebx, 1                      ; ebx will contain the latest Fibonacci number
    mov     ecx, 1                      ; ecx will be used for looping. It also marks the currently iterated Fibonacci number

fibLoop:

    cmp     ecx, [n]
    je      result
    mov     edx, ebx                    ; edx contains the old ebx value (so we can assign it to eax)
    add     ebx, eax
    inc     ecx
    mov     eax, edx                    ; Assign eax to the old edx value
    jmp     fibLoop

result:

    mov     [fibnum], ebx               ; Assign fibnum to the latest fibonacci number

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall