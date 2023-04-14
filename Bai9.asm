.Model Small
.Stack 100H
.Data
    crlf db 13, 10, '$'
    base_dec dw 10
    base_bin dw 2
    base_hex dw 16
    error db "Invalid$"
    str db '0123456789ABCDEF'
    
    x dw 0

     
.Code
Main Proc    
   mov ax, @data
   mov ds, ax
   
   mov cx, 0
   call Input
   
   mov ah, 9
   lea dx, crlf
   int 21h
   
   call convert
   
   

   mov ah, 4ch
   int 21h
   
Main endp 

Input Proc
  
loop_input:
    mov ah, 1
    int 21h
    cmp al, '#'
    je exit
    cmp al, '1'
    je calc
    cmp al, '0'
    je calc
    mov ah, 9
    lea dx, error
    int 21h
    jmp exit
calc:
    inc cx
    mov ah, 0
    sub al, '0'
    push ax
    mov ax, x
    mul base_bin
    mov x, ax
    pop ax
    add x, ax 
    cmp cx, 8
    je exit
    jmp loop_input    

exit:
    ret
        
Input Endp

convert Proc
    mov ax, x
    mov cx, 0
loop_output:
    mov dx, 0
    div base_hex
    push dx
    inc cx
    cmp ax, 0
    jg loop_output
    
    mov ah, 2
print:
    pop si
    add si, (str)
    mov dl, [si]
    int 21h
    loop print
ret
     
convert Endp

END MAIN