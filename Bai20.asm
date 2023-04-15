.model small
.stack 100h
.data
    crlf db 13, 10, '$'
    str1 db 13, 10, 'Enter string A: $'
    str2 db 13, 10, 'Enter string B: $'
    m dw ?
    n dw ?
    strA db 100 dup('$')
    strB db 100 dup('$')
    i dw 0
    j dw 0 
    x dw 0
    count dw 0
    char db 0
    addressA dw ?
    addressB dw ?
    base_dec dw 10 
    str3 db 13, 10, 'The number of occurrences of string B in A is: $' 
.code
Main proc 
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, str1 
    int 21h
    
    mov ah, 10
    lea dx, strA
    int 21h 
    mov al, strA + 1 
    mov ah, 0
    mov m, ax
    
    mov ah, 9
    lea dx, str2
    int 21h
    
    mov ah, 10
    lea dx, strB
    int 21h
    mov al, strB + 1
    mov ah, 0
    mov n, ax
    
    mov ah, 9
    lea dx, crlf
    int 21h
    
    lea si, strA + 2
    mov addressA, si
    
    lea si, strB + 2
    mov addressB, si
    
    mov ax, n 
    
    mov bx, 0
    ; ax store n
    ; bx store m
LAP:
    cmp bx, m 
    je COMPLETE
    push bx
    LAP2: 
        cmp ax , j
        je done 
        mov si, j
        add si, addressB
        mov dl, [si]
        mov si, bx
        add si, addressA
        cmp [si], dl
        je CONTINUE
        pop bx
        inc bx
        jmp LAP
    
    CONTINUE:
        inc j 
        inc bx
        jmp LAP2   
    
    done:
        mov j, 0
        
        inc count
        pop bx
        inc bx
        jmp LAP
     
COMPLETE:     
    mov ah, 9
    lea dx, str3
    int 21h
    call Output
    
    
    mov ah, 4ch
    int 21h
    
    
Main endp 
Output Proc
   mov ax, count
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

end main