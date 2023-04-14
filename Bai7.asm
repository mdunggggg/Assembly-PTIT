.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    n dw 0
    base_dec dw 10
    base_bin dw 2 
    
     
.Code
Main Proc  
    mov ax, @data
    mov ds, ax
    
    call Input 
    
    mov ah, 9
    lea dx, crlf
    int 21h
    
    mov ax, n 
    call Output
     
    mov ah, 4ch
    int 21h 
    
      
   
Main endp 
Input Proc 
loop_input: 
    mov ah, 1
    int 21h
    cmp al, 13
    je end_input
    sub al, '0'
    xor ah, ah
    push ax
    mov ax, n
    mul base_dec
    mov n, ax
    pop ax
    add n, ax
    jmp loop_input
end_input:
    ret
    
Input Endp

Output Proc
    mov cx, 0
Loop_output:
    mov dx, 0
    div base_bin
    push dx
    inc cx
    cmp ax, 0
    jg Loop_output 
    
    mov ah, 2
Show:
    pop dx;
    add dl, '0' 
    int 21h
    Loop Show
ret   
    
Output Endp


END MAIN