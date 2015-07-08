DATA SEGMENT 
A  DW  1234H, 2345H, 5678H, 6347H, 7556H
LEN DB $-A
KEY DW 0001H
MID DB ?
MSG1 DB "KEY FOUND AT $"
MSG2 DB "KEY NOT FOUND $"
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE, DS:DATA
START:
        MOV AX, DATA
        MOV DS, AX
        SHR LEN, 01H
        DEC LEN
        MOV DL, 00H   ; LOW
        MOV DH, LEN   ; HIGH
        MOV BX, 0000H
        MOV AX, KEY
   UP:  CMP DL, DH
        JG NOTFOUND    	; IF LOW > HIGH; USE JG ONLY SINCE VALUE MAY GET IS -VE
        MOV BL, DL
        ADD BL, DH
        SHR BL, 01H     	;MID=(LOW+HIGH)/2
        MOV MID, BL
        MOV AL, 02H
        MUL BL
        MOV BX, AX
        MOV AX, KEY
        CMP AX, A[BX]
        JZ FOUND
        JG SECONDHALF
        DEC MID          	; IF KEY < a[mid]="" ,="" high="MID-1" mov="" dh,="" mid="" jmp="" up="" secondhalf:="" inc="" mid="" mov="" dl,="" mid="" ;="" if="" key="">A[MID], LOW=MID+1
        JMP UP
FOUND: LEA DX, MSG1
        MOV AH, 09H
        INT 21H
        INC MID        
        MOV DL, MID
        AND DL, 0F0H       	; DISPLAY 1ST DIGIT
        MOV CL, 04H
        SHR DL, CL
        CMP DL, 09H
        JBE L3
        ADD DL, 07H
    L3: ADD DL, 30H
        MOV AH, 02H
        INT 21H
        MOV DL, MID
        AND DL, 0FH       	; DISPLAY 2ND DIGIT
        CMP DL, 09H
        JBE L4
        ADD DL, 07H
    L4: ADD DL, 30H
        MOV AH, 02H
        INT 21H
        JMP EXIT
NOTFOUND:
       LEA DX, MSG2
        MOV AH, 09H
        INT 21H
  EXIT: MOV AH, 4CH
        INT 21H
CODE ENDS
END START



    
    

       