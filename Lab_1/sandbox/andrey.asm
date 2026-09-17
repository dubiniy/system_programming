format ELF
public _start
fio db "Andrey", 0xA, "Goltsev", 0xA, "Evgenievich", 0xA, 0

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, fio
    mov edx, 28
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80