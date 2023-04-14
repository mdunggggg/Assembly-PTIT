.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$' 
    str db 100 dup('$')
    base_dec dw 10 
    x dw ?

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
    
    mov ax, 0
    mov al, str + 1
    mov x, ax
    
    call print 
  
    
    mov ah, 4ch
    int 21h
   
Main endp 
print Proc
  mov ax, x
  mov cx, 0
Divide: 
    mov dx, 0
    div base_dec
    push dx
    inc cx
    cmp al, 0
    je show
    jmp Divide
    
   
Show:
    mov ah, 2
    pop dx
    add dl, '0'
    int 21h
    dec cx
    cmp cx, 0
    jne Show
ret 
    
print Endp
END MAIN