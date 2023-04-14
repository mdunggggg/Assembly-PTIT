.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    str db 100 dup('$')
    childStr db 'ktmt' 
    strNumber db 13, 10, 'NUMBER OF KTMT IN STR: $'
    last dw 0
    count dw 0 
    base_dec dw 10
     
.Code
Main Proc    
   
    mov ax, @data
    mov ds, ax 
    
    mov ah, 10
    lea dx, str
    int 21h
    
    mov ah, 9
    lea dx, crlf
    int 21h
 
  
    mov al, str + 1
    sub al, 4
    mov ah, 0
   
    mov last, ax
    lea si, str + 2 
    lea di, str 
    mov dx, 0
    mov cx, 0
Lap:
    cmp [si], '$'
    je Done
    cmp [si], 'k'
    jne continue 
    cmp [si + 1], 't'
    jne continue
    cmp [si + 2], 'm'
    jne continue
    cmp [si + 3], 't'
    jne continue 
    cmp [si + 3], '$'
    je Done
    inc dx
continue:
    inc si
    inc cx
    jmp Lap
    
    
Done: 
    mov count , dx 
    mov ah, 9 
    lea dx, strNumber
    int 21h
    
    call Output
        
    mov ah, 4ch
    int 21h
   
Main endp
Output Proc
   mov ax, count
   mov cx, 0
Divide:
    mov dx, 0
    div base_dec
    push dx
    inc cx
    cmp ax, 0
    je show
    jmp Divide
show:
    mov ah, 2
    pop dx
    add dl, '0'
    int 21h
    dec cx
    cmp cx, 0
    jne show
ret

END MAIN