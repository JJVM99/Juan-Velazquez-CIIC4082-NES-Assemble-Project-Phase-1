.include "constants.inc"
.include "header.inc"

.segment "CODE"
.proc irq_handler
  RTI
.endproc

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
  ;write palettes
  LDX PPUSTATUS
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR
load_palettes:
  LDA palettes,X
  STA PPUDATA
  INX
  CPX #$20 ;8 palettes, 32 colors
  BNE load_palettes

  ;write all the sprites
  LDX #$00
load_sprites:
  LDA sprites,X
  STA $0200,X
  INX
  CPX #$80
  BNE load_sprites

  ;write nametables
	;top-left hi
    LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$8a
	STA PPUADDR
	LDX #$21
	STX PPUDATA
	
	;top-right hi
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$8b
	STA PPUADDR
	LDX #$22
	STX PPUDATA

	;bottom-left hi
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$aa
	STA PPUADDR
	LDX #$31
	STX PPUDATA

	;bottom-right hi
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$ab
	STA PPUADDR
	LDX #$32
	STX PPUDATA

	;Top-Left Circle Wall
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$8d
	STA PPUADDR
	LDX #$27
	STX PPUDATA

	;Top-Right Circle Wall
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$8e
	STA PPUADDR
	LDX #$28
	STX PPUDATA

	;Bottom-Left Circle Wall
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$ad
	STA PPUADDR
	LDX #$37
	STX PPUDATA

	;Bottom-Right Circle Wall
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$ae
	STA PPUADDR
	LDX #$38
	STX PPUDATA

	;Top-Left Vertical Road
  	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$92
	STA PPUADDR
	LDX #$03
	STX PPUDATA

	;Top-Right Vertical Road
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$93
	STA PPUADDR
	LDX #$04
	STX PPUDATA

	;Bottom-Left Vertical Road
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$b2
	STA PPUADDR
	LDX #$13
	STX PPUDATA

	;Bottom-Right Vertical Road 
	LDA PPUSTATUS
	LDA #$22 
	STA PPUADDR
	LDA #$b3
	STA PPUADDR
	LDX #$14
	STX PPUDATA

	;Top-Left Big Tree
    LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$96
	STA PPUADDR
	LDX #$07
	STX PPUDATA

	;Top-Right Big Tree
    LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$97
	STA PPUADDR
	LDX #$08
	STX PPUDATA

	;Bottom-Left Big Tree
    LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$b6
	STA PPUADDR
	LDX #$17
	STX PPUDATA

	;Bottom-Right Big Tree
    LDA PPUSTATUS
	LDA #$22
	STA PPUADDR
	LDA #$b7
	STA PPUADDR
	LDX #$18
	STX PPUDATA


	;Top-left no
  	LDA PPUSTATUS
	LDA #$23 
	STA PPUADDR
	LDA #$0a
	STA PPUADDR
	LDX #$01
	STX PPUDATA

	;Top-right no
  	LDA PPUSTATUS
	LDA #$23 
	STA PPUADDR
	LDA #$0b
	STA PPUADDR
	LDX #$02
	STX PPUDATA

	;Bottom-left no
  	LDA PPUSTATUS
	LDA #$23 
	STA PPUADDR
	LDA #$2a
	STA PPUADDR
	LDX #$11
	STX PPUDATA

	;Bottom-right no
  	LDA PPUSTATUS
	LDA #$23 
	STA PPUADDR
	LDA #$2b
	STA PPUADDR
	LDX #$12
	STX PPUDATA

	;Top-Left Second wall
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$0d
	STA PPUADDR
	LDX #$23
	STX PPUDATA

	;Top-Right Second wall
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$0e
	STA PPUADDR
	LDX #$24
	STX PPUDATA

	;Bottom-Left Second wall
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$2d
	STA PPUADDR
	LDX #$33
	STX PPUDATA

	;Bottom-Right Second wall
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$2e
	STA PPUADDR
	LDX #$34
	STX PPUDATA


	;Top-Left Horizontal Road
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$12
	STA PPUADDR
	LDX #$05
	STX PPUDATA

	;Top-Right Horizontal Road
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$13
	STA PPUADDR
	LDX #$06
	STX PPUDATA

	;Bottom-Left Horizontal Road
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$32
	STA PPUADDR
	LDX #$15
	STX PPUDATA

	;Bottom-Right Horizontal Road
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$33
	STA PPUADDR
	LDX #$16
	STX PPUDATA

	;Top-Left Small Tree
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$16
	STA PPUADDR
	LDX #$25
	STX PPUDATA

	;Top-Right Small Tree
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$17
	STA PPUADDR
	LDX #$26
	STX PPUDATA

	;Bottom-Left Small Tree
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$36
	STA PPUADDR
	LDX #$35
	STX PPUDATA

	;Bottom-Right Small Tree
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$37
	STA PPUADDR
	LDX #$36
	STX PPUDATA

  ; finally, attribute table
	;Hi
	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$ea
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

	;Circle Wall
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$eb
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

	;Vertical Road
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$ec
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

	;Big Tree
	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$ed
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

	;No
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$f2
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

	;Second Wall
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$f3
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

	;Horizontal Road
  	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$f4
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

	;Small Tree
	LDA PPUSTATUS
	LDA #$23
	STA PPUADDR
	LDA #$f5
	STA PPUADDR
	LDA #%00001111
	STA PPUDATA

vblankwait:
  BIT PPUSTATUS
  BPL vblankwait
  LDA #%10010000
  STA PPUCTRL
  LDA #%00011110
  STA PPUMASK

forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"
palettes:
.byte $0f, $24, $25, $11
.byte $0f, $30, $21, $31
.byte $0f, $37, $16, $26
.byte $0f, $2b, $1c, $36

.byte $0f, $11, $24, $31
.byte $0f, $12, $22, $32
.byte $0f, $13, $23, $33
.byte $0f, $2b, $1c, $36

sprites:
.byte $40, $03, $00, $58
.byte $48, $12, $00, $50
.byte $48, $13, $00, $58
.byte $50, $22, $00, $50
.byte $50, $23, $00, $58
.byte $58, $32, $00, $50
.byte $58, $33, $00, $58
.byte $60, $04, $00, $50
.byte $60, $05, $00, $58
.byte $68, $14, $00, $50
.byte $68, $15, $00, $58
.byte $70, $24, $00, $50
.byte $70, $25, $00, $58
.byte $78, $34, $00, $50
.byte $78, $35, $00, $58
.byte $40, $06, $00, $70
.byte $40, $07, $00, $78
.byte $48, $16, $00, $70
.byte $48, $17, $00, $78
.byte $50, $26, $00, $70
.byte $50, $27, $00, $78
.byte $58, $36, $00, $70
.byte $58, $37, $00, $78
.byte $60, $08, $00, $70
.byte $60, $09, $00, $78
.byte $68, $18, $00, $70
.byte $68, $19, $00, $78
.byte $70, $28, $00, $70
.byte $70, $29, $00, $78
.byte $78, $38, $00, $70
.byte $78, $39, $00, $78


.segment "CHR"
.incbin "gamesprites.chr"
