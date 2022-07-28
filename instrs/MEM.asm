MovRegToMem8: pushad
GetAddr edi, 1
LEA8 ebx, eax, 2
movzx eax, byte[eax]
movzx ebx, byte[ebx]
or bl, al
mov [edi], bl
popad
add word[_IP], 3
ret

MovMem8ToReg: pushad
GetAddr edi, 1
LEA8 ebx, eax, 2
mov dl, [edi]
mov [eax], dl
mov [ebx], dl
popad
add word[_IP], 3
ret

MovRegToMem16: pushad
GetAddr edi, 1
LEA16 ebx, eax, 2
ReadByEA16 ebx, eax, ebx, eax
or ax, bx
xchg ah, al
mov [edi], ax
popad
add word[_IP], 3
ret

MovMem16ToReg: pushad
GetAddr edi, 1
LEA16 ebx, eax, 2
mov dx, [edi]
mov [edi], dx
popad
add word[_IP], 3
ret