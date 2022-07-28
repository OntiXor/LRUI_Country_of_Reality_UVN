MovValueToByte: ;jmp $
LEA8 ebx, eax, 1
mov dl, [esi+2]
mov [ebx], dl
mov [eax], dl
add word[_IP], 3 
ret

Mov8To8: ;jmp $
LEA8 ebx, eax, 1
mov dl, [eax]
mov [ebx], dl
add word[_IP], 2 
ret

MovValueToWord: ;jmp $
LEA16 ebx, eax, 1
mov cx, [esi+2]
mov [eax], cx
mov [ebx], cx
add word[_IP], 4 
ret

Mov16To16: ;jmp $
LEA16 ebx, eax, 1
mov cx, [eax]
mov [ebx], cx
add word[_IP], 2 
ret

LoadSegment: ;jmp $
LEA16 ebx, eax, 1
add ebx, SEGMENTS-REGS
mov dx, [eax]
xchg dh, dl
mov [ebx], dx
add word[_IP], 2
ret

LoadFromSegment: ;jmp $
LEA16 ebx, eax, 1
add ebx, SEGMENTS-REGS
mov dx, [ebx]
xchg dh, dl
mov [eax], dx
add word[_IP], 2
ret