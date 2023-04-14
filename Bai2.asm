.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    char db ? 
.Code
Main Proc 
    
    mov ax, @data
    mov ds, ax   
    
    mov ah, 1
    int 21h
    mov char, al 
    
    mov ah, 9
    lea dx, crlf
    int 21h 
    
    mov dl, char
    mov ah, 2
    int 21h
    
    mov ah, 4ch
    int 21h
   
Main endp 

END MAIN