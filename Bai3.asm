.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    str db 100 dup ('$') 
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
    
   
    lea dx, str + 2
    int 21h
   
   
Main endp 

END MAIN