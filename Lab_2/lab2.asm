format ELF
public _start

section '.data' writeable
place db 1

section '.text' executable

_start:
xor ecx, ecx
xor edi, edi

.line:
mov al, '%'
mov [place], al
mov eax, 4
mov ebx, 1
push ecx
mov ecx, place
mov edx, 1
int 0x80
pop ecx

inc ecx
inc edi
cmp edi, 14
jne .max

mov al, 0xA
mov [place], al
mov eax, 4
mov ebx, 1
push ecx
mov ecx, place
mov edx, 1
int 0x80
pop ecx
xor edi, edi

.max:
cmp ecx, 406
jne .line

mov eax, 1
xor ebx, ebx
int 0x80
