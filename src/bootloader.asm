[ORG 0x7c00]

mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp

call read_disk

jmp PROGRAM_SPACE

jmp $

%include "src/asm/diskread.asm"

times 510-($-$$) db 0
db 0x55
db 0xaa