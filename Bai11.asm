.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    base_dec dw 10
    base_bin dw 2
    base_hex dw 16
    error db "Invalid$"
    str db '0123456789ABCDEF'
    len db 'Lenght: $'
    strMax db 13, 10, 'MAX: $'
    strMin db 13, 10, 'MIN: $'
    x dw 0
    y dw 0
    MAX dw 0
    MIN dw 9999

     
.Code
Main Proc    
   mov ax, @data
   mov ds, ax
   
   mov ah, 9
   lea dx, len
   int 21h
   
   call input
   mov cx, x 
   
   mov ah, 9
   lea dx, crlf
   int 21h 
   
    
   
input_array:
   call input
   mov bx, x
   cmp bx, MAX
   jl find_min
   mov MAX, bx
find_min:  
   cmp bx, MIN
   jg continue
   mov MIN, bx
continue: 
   loop input_array 
   
 
   
   mov bx, MAX
   mov x, bx
   
   mov ah, 9
   lea dx, strMax
   int 21h
   call Output
   
   mov bx, MIN
   mov x, bx  
   
    mov ah, 9
   lea dx, strMin 
   int 21h
   call Output   
   
   mov ah, 4ch
   int 21h
   
Main endp 

Input Proc
    mov x, 0
loop_input:
    mov ah, 1 
    int 21h
    cmp al, 13
    je end_input
    cmp al, ' '
    je end_input
    mov ah, 0
    sub al, '0'
    push ax
    mov ax, x
    mul base_dec
    mov x, ax
    pop ax
    add x, ax
    jmp loop_input
end_input:
    ret
    
        
Input Endp

Output Proc
   mov ax, x
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
    
Output Endp

END MAIN