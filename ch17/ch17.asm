; Chapter 17 - Buffered I/O
; Implement a readLine function that:
;   * Fills a buffer on first call
;   * Reads up to LF on the buffer
;   * Returns TRUE if a line was read
;   * Returns FALSE if a line was not read (due to the file being already read or an error)

default rel

%define     SYS_exit        0x2000001
%define     SYS_read        0x2000003
%define     SYS_write       0x2000004
%define     SYS_open        0x2000005
%define     SYS_close       0x2000006

%define     SUCCESS         0
%define     LF              10
%define     NULL            0
%define     TRUE            1
%define     FALSE           0
%define     STDOUT          1

%define     O_RDONLY        0x0000

%define     BUFFER_LEN      1000
%define     READLN_LEN      100

; **************************************

section     .data

file        db          "/Users/austindewey/test/learning-assembly/ch17/file.txt", NULL

; **************************************

section     .text
global _start
_start:

    ; Open file
    lea     rdi, [file]
    call    openFile

exit:

    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall


; -----
; Open a (already existing) file
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

    mov     rsi, O_RDONLY
    mov     rax, SYS_open
    syscall
    ret