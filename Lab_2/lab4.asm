format ELF
public _start

section '.data' writeable
    place db 0
section '.text' executable

_start:
    mov eax, 1167271174
    xor ebx, ebx
.sum:
    xor edx, edx
    mov esi, 10
    div esi
    add ebx, edx
    test eax, eax
    jnz .sum
    mov eax, ebx
    xor ecx, ecx

.push_symb:
    xor edx, edx
    mov esi, 10
    div esi
    add dl, '0'
    push edx
    inc ecx
    test eax, eax
    jnz .push_symb
.pop_symb:
    pop eax
    mov [place], al
    mov eax, 4
    mov ebx, 1
    push ecx
    mov ecx, place
    mov edx, 1
    int 0x80
    pop ecx
    dec ecx
    jnz .pop_symb
    mov al, 0xA
    mov [place], al
    mov eax, 4
    mov ebx, 1
    mov ecx, place
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
