.MODEL SMALL
.STACK 100H
.DATA
    CRLF DB 13, 10, '$' 
    
    BASE_DEC DW 10
    
   
    MSG_A DB "SO LINH HON: $"
    MSG_B DB "SO NHAN CACH: $"
    MSG_C DB "SO DUONG DOI: $"
    MSG_D DB "SO THAI DO: $"
                                                      
    NAME_AND_BIRTH DB "HOANG MANH DUNG: 25/07/2003$"  
   
    FULL_NAME DB "HOANGMANHDUNG$"  
    
    COUNT_NAME DW 13     
    
    NGUYEN_AM DB "OAAU$"  
    
    COUNT_NGUYEN_AM DW 4    
    
    BIRTH_DAY DW "25/07/2003"  
    
    SUM_NAME DW 0 
    
    SUM_NGUYEN_AM DW 0
    
    SUM_PHU_AM DW 0 
    
    NUMBER DW 0 
    
    A DW 0 
    
    SO_NGAY_SINH DW 0
    
    SO_DUONG_DOI DW 0
    
    SO_THAI_DO DW 0
     
     
     
  
.CODE
MAIN PROC   
   
   
    MOV AX, @DATA
    MOV DS, AX 

    CALL SUM_NUMBER
   
    CALL LINH_HON
    MOV SUM_NGUYEN_AM, BX

    MOV BX, SUM_NAME
    SUB BX, SUM_NGUYEN_AM
    MOV SUM_PHU_AM, BX

   
    CALL NGAY_SINH
    CALL DUONG_DOI
    CALL THAI_DO 
    
    
    
    MOV BX, SUM_NAME 
    MOV NUMBER, BX  
    
    
    
    ; IN TEN
    MOV AH, 9
    LEA DX, NAME_AND_BIRTH
    INT 21H 
    
    CALL NEWLINE
    CALL NEWLINE 
    
    MOV BX, SUM_NAME
    CALL RUT_GON_LOOP
    MOV AX, BX
    MOV DX, 0
    MOV BX, 4
    DIV BX
    CMP DX, 0
    JE LABEL_LINH_HON
    CMP DX, 1
    JE LABEL_NHAN_CACH
    CMP DX, 2
    JE LABEL_DUONG_DOI
    CMP DX, 3
    JE LABEL_THAI_DO 
                  
    
    ; IN SO LINH HON  
    
    
 LABEL_LINH_HON:
    MOV AH, 9
    LEA DX, MSG_A
    INT 21H
    
    
    MOV BX, SUM_NGUYEN_AM
    CALL RUT_GON_LOOP
    MOV NUMBER, BX
    CALL OUTPUT
    
    CALL NEWLINE
    CALL NEWLINE
    JMP LABEL_END
    
    ; IN SO NHÂN CÁCH
    
LABEL_NHAN_CACH:
    MOV AH, 9
    LEA DX, MSG_B
    INT 21H
    
    MOV BX, SUM_PHU_AM
    CALL RUT_GON_LOOP
    MOV NUMBER, BX
    CALL OUTPUT 
    
    CALL NEWLINE
    CALL NEWLINE
    JMP LABEL_END
    
    ; IN SO DUONG DOI 
    
LABEL_DUONG_DOI:
    MOV AH, 9
    LEA DX, MSG_C
    INT 21H
    
    MOV BX, SO_DUONG_DOI
    CALL RUT_GON_LOOP
    MOV NUMBER, BX
    CALL OUTPUT
    
    
    CALL NEWLINE
    CALL NEWLINE
    JMP LABEL_END
    
    ; IN SO THAI DO
             
LABEL_THAI_DO:
    MOV AH, 9
    LEA DX, MSG_D
    INT 21H
    
    MOV BX, SO_THAI_DO
    CALL RUT_GON_LOOP
    MOV NUMBER, BX
    CALL OUTPUT
    JMP LABEL_END
    
LABEL_END:     
    MOV AH, 4CH
    INT 21H
   
MAIN ENDP

NEWLINE PROC
            
    MOV AH, 9
    LEA DX, CRLF
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
        DIV BASE_DEC
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

RUT_GON_LOOP PROC
    VONG_LAP:
        CALL RUT_GON
        MOV NUMBER, BX
        CMP BX, 9
        JG VONG_LAP
    RET

RUT_GON_LOOP ENDP


SUM_NUMBER PROC
    MOV AX, 0
    MOV BX, 0
    LEA SI, FULL_NAME
    MOV CX, COUNT_NAME 
    MOV DX, 0
    MOV DL, 9
    LOOP_SUM_NUMBER:
        MOV AL, [SI] 
        SUB AL, 'A'
        DIV DL
        MOV AL, AH
        MOV AH, 0 
        ADD BX, AX
        INC BX
        INC SI
        LOOP LOOP_SUM_NUMBER   
        
    MOV SUM_NAME, BX    
    RET    
SUM_NUMBER ENDP

LINH_HON PROC

    LEA SI, NGUYEN_AM
    MOV CX, COUNT_NGUYEN_AM
    MOV BX, 0
    LOOP_LINH_HON:
        MOV DL, [SI]
        CMP DL, 'U'
        JE ADD_U
        CMP DL, 'E'
        JE ADD_E
        CMP DL, 'A'
        JE ADD_A
        CMP DL, 'O'
        JE ADD_O
        CMP DL, 'I'
        JE ADD_I
        CMP DL, 'Y'
        JE ADD_Y 
        
    ADD_U:
        ADD BX, 3
        JMP END_ADD   
    ADD_E:
        ADD BX, 5
        JMP END_ADD 
    ADD_O:
        ADD BX, 6
        JMP END_ADD 
    ADD_A:
        ADD BX, 1
        JMP END_ADD 
    ADD_I:
        ADD BX, 9
        JMP END_ADD 
    ADD_Y:
        ADD BX, 7
        JMP END_ADD
    
    END_ADD:
        INC SI
        LOOP LOOP_LINH_HON
    RET 
    MOV SUM_NGUYEN_AM, BX
    
LINH_HON ENDP

NGAY_SINH PROC 
    LEA SI, BIRTH_DAY
    MOV BX, 0
    MOV CX, 2
    LOOP_NGAY_SINH:
        MOV DL, [SI]
        SUB DL, '0'
        ADD BL, DL
        INC SI
        LOOP LOOP_NGAY_SINH
             
    MOV SO_NGAY_SINH, BX    
    RET
        
    
NGAY_SINH ENDP 

DUONG_DOI PROC
              
     LEA SI, BIRTH_DAY
     MOV BX, 0
     MOV CX, 10
     MOV DX, 0
     LOOP_DUONG_DOI:
        MOV DL, [SI]
        CMP DL, '/'
        JE END_LOOP_DUONG_DOI
        SUB DL, '0'
        ADD BL, DL  
        END_LOOP_DUONG_DOI:
        INC SI  
        LOOP LOOP_DUONG_DOI
     
     
     MOV SO_DUONG_DOI, BX
     RET 
                 
              
DUONG_DOI ENDP 

THAI_DO PROC
    
     LEA SI, BIRTH_DAY
     MOV BX, 0
     MOV CX, 5
     MOV DX, 0
     LOOP_THAI_DO:
        MOV DL, [SI]
        CMP DL, '/'
        JE END_LOOP_THAI_DO
        SUB DL, '0'
        ADD BL, DL  
        END_LOOP_THAI_DO:
        INC SI  
        LOOP LOOP_THAI_DO
     
     
     MOV SO_THAI_DO, BX
     RET
    
THAI_DO ENDP

RUT_GON PROC
    MOV AX, BX
    MOV CX, 0
    MOV BX, 0
    DIVIDE_RUTGON: 
        MOV DX, 0
        DIV BASE_DEC
        ADD BX , DX
        INC CX
        CMP AX, 0
        JE END_RUTGON
        JMP DIVIDE_RUTGON
    END_RUTGON:
        RET
RUT_GON ENDP



END MAIN