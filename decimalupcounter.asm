CLRSCR MACRO 
     
        MOV AH, 00H
        MOV AL, 02H
        INT 10H
ENDM

CODE SEGMENT
ASSUME CS:CODE
START:
      CLRSCR  ; TO CLEAR SCREEN
UP1:  	      MOV AL, 00H  ; INTIALIZE COUNTER TO 00
UP:   	      CALL CENTER     ; TO MOVE CURSOR TO THE CENTER
      MOV BL, AL
      CALL DISPLAY    ; TO DISPLAY THE BCD NO
      CALL DELAY      ; DELAY
      ADD AL, 01H
      DAA             
      CMP AL, 99H
      JB UP
      CALL CENTER
      MOV BL, AL
      CALL DISPLAY
      CALL DELAY
      MOV AH, 01H
      INT 16H         ; IF ANY KEY PRESSED THEN STOP AND EXIT ELSE CONTINUE
      JZ UP1
      MOV AH, 4CH
      INT 21H

      CENTER PROC
                PUSH AX
                MOV DL, 39
                MOV DH, 12
                MOV BH,0
                MOV AH,02h
                INT 10h
                POP AX
                RET
     CENTER ENDP

     DISPLAY PROC
                PUSH AX
                MOV DL, BL
        	MOV CL,04
        	SHR DL, CL
        	CMP DL,09
        	JBE DOWN1
        	ADD DL,07h
DOWN1:  	ADD DL,30h
                MOV AH,02h
                INT 21h
      	MOV DL, BL
                AND DL,0Fh
        	CMP DL,09H
        	JBE DOWN2
        	ADD DL,07h
DOWN2:  	ADD DL,30h
                MOV AH,02h
                INT 21h
        	POP AX
        	RET
      DISPLAY ENDP

      DELAY PROC
            PUSH AX
            PUSH BX
            PUSH CX
            MOV CX,07FFFh
   L1:    MOV BX,0FFFh
   L2:    DEC BX
            JNZ L2
            LOOP L1
            POP CX
            POP BX
            POP AX
            RET
    DELAY ENDP

 CODE ENDS
 END START