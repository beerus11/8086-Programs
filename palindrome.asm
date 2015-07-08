name "pali"
org 100h
jmp start
m1:
s db 'mom'
s_size = $ - m1
  db 0Dh,0Ah,'$'

start:

; first let's print it:
mov ah, 9
mov dx, offset s
int 21h


lea di, s
mov si, di
add si, s_size
dec si  ; point to last char!

mov cx, s_size
cmp cx, 1
je is_palindrome  ; single char is always palindrome!

shr cx, 1     ; divide by 2!

next_char:
    mov al, [di]
    mov bl, [si]
    cmp al, bl
    jne not_palindrome
    inc di
    dec si
loop next_char

is_palindrome:  
   ;  the string is "palindrome!"
   mov ah, 9
   mov dx, offset msg1
   int 21h
jmp stop

not_palindrome:
   ;  the string is "not palindrome!"
   mov ah, 9
   mov dx, offset msg2
   int 21h
   

stop:
; wait for any key press:
mov ah, 0
int 16h


ret
