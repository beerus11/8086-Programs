putc    macro   char
        push    ax
        mov     al, char
        mov     ah, 0eh
        int     10h     
        pop     ax
endm

org     100h

jmp start

result dw ?

start:

; get first number:

mov dx, offset msg1
mov ah, 9
int 21h
jmp n1
msg1 db 0Dh,0Ah, 'enter the number: $'
n1:

call    scan_num


; factorial of 0 = 1:
mov     ax, 1
cmp     cx, 0
je      print_result

; move the number to bx:
; cx will be a counter:

mov     bx, cx

mov     ax, 1
mov     bx, 1

calc_it:
mul     bx
cmp     dx, 0
jne     overflow
inc     bx
loop    calc_it

mov result, ax

print_result:

; print result in ax:
mov dx, offset msg2
mov ah, 9
int 21h
jmp n2
msg2 db 0Dh,0Ah, 'factorial: $'

n2:

mov     ax, result
call    print_num_uns
jmp     exit

overflow:
mov dx, offset
