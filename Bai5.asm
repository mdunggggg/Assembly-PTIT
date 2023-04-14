.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$' 
    str db 100 dup ('$')
    dis db 32
     
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
   
   mov ch, 0
   mov cl, str + 1
   lea si, str + 2
   mov ah, 2
   call Lowercase
   
   
   mov ah, 9
   lea dx, crlf
   int 21h
   
   mov ch, 0
   mov cl, str + 1
   lea si, str + 2
   mov ah, 2
   call Uppercase
   
  
   mov ah, 4ch
   int 21h
      
   
Main endp 
Lowercase Proc

loop_lower:
    mov dl, [si]
    cmp dl, 'A'
    jl print_lower
    cmp dl, 'Z'
    jg print_lower
    add dl, 32
print_lower:
    int 21h
    inc si 
    loop loop_lower
ret  
  
Lowercase Endp 


Uppercase Proc
 
loop_upper:
    mov dl, [si]
    cmp dl, 'a'
    jl print_upper
    cmp dl, 'z'
    jg print_upper
    sub dl, dis
print_upper:
    int 21h
    inc si
    loop loop_upper
ret    
    
Uppercase Endp

END MAIN