.set noreorder
.set noat

.section .lib.ent.top, "a", @progbits
.align 2
__lib_ent_top:

.section .lib.ent.btm, "a", @progbits
.align 2
__lib_ent_bottom:

.section .lib.stub.top, "a", @progbits
.align 2
.global module_import
module_import:
__lib_stub_top:

.section .lib.stub.btm, "a", @progbits
.align 2
.global module_import_end
module_import_end:
__lib_stub_bottom:

.section .rodata.sceModuleInfo, "a", @progbits
.align 5
.global module_info
module_info:
  .hword 0x0000
  .byte 1, 0
  .ascii "spk_module"
  .space 17
  .byte 0
  .word _gp
  .word __lib_ent_top
  .word __lib_ent_bottom
  .word __lib_stub_top
  .word __lib_stub_bottom

.section .rodata.sceResident, "a", @progbits
.align 2
__syslib_exports:
  .word 0xD632ACDB
  .word 0xF01D73A7
  .word module_start
  .word module_info

.section .lib.ent, "a", @progbits
.align 2
__library_exports:
  .word 0
  .hword 0
  .hword 0x8000
  .byte 4
  .byte 1
  .hword 1
  .word __syslib_exports

.set noreorder
.set noat

.section .text
.align 2

.global module_start
.ent module_start

module_start:
  .set noreorder
  .set noat
    
  addiu   $sp, $sp, -16
  sw      $ra, 12($sp)
  sw      $a0, 8($sp)
  sw      $a1, 4($sp)

  jal     _start
  nop
  
  lw      $a0, 8($sp)
  lw      $a1, 4($sp)
  lw      $ra, 12($sp)

  addiu   $sp, $sp, 16
  
  jr      $ra
  nop

.end module_start
