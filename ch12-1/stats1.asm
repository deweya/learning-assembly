; Chapter 12, exercise 1
; Implement the "stats1" void function that does the following:
;   * Finds the sum of a list of numbers
;   * Finds the average of a list of numbers

default rel

; *********************

; HLL call:
;   stats1(arr, len, sum, ave);
; -----
; Arguments:
;   arr, address        – rdi       ; dword
;   len, dword value    – rsi       ; dword
;   sum, address        – rdx       ; dword
;   ave, address        - rcx       ; dword

section     .text
global stats1
stats1:

    push    r12                     ; Prologue
    mov     r12, 0
    mov     eax, 0                  ; Saves the running sum

sumLoop:

    add     eax, [rdi + r12*4]
    inc     r12
    dec     esi
    cmp     esi, 0
    je      exit
    jmp     sumLoop

exit:

    mov     [rdx], rax
    pop     r12                     ; Epilogue
    ret