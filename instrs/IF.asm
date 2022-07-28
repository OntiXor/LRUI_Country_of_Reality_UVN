ScipNext: add [_IP], dx
ScipNextWhile:
movzx esi, word[_CS]
shl esi, 4
add esi, [MEM_ADDR]
add esi, [_IP]
movzx edx, byte[esi]
add edx, SizeTable
movzx edx, byte[edx]
add [_IP], dx
add esi, edx
mov cl, [esi]
test cl, cl
jz ScipNextReturn
jmp ScipNextWhile
ScipNextReturn: ret

;==========================================

ConditionZ8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
test bl, al
jnz ScipNext
add [_IP], dx
ret
 
;==========================================

ConditionE8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
cmp bl, al
jne ScipNext
add [_IP], dx
ret
 
;==========================================
 
ConditionG8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
cmp bl, al
jng ScipNext
add [_IP], dx
ret

;==========================================

ConditionL8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
cmp bl, al
jnl ScipNext
add [_IP], dx
ret

;=========================================

ConditionNZ8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
test bl, al
jz ScipNext
add [_IP], dx
ret
 
;==========================================

ConditionNE8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
cmp bl, al
je ScipNext
add [_IP], dx
ret
 
;==========================================
 
ConditionNG8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
cmp bl, al
jg ScipNext
add [_IP], dx
ret

;==========================================

ConditionNL8: ;jmp $
LEA8 ebx, eax, 1
movzx ebx, byte[ebx]
movzx eax, byte[eax]
mov dx, 2
cmp bl, al
jl ScipNext
add [_IP], dx
ret

;==========================================

;==========================================

ConditionZ16: ;jmp $
LEA16 ebx, eax, 1
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
test bx, ax
jnz ScipNext
add [_IP], dx
ret
 
;==========================================

ConditionE16: ;jmp $
LEA16 ebx, eax, 1
nop
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
cmp bx, ax
jne ScipNext
add [_IP], dx
ret
 
;==========================================
 
ConditionG16: ;jmp $
LEA16 ebx, eax, 1
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
cmp bx, ax
jng ScipNext
add [_IP], dx
ret

;==========================================

ConditionL16: ;jmp $
LEA16 ebx, eax, 1
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
cmp bx, ax
jnl ScipNext
add [_IP], dx
ret

;=========================================

ConditionNZ16: ;jmp $
LEA16 ebx, eax, 1
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
test bx, ax
jz ScipNext
add [_IP], dx
ret
 
;==========================================

ConditionNE16: ;jmp $
LEA16 ebx, eax, 1
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
cmp bx, ax
je ScipNext
add [_IP], dx
ret
 
;==========================================
 
ConditionNG16: ;jmp $
LEA16 ebx, eax, 1
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
cmp bx, ax
jg ScipNext
add [_IP], dx
ret

;==========================================

ConditionNL16: ;jmp $
LEA16 ebx, eax, 1
ReadByEA16 ebx, eax, ebx, eax
mov dx, 2
cmp bx, ax
jl ScipNext
add [_IP], dx
ret

;==========================================

StopIf: add word[_IP], 1
        ret