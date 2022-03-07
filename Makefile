all: build/bootloader.bin 

build/bootloader.bin: build/bootloader.tmp build/extended.tmp
	cat build/bootloader.tmp build/extended.tmp > build/bootloader.bin

build/bootloader.tmp: src/bootloader.asm
	nasm src/bootloader.asm -f bin -o build/bootloader.tmp


build/extended.tmp: src/asm/extended.asm src/asm/gdt.asm
	nasm src/asm/extended.asm -f bin -o build/extended.tmp

clean:
	rm -rf build/*