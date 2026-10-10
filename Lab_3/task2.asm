format ELF64
 
public _start
 
section '.data' writable
 
buffer     rb 32
vals       dq 0, 0, 0
nl         db 10
msg_zero   db "Ошибка: деление на ноль (b = 0)", 10
len_zero   = $ - msg_zero
msg_result db "Результат (((b-c)/b)+a) = "
len_result = $ - msg_result
 
section '.text' executable
 
_start:
    mov rcx, [rsp]
    cmp rcx, 4
    jne .usage_error
 
    xor r12, r12
.next_arg:
    mov rsi, [rsp+16+8*r12]
    xor rax, rax
    xor rcx, rcx
    xor rdi, rdi
    cmp byte [rsi], 45
    jne .digits
    mov rdi, 1
    inc rcx
.digits:
    xor rbx, rbx
    mov bl, byte [rsi+rcx]
    cmp bl, 48
    jl .end_num
    cmp bl, 57
    jg .end_num
    sub bl, 48
    mov rdx, 10
    mul rdx
    add rax, rbx
    inc rcx
    jmp .digits
.end_num:
    cmp rdi, 0
    je .store_num
    neg rax
.store_num:
    mov [vals+8*r12], rax
    inc r12
    cmp r12, 3
    jne .next_arg
 
    mov rbx, [vals+8]
    cmp rbx, 0
    je .zero
 
    mov rax, rbx
    sub rax, [vals+16]
    cqo
    idiv rbx
    add rax, [vals]
    mov r8, rax
 
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_result
    mov rdx, len_result
    syscall
 
    mov rax, r8
    mov r9, buffer
    cmp rax, 0
    jge .positive
    mov byte [r9], 45
    inc r9
    neg rax
.positive:
    mov rbx, 10
    xor r12, r12
.divide:
    xor rdx, rdx
    div rbx
    add rdx, 48
    push rdx
    inc r12
    cmp rax, 0
    jne .divide
.store:
    pop rax
    mov byte [r9], al
    inc r9
    dec r12
    jnz .store
    
    mov byte [r9], 10
    inc r9
 
    mov rsi, buffer
    mov rdx, r9
    sub rdx, rsi
    mov rax, 1
    mov rdi, 1
    syscall
    jmp .exit
 
.zero:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_zero
    mov rdx, len_zero
    syscall
    
.usage_error:
    mov rax, 0x3c
    mov rdi, 1
    syscall
 
.exit:
    mov rax, 0x3c
    xor rdi, rdi
    syscall