# Halt opcode POC

.set noreorder
.set noat

.include "allegrex.inc"

.section .text
.align 2

.global halt
.type halt, @function
halt:
    halt
    jr      $ra
    nop
