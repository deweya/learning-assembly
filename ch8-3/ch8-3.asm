; Chapter 8, exercise 3
; This exercise performs the following:
; * Computes the lateral total surface area (including the base) of
;   each pyramid in a set of square pyramids
; * Computes the volume of each pyramid in a set of square pyramids
; * Finds the minimum, maximum, sum, and average for the total
;   surface areas and volumes

; Formulas (where n is a pyramid from the set of pyramids):
; * totalSurfaceArea(n) = a(n)^2 + 2*a(n)*l(n)
;     where "a" is the base's length
;     and "l" is the slant height (height of each side face)
; * volume(n) = (a(n)^2 * h(n)) / 3
;     where "a" is the base's length
;     and "h" is the pyramid's height

DEFAULT REL

; ***************************

section     .data

; Constants
SUCCESS     equ     0
SYS_exit    equ     0x2000001

; Variables
a           db      10, 14, 13, 37, 54                          ; List of a (base length) values
            db      31, 13, 20, 61, 36
            db      14, 53, 44, 19, 42
            db      27, 41, 53, 62, 10
            db      19, 18, 14, 10, 15
            db      15, 11, 22, 33, 70
            db      15, 23, 15, 63, 26
            db      24, 33, 10, 61, 15
            db      14, 34, 13, 71, 81
            db      38, 13, 29, 17, 93

l           dw      1233, 1114, 1773, 1131, 1675                ; List of l (slant height) values
            dw      1164, 1973, 1974, 1123, 1156
            dw      1344, 1752, 1973, 1142, 1456
            dw      1165, 1754, 1273, 1175, 1546
            dw      1153, 1673, 1453, 1567, 1535
            dw      1144, 1579, 1764, 1567, 1334
            dw      1456, 1563, 1564, 1753, 1165
            dw      1646, 1862, 1457, 1167, 1534
            dw      1867, 1864, 1757, 1755, 1453
            dw      1863, 1673, 1275, 1756, 1353

h           dd      14145, 11134, 15123, 15123, 14123           ; List of h (height) values
            dd      18454, 15454, 12156, 12164, 12542
            dd      18453, 18453, 11184, 15142, 12354
            dd      14564, 14134, 12156, 12344, 13142
            dd      11153, 18543, 17156, 12352, 15434
            dd      18455, 14134, 12123, 15324, 13453
            dd      11134, 14134, 15156, 15234, 17142
            dd      19567, 14134, 12134, 17546, 16123
            dd      11134, 14134, 14576, 15457, 17142
            dd      13153, 11153, 12184, 14142, 17134

num         db      50                                          ; Number of square pyramids

tSa         dd      0                                           ; Sum of all surface areas
minSa       dd      0x7fffffff                                  ; Min SA
maxSa       dd      0                                           ; Max SA
avgSa       dd      0                                           ; Avg SA

tVol        dd      0                                           ; Sum of all volumes
minVol      dd      0x7fffffff                                  ; Min Vol
maxVol      dd      0                                           ; Max Vol
avgVol      dd      0                                           ; Avg Vol

w2          dw      2
d3          dd      3

; ***************************

section     .bss

tSaArr      resd    50                  ; Array of total surface areas
tVolArr     resd    50                  ; Array of total volumes

; ***************************

section     .text
global _start
_start:

    mov     cl, [num]                   ; Initialize loop counter register
    lea     r8, [a]                     ; Initialize displacements
    lea     r9, [l]
    lea     r10, [h]
    lea     r13, [tSaArr]
    lea     r14, [tVolArr]
    mov     r11, 0                      ; r11 is our register index

; -----
; Calculate totalSurfaceArea(n) and volume(n)
; Add each index's total to a surface area and volume array

totalSurfaceArea:

                                        ; * totalSurfaceArea(n) = a(n)^2 + 2*a(n)*l(n)
    movzx   eax, byte [r8 + r11*1]      ; Load a(n)
    mov     ebx, eax                    ; Pass the same thing into bl
    mul     eax                         ; a(n)^2
    mov     r12d, eax                   ; Load a(n)^2 to r12
    movzx   eax, word [r9 + r11*2]      ; Load l(n)
    mul     ebx                         ; 2*a(n)*l(n) + a(n)^2
    mul     word [w2]
    add     eax, r12d
    mov     [r13 + r11*4], eax          ; Move totalSurfaceArea(n) to total surface area array
    add     [tSa], eax                  ; tSa += totalSurfaceArea(n)
    inc     r11
    loop    totalSurfaceArea
    mov     cl, [num]                   ; Reset counters
    mov     r11, 0

totalVolume:
                                        ; * volume(n) = (a(n)^2 * h(n)) / 3
    movzx   eax, byte [r8 + r11*1]      ; Load a(n)
    mul     eax                         ; a(n)^2
    mov     ebx, [r10 + r11*4]          ; Load h(n)
    mul     ebx                         ; a(n)^2 * h(n)
    div     dword [d3]                  ; (a(n)^2 * h(n)) / 3
    mov     [r14 + r11*4], eax          ; Move volume(n) to total volume array
    add     [tVol], eax                 ; tVol += volume(n)
    inc     r11
    loop    totalVolume
    mov     cl, [num]                   ; Reset counters
    mov     r11, 0

; -----
; Calculate min/max/average for totalSurfaceArea(n) and volume(n)

statsStart:

    mov     eax, [r13 + r11*4]          ; Move totalSurfaceArea(n) to eax
    mov     ebx, [r14 + r11*4]          ; Move volume(n) to ebx

checkMinSa:

    cmp     [minSa], eax                ; if minSa > totalSurfaceArea(n)
    jg      setMinSa

checkMaxSa:

    cmp     [maxSa], eax                ; if maxSa < totalSurfaceArea(n)
    jl      setMaxSa

checkMinVol:

    cmp     [minVol], ebx               ; if minVol > volume(n)
    jg      setMinVol

checkMaxVol:

    cmp     [maxVol], ebx               ; if maxVol < volume(n)
    jl      setMaxVol
    jmp     statsEnd

setMinSa:

    mov     [minSa], eax
    jmp     checkMaxSa

setMaxSa:

    mov     [maxSa], eax
    jmp     checkMinVol

setMinVol:

    mov     [minVol], ebx
    jmp     checkMaxVol

setMaxVol:

    mov     [maxVol], ebx

statsEnd:

    inc     r11
    loop    statsStart

initSetAvgs:

    movzx   ebx, byte [num]

setAvgSa:

    mov     eax, [tSa]                  ; avgSa = totalSurfaceArea(n) / number of pyramids
    div     ebx
    mov     [avgSa], eax

setAvgVol:

    mov     eax, [tVol]                 ; avgVol = volume(n) / number of pyramids
    div     ebx
    mov     [avgVol], eax

; -----
; Terminate the program

exit:
    mov     rax, SYS_exit
    mov     rdi, SUCCESS
    syscall
