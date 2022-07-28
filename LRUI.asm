rh8 = 0x0000001000
rl8 = 0x0000010000

ARH = 0x0000010000
ARL = 0x0000020000
BRH = 0x0000030000
BRL = 0x0000040000
CRH = 0x0000050000
CRL = 0x0000060000
DRH = 0x0000070000
DRL = 0x0000080000
ERH = 0x0000090000
ERL = 0x00000A0000
FRH = 0x00000B0000
FRL = 0x00000C0000
GRH = 0x00000D0000
GRL = 0x00000E0000
OAH = 0x00000F0000
OAL = 0x0000100000

rh16 = 0x0000100000
rl16 = 0x0001000000

AR  = 0x0001000000
BR  = 0x0002000000
CR  = 0x0003000000
DR  = 0x0004000000
ER  = 0x0005000000
FR  = 0x0006000000
GR  = 0x0007000000
OA  = 0x0008000000
I0  = 0x0009000000
I1  = 0x000A000000
I2  = 0x000B000000
I3  = 0x000C000000
I4  = 0x000D000000
I5  = 0x000E000000
BE  = 0x000F000000
SK  = 0x0010000000
SA = SK

sh = 0x0010000000
sl = 0x0100000000

.ZS = 0x0100000000
.CS = 0x0200000000
.DS = 0x0300000000
.SS = 0x0400000000
.GS = 0x0500000000
.S0 = 0x0600000000
.S1 = 0x0700000000
.S2 = 0x0800000000
.S3 = 0x0900000000
.S4 = 0x0A00000000
.S5 = 0x0B00000000
.S6 = 0x0C00000000
.S7 = 0x0D00000000
.S8 = 0x0E00000000
.S9 = 0x0F00000000
.SX = 0x1000000000
;========================
arh = 0x0000010000
arl = 0x0000020000
brh = 0x0000030000
brl = 0x0000040000
crh = 0x0000050000
crl = 0x0000060000
drh = 0x0000070000
drl = 0x0000080000
erh = 0x0000090000
erl = 0x00000a0000
frh = 0x00000b0000
frl = 0x00000c0000
grh = 0x00000d0000
grl = 0x00000e0000
oah = 0x00000f0000
oal = 0x0000100000

ar  = 0x0001000000
br  = 0x0002000000
cr  = 0x0003000000
dr  = 0x0004000000
er  = 0x0005000000
fr  = 0x0006000000
gr  = 0x0007000000
oa  = 0x0008000000
i0  = 0x0009000000
i1  = 0x000a000000
i2  = 0x000b000000
i3  = 0x000c000000
i4  = 0x000d000000
i5  = 0x000e000000
be  = 0x000f000000
sk  = 0x0010000000

.zs = 0x0100000000
.cs = 0x0200000000
.ds = 0x0300000000
.ss = 0x0400000000
.gs = 0x0500000000
.s0 = 0x0600000000
.s1 = 0x0700000000
.s2 = 0x0800000000
.s3 = 0x0900000000
.s4 = 0x0a00000000
.s5 = 0x0b00000000
.s6 = 0x0c00000000
.s7 = 0x0d00000000
.s8 = 0x0e00000000
.s9 = 0x0f00000000
.sx = 0x1000000000
;=======================

macro asg rg1, rg2, data {
        if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
                db 80h
                db (rg1/ARH-1)*10h+(rg2/ARH-1)
                db data
        else if rg1 <= SA & rg1 >= AR & rg2 <= SA & rg2 >= AR
                db 82h
                db (rg1/AR-1)*10h+(rg2/AR-1)
                db data/0x0100
                db data - data/0x0100*0x0100
        end if
}
macro ASG rg1, rg2, data {
        asg rg1, rg2
}

macro mov rg1, rg2 {
        if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
                db 81h 
                db (rg1/ARH-1)*10h+(rg2/ARH-1)
        else if rg1 <= SA & rg1 >= AR & rg2 <= SA & rg2 >= AR
                db 83h
                db (rg1/AR-1)*10h+(rg2/AR-1)
        else if rg1 >= .ZS & rg1 <= .SX & rg2 >= AR & rg2 <= SA
                db 88h
                db (rg1/.ZS-1)*10h+(rg2/AR-1)
        else if rg1 >= AR & rg1 <= SA & rg2 >= .zs & rg2 <= .SX
                db 89h
                db (rg2/.ZS-1)*10h+(rg1/AR-1)
        else if rg1 <= OAL & rg1 >= ARH & rg2 < ARH
                asg rg1, rg1, rg2
        else if rg1 <= SA & rg1 >= AR & rg2 < AR
                asg rg1, rg1, rg2
        end if
}

macro MOV rg1, rg2 {
        mov rg1, rg2
}

macro plus rg1, rg2, value {
        if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
                db 20h 
                db (rg1/ARH-1)*10h+(rg2/ARH-1)
                db value
        else if rg1 <= SA & rg1 >= AR & rg2 <= SA & rg2 >= AR
                db 22h
                db (rg1/AR-1)*10h+(rg2/AR-1)
                db value/0x0100
                db value - value/0x0100*0x0100
        end if  
}
macro PLUS rg1, rg2, value {
        plus rg1, rg1, value
}

macro add rg1, rg2 {
        if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
                db 21h 
                db (rg1/ARH-1)*10h+(rg2/ARH-1)
        else if rg1 <= SA & rg1 >= AR & rg2 <= SA & rg2 >= AR
                db 23h
                db (rg1/AR-1)*10h+(rg2/AR-1)
        else if rg1 <= OAL & rg1 >= ARH & rg2 < ARH
                plus rg1, rg1, rg2
        else if rg1 <= SA & rg1 >= AR & rg2 < AR
                plus rg1, rg1, rg2
        end if
}
macro ADD rg1, rg2 {
        add rg1, rg2
}

macro minus rg1, rg2, value {
        if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
                db 30h 
                db (rg1/ARH-1)*10h+(rg2/ARH-1)
                db value
        else if rg1 <= SA & rg1 >= AR & rg2 <= SA & rg2 >= AR
                db 32h
                db (rg1/AR-1)*10h+(rg2/AR-1)
                db value/0x0100
                db value - value/0x0100*0x0100
        end if  
}
macro MINUS rg1, rg2, value {
        minus rg1, rg1, value
}

macro sub rg1, rg2 {
        if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
                db 31h 
                db (rg1/ARH-1)*10h+(rg2/ARH-1)
        else if rg1 <= SA & rg1 >= AR & rg2 <= SA & rg2 >= AR
                db 33h
                db (rg1/AR-1)*10h+(rg2/AR-1)
        else if rg1 <= OAL & rg1 >= ARH & rg2 < ARH
                minus rg1, rg1, rg2
        else if rg1 <= SA & rg1 >= AR & rg2 < AR
                minus rg1, rg1, rg2
        end if
}
macro SUB rg1, rg2 {
        sub rg1, rg2
}

macro mem rg1, rg2, rg3, rg4 {
        if rg1 <= .SX & rg1 >= .ZS & rg2 >= AR & rg2 <= SA
                if rg3 >= ARH & rg3 <= OAL & rg4 >= ARH & rg4 <= OAL
                        db 84h
                        db (rg1/.ZS-1)*10h+(rg2/AR-1)
                        db (rg3/ARH-1)*10h+(rg4/ARH-1)
                else if rg3 >= AR & rg3 <= OA & rg4 >= AR & rg4 <= OA
                        db 86h
                        db (rg1/.ZS-1)*10h+(rg2/AR-1)
                        db (rg1/AR-1)*10h+(rg2/AR-1)
                end if
        else if rg3 <= .SX & rg3 >= .ZS & rg4 >= AR & rg4 <= SA
                if rg1 >= ARH & rg1 <= OAL & rg2 >= ARH & rg2 <= OAL
                        db 85h
                        db (rg3/.ZS-1)*10h+(rg4/AR-1)
                        db (rg1/ARH-1)*10h+(rg2/ARH-1)
                else if rg1 >= AR & rg1 <= OA & rg2 >= AR & rg2 <= OA
                        db 87h
                        db (rg3/.ZS-1)*10h+(rg4/AR-1)
                        db (rg1/AR-1)*10h+(rg2/AR-1)
                end if
        end if
}  
macro MEM rg1, rg2, rg3, rg4 {
        mem rg1, rg2, rg3, rg4
}

macro ifz rg1, rg2 {
	  if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
		 db 10h
		 db (rg1/ARH-1)*10h+(rg2/ARH-1)
	  end if
}
macro IFZ rg1, rg2 {
	ifz rg1, rg2
}

macro ifeq rg1, rg2 {
	  if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
		 db 11h
		 db (rg1/ARH-1)*10h+(rg2/ARH-1)
	  end if
}
macro IFEQ rg1, rg2 {
	ifz rg1, rg2
}

macro ifg rg1, rg2 {
	  if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
		 db 12h
		 db (rg1/ARH-1)*10h+(rg2/ARH-1)
	  end if
}
macro IFG rg1, rg2 {
	ifz rg1, rg2
}

macro ifl rg1, rg2 {
	  if rg1 <= OAL & rg1 >= ARH & rg2 <= OAL & rg2 >= ARH
		 db 13h
		 db (rg1/ARH-1)*10h+(rg2/ARH-1)
	  end if
}
macro IFL rg1, rg2 {
	ifz rg1, rg2
}


macro condition_end {
	  db 0
} 
macro CONDITION_END {
	  db 0
} 
macro cend {
	  db 0
} 
macro CEND {
	  db 0
} 

macro stop {
    db 0xFF
}
macro STOP {
    stop
}



















