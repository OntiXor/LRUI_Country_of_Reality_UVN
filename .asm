include "LRUI.asm"

;mov arl, 0
;mov arl, 0xF
asg arl, arh, 0x76
add arh, 1
ifg arl, arh
mov ar, 0xFFFF
mov dr, ar
cend
mov cr, dr

stop
