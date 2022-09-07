; Print messages to the console

default rel

%define     SUCCESS         0
%define     SYS_exit        0x2000001
%define     SYS_write       0x2000004

%define     STDOUT          1

%define     LF              10
%define     NULL            0

; ***************************

section     .data

message1    db      "Hello, world!", LF, NULL
message2    db      "Yo, yo, yo!", LF, NULL
message3    db      "Hey, y'all!", LF, NULL

; ***************************

section     .text
global _start
_start:

    lea     rdi, [message1]
    call    printString

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall

; -----
; Prints a string to the console
; Args:
;   * rdi - message (address)
; Syscall:
;   ssize_t
;   write(int fildes, const void *buf, size_t nbyte);
;         rdi         rsi              rdx

global printString
printString:

    mov     rax, SYS_write
    mov     rdx, 0                  ; 3rd arg
    mov     rsi, rdi                ; 2nd arg
    mov     rdi, STDOUT             ; 1st arg

    mov     r10, rsi                ; use r10 to iterate so we don't knock rsi off

getLength:

    ; Get the length of the string so we know how many bytes to read from the buffer

    cmp     byte [r10], NULL
    je      doPrint
    inc     r10                     ; increase the pointer one byte
    inc     rdx                     ; increase the size of nbytes
    jmp     getLength

doPrint:

    syscall
    ret