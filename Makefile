all: build build/system.bin

build/system.bin: build/kernel.bin build/bootloader.bin build/zeroes.bin
	cat build/bootloader.bin build/kernel.bin build/zeroes.bin > build/system.bin

build/kernel.bin: build/kernel.o build/kernel_entry.o
	/home/andrew/opt/cross/bin/i686-elf-ld -o "build/kernel.bin" -Ttext 0x1000 "build/kernel_entry.o" "build/kernel.o" --oformat binary

build/kernel.o: src/kernel.c
	/home/andrew/opt/cross/bin/i686-elf-gcc -ffreestanding -m32 -g -c "src/kernel.c" -o "build/kernel.o"

build/kernel_entry.o: src/asm/kernel_entry.asm
	nasm "src/asm/kernel_entry.asm" -f elf -o "build/kernel_entry.o"

build/bootloader.bin: build/bootloader.tmp
	cat build/bootloader.tmp > build/bootloader.bin

build/bootloader.tmp: src/bootloader.asm
	nasm src/bootloader.asm -f bin -o build/bootloader.tmp

build/zeroes.bin: src/asm/zeroes.asm
	nasm src/asm/zeroes.asm -f bin -o "build/zeroes.bin"

build:
	mkdir build

clean:
	rm -rf build/*