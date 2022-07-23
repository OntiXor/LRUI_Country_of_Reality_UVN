NoInstruction: inc word[_IP]
               ret

macro LEA16 rg1, rg2, num {
      movzx rg2, byte[esi+num]
      mov rg1, rg2
      and rg2, 0x0F
      shr rg1, 4
      lea rg1, [rg1+rg1+REGS]
      lea rg2, [rg2+rg2+REGS]
}
macro LEA8 rg1, rg2, num {
      movzx rg2, byte[esi+num]
      mov rg1, rg2
      and rg2, 0x0F
      shr rg1, 4
      lea rg1, [rg1+REGS]
      lea rg2, [rg2+REGS]
}
macro ReadByEA16 rg1, rg2, rs1, rs2 {
      movzx rg1, word[rs1]
      movzx rg2, word[rs2]
      push ebp
      mov ebp, rg1
      rol bp, 8
      mov rg1, ebp
      mov ebp, rg2
      rol bp, 8
      mov rg2, ebp
      pop ebp
}

macro Load16 addres, source {
	push ebp
	mov bp, source
	rol bp, 8
	mov [addres], bp
	pop ebp
}

macro GetAddr rg, num {
	  push eax
	  push ebx
	  push ecx
	  push edx
	  movzx eax, byte[esi+num]
	  mov ebx, eax
	  and al, 0x0F
	  shr bl, 4
	  lea ebx, [ebx+ebx+SEGMENTS]
	  lea eax, [eax+eax+REGS]
	  mov rg, dword[ebx]
	  shl rg, 4
	  movzx ecx, word[eax]
	  xchg ch, cl
	  add rg, ecx
	  add rg, [MEM_ADDR]
	  pop edx
	  pop ecx
	  pop ebx
	  pop eax
}

;==================================

MovValueToByte: LEA8 ebx, eax, 1
				mov dl, [esi+2]
				mov [ebx], dl
				mov [eax], dl
                add word[_IP], 3 ;add si, 3
                ret

Mov8To8: ;jmp $
		 LEA8 ebx, eax, 1
         mov dl, [eax]
         mov [ebx], dl
         add word[_IP], 2 ;add si, 2
         ret

MovValueToWord: LEA16 ebx, eax, 1
                mov cx, [esi+2]
                mov [eax], cx
                mov [ebx], cx
                add word[_IP], 4 ;add si, 4
                ret
Mov16To16: ;jmp $
		   LEA16 ebx, eax, 1
           mov cx, [eax]
           mov [ebx], cx
           add word[_IP], 2 ;add si, 2
           ret

AddValueTo8: LEA8 ebx, eax, 1
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
             add word[_IP], 3 ;add si, 3
             ret

Add8With8: LEA8 ebx, eax, 1
		   movzx dx, byte[ebx]
		   movzx cx, byte[eax]
		   add dx, cx
		   mov [ebx], dl
		   mov [_OAL], dh
           add word[_IP], 2 ;add si, 2
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

AddValueTo16: LEA16 ebx, eax, 1
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
              add word[_IP], 4 ;add si, 4
              ret

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


STOP: jmp $





