    .inesprg    2
    .ineschr    1
    .inesmir    1
    .inesmap    0

BANK0_OFFSET	equ $8000
BANK1_OFFSET	equ $a000
BANK2_OFFSET	equ $c000
BANK3_OFFSET	equ $e000
DPCM_OFFSET		equ $e000 ;$c000 or higher, 64-byte steps

	.include "game.asm"

	.bank 3
    .org $fffa
    .dw  NMI_CALL
    .dw  reset
	.dw  irq
	
    .bank 4
    .org $0000
    .incbin "patterns.chr"