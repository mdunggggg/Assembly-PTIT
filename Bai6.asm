.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$' 
    
     
.Code
Main Proc  
   mov ax, @data
   mov ds, ax
   
   mov ah, 1
   mov cx, 0
input:
   int 21h
   cmp al, '#'
   je continue
   push ax
   jmp input
continue:
   mov ah, 9
   lea dx, crlf
   int 21h
   mov ah, 2
print:
   cmp sp, 100h
   je exit
   pop dx
   int 21h
   jmp print
exit:
    mov ah, 4ch
    int 21h 
   
      
   
Main endp 

END MAIN