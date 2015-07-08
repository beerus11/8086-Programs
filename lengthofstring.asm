org 100h

main proc near
    mov dx,offset message   ; String in dx
    call stringLength       ; returns length in cx
    mov ax,cx   
    
    mov si,offset strHextToAsc  ; Convert Length to ascii
    call hexToAsc

    mov ah,09   ; Display Length
    mov dx,offset strHextToAsc
    int 21h     
    
    mov ah,4ch      ; Terminate and return to dos
    mov al,00
    int 21h
endp    

stringLength proc near
    mov si,dx 
    dec si
    mov cx,0
loop_String_Length:
    inc si    
    inc cx
    cmp [si],'$'   
    jne loop_String_Length  
    dec cx
    dec cx
    ret
endp 


hexToAsc proc near     ;AX input , si point result storage addres
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

message db "Hello World$"
strHextToAsc db "        $" 

end main

ret
