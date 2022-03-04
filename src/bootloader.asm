[ORG 0x7c00]

xor ax, ax
mov ds, ax
mov ss, ax
mov sp, 0x9c00

cld

mov ax, 0xb800
mov es, ax

mov si, msg
call sprint

hang:
        jmp hang

%include "src/asm/print.asm"

ypos        db 0
xpos        db 0

hexstr      db '0123456789ABCDEF'
outstr16    db '0x0000', 0
reg16       dw 0

msg         db "BOOTPROC"
times 510-($-$$) db 0
db 0x55
db 0xaa