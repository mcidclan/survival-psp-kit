OUTPUT_FORMAT("elf32-tradlittlemips")
OUTPUT_ARCH(mips)
ENTRY(module_start)
__DYNAMIC = 0;

PHDRS {

  text PT_LOAD FLAGS(5);
  data PT_LOAD FLAGS(6);
}

SECTIONS {

  . = 0x00000000;
  PROVIDE (__executable_start = 0x0); . = 0x0;

  .text : { *(.text*) } :text
  .sceStub.text : ALIGN(8) { KEEP(*(.sceStub.text)) } :text
  .lib.ent : ALIGN(4) { KEEP(*(.lib.ent.top)) KEEP(*(.lib.ent)) KEEP(*(.lib.ent.btm)) } :text
  .lib.stub : ALIGN(4) { KEEP(*(.lib.stub.top)) KEEP(*(.lib.stub)) KEEP(*(.lib.stub.btm)) } :text
  .rodata.sceModuleInfo : ALIGN(4) { KEEP(*(.rodata.sceModuleInfo)) } :text
  .rodata.sceResident : ALIGN(4) { KEEP(*(.rodata.sceResident)) } :text
  .rodata.sceNid : ALIGN(4) { KEEP(*(.rodata.sceNid)) } :text
  .rodata : ALIGN(4) { *(.rodata*) } :text
  .data : ALIGN(16) { *(.data*) } :data

  .bss : {
  
    *(.dynbss)
    *(.bss .bss.* .gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN(4);
  }

  .rel.text                 : { *(.rel.text) }
  .rel.lib.stub             : { *(.rel.lib.stub) }
  .rel.lib.ent              : { *(.rel.lib.ent) }
  .rel.rodata.sceModuleInfo : { *(.rel.rodata.sceModuleInfo) }
  .rel.rodata.sceResident   : { *(.rel.rodata.sceResident) }
  .rel.rodata.sceNid        : { *(.rel.rodata.sceNid) }

  .MIPS.abiflags : {
  
    *(.MIPS.abiflags)
  }

  /DISCARD/ : {
  
    *(.reginfo)
    *(.pdr)
    *(.gnu.attributes)
    *(.comment)
  }

  . = ALIGN(16);
  _gp = . + 0x7ff0;
  . = ALIGN(256);
  _stack_bottom = .;
  . += 0x4000;
  _stack_top = .;
}

