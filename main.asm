format PE Console
use32
include "win32a.inc"
entry MAIN

section '.data' readable writable
include 'Table.asm'

CmdLinePtr: dd 0
HFile: dd 0
LPOFSTRUCT: dd 0
StdFileName: db '.bin', 0
Title: db 'Intel IWRP processor', 0
ErrTxt: db 'Error! 0x00000000', 0
CmdHandle: dd 0
HEX: db '0123456789ABCDEF', 0
FSize: dd 0

RegP1: dd 0
RegP2: dd 0

IShtr = RegP1
JShtr = RegP2

STR1:  db 'AR: 0x0000',0
STR2:  db 'BR: 0x0000',0
STR3:  db 'CR: 0x0000',0
STR4:  db 'DR: 0x0000',0
STR5:  db 'ER: 0x0000',0
STR6:  db 'FR: 0x0000',0
STR7:  db 'GR: 0x0000',0
STR8:  db 'OA: 0x0000',0
STR9:  db 'I0: 0x0000',0
STR10: db 'I1: 0x0000',0
STR11: db 'I2: 0x0000',0
STR12: db 'I3: 0x0000',0
STR13: db 'I4: 0x0000',0
STR14: db 'I5: 0x0000',0
STR15: db 'BE: 0x0000',0
STR16: db 'SK: 0x0000',0

STR17: db 'ZS: 0x----',0
STR18: db 'CS: 0x0000',0
STR19: db 'DS: 0x0000',0
STR20: db 'SS: 0x0000',0
STR21: db 'GS: 0x0000',0
STR22: db 'S0: 0x0000',0
STR23: db 'S1: 0x0000',0
STR24: db 'S2: 0x0000',0
STR25: db 'S3: 0x0000',0
STR26: db 'S4: 0x0000',0
STR27: db 'S5: 0x0000',0
STR28: db 'S6: 0x0000',0
STR29: db 'S7: 0x0000',0
STR30: db 'S8: 0x0000',0
STR31: db 'S9: 0x0000',0
STR32: db 'SX: 0x0000',0

REGS:
_AR: _ARH: db 0 ;0, 0
     _ARL: db 0 ;0, 1
_BR: _BRH: db 0 ;1, 2
     _BRl: db 0 ;1, 3
_CR: _CRH: db 0 ;2, 4
     _CRL: db 0 ;2, 5
_DR: _DRH: db 0 ;3, 6
     _DRL: db 0 ;3, 7
_ER: _ERH: db 0 ;4, 8
     _ERL: db 0 ;4, 9
_FR: _FRH: db 0 ;5, A
     _FRL: db 0 ;5, B
_GR: _GRH: db 0 ;6, E
     _GRL: db 0 ;6, D
_OA: _OAH: db 0 ;7, E
     _OAL: db 0 ;7, F
_Index1:   dw 0 ;8
_Index2:   dw 0 ;9
_Index3:   dw 0 ;A
_Index4:   dw 0 ;B
_Index5:   dw 0 ;C
_Index6:   dw 0 ;D
_BE:       dw 0 ;E
_SK:       dw 0xFFFF ;F

SEGMENTS:
_ZS:  dw 0x0000 ;0
_CS:  dw 0x1000 ;1
_DS:  dw 0x2000 ;2
_SS:  dw 0x3000 ;3
_GS:  dw 0xA000 ;4
_S1:  dw 0x4000 ;5
_S2:  dw 0x5000 ;6
_S3:  dw 0x6000 ;7
_S4:  dw 0x7000 ;8
_S5:  dw 0x8000 ;9
_S6:  dw 0x9000 ;A
_S7:  dw 0xB000 ;B
_S8:  dw 0xC000 ;C
_S9:  dw 0xD000 ;D
_SA:  dw 0xE000 ;E
_SB:  dw 0xF000 ;F

_IP: dw 0

MEM_ADDR: dd 0

SYSTIME1: dq 0, 0
SYSTIME2: dq 0, 0

section '.code' readable writable executable
MAIN:

invoke SetConsoleTitle, Title
invoke GetStdHandle, STD_OUTPUT_HANDLE
mov [CmdHandle], eax
invoke VirtualAlloc, 0, 0xFF, MEM_COMMIT, PAGE_READWRITE
mov [LPOFSTRUCT], eax
invoke OpenFile, StdFileName, dword[LPOFSTRUCT], OF_READ
mov [HFile], eax
invoke GetLastError
test eax, eax
jnz Error
invoke GetFileSize, dword[HFile], 0
mov [FSize], eax
invoke VirtualAlloc, 0, 0x000FFFFF, MEM_COMMIT, PAGE_READWRITE
mov [MEM_ADDR], eax

xor eax, eax
mov ax, [_CS]
shl eax, 4
add eax, [MEM_ADDR]
invoke ReadFile, dword[HFile], eax, dword[FSize], 0, 0

;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

push ds
pop es
invoke GetSystemTime, SYSTIME1
MAIN_WHILE: invoke GetSystemTime, SYSTIME2
            mov edi, SYSTIME1
            mov esi, SYSTIME2
            mov ecx, 4
            repe cmpsd
            je MAIN_WHILE
            invoke GetSystemTime, SYSTIME1


            movzx esi, word[_CS]
            shl esi, 4
            add esi, [MEM_ADDR]
            add esi, [_IP]
            movzx eax, byte[esi]
            add eax, eax
            add eax, eax
            mov eax, [Table+eax]
            call eax
            call Shtorka
            mov word[_ZS], 0
jmp MAIN_WHILE

;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
invoke ExitProcess, 0


Error: invoke GetLastError
       mov ebx, eax
       mov ecx, 8
       LoopInError:
       mov eax, ebx
       and eax, 0x0000000F
       shr ebx, 4
       mov al, [HEX+eax]
       mov edx, ecx
       add edx, ErrTxt+8
       mov [edx], al
       loop LoopInError
       invoke WriteConsole, dword[CmdHandle], ErrTxt, 17, 0, 0
jmp $

include "Instructions.asm"


;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
Shtorka: pushad
         mov dword[JShtr], REGS
         xor esi, esi
         mov edi, STR1
         xor ebp, ebp
         mov dword[IShtr], STR1+5
         ShtorkaCommon: invoke SetConsoleCursorPosition,\
                               dword[CmdHandle],\
                               ebp
                        mov ebx, [JShtr]
                        mov bx, [ebx]
                        cmp esi, 17
                        jnl ShtrXchBX_Skip
                            xchg bh, bl
                        ShtrXchBX_Skip:
                        mov ecx, 4
                        xor eax, eax
                        Loop1: mov ax, bx
                               and ax, 0x000F
                               shr bx, 4
                               mov al, [HEX+eax]
                               mov edx, ecx
                               add edx, [IShtr]
                               mov [edx], al
                       loop Loop1
                       mov word[STR17+6], '--'
                       mov word[STR17+8], '--'
                       invoke WriteConsole, dword[CmdHandle], edi, 10, 0, 0
                       add edi, 11
                       add ebp, 0x00010000
                       add dword[IShtr], 11
                       add dword[JShtr], 2
         inc esi
         cmp esi, 32
         jl ShtorkaCommon

popad
ret

section '.idata' import data readable
library kernel,'KERNEL32.DLL'
import kernel,\
       ExitProcess,'ExitProcess',\
       GetCommandLineA, 'GetCommandLineA',\
       OpenFile, 'OpenFile',\
       VirtualAlloc, 'VirtualAlloc',\
       GetStdHandle, 'GetStdHandle',\
       SetConsoleTitle, 'SetConsoleTitleA',\
       WriteConsole, 'WriteConsoleA',\
       GetLastError, 'GetLastError',\
       GetFileSize, 'GetFileSize',\
       ReadFile, 'ReadFile',\
       SetConsoleCursorPosition, 'SetConsoleCursorPosition',\
       GetSystemTime, 'GetSystemTime'