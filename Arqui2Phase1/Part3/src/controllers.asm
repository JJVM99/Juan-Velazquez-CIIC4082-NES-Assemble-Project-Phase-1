.include "constants.inc"

.segment "ZEROPAGE"
.importzp ctrl

.segment "CODE"
.export read_controller
.proc read_controller
  PHA
  TXA
  PHA
  PHP

  LDA #$01
  STA CONTROLLER1
  LDA #$00
  STA CONTROLLER1

  LDA #%00000001
  STA ctrl

get_buttons:
  LDA CONTROLLER1
  LSR A          
  ROL ctrl
  BCC get_buttons
  
  PLP
  PLA
  TAX
  PLA
  RTS
.endproc
