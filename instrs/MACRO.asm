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
      push ebp
      movzx ebp, word[rs1]
      rol bp, 8
      mov rg1, ebp
      movzx ebp, word[rs2]
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