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
n           db      5                   ; Argument to fib(n)
fibnum      dd      0                   ; The nth Fibonacci number

; *********************

section     .text
global _start
_start:

                                        ; fib(n) will recurse n times
    mov     cl, [n]
    mov     dl, cl                      ; Copy cl to dl, which will be used for calling fib(n) recursively

fib:                                    ; fib(n) function

    dec     dl
    cmp     dl, 1
    je      base
    jne     fib

fibLoopback:

    mov     dl, cl
    dec     dl                          ; Reset dl
    loop    fib
    jmp     exit

base:                                   ; Base case

    add     dword [fibnum], 1
    jmp     fibLoopback

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall