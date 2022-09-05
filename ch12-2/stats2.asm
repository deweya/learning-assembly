; Chapter 12, exercise 2
; Implement the stats2 function that does the following:
;   * Finds the median of a list of numbers
;   * Finds the min and max of a list of numbers
;   * Finds the sum of a list of numbers
;   * Finds the average of a list of numbers

default rel

; HLL call:
;   stats2(arr, len, min, med, max, sum, ave);
; -----
; Arguments:
;   arr, address        – rdi
;   len, dword value    – esi
;   min, address        - rdx
;   med, address        - rcx
;   max, address        - r8
;   sum, address        - r9
;   ave, address        - rbp + 16

section     .text
global stats2
stats2:

    push    rbx
    push    r12

    mov     rbx, 2

    mov     r10, 0
    mov     r11, rdx                ; Save addr of rdx
    mov     eax, esi
    mov     rdx, 0
    div     ebx
    mov     ebx, eax                ; ebx contains the index of the median
    mov     eax, 0                  ; Now eax will store the sum

iter:

    mov     r12d, [rdi + r10*4]
    add     eax, r12d
    cmp     r10, rbx
    je      setMed

endIter:

    inc     r10
    cmp     r10, rsi
    jne     iter
    jmp     exit

setMed:

    mov     [rcx], r12d
    jmp     endIter

exit:

    mov     [r9], eax

    pop     r12
    pop     rbx
    ret