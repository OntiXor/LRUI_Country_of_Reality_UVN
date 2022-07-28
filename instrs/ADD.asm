AddValueTo8: ;jmp $
LEA8 ebx, eax, 1
cmp ebx, eax
je AVT8Once
 movzx dx, byte[ebx]
 movzx cx, byte[esi+2]
 add dx, cx
 mov [ebx], dl
 mov [_OAH], dh
AVT8Once:
movzx dx, byte[eax]
movzx cx, byte[esi+2]
add dx, cx
mov [eax], dl
mov [_OAL], dh
add word[_IP], 3 
ret

Add8With8: ;jmp $
LEA8 ebx, eax, 1
movzx dx, byte[ebx]
movzx cx, byte[eax]
add dx, cx
mov [ebx], dl
mov [_OAL], dh
add word[_IP], 2 
ret


Add16With16: ;jmp $ 
LEA16 ebx, eax, 1
ReadByEA16 edx, ecx, ebx, eax
add edx, ecx
Load16 ebx, dx
shr edx, 8
mov [_OA], dx
add word[_IP], 2
ret

AddValueTo16: ;jmp $
LEA16 ebx, eax, 1
cmp eax, ebx
je AVT16Once
ReadByEA16 edx, edx, ebx, ebx
movzx ecx, word[esi+2]
xchg ch, cl
add edx, ecx
Load16 ebx, dx
shr edx, 8
mov [_OAH], dh
AVT16Once:
ReadByEA16 edx, edx, eax, eax
movzx ecx, word[esi+2]
xchg ch, cl
add edx, ecx
Load16 eax, dx
shr edx, 8
mov [_OAL], dh
add word[_IP], 4 
ret