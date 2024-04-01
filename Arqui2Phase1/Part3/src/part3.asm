.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_x: .res 1
player_y: .res 1
player_dir: .res 1
ctrl: .res 1
.exportzp player_x, player_y, ctrl

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.import read_controller

.proc nmi_handler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
  LDA #$00
  JSR read_controller

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

  LDA ctrl
  AND #BTN_LEFT
  BEQ check_right
  DEC player_x
check_right:
  LDA ctrl
  AND #BTN_RIGHT
  BEQ check_up
  INC player_x
check_up:
  LDA ctrl
  AND #BTN_UP
  BEQ check_down
  DEC player_y 
check_down:
  LDA ctrl
  AND #BTN_DOWN
  BEQ done
  INC player_y
done:
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

  ;tile numbers
  LDA #$02
  STA $0201
  LDA #$03
  STA $0205
  LDA #$12
  STA $0209
  LDA #$13
  STA $020d

  ;tile attributes
  ;using palette 0
  LDA #$00
  STA $0202
  STA $0206
  STA $020a
  STA $020e

  ;Store tile locations
  ;top left
  LDA player_y
  STA $0200
  LDA player_x
  STA $0203

  ;top right
  LDA player_y
  STA $0204
  LDA player_x
  CLC
  ADC #$08
  STA $0207

  ;bottom left
  LDA player_y
  CLC
  ADC #$08
  STA $0208
  LDA player_x
  STA $020b

  ;bottom right
  LDA player_y
  CLC
  ADC #$08
  STA $020c
  LDA player_x
  CLC
  ADC #$08
  STA $020f

  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
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

.segment "CHR"
.incbin "gamesprites.chr"
