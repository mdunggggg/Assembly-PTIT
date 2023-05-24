.MODEL SMALL
.STACK 100H
.DATA
    CRLF db 13, 10, '$' 
    NUMBER DW ? 
    BASE_DEC dw 10
.CODE
MAIN PROC   
   
   
    MOV AX, @DATA
    MOV DS, AX 
    
        
    MOV AH, 4CH
    INT 21H
   
MAIN ENDP

NEWLINE PROC
            
    MOV AH, 9
    LEA SI, CRLF
    INT 21H
    RET
            
NEWLINE ENDP

INPUT PROC

    INPUT_LOOP:
        AND AX,000FH                        
        PUSH AX                                 
        MOV AX,10                                               
        MUL BX                                  
        MOV BX,AX                               
        POP AX                                          
        ADD BX,AX                                   
        MOV AH,1                                            
        INT 21H                 
        CMP AL,0DH
        JE EXIT_INPUT
        JMP INPUT_LOOP

    EXIT_INPUT:
        RET             

INPUT ENDP

OUTPUT PROC
    MOV AX, NUMBER
    MOV CX, 0
    DIVIDE: 
        MOV DX, 0
        DIV base_dec
        PUSH DX
        INC CX
        CMP AX, 0
        JE DISPLAY
        JMP DIVIDE
    DISPLAY:
        MOV AH, 2
        POP DX
        ADD DL, '0'
        INT 21h
        LOOP DISPLAY
    RET

OUTPUT ENDP

END MAIN