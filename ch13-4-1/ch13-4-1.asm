; Chapter 13.4.1
; Accept input from the console
; Then print the input back out to the console when LF is reached

default rel

%define     SYS_exit        0x2000001
%define     SYS_read        0x2000003
%define     SYS_write       0x2000004

%define     SUCCESS         0
%define     STDIN           0
%define     STDOUT          1
%define     LF              10
%define     NULL            0

%define     STRLEN          50

; **********************************

section     .data

prompt      db          "Enter message:", LF, NULL
yourMsg     db          "Here was your message:", LF, NULL
length      db          STRLEN                              ; Length of input to read from console (excluding LF and NULL)

; **********************************

section     .bss

char        resb        1                                   ; Individual character to read from input
input       resb        STRLEN+2                            ; Console input (including LF and NULL)

; **********************************

section     .text
global _start
_start:

    lea     rdi, [prompt]
    call    printString

    lea     rdi, [input]
    mov     rsi, [length]
    call    readInput

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall

; -----
; Read input from STDIN
; Reads one char at a time until either:
;   * LF has been hit
;   * Max string length has been hit
; Args:
;   * rdi - input (address)
;   * rsi - length (byte)
; Syscall:
;   ssize_t
;   read(int fildes, void *buf, size_t nbyte);
;        rdi         rsi        rdx

global readInput
readInput:

    mov     r8, rdi                                 ; input
    mov     r9, rsi                                 ; length
    mov     r10, 0                                  ; char counter and iterator

readInputLoop:

    mov     rax, SYS_read
    mov     rdi, STDIN
    lea     rsi, [char]
    mov     rdx, 1
    syscall

    cmp     byte [rsi], LF
    je      readInputDone

    movzx   r11, byte [rsi]
    mov     [r8 + r10], r11

    inc     r10
    cmp     r10, r9
    jge     readInputDone

    jmp     readInputLoop

readInputDone:

    mov     byte [r8 + r10], LF
    inc     r10
    mov     byte [r8 + r10], NULL

    lea     rdi, [yourMsg]
    call    printString

    lea     rdi, [r8]
    call    printString

    ret

; -----
; Prints a string to the console
; Args:
;   * rdi - message (address)
; Returns:
;   * rax - number of bytes written to the console
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