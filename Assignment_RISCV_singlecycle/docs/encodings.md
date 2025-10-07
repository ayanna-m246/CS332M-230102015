# ⚙️ RISC-V Load/Store Instruction Encodings

This document defines the **binary encoding formats** for RISC-V load and store instructions used in the `rv32i_load_store` module.

---

## 1. Instruction Format Overview

| Format | Used For | Immediate Bits | Bit Field Layout |
|:--|:--|:--|:--|
| **I-Type** | Load Instructions (`LB`, `LH`, `LW`, `LBU`, `LHU`) | imm[11:0] | `imm[11:0]`(31:20) \| `rs1`(19:15) \| `funct3`(14:12) \| `rd`(11:7) \| `opcode`(6:0) |
| **S-Type** | Store Instructions (`SB`, `SH`, `SW`) | imm[11:5], imm[4:0] | `imm[11:5]`(31:25) \| `rs2`(24:20) \| `rs1`(19:15) \| `funct3`(14:12) \| `imm[4:0]`(11:7) \| `opcode`(6:0) |

---

## 2. Load Instructions (I-Type)

| Instruction | Opcode | Funct3 | Description |
|:--|:--|:--|:--|
| **LB** | `0000011` | `000` | Load **byte**, **sign-extend** to 32 bits |
| **LH** | `0000011` | `001` | Load **half-word (16 bits)**, **sign-extend** |
| **LW** | `0000011` | `010` | Load **word (32 bits)** |
| **LBU** | `0000011` | `100` | Load **byte**, **zero-extend** |
| **LHU** | `0000011` | `101` | Load **half-word**, **zero-extend** |

### Effective Address
EA = R[rs1] + sign_extend(imm[11:0])


### Register Update
R[rd] = mem(EA, width) [sign/zero-extended to 32 bits]


---

## 3. Store Instructions (S-Type)

| Instruction | Opcode | Funct3 | Description |
|:--|:--|:--|:--|
| **SB** | `0100011` | `000` | Store **byte** |
| **SH** | `0100011` | `001` | Store **half-word (16 bits)** |
| **SW** | `0100011` | `010` | Store **word (32 bits)** |

### Immediate Construction
imm[11:0] = { instr[31:25], instr[11:7] }


### Effective Address
EA = R[rs1] + sign_extend(imm[11:0])


### Memory Update
mem(EA, width) = R[rs2][width-1:0]


---

## 4. Sign and Zero Extension Rules

| Instruction | Width | Extension | Example (mem = 0xFF) → Register |
|:--|:--|:--|:--|
| **LB** | 8 bits  | Sign | 0xFF → 0xFFFFFFFF |
| **LBU** | 8 bits  | Zero | 0xFF → 0x000000FF |
| **LH** | 16 bits | Sign | 0xFFFF → 0xFFFFFFFF |
| **LHU** | 16 bits | Zero | 0xFFFF → 0x0000FFFF |
| **LW** | 32 bits | — | 0xFFFFFFFF → 0xFFFFFFFF |

---

## 5. Example Encodings

| Instruction | Assembly | Binary Fields | Hex |
|:--|:--|:--|:--|
| `LB x5, 8(x10)` | I-Type | `000000001000 01010 000 00101 0000011` | `0x00850283` |
| `LH x3, -4(x2)` | I-Type | `111111111100 00010 001 00011 0000011` | `0xFFC11183` |
| `SW x7, 12(x8)` | S-Type | `0000000 00111 01000 010 01100 0100011` | `0x00742323` |

---

## 6. Endianness and Memory Layout
All accesses follow **little-endian** order.

For `LW`:
mem[EA + 0] → bits [7:0]
mem[EA + 1] → bits [15:8]
mem[EA + 2] → bits [23:16]
mem[EA + 3] → bits [31:24]

---

## 7. References
- *RISC-V User-Level ISA Specification (RV32I Base ISA)* - *RISC-V Green Card (RV32I)* - *Cocotb-Based Verification Testbench (see testplan.md)*
