NoInstruction: inc word[_IP]
               ret

include 'instrs\\MACRO.asm'

;==================================

include 'instrs\\MOV.asm'
include 'instrs\\ADD.asm'
include 'instrs\\SUB.asm'                          
include 'instrs\\MEM.asm'
include 'instrs\\IF.asm'
                                                           
STOP: jmp $





