.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_x: .res 1
player_y: .res 1
player_xr: .res 1
player_yr: .res 1
player_xl: .res 1
player_yl: .res 1
player_xb: .res 1
player_yb: .res 1
player_dir: .res 1
.exportzp player_x, player_y 
.exportzp player_xr, player_yr 
.exportzp player_xl, player_yl
.exportzp player_xb, player_yb

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
  
  JSR update_player
  JSR draw_player
  
  
  STA $2005
  STA $2005
  RTI
.endproc

.import reset_handler

.export main
.proc main
  LDX PPUSTATUS
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR
load_palettes:
  LDA palettes,X
  STA PPUDATA
  INX
  CPX #$20
  BNE load_palettes

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

.proc update_player
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

LDA player_y
LDA player_yb
LDA player_xl
LDA player_xr
INC player_y
DEC player_yb
INC player_xr
DEC player_xl


  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
.endproc

.proc draw_player
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA
 
  ;Looking forward
  LDA #$02
  STA $0201
  LDA #$03
  STA $0205
  LDA #$12
  STA $0209
  LDA #$13
  STA $020d

  ;Looking right
  LDA #$04
  STA $0211
  LDA #$05
  STA $0215
  LDA #$14
  STA $0219
  LDA #$15
  STA $021d

  ;Looking left
  LDA #$06
  STA $0221
  LDA #$07
  STA $0225
  LDA #$16
  STA $0229
  LDA #$17
  STA $022d

  ;Looking back
  LDA #$08
  STA $0231
  LDA #$09
  STA $0235
  LDA #$18
  STA $0239
  LDA #$19
  STA $023d

  ;sprite attributes
  ;load palette 0
  LDA #$00

  ;Looking Forward
  STA $0202
  STA $0206
  STA $020a
  STA $020e

  ;Looking Right
  STA $0212
  STA $0216
  STA $021a
  STA $021e

  ;Looking Left
  STA $0222
  STA $0226
  STA $022a
  STA $022e

  ;Looking Back
  STA $0232
  STA $0236
  STA $023a
  STA $023e

  ;Sprite tile locations
  ;looking forward
  ;top left tile:
  LDA player_y
  STA $0200
  LDA player_x
  STA $0203

  ;top right tile:
  LDA player_y
  STA $0204
  LDA player_x
  CLC
  ADC #$08
  STA $0207

  ;bottom left tile:
  LDA player_y
  CLC
  ADC #$08
  STA $0208
  LDA player_x
  STA $020b

  ;bottom right tile:
  LDA player_y
  CLC
  ADC #$08
  STA $020c
  LDA player_x
  CLC
  ADC #$08
  STA $020f

  ;looking right
  ;top left tile:
  LDA player_yr
  CLC
  ADC #$50
  STA $0210
  LDA player_xr
  CLC
  ADC#$50
  STA $0213

  ;top right tile:
  LDA player_yr
  CLC
  ADC #$50
  STA $0214
  LDA player_xr
  CLC
  ADC #$58
  STA $0217

  ;bottom left tile:
  LDA player_yr
  CLC
  ADC #$58
  STA $0218
  LDA player_xr
  CLC
  ADC #$50
  STA $021b

  ;bottom right tile:
  LDA player_yr
  CLC
  ADC #$58
  STA $021c
  LDA player_xr
  CLC
  ADC #$58
  STA $021f

  ;looking left
  ;top left tile:
  LDA player_yl
  CLC
  ADC #$80
  STA $0220
  LDA player_xl
  CLC
  ADC #$80
  STA $0223

  ;top right tile:
  LDA player_yl
  CLC
  ADC #$80
  STA $0224
  LDA player_xl
  CLC
  ADC #$88
  STA $0227

  ;bottom left tile:
  LDA player_yl
  CLC
  ADC #$88
  STA $0228
  LDA player_xl
  CLC
  ADC #$80
  STA $022b

  ;bottom right tile:
  LDA player_yl
  CLC
  ADC #$88
  STA $022c
  LDA player_xl
  CLC
  ADC #$88
  STA $022f

  ;looking back
  ;top left tile:
  LDA player_yb
  CLC
  ADC #$10
  STA $0230
  LDA player_xb
  CLC
  ADC #$10
  STA $0233

  ;top right tile:
  LDA player_yb
  CLC
  ADC #$10
  STA $0234
  LDA player_xb
  CLC
  ADC #$18
  STA $0237

  ;bottom left tile:
  LDA player_yb
  CLC
  ADC #$18
  STA $0238
  LDA player_xb
  CLC
  ADC #$10
  STA $023b

  ;bottom right tile:
  LDA player_yb
  CLC
  ADC #$18
  STA $023c
  LDA player_xb
  CLC
  ADC #$18
  STA $023f

  ; JSR running_animation
  
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
.endproc
;   LDX #$00
; .proc running_animation
;   PHP
;   PHA
;   TXA
;   PHA
;   TYA
;   PHA

;   CPX #$00
;   BNE stand

;   ;Looking forward
;   LDA #$22
;   STA $0201
;   LDA #$23
;   STA $0205
;   LDA #$32
;   STA $0209
;   LDA #$33
;   STA $020d

;   ;Looking right
;   LDA #$24
;   STA $0211
;   LDA #$25
;   STA $0215
;   LDA #$34
;   STA $0219
;   LDA #$35
;   STA $021d

;   ;Looking left
;   LDA #$26
;   STA $0221
;   LDA #$27
;   STA $0225
;   LDA #$36
;   STA $0229
;   LDA #$37
;   STA $022d

;   ;Looking back
;   LDA #$28
;   STA $0231
;   LDA #$29
;   STA $0235
;   LDA #$38
;   STA $0239
;   LDA #$39
;   STA $023d

;   INX
;   JSR exit_subroutine

; stand:
;   ;Looking forward
;   LDA #$02
;   STA $0201
;   LDA #$03
;   STA $0205
;   LDA #$12
;   STA $0209
;   LDA #$13
;   STA $020d

;   ;Looking right
;   LDA #$04
;   STA $0211
;   LDA #$05
;   STA $0215
;   LDA #$14
;   STA $0219
;   LDA #$15
;   STA $021d

;   ;Looking left
;   LDA #$06
;   STA $0221
;   LDA #$07
;   STA $0225
;   LDA #$16
;   STA $0229
;   LDA #$17
;   STA $022d

;   ;Looking back
;   LDA #$08
;   STA $0231
;   LDA #$09
;   STA $0235
;   LDA #$18
;   STA $0239
;   LDA #$19
;   STA $023d

;   DEX
  
; exit_subroutine:
;   PLA
;   TAY
;   PLA
;   TAX
;   PLA
;   PLP
;   RTS
; .endproc


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

.segment "CHR"
.incbin "gamesprites.chr"
