DATA SEGMENT 
str1 db 20 dup(?)		; Original String
str2 db 20 dup(?)		; Reversed String
n db ?
msg1 db 10, 13, "String is palindrome",10, 13,"$"
msg2 db 10, 13, "String is Not palindrome",10, 13,"$"
msg3 db 10, 13, "enter the string", 10, 13, "$"
NL db 10, 13 , '$'
DATA ENDS
code segment
assume cs:code, ds:data
start:
        MOV AX, data
        MOV DS, AX
        LEA SI, str1
        LEA DI, str2
        MOV CL, 00H
        LEA DX, msg3
        MOV AH, 09H       	; DISPLAY MSG3
        INT 21H
UP:  MOV AH, 01H       	; to read string until enter key is pressed
        INT 21H
        CMP AL, 0dh       	; for enter key
        JZ L2
        MOV [SI], AL
        INC SI
        INC CL
        JMP UP
L2:   MOV n, CL
        MOV CL, 00H
        DEC SI           		; BRING SI TO POINT TO LAST CHAR OF STR1
               UP1: CMP CL, n
        JZ CHECK
        MOV AL, [SI]
        MOV [DI], AL                 ; REVERSE 
        DEC SI
        INC CL
        INC DI
        JMP UP1
CHECK:
        LEA SI, str1
        LEA DI, str2
        MOV CL, 00H
              UP2: CMP CL, n
        JZ PAL
        MOV AL, [SI]
        CMP AL, [DI]
        JNZ NOTPAL
        INC SI
        INC DI
        INC CL
        JMP UP2
 NOTPAL:        LEA DX, msg2	; Display Not Palindrome
        MOV AH, 09H
        INT 21H
        JMP EXIT
PAL:        	        LEA DX, msg1	; Display Palindrome
        MOV AH, 09H
        INT 21H
EXIT: 	        MOV AH,4CH
        INT 21H
 code ENDS
 END start
