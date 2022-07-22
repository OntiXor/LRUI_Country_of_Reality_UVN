NoInstruction: inc word[_IP]
               ret


macro GetREA8 r1, r2, _add {
      movzx r1, byte[esi+_add]
      mov r2, r1
      and r2, 0x0F
      and r1, 0xF0
      shr r1, 4
      add r1, REGS
      add r2, REGS
      xchg r1, r2
}

macro GetREA16 r1, r2, _add {
      movzx r1, byte[esi+_add]
      mov r2, r1
      and r2, 0x0F
      and r1, 0xF0
      shr r1, 4
      lea r1, [r1+r1+REGS]
      lea r2, [r2+r2+REGS]
      xchg r1, r2
}

macro LoadAddr rg, num {
      mov rg, [MEM_ADDR]
      push eax
      push ebx
      movzx eax, byte[esi+num]
      and al, 0xF0
      shr al, 4
      lea eax, [eax+eax+SEGMENTS]
      movzx ebx, word[eax]
      shl ebx, 4
      add rg, ebx
      movzx eax, byte[esi+num]
      and al, 0x0F
      lea eax, [eax+eax+REGS]
      movzx ebx, word[eax]
      xchg bh, bl
      add rg, ebx
      pop ebx
      pop eax
}

MovValueToByte: GetREA8 ebx, eax, 1
                mov dl, [esi+2]
                mov [ebx], dl
                mov [eax], dl
                add word[_IP], 3 ;add si, 3
                ret

Mov8To8: GetREA8 ebx, eax, 1
         mov dl, [ebx]
         mov [eax], dl
         add word[_IP], 2 ;add si, 2
         ret

MovValueToWord: GetREA16 ebx, eax, 1
                mov cx, [esi+2]
                mov [ebx], cx
                mov [eax], cx
                add word[_IP], 4 ;add si, 4
                ret
Mov16To16: GetREA16 ebx, eax, 1
           mov cx, [ebx]
           mov [eax], cx
           add word[_IP], 2 ;add si, 2
           ret

AddValueTo8: GetREA8 ebx, eax, 1
             cmp ebx, eax
             je AVT8Once
                xor ecx, ecx
                xor edx, edx
                mov cl, [eax]
                mov dl, [esi+2]
                add cx, dx
                mov [_OAH], ch
                mov [eax], cl
             AVT8Once:
                xor ecx, ecx
                xor edx, edx
                mov cl, [ebx]
                mov dl, [esi+2]
                add cx, dx
                mov [_OAL], ch
                mov [ebx], cl
             add word[_IP], 3 ;add si, 3
             ret

Add8With8: GetREA8 ebx, eax, 1
           xchg ebx, eax
           xor edx, edx
           xor ecx, ecx
           mov cl, [ebx]
           mov dl, [eax]
           add dx, cx
           mov [_OAL], dh
           mov [ebx], dl
           add word[_IP], 2 ;add si, 2
           ret


Add16With16: GetREA16 ebx, eax, 1
             xor ecx, ecx
             xor edx, edx
             mov cx, [ebx]
             mov dx, [eax]
             xchg ch, cl
             xchg dh, dl
             add edx, ecx
             xchg dh, dl
             mov [eax], dx
             shr edx, 16
             mov [_OAL], dl
             add word[_IP], 2
             ret

AddValueTo16: GetREA16 ebx, eax, 1
              cmp eax, ebx
              je AVT16Once
                 xor ecx, ecx
                 xor edx, edx
                 mov cx, [eax]
                 xchg cl, ch
                 mov dx, [esi+2]
                 xchg dh, dl
                 add ecx, edx
                 xchg ch, cl
                 mov [eax], cx
                 shr ecx, 16
                 mov [_OAH], cl
              AVT16Once:
                 xor ecx, ecx
                 xor edx, edx
                 mov cx, [ebx]
                 xchg cl, ch
                 mov dx, [esi+2]
                 xchg dh, dl
                 add ecx, edx
                 xchg ch, cl
                 mov [ebx], cx
                 shr ecx, 16
                 mov [_OAL], cl
              add word[_IP], 4 ;add si, 4
              ret

MovRegToMem8: pushad
              LoadAddr edi, 1
              GetREA8 ebx, eax, 2
              mov dl, [ebx]
              mov dh, [eax]
              or dl, dh
              mov [edi], dl
              popad
              add word[_IP], 3
              ret

MovMem8ToReg: pushad
              LoadAddr edi, 1
              GetREA8 ebx, eax, 2
              mov dl, [edi]
              mov [ebx], dl
              mov [eax], dl
              popad
              add word[_IP], 3
              ret

MovRegToMem16: pushad
               LoadAddr edi, 1
               GetREA16 ebx, eax, 2
               mov dx, [eax]
               or dx, [ebx]
               mov [edi], dx
               popad
               add word[_IP], 3
               ret

MovMem16ToReg: pushad
               LoadAddr edi, 1
               GetREA16 ebx, eax, 2
               mov dx, [edi]
               mov [ebx], dx
               mov [eax], dx
               popad
               add word[_IP], 3
               ret

LoadSegment: GetREA16 eax, ebx, 1
             add ebx, SEGMENTS-REGS
             mov dx, [eax]
             xchg dh, dl
             mov [ebx], dx
             add word[_IP], 2
             ret

LoadFromSegment: GetREA16 eax, ebx, 1
                 add ebx, SEGMENTS-REGS
                 mov dx, [ebx]
                 xchg dh, dl
                 mov [eax], dx
                 add word[_IP], 2
                 ret


STOP: jmp $





