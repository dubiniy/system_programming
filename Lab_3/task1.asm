format ELF64
public _start

include 'func.asm'
section '.data' writable

    msg_char  db "Символ: ", 0
    msg_code  db "ASCII-код: ", 0
    code_str  rb 32
section '.text' executable

_start:
    mov rcx, [rsp]
    cmp rcx, 2
    jne .usage
    mov rsi, msg_char
    call print_str
    mov rsi, [rsp+16]
    call print_str
    call new_line
    mov rsi, msg_code
    call print_str
    mov rdi, [rsp+16]
    movzx rax, byte [rdi]
    mov rsi, code_str
    call number_str
    mov rsi, code_str
    call print_str
    call new_line
    call exit
.usage:
    mov rax, 0x3c
    mov rdi, 1
    syscall
