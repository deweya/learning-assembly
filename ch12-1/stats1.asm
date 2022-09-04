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

    mov     rax, 0              ; Holds the running sum
    mov     r8, 0               ; Helps with iterating
    mov     r10, rdx            ; Save array address, since div will wipe it out

sumLoop:

    add     eax, [rdi + r8*4]
    inc     r8
    cmp     r8, rsi
    jne     sumLoop
    mov     r9, rax             ; Store the sum in r9

calcAvg:

    cdq                         ; Fancy way to zero out rdx for division
    div     esi

exit:

    mov     [r10], r9
    mov     [rcx], rax
    ret