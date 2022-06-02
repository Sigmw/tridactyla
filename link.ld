OUTPUT_FORMAT("binary")

ENTRY("start")

/* phisical adress where kernel will be alloc */
phys = 0x00100000;

/* ld expositions */
SECTIONS
{
 .text phys : AT(phys)
 {
  code = .;
   *(.text)
   *(.rodata)
   . = ALIGN(4096);
 }
 .data : AT(phys + (data - code))
 {
   data = .;
   *(.data)
   . = ALIGN(4096);
 }
  .bss : AT(phys + (bss - code))
 {
  bss = .;
  *(.bss)
  . = ALIGN(4096);
 }
end = .;
}

