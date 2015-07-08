DATA SEGMENT
  X DW 0060H,0020H,0030H,0040H,0050H
  MES DB 10,13,'SMALLEST NUMBER AMONG THE SERIES IS $'
DATA ENDS
CODE SEGMENT
  ASSUME CS:CODE,DS:DATA

  START: MOV AX,DATA
         MOV DS,AX
         MOV CX,05H
         LEA SI,X
         MOV AX,[SI]
         DEC CX
     UP: CMP AX,[SI+2]
         JB CONTINUE
         MOV AX,[SI+2]
 CONTINUE:ADD SI,2
          DEC CX
          JNZ UP
          AAM
          ADD AX,3030H
          MOV BX,AX
          MOV AH,09H
          LEA DX,MES
          INT 21H
          MOV DL,BH
          MOV AH,02H
          INT 21H
          MOV DL,BL
          INT 21H
          MOV AH,4CH
          INT 21H
CODE ENDS
END START
