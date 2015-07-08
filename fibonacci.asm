DATA SEGMENT   
    
    f1 db 00h
f2 db 01h
f3 db ?
msg1 db "The Fibonacci series is", 10, 13, "$"
n db 12
DATA ENDS
code segment
assume cs:code, ds:data
start:     	        mov ax, data
        mov ds, ax
        lea dx, msg1
        mov ah, 09h
        int 21h
        mov bl, f1
        CALL DISPNUM
        mov dl, ' '
        mov ah, 02h
        int 21h
        mov bl, f2
        CALL DISPNUM
        mov dl, ' '
        mov ah, 02h
        int 21h
        mov ch, 00h
up1:   	       cmp ch, n
        jae exit
        mov al, f1
        add al, f2
        mov f3, al
        mov bl, f3
        CALL DISPNUM
        mov dl, ' '
        mov ah, 02h
        int 21h
        mov al, f2
        mov f1, al
        mov al, f3
        mov f2, al
        inc ch
        jmp up1
exit:   	        mov ah, 4ch
        int 21h
DISPNUM PROC NEAR
        MOV DL, BL
        AND DL, 0F0H          ; display 1st digit
        MOV CL, 04H
        SHR DL, CL
        CMP DL, 09H
        JBE L2
        ADD DL, 07H
 L2:  ADD DL, 30H
        MOV AH, 02H
        INT 21H
        MOV DL, BL
        AND DL, 0FH
        CMP DL, 09H       ;display 2nd digit
        JBE L3
        ADD DL, 07H
 L3: ADD DL, 30H
        MOV AH, 02H
        INT 21H
        RET
DISPNUM ENDP
        	code ends  
end start