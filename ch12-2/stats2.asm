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
    push    r13

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
    push    r12                     ; push since r12 could be modified in setMed
    add     eax, r12d
    cmp     r10, rbx
    je      setMed

checkMin:

    pop     r12
    cmp     [r11], r12d
    jg      setMin

checkMax:

    cmp     [r8], r12d
    jl      setMax

endIter:

    inc     r10
    cmp     r10, rsi
    jne     iter
    jmp     exit

setMed:

    cmp     rdx, 1                  ; If remainder is 1, then the med is the middle number
    je      setMedOdd
    jmp     setMedEven

setMedOdd:

    mov     [rcx], r12d
    jmp     checkMin

setMedEven:

    push    rax
    dec     r10
    mov     r13d, [rdi + r10*4]
    inc     r10
    add     r12d, r13d
    cdq
    mov     eax, r12d
    mov     rbx, 2
    div     rbx
    mov     [rcx], eax
    pop     rax
    jmp     checkMin

setMin:

    mov     [r11], r12
    jmp     checkMax

setMax:

    mov     [r8], r12
    jmp     endIter

exit:

    mov     [r9], eax

    pop     r13
    pop     r12
    pop     rbx
    ret