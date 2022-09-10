; Chapter 13.8.1
; Write (hardcoded) contents to a file

default rel

%define     SYS_exit        0x2000001
%define     SYS_open        0x2000005

%define     SUCCESS         0

%define     O_WRONLY        0x0001
%define     O_CREAT         0x00000200
%define     O_TRUNC         0x00000400

%define     S_IRUSR         0q0000400
%define     S_IWUSR         0q0000200
%define     S_IRGRP         0q0000040
%define     S_IROTH         0q0000004

%define     LF              10
%define     NULL            0

; *********************************

section     .data

string      db          "Abcdefghijklmnopqrstuvwxyz!", LF, NULL                                 ; The message we'll write to the file
filepath    db          "/Users/austindewey/test/learning-assembly/ch13-8-1/file.txt", NULL     ; The file we'll create and write to

; *********************************

section     .text
global _start
_start:

    ; Create file
    lea     rdi, [filepath]
    call    openFile

exit:

    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall


; -----
; Open (and create if not exist) a file
; Args:
;   * rdi - filepath (char *)
; Returns:
;   * rax - fd
global openFile
openFile:

    ; -----
    ; int
    ; open(const char *path, int oflag, mode_t mode);
    ;      rdi               rsi        rdx

    ; rdi is already set, so nothing to do with the 1st arg

    mov     rsi, O_WRONLY | O_CREAT | O_TRUNC               ; Set up open flags

    mov     rdx, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH      ; Set up 0644 file permissions

    mov     rax, SYS_open
    syscall

    ret
