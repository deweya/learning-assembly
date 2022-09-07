; Example from Chapter 13.3.1
; A program to print a set of messages to the console

default rel

; ******************************

section     .data

SUCCESS     equ     0
SYS_exit    equ     0x2000001

STDOUT      equ     1
SYS_write   equ     0x2000004

LF          equ     10
NULL        equ     0

message1    db      "Hello, world!", LF, NULL
message2    db      "Yo yo yo!", LF, NULL
message3    db      "Foo bar baz", LF, NULL

; ******************************

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

global printString:
printString:

    mov     rax, SYS_write
    mov     rdx, 0                  ; 3rd arg
    mov     rsi, rdi                ; 2nd arg
    mov     rdi, STDOUT             ; 1st arg

getLength:

    ; Get the length of the string so we know how many bytes to read from the buffer

    cmp     rsi, NULL
    je      doPrint
    inc     rsi                     ; increase the pointer one byte
    inc     rdx                     ; increase the size of nbytes
    jmp     getLength

doPrint:

    syscall
    ret