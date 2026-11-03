format ELF
public _start

section '.data' writeable
pla db 1

section '.text' executable
_start:
mov ecx, 1
mov edx, 1

.iteration:
push ecx
push edx

mov al, '%'
mov [pla], al
mov eax, 4
mov ebx, 1
mov ecx, pla
mov edx, 1
int 0x80

pop edx
pop ecx

dec edx
jnz .iteration

push ecx

mov al, 0xA
mov [pla], al
mov eax, 4
mov ebx, 1
mov ecx, pla
mov edx, 1
int 0x80

pop ecx

inc ecx
mov edx, ecx
cmp ecx, 28
jne .iteration

mov eax, 1
xor ebx, ebx
int 0x80
