all: build 

build:
		mkdir -p obj/ bin/
	 	nasm -f elf64 -o obj/start.o start.asm 
		gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -m64 -c libc/io.c -o obj/io.o
		gcc -Wall -O -fstrength-reduce -fomit-frame-pointer -finline-functions -nostdinc -fno-builtin -m64 -c main.c -o obj/main.o
		ld -m elf_x86_64 -T link.ld -o bin/kernel.bin obj/start.o obj/main.o obj/io.o
clean:
	rm -rf obj/
	rm -rf bin/
