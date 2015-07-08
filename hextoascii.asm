org 100h

main proc near
    mov ah,09h      ; Display String
    mov dx,offset message
    int 21h             
                   
    mov ax,55h       ; AX Contains Hex 55H = 85 Decimal
    mov si,offset strHextToAsc  ;   SI Offset Where Converted
                                    to String is stored 
    call hexToAsc
    
    
    mov ah,,09h     ; Display String : Number Converted
    mov dx,offset strHextToAsc
    int 21h   
    
    mov ah,4ch      ;   Return To Dos
    mov al,00
    int 21h       
endp


hexToAsc proc near        ;AX input , si point result storage addres
        mov cx,00h
        mov bx,0ah
        hexloop1:
                mov dx,0
                div bx
                add dl,'0'
                push dx
                inc cx
                cmp ax,0ah
                jge hexloop1
                add al,'0'
                mov [si],al
        hexloop2:
                pop ax
                inc si
                mov [si],al
                loop hexloop2
                inc si
                mov al,'$'
                mov [si],al
                ret
endp    

message db "HexToAsc Character =  $"        
strHextToAsc db "                 "

end main

ret

