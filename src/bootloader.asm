[ORG 0x7c00]

mov [BOOT_DISK], dl

call read_disk

jmp PROGRAM_SPACE

%include "src/asm/diskread.asm"

times 510-($-$$) db 0
db 0x55
db 0xaa