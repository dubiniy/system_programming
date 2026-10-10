format ELF64

public _start

section '.data' writable

buffer    rb 32
nl        db 10
msg_char  db "Символ: "
len_char  = $ - msg_char
msg_code  db "ASCII-код: "
len_code  = $ - msg_code

section '.text' executable

_start:
    mov rcx, [rsp]
    cmp rcx, 2
    jne .usage

    mov rdi, [rsp+16]
    movzx rax, byte [rdi]
    mov r8, rax

    mov rax, 1
    mov rdi, 1
    mov rsi, msg_char
    mov rdx, len_char
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, [rsp+16]
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, msg_code
    mov rdx, len_code
    syscall

    mov rax, r8
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

    mov r10, r12
    mov r9, buffer

.store:
    pop rax
    mov byte [r9], al
    inc r9
    dec r12
    jnz .store
    
    mov byte [r9], 10
    inc r10

    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, r10
    syscall
    jmp .exit

.usage:
    mov rax, 0x3c
    mov rdi, 1
    syscall

.exit:
    mov rax, 0x3c
    xor rdi, rdi
    syscall