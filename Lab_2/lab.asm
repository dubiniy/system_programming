format ELF
public _start

section '.data' writable
    S db "zuXmTpytwmPaMVrgIObsBkudhwH"
    place db 1

section '.text' executable
_start:
    mov ecx, 27

loop_start:
    mov al, [S + ecx - 1]
    mov [place], al

    mov eax, 4
    mov ebx, 1
    mov edx, ecx

    mov ecx, place
    mov edi, edx
    mov edx, 1
    int 0x80

    mov ecx, edi
    sub ecx, 1
    cmp ecx, 0
    jne loop_start

    mov al, 0xA
    mov [place], al
    mov eax, 4
    mov ebx, 1
    mov ecx, place
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
