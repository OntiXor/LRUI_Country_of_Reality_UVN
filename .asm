include "LRUI.asm"

mov dr, 5
mov cr, 6
ifneq dr, cr
mov i0, dr
mov i1, dr
mov i2, dr
cend

stop
