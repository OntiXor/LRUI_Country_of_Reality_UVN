include "LRUI.asm"

mov ar, 0xFF
mem .ds, i0, ar, ar
add i0, 1
mem crl, crl, .ds, i0

stop
