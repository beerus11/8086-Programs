CLRSCR MACRO 

        MOV AH, 00H
        MOV AL, 02H
        INT 10H
ENDM
SETCURSOR MACRO X, Y
        MOV DL, Y       	; Y COORDINATE or COLUMN
        MOV DH, X      	; X COORDINATE or ROW
        MOV BH, 00H   	; CURRENT PAGE
        MOV AH, 02H
        INT 10H
ENDM
DATA SEGMENT
msg1 db "Enter Your Name", 10, 13, "$"
str1 db 30 dup (?)
n db ?
str2 db "What is Your Name?$"
x db 15
y db 35
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:
        MOV AX, DATA
        MOV DS, AX
        LEA DX, msg1
        MOV AH, 09H     ; DISPLAY MSG1
        INT 21H
        LEA SI, str1
        MOV CL, 00H
UP1: 	        CMP CL, 30
        JAE L1
        MOV AH, 01H     ; READ CHARACTER
        INT 21H
        CMP AL, 0dh
        JZ L1
        MOV [SI], AL
        INC SI
        INC CL
        JMP UP1
L1: 	        MOV n, CL
        CLRSCR
        MOV AL, 02H     ; FOR 80 X 25 BW
        SETCURSOR x, y
        LEA DX, str2
        MOV AH, 09H      ; DISPLAY STR2
        INT 21H
        MOV CL, 00H
        LEA SI, str1
   UP2: 	        CMP CL, n
        JAE EXIT                      
        MOV DL, [SI] 		; DISPLAY NAME
        MOV AH, 02H
        INT 21H
        INC SI
        INC CL
        JMP UP2
 EXIT:	        MOV AH, 01H       ; wait until any key press just like getch in C
        INT 21H
        MOV AH, 4CH
        INT 21H
           CODE ENDS
           END START


    