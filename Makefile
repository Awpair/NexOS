export target=i686 # wowzers

all: build/bootloader.bin build/kernel.bin 

build/kernel.bin: build/stage2.o build/kernel.o
	/home/andrew/opt/cross/bin/$(target)-elf-ld -o build/kernel.tmp -Ttext 0x7e00 build/stage2.o build/kernel.o
	objcopy -O binary build/kernel.tmp build/kernel.bin

build/bootloader.bin: src/bootloader.asm
	nasm src/bootloader.asm -f bin -o build/bootloader.bin

build/stage2.o: src/stage2.asm
	nasm src/stage2.asm -f elf -o build/stage2.o

build/kernel.o: src/kernel.c
	/home/andrew/opt/cross/bin/$(target)-elf-gcc -ffreestanding -m32 -c "src/kernel.c" -o "build/kernel.o"

clean:
	rm -rf build/*