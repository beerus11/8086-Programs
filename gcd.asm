DATA SEGMENT
  NUM1 DW 000AH
  NUM2 DW 0004H
  GCD DW ?
DATA ENDS
CODE SEGMENT
  ASSUME CS:CODE,DS:DATA
  START: MOV AX,DATA   ;Load the Data to AX.
         MOV DS,AX     ;Move the Data AX to DS.
         MOV AX,NUM1   ;Move the first number to AX.
         MOV BX,NUM2   ;Move the second number to BX.
  UP: CMP AX,BX        ;Compare the two numbers.
      JE EXIT          ;If equal, go to EXIT label.
      JB EXCG          ;If first number is below than second,
                       ;go to EXCG label.
  UP1: MOV DX,0H       ;Initialize the DX.
       DIV BX          ;Divide the first number by second number.
       CMP DX,0        ;Compare remainder is zero or not.
       JE EXIT         ;If zero, jump to EXIT label.
       MOV AX,DX       ;If non-zero, move remainder to AX.
       JMP UP          ;Jump to UP label.
  EXCG:XCHG AX,BX     ;Exchange the remainder and quotient.
       JMP UP1        ;Jump to UP1.
  EXIT:MOV GCD,BX     ;Store the result in GCD.
       MOV AH,4CH
       INT 21H
  CODE ENDS
  END START