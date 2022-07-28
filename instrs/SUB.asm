SubValueTo8: LEA8 ebx, eax, 1
cmp ebx, eax
je SVT8Once
mov dl, [ebx]
mov cl, [esi+2]
sub dl, cl
mov [ebx], dl
SVT8Once:
movzx dx, byte[eax]
movzx cx, byte[esi+2]
sub dl, cl
mov [eax], dl
add word[_IP], 3 ;add si, 3
ret

Sub8With8: LEA8 ebx, eax, 1
mov dl, [ebx]
mov cl, [eax]
sub dl, cl
mov [ebx], dl
add word[_IP], 2 ;add si, 2
ret


Sub16With16: ;jmp $ 
LEA16 ebx, eax, 1
ReadByEA16 edx, ecx, ebx, eax
sub edx, ecx
Load16 ebx, dx
add word[_IP], 2
ret

SubValueTo16: LEA16 ebx, eax, 1
cmp eax, ebx
je SVT16Once
 ReadByEA16 edx, edx, ebx, ebx
 movzx ecx, word[esi+2]
 xchg ch, cl
 sub edx, ecx
 Load16 ebx, dx
SVT16Once:
 ReadByEA16 edx, edx, eax, eax
 movzx ecx, word[esi+2]
 xchg ch, cl
 sub edx, ecx
 Load16 eax, dx
add word[_IP], 4 ;add si, 4
ret