[ORG 0x7c00]

xor ax, ax  ; AX = 0
mov ds, ax  ; DS = AX

mov ax, 0xABCD

mov word [reg16], ax
call putreg16

hang:
    jmp hang

puts:       lodsb
            mov ah, 0x0E    ;Bios print mode
            mov bh, 0
            mov bl, 4
            mov cx, 1

            or al, al
            jz loop_exit
            int 0x10
            jmp puts
            loop_exit:ret            

putreg16:   mov di, outstr16
            mov ax, [reg16]
            mov si, hexstr
            mov cx, 4
hexloop:    rol ax, 4
            mov bx, ax
            and bx, 0x000f
            mov bl, [si + bx]
            mov [di+2], bl
            inc di
            dec cx
            jnz hexloop

            mov si, outstr16
            call puts

hexstr db '0123456789ABCDEF'
outstr16 db '0x0000', 0
reg16 dw 0

msg db "BURG v0.0.1"
times 510-($-$$) db 0
db 0x55
db 0xaa