; Simple example program to compute the
; sum of squares from 1 to n
;
; For example:
; 1^2 + 2^2 + ... + 10^2 = 385

; *****************************

section     .data

; Define constants
SUCCESS     equ     0           ; Successful operation
SYS_exit    equ     0x2000001   ; Call code for _exit

; Define data
n               dd      10
sumOfSquares    dq      0

; *****************************

section     .text
global _start
_start:

; -----
; Compute sum of squares from 1 to n (inclusive)
; Approach:
;   for (i=1; i<=n; i++)
;     sumOfSquares += i^2;

    mov     rbx, 1                          ; i
    mov     ecx, dword [n]                  ; Set count register to n
                                            ; ecx will be decremented on each loop

sumLoop:
    mov     rax, rbx                        ; get i
    mul     rax                             ; i^2
    add     qword [sumOfSquares], rax
    inc     rbx
    loop    sumLoop

; -----
; Done. Exit program

last:
    mov     rax, SYS_exit       ; Call code for exit
    mov     rdi, SUCCESS        ; Exit with success
    syscall
