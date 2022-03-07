[org 0x7e00]

CODE_SEG equ GDT_code - GDT_start
DATA_SEG equ GDT_data - GDT_start

cli
lgdt [GDT_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax

jmp CODE_SEG:start_protected_mode

[bits 32]
start_protected_mode:
    mov ebx, msg
    call print_string_pm
    ; protected code here 
jmp $

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_str_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je print_str_pm_return

    mov [edx], ax

    add ebx, 1
    add edx, 2

    jmp print_str_pm_loop

print_str_pm_return:
    popa
    ret

; TODO enter 32 bit protected mode

%include "src/asm/print.asm"
%include "src/asm/gdt.asm"

msg db "Successfully landed in 32-bit protected mode",0

times 2048-($-$$) db 0