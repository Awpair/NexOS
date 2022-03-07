[org 0x7e00]

xor ax, ax
mov ds, ax
mov ss, ax
mov sp, 0x9c00

cld

mov ax, 0xb800
mov es, ax

mov si, msg
call sprint

jmp $

; TODO enter 32 bit protected mode

%include "src/asm/print.asm"

times 2048-($-$$) db 0