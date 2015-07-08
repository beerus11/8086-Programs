DATA SEGMENT 
str1 db 20 dup(?)			; First string
str2 db 20 dup(?)			; Second string 
n1 db ?				; length of 1st string
n2 db ?				; length of 2nd string
msg1 db 10, 13, "Strings are equal",10, 13,"$"
msg2 db 10, 13, "String are not equal",10, 13,"$"
msg3 db 10, 13, "enter string1", 10, 13, "$"
msg4 db 10, 13, "enter string2", 10, 13, "$"
msg5 db 10,13, ÃƒÂ¢Ã¢â€šÂ¬Ã…â€œLength of string1ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â,10,13,ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â$ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â
msg6 db 10,13, ÃƒÂ¢Ã¢â€šÂ¬Ã…â€œLength of string2ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â,10,13,ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â$ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â	
DATA ENDS
code segment
assume cs:code, ds:data
                      start:        MOV AX, data
        MOV DS, AX
        LEA DX, msg3
        MOV AH, 09H       	; DISPLAY MSG3
        INT 21H
        LEA SI, str1
        CALL READSTRING
        MOV n1, CL
        LEA DX, msg4
        MOV AH, 09H       	; DISPLAY MSG4
        INT 21H
        LEA SI, str2
        CALL READSTRING
        MOV n2, CL
        COMP n1, CL		; CMP n1, n2
        JNZ NOTEQ
        LEA	SI, str1
        LEA  DI, str2
        MOV CL, 00h
               UP1: CMP CL, n1		; CMP with n1 or n2
        JZ STREQUAL
        MOV AL, [SI]
        CMP AL, [DI] 
        JNZ NOTEQ	
        INC SI
        INC DI
        INC CL
        JMP UP1
NOTEQ:         LEA DX, msg2		; Display strings are not equal
        MOV AH, 09H
        INT 21H
        JMP DISPLEN
STREQUAL:    LEA DX, msg1	; Display strings are equal
        MOV AH, 09H
        INT 21H
DISPLEN:        LEA DX, msg5	; Display msg5 
        MOV AH, 09H
        INT 21H
        MOV BL, n1		; Display n1
        CALL STRINGLENDISP
        LEA DX, msg6	 ; Display msg6
        MOV AH, 09H
        INT 21H
        MOV BL, n2		; Display n2
        CALL STRINGLENDISP
        MOV AH, 4CH
        INT 21H
READSTRING PROC NEAR
        MOV CL, 00H 
UP:  MOV AH, 01H       	; to read string until enter key is pressed
        INT 21H
        CMP AL, 0dh       	; for enter key
        JZ L1
        MOV [SI], AL
        INC SI
        INC CL
        JMP UP
L1:   RET
        READSTRING ENDP
STRINGLENDISP PROC NEAR
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
STRINGLENDISP ENDP
code ENDS
END start	