.include "constants.inc"
.include "header.inc"

; I don't think this is whats causing the error
.segment "HEADER"

.segment "CODE"
.proc irq_handler
  RTI
.endproc 

; nmi_handlet sets the scrolling position to display the first nametable. We do this to prevent displaying the incorrect nametable even if scrolling has not been implemented.
.proc nmi_handler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
	LDA #$00
	STA $2005
	STA $2005
  RTI
.endproc

.import reset_handler

.export main
.proc main
  LDX $2002
  LDX #$3f
  STX $2006
  LDX #$00
  STX $2006
  LDA #$29
  STA $2007
  LDA #%00011110
  STA $2001

  ; Initialize a palette (taken from famicom party code)
  LDX PPUSTATUS
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR

load_palettes:
  LDA palettes, x
  STA PPUDATA
  INX
  CPX #$20
  BNE load_palettes

  ; write sprite data
  LDX #$00
load_sprites:
  LDA sprites,X
  STA $0200,X
  INX
  CPX #$10
  BNE load_sprites

load_background:
	LDA $2002
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006
	LDX #$00
	LDY #$00

; background_loop:
	; LDA background, x
	; STA $2007
	; ADC d, 4, 0
	; INX
	; INY
	; BNE background_loop
	; BEQ y, d, Else
	; ADC d, 0, 0
	; JMP background_loop
	; Else:

  ; left top half of moon
  	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$39
	STA PPUADDR
	LDX #$29
	STX PPUDATA

  ; right top half of moon
  	LDA PPUSTATUS
	LDA #$21
	STA PPUADDR
	LDA #$3a
	STA PPUADDR
	LDX #$2a
	STX PPUDATA

  ; left bottom half of moon
  	LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$59
	STA PPUADDR
	LDX #$2b
	STX PPUDATA

  ; right bottom half of moon
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$5a
	STA PPUADDR
	LDX #$2c
	STX PPUDATA

  ; platform 1
  	; LDA PPUSTATUS
	; LDA #$24
	; STA PPUADDR
	; LDA #$36e
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

  ; platform 2
  	; LDA PPUSTATUS
	; LDA #$25
	; STA PPUADDR
	; LDA #$36f
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

  ; platform 3
  	; LDA PPUSTATUS
	; LDA #$26
	; STA PPUADDR
	; LDA #$370
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

; platform 4
  	; LDA PPUSTATUS
	; LDA #$27
	; STA PPUADDR
	; LDA #$371
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

  ; platform 5
  	; LDA PPUSTATUS
	; LDA #$28
	; STA PPUADDR
	; LDA #$372
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

  ; platform 6
  	; LDA PPUSTATUS
	; LDA #$29
	; STA PPUADDR
	; LDA #$373
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

  ; platform 7
  	; LDA PPUSTATUS
	; LDA #$2a
	; STA PPUADDR
	; LDA #$374
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

  ; platform 8
  	; LDA PPUSTATUS
	; LDA #$2b
	; STA PPUADDR
	; LDA #$375
	; STA PPUADDR
	; LDX #$31
	; STX PPUDATA

  ; skyscraperA 1
  	; LDA PPUSTATUS
	; LDA #$2c
	; STA PPUADDR
	; LDA #$301
	; STA PPUADDR
	; LDX #$2d
	; STX PPUDATA

; skyscraperA 2
 	; LDA PPUSTATUS
	; LDA #$2d
	; STA PPUADDR
	; LDA #$321
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperA 3
  	; LDA PPUSTATUS
	; LDA #$2e
	; STA PPUADDR
	; LDA #$341
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperA 4
  	; LDA PPUSTATUS
	; LDA #$2f
	; STA PPUADDR
	; LDA #$361
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperA 5
  	; LDA PPUSTATUS
	; LDA #$30
	; STA PPUADDR
	; LDA #$381
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperA 6
  	; LDA PPUSTATUS
	; LDA #$31
	; STA PPUADDR
	; LDA #$3a1
	; STA PPUADDR
	; LDX #$2e
	; STX PPUDATA

; skyscraperB 1
  	; LDA PPUSTATUS
	; LDA #$32
	; STA PPUADDR
	; LDA #$30a
	; STA PPUADDR
	; LDX #$2d
	; STX PPUDATA

  ; skyscraperB 2
  	; LDA PPUSTATUS
	; LDA #$33
	; STA PPUADDR
	; LDA #$32a
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperB 3
  	; LDA PPUSTATUS
	; LDA #$34
	; STA PPUADDR
	; LDA #$34a
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperB 4
  	; LDA PPUSTATUS
	; LDA #$35
	; STA PPUADDR
	; LDA #$36a
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperB 5
  	; LDA PPUSTATUS
	; LDA #$36
	; STA PPUADDR
	; LDA #$38a
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperB 6
  	; LDA PPUSTATUS
	; LDA #$37
	; STA PPUADDR
	; LDA #$3aa
	; STA PPUADDR
	; LDX #$2e
	; STX PPUDATA

  ; skyscraperC 1
  	; LDA PPUSTATUS
	; LDA #$38
	; STA PPUADDR
	; LDA #$31e
	; STA PPUADDR
	; LDX #$2d
	; STX PPUDATA

  ; skyscraperC 2
  	; LDA PPUSTATUS
	; LDA #$39
	; STA PPUADDR
	; LDA #$33e
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperC 3
  	; LDA PPUSTATUS
	; LDA #$3a
	; STA PPUADDR
	; LDA #$35e
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperC 4
  	; LDA PPUSTATUS
	; LDA #$3b
	; STA PPUADDR
	; LDA #$37e
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperC 5
  	; LDA PPUSTATUS
	; LDA #$3c
	; STA PPUADDR
	; LDA #$39e
	; STA PPUADDR
	; LDX #$2f
	; STX PPUDATA

  ; skyscraperC 6
  	; LDA PPUSTATUS
	; LDA #$3d
	; STA PPUADDR
	; LDA #$3be
	; STA PPUADDR
	; LDX #$2e
	; STX PPUDATA

  ; largerstar 1
  	LDA PPUSTATUS
	LDA #$3e
	STA PPUADDR
	LDA #$23
	STA PPUADDR
	LDX #$3f
	STX PPUDATA

  ; largerstar 2
  	LDA PPUSTATUS
	LDA #$3f
	STA PPUADDR
	LDA #$2d
	STA PPUADDR
	LDX #$3f
	STX PPUDATA

  ; largerstar 3
  	LDA PPUSTATUS
	LDA #$40
	STA PPUADDR
	LDA #$c4
	STA PPUADDR
	LDX #$3f
	STX PPUDATA

  ; largerstar 4
  	; LDA PPUSTATUS
	; LDA #$41
	; STA PPUADDR
	; LDA #$184
	; STA PPUADDR
	; LDX #$3f
	; STX PPUDATA

  ; largerstar 5
  	; LDA PPUSTATUS
	; LDA #$42
	; STA PPUADDR
	; LDA #$1cd
	; STA PPUADDR
	; LDX #$3f
	; STX PPUDATA

  ; largerstar 6
  	LDA PPUSTATUS
	LDA #$43
	STA PPUADDR
	LDA #$fa
	STA PPUADDR
	LDX #$3f
	STX PPUDATA

  ; largerstar 7
  	LDA PPUSTATUS
	LDA #$44
	STA PPUADDR
	LDA #$52
	STA PPUADDR
	LDX #$3f
	STX PPUDATA

; largerstar 8
  	LDA PPUSTATUS
	LDA #$45
	STA PPUADDR
	LDA #$3f
	STA PPUADDR
	LDX #$3f
	STX PPUDATA

; whitestar 1
  	LDA PPUSTATUS
	LDA #$46
	STA PPUADDR
	LDA #$21
	STA PPUADDR
	LDX #$3c
	STX PPUDATA

  ; whitestar 2
  	LDA PPUSTATUS
	LDA #$47
	STA PPUADDR
	LDA #$6b
	STA PPUADDR
	LDX #$3c
	STX PPUDATA

; whitestar 3
 	LDA PPUSTATUS
	LDA #$48
	STA PPUADDR
	LDA #$56
	STA PPUADDR
	LDX #$3c
	STX PPUDATA

  ; whitestar 4
  	; LDA PPUSTATUS
	; LDA #$49
	; STA PPUADDR
	; LDA #$1f3
	; STA PPUADDR
	; LDX #$3c
	; STX PPUDATA

  ; whitestar 5
  	; LDA PPUSTATUS
	; LDA #$4a
	; STA PPUADDR
	; LDA #$188
	; STA PPUADDR
	; LDX #$3c
	; STX PPUDATA

  ; pinkstar 1
  	LDA PPUSTATUS
	LDA #$4b
	STA PPUADDR
	LDA #$d6
	STA PPUADDR
	LDX #$30
	STX PPUDATA

  ; pinkstar 2
  	; LDA PPUSTATUS
	; LDA #$4c
	; STA PPUADDR
	; LDA #$1f8
	; STA PPUADDR
	; LDX #$30
	; STX PPUDATA

  ; pinkstar 3
  	; LDA PPUSTATUS
	; LDA #$4d
	; STA PPUADDR
	; LDA #$21e
	; STA PPUADDR
	; LDX #$30
	; STX PPUDATA

  ; pinkstar 4
  	; LDA PPUSTATUS
	; LDA #$4e
	; STA PPUADDR
	; LDA #$147
	; STA PPUADDR
	; LDX #$30
	; STX PPUDATA

  ; pinkstar 5
  	; LDA PPUSTATUS
	; LDA #$4f
	; STA PPUADDR
	; LDA #$319
	; STA PPUADDR
	; LDX #$30
	; STX PPUDATA

  ; orangestar 1
  	LDA PPUSTATUS
	LDA #$50
	STA PPUADDR
	LDA #$a8
	STA PPUADDR
	LDX #$3c
	STX PPUDATA

  ; orangestar 2
  	LDA PPUSTATUS
	LDA #$51
	STA PPUADDR
	LDA #$ba
	STA PPUADDR
	LDX #$3c
	STX PPUDATA

  ; orangestar 3
  	; LDA PPUSTATUS
	; LDA #$52
	; STA PPUADDR
	; LDA #$1bc
	; STA PPUADDR
	; LDX #$3c
	; STX PPUDATA

  ; orangestar 4
  	; LDA PPUSTATUS
	; LDA #$53
	; STA PPUADDR
	; LDA #$15d
	; STA PPUADDR
	; LDX #$3c
	; STX PPUDATA

  ; orangestar 5
  	; LDA PPUSTATUS
	; LDA #$54
	; STA PPUADDR
	; LDA #$1bd
	; STA PPUADDR
	; LDX #$3c
	; STX PPUDATA

  ; attribute table for background
	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$c2
	STA PPUADDR
	; Establishing the palette each section uses if issues with colors they definetly are happening here
	LDA #%01000100
	STA PPUDATA

background:
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$3c,$00,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3f,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$29,$2a,$00,$3c,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$3f,$00,$00,$00,$3c,$00,$00,$2b,$2c,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$3d,$00,$00,$00,$00,$3c,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$96,$96,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$96,$96,$00,$3c,$00,$00
	.byte $00,$00,$3c,$00,$00,$00,$00,$00,$3c,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$3f,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$30,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$3d,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$3c,$00,$00,$00,$00,$00,$3d,$00,$3f,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$3d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$30,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3f,$00,$00,$3c,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $3c,$00,$00,$00,$00,$3c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$3c,$00,$00,$3f,$00,$00,$00,$3c,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$3c,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$00,$00,$3f,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3d,$00
	.byte $00,$00,$00,$00,$3c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$3c,$00,$00,$00,$00,$30,$00,$00,$00,$00,$00,$a4,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3d,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$00,$00,$00,$30,$00
	.byte $00,$3d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3f,$00,$a4,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$00,$00,$00,$00,$00,$88
	.byte $00,$3c,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a4,$00
	.byte $00,$00,$00,$00,$3d,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $88,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a4,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$3c,$00,$00,$00,$3c,$00,$30,$00,$00
	.byte $88,$88,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$a4,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$30,$30
	.byte $00,$88,$88,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$3c,$a4,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$30
	.byte $30,$88,$88,$88,$30,$00,$00,$00,$00,$3c,$00,$00,$00,$00,$a4,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$88,$88,$00,$00,$30,$00,$00,$00,$00,$00,$00,$00,$a4,$00
	.byte $00,$2d,$00,$00,$00,$00,$00,$00,$00,$00,$2d,$00,$00,$00,$00,$00
	.byte $00,$00,$88,$88,$88,$00,$00,$00,$00,$30,$00,$00,$00,$00,$2d,$00
	.byte $00,$2f,$00,$00,$00,$00,$00,$00,$00,$00,$2f,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$30,$00,$00,$00,$00,$00,$00,$00,$00,$2f,$00
	.byte $00,$2f,$00,$00,$00,$00,$00,$00,$00,$00,$2f,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$88,$00,$00,$30,$00,$00,$00,$00,$00,$2f,$00
	.byte $00,$2f,$00,$00,$00,$00,$00,$00,$00,$00,$2f,$00,$00,$00,$31,$31
	.byte $31,$31,$31,$31,$31,$31,$00,$00,$00,$00,$00,$00,$00,$74,$2f,$00
	.byte $00,$2f,$00,$00,$00,$00,$00,$00,$00,$00,$2f,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$2f,$00
	.byte $00,$2e,$00,$00,$00,$00,$00,$00,$00,$00,$2e,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$2e,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$40,$04,$00
	.byte $00,$40,$00,$00,$00,$00,$04,$10,$00,$00,$00,$00,$00,$00,$10,$01
	.byte $00,$00,$00,$00,$00,$00,$00,$04,$00,$00,$00,$00,$00,$10,$00,$00
	.byte $00,$00,$44,$00,$00,$01,$11,$00,$00,$00,$04,$00,$00,$00,$00,$00


vblankwait:       ; wait for another vblank before continuing
  BIT PPUSTATUS
  BPL vblankwait

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK


forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"

palettes:
.byte $0f, $00, $31, $30
.byte $0f, $01, $14, $37
.byte $0f, $06, $16, $26
.byte $0f, $09, $19, $29

.byte $0f, $2d, $10, $15
.byte $0f, $19, $09, $29
.byte $0f, $19, $09, $29
.byte $0f, $19, $09, $29

sprites:
.byte $70, $05, $00, $80
.byte $70, $06, $00, $88
.byte $78, $07, $00, $80
.byte $78, $08, $00, $88

.segment "CHARS"
.incbin "fourside.chr"
