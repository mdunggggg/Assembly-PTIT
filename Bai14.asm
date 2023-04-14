.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    base_dec dw 10
    base_bin dw 2
    base_hex dw 16
    input_str_a db 13, 10, 'a = $'
    input_str_b db 13, 10, 'b = $' 
    input_gcd db 13, 10, 'GCD(a, b) = $'
    input_lcm db 13, 10, 'LCM(a, b) = $'
    x dw 0
    a dw 0
    b dw 0
    gcd dw 0
    lcm dw 0
   
     
.Code
Main Proc    
   mov ax, @data
   mov ds, ax
   
   mov ah, 9
   lea dx, input_str_a
   int 21h
   call Input         
          
   mov ax, x
   mov a, ax
   
   mov ah, 9
   lea dx, input_str_b 
   int 21h 
   call Input
   
   mov ax, x
   mov b, ax
   
   
   call gcdEuclid 
   mov gcd, ax
   mov x, ax
   call Output
   
   mov ah, 9
   lea dx, input_lcm
   int 21h
   
   mov ax, a
   mov bx, gcd
   mov dx, 0
   div bx
   
   mov bx, b
   mul bx
   
   mov x, ax
   call output
  
   
   
    
   

   
   
   mov ah, 4ch
   int 21h
   
Main endp

gcdEuclid Proc
    mov ah, 9
    lea dx, input_gcd
    int 21h
    mov ax, a
    mov dx, b
euclid:
    cmp dx, 0
    je return_gcd
    mov bx, dx 
    mov dx, 0
    div bx
    mov ax, bx
    jmp euclid
return_gcd:
    ret     
        
gcdEuclid Endp

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