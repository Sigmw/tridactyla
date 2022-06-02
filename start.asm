[BITS 32]

global start

start:
  mov esp, _sys_stack ; new area in system stack
  jmp push_kernel ; jumping to kernel block in main.c

ALIGN 4 ; this line need to be aligned in 4 bytes

; multiboot is necessary to expose important informations to link

multiboot:
   ; GRUB MACROS
   MULTIBOOT_PAGE_ALIGN equ 1<<0
   MULTIBOOT_MEMORY_INFO   equ 1<<1
   MULTIBOOT_AOUT_KLUDGE   equ 1<<16
   MULTIBOOT_HEADER_MAGIC  equ 0x1BADB002
   MULTIBOOT_HEADER_FLAGS  equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO | MULTIBOOT_AOUT_KLUDGE
   MULTIBOOT_CHECKSUM  equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)
  
   EXTERN code, bss, end

  ; exposuring multiboot grub headers and boot assign
  ; to more info: http://www.gnu.org/software/grub/manual/multiboot/multiboot.html
  dd MULTIBOOT_HEADER_MAGIC
  dd MULTIBOOT_HEADER_FLAGS
  dd MULTIBOOT_CHECKSUM

  ; exposuring phisical addresses to linker (I HOPE THIS LINKER WAS MUSL XDDD, just kidding.)
  dd multiboot
  dd code
  dd bss
  dd end
  dd start

; push_kernel will call main (main.c)
push_kernel:
  extern main
  call main
  jmp $

; BSS will alloc sizeof our stack
SECTION .bss
  resb 8192 ; 8kb to our stack (not bloated >:))
_sys_stack:

