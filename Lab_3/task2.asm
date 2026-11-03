format ELF64
public _start

include 'func.asm'
section '.data' writable
vals       dq 0, 0, 0
buffer     rb 32
msg_zero   db "Ошибка: деление на ноль (b = 0)", 10, 0
msg_result db "Результат (((b-c)/b)+a) = ", 0
section '.text' executable
_start:
    mov rcx, [rsp]
    cmp rcx, 4
    jne .usage_error
    xor r12, r12.next_arg:
    mov rsi, [rsp+16+8*r12]
    push r12
    call str_number
    pop r12
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
    push rax
    mov rsi, msg_result
    call print_str
    pop rax
    mov rsi, buffer
    cmp rax, 0
    jge .positive
    mov byte [rsi], '-'
    inc rsi
    neg rax
.positive:
    call number_str
    mov rsi, buffer
    call print_str
    call new_line
    call exit
.zero:
    mov rsi, msg_zero
    call print_str
.usage_error:
    mov rax, 0x3c
    mov rdi, 1
    syscall
