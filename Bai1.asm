.Model Small
.Stack 100H
.Data
    English db "Hello$"
    VietNam db "Xin chao$"
    crlf db 13, 10, '$' 
.Code
Main Proc    
   
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, English
    int 21h        
    
    lea dx, crlf
    int 21h
    
    lea dx, VietNam
    int 21h
    
    mov ah, 4ch
    int 21h
   
Main endp 

END MAIN