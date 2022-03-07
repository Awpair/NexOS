[ORG 0x7c00]
KERNEL_LOCATION equ 0x1000

mov [BOOT_DISK], dl

xor ax, ax
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp
mov bx, KERNEL_LOCATION
mov dh, 20

mov ah, 0x02
mov al, dh
mov ch, 0x00
mov dh, 0x00
mov cl, 0x02
mov dl, [BOOT_DISK]
int 0x13

mov ah, 0x0
mov al, 0x3
int 0x10

CODE_SEG equ GDT_code - GDT_start
DATA_SEG equ GDT_data - GDT_start



cli
lgdt [GDT_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_SEG:start_protected_mode
jmp $

BOOT_DISK db 0

%include "src/asm/gdt.asm"

[bits 32]
start_protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ebp, 0x90000
    mov esp, ebp

    jmp KERNEL_LOCATION


times 510-($-$$) db 0
db 0x55
db 0xaa