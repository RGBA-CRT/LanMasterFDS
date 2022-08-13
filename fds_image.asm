	.bank 0
    .org $0000
; FDS Header
; https://www.nesdev.org/wiki/FDS_file_format
	.db "FDS"
	.db $1A		; magic
	.db 1 		; number of disk side
	.db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; 0 fill

; Block01: QD Volume Label
; https://fantasysoft.net/fds/document/2-8.htm
; 500円で書き換えたディスクという設定
	.db $01 	; block code
	.db "*NINTENDO-HVC*"
	.db $00 	; licensee code
	
	.db "LMD ";	; game code: Lan Master for DiskSystem
	.db 0 		; game version
	.db 0 		; disk side
	.db 0		; disk number
	.db 0		; disk type: yellow
	.db 0		; unknown (最初に読みこむファイル番号 by fdsstudy)
	.db $01		; boot file number
	.db $FF,$FF,$FF,$FF,$FF ; unkwnon
	.db $97, $07, $24		; Manufacturing date(BCD): syowa 97 = reiwa 4 = 2022
	.db $49		; country code
	.db $61, $00, $00, $02	; unknown (fixed value)

	; 手元のディスクのunkwnon 0037h-003Bhメモ
	; .db $00, $35, $00, $99, $00	; unknown (オセロ [hacker wakker disk])
	.db $00, $C7, $03, $54, $01	; unknown (謎の壁 [retail disk])
	; .db $06, $28, $04, $27, $01	; unknown (将棋指南II [retail disk])
	; .db $00, $94, $03, $15, $01	; unknown (GOLF [rewrite disk])

	.db $97, $08, $13		; Write date(BCD): syowa 97 = reiwa 4 = 2022
	.db $00, $00 ; unknown
	.dw $FFFF	; Disk Writer serial number
	.db $00		; unknown
	.db $01		; rewrite count (rewrited disk by disk writer)
	.db $00		; actual disk side
	.db $00		; actual disk type
	.db $00		; price: 500 yen / non debug ver

; Block02: QD File number block
	.db $02			; block code
    .db $03			; file number of this disk side

; ====== KYODAKU =====
; Block03: QD File Header: PRG ROM
	.db $03			; block code
	.db $00			; sequential file number
	.db $00			; load file number
	.db "KYODAKU-";	; file number
	.dw $2800		; load address
	.dw $00E0		; file size
	.db 2			; load dest type(PRG=0, CHR=1, OTHER=2)

; Block04: KYODAKU data
	.db $04			; block code
	; dummy KYODAKU datas.
	.ds $E0			
	.org $5B
	.db "THIS GAME IS HOMEBREW AND IS NOT LICENCED."
	.org $13B

; =============== PRG =============
; Block03: QD File Header: PRG ROM
	.db $03			; block code
	.db $01			; sequential file number
	.db $01			; load file number
	.db "LM.RPG  ";	; file number
	.dw $6000		; load address
	.dw $8000		; file size
	.db 0			; load dest type(PRG=0, CHR=1, OTHER=2)

; Block04: PRG ROM Data
	.db $04			; block code
    .incbin "main_fds.nes"
	
; ============== CHR ==============
; Block05: QD File Header: CHR ROM
	.db $03			; block code
	.db $02			; sequential file number
	.db $01			; load file number
	.db "LM.CHR  ";	; file number
	.dw $0000		; load address
	.dw $2000		; file size
	.db 1			; load dest type(PRG=0, CHR=1, OTHER=2)

; Block06: CHR ROM Data
	.db $04			; block code
    .incbin "patterns.chr"

	.bank 7
	.org $FFD0
	.db "Lan Master FDS  "

	; .bank 8