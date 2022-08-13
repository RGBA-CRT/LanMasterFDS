BANK0_OFFSET	equ $6000
BANK1_OFFSET	equ $8000
BANK2_OFFSET	equ $a000
BANK3_OFFSET	equ $D000
DPCM_OFFSET		equ $D000 ;$c000 or higher, 64-byte steps

	.include "game.asm"

    .org $dfd0
reset_fds
    lda #$a0		; set FDS NMI #1
    sta $100
    lda $7e     ; stop moter
    sta $4025
    jmp reset

    .org $dff6
    .dw  NMI_CALL   ; NMI #1
    .dw  NMI_CALL   ; NMI #2
    .dw  reset_fds      ; NMI #3
    .dw  reset      ; reset
	.dw  irq        ; irq