DATA SEGMENT   
    
      T db "NMAMIT"
      n db $-T
      P db "MIT"
      m db $-P
      len db ?
      msg1 db "Sub String Found$"
      msg2 db "Sub String Not Found$"
      temp db ?
DATA ENDS
code segment
assume cs:code, ds:data
start:
        MOV AX, data
        MOV ds, AX
        LEA SI, T
        LEA DI, P
        MOV AL, n      ;len=n-m
        SUB AL, m
        MOV len, AL
        MOV CX, 0000H     ; i->CX
UP1: 	        CMP CL, len
        JA NOMATCH     ;check if i<=n-m mov="" dx,="" 0000h="" ;="" j-="">DX
UP2: 	        CMP DL, m
        JAE L1         ;check if j