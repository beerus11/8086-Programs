
org 100h

main proc near
    mov ah,00       ;  Function To Read Character
    int 16h
    
    mov ah,4ch      ; Terminate and return to dos
    mov al,00
    int 21h
endp
end main

ret
