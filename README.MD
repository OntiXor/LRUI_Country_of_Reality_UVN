## Compiler

This project uses the FASM compiler.

LURI code should be written in `.asm` file and then FASM compiles it to `.bin` file.

## Files

| File name | Purpose |
|--|--|
| `main.asm` | The main file, which includes `table.asm` and `instructions.asm` files. |
| `table.asm` | Assigning addresses to instruction handlers |
| `instructions.asm` | Defining instruction handlers |
| `LRUI.asm` | Defining macros for the `.asm` code file |
| `.asm` | File for LRUI code |
