# 🧪 Test Plan – RISC-V Load/Store Instruction Module

## 1. Objective
This test plan defines the verification strategy for the **RISC-V load/store instruction logic**, ensuring that:
- All supported instructions (`LB`, `LH`, `LW`, `LBU`, `LHU`, `SB`, `SH`, `SW`) are correctly decoded and executed.
- Sign and zero extension behaviors are accurate.
- Effective address calculations, memory reads/writes, and alignment rules comply with the RV32I specification.

---

## 2. Scope
The testbench verifies:
- **Instruction decode correctness** for opcode and funct3.
- **Address computation**: `EA = R[rs1] + sign_extend(imm[11:0])`
- **Memory operations**: correct byte/halfword/word access.
- **Data extension**: correct sign or zero extension based on instruction type.
- **Alignment behavior** for unaligned accesses (if supported).
- **Endianness** compliance (little-endian).
- **Edge cases**: positive/negative immediates, boundary memory addresses.

---

## 3. Test Environment
| Component | Description |
|:--|:--|
| **Language** | SystemVerilog (DUT) |
| **Testbench Framework** | Cocotb (Python) |
| **Simulator** | Icarus Verilog / Verilator |
| **Memory Model** | Python-based memory array with byte-level access |
| **Reference Model** | Software emulation in Cocotb comparing expected vs. DUT outputs |
| **DUT Interface** | Inputs: `instr`, `rs1`, `rs2`, `mem_rdata`; Outputs: `mem_addr`, `mem_wdata`, `rd_data` |

---

## 4. Test Categories

### 4.1 Functional Tests
| Test Name | Description | Expected Result |
|:--|:--|:--|
| **TC1 – LB (sign-extend)** | Load signed byte (positive and negative values) | Proper 32-bit sign extension |
| **TC2 – LBU (zero-extend)** | Load unsigned byte | Zero-extended 32-bit result |
| **TC3 – LH (sign-extend)** | Load signed halfword | Proper sign extension from bit[15] |
| **TC4 – LHU (zero-extend)** | Load unsigned halfword | Zero extension to 32 bits |
| **TC5 – LW** | Load 32-bit word | Exact match of memory data |
| **TC6 – SB** | Store lower byte of rs2 | Only byte at EA modified |
| **TC7 – SH** | Store lower 16 bits of rs2 | Two bytes modified |
| **TC8 – SW** | Store full 32-bit value | Four consecutive bytes modified |

---

### 4.2 Immediate & Address Calculation Tests
| Test Name | Description | Expected Result |
|:--|:--|:--|
| **TC9 – Positive Immediate** | EA = rs1 + imm (imm > 0) | Correct address addition |
| **TC10 – Negative Immediate** | EA = rs1 + sign_extend(imm) | Proper two’s complement addition |
| **TC11 – Unaligned Access** | EA not multiple of width | Detect misalignment or access anyway depending on implementation |
| **TC12 – Boundary Access** | EA near top of memory | No overflow beyond defined memory range |

---

### 4.3 Randomized and Stress Tests
| Test Name | Description | Expected Result |
|:--|:--|:--|
| **TC13 – Randomized Loads** | Random rs1, imm, memory contents | Consistency with software model |
| **TC14 – Randomized Stores** | Random rs2 data and EA | Correct memory updates |
| **TC15 – Full Memory Sweep** | Sequential load/store through full memory range | Stable behavior, no corruption |
| **TC16 – Parallel Access Test** | Multiple instructions queued | Proper one-cycle-per-instruction behavior |

---

## 5. Verification Metrics
| Metric | Goal |
|:--|:--|
| **Functional Coverage** | 100% of load/store instruction types tested |
| **Opcode/Funct3 Coverage** | All 5 funct3 load and 3 funct3 store combinations hit |
| **Sign/Zero Extension Coverage** | All extension types verified with both +ve and -ve data |
| **Addressing Coverage** | Positive, zero, and negative immediates covered |
| **Data Pattern Coverage** | 0x00, 0xFF, alternating bits, random patterns |

---

## 6. Pass/Fail Criteria
A test passes if:
- `rd` (for load) or memory content (for store) matches the reference model output.
- Sign/zero extension matches expected 32-bit representation.
- No address or data corruption occurs outside target region.
- No simulation assertion failures are triggered.

---

## 7. Regression Strategy
- **Smoke tests**: run for basic functionality (`LB`, `SB`, `LW`, `SW`).
- **Full regression**: includes randomized tests and edge cases.
- **Continuous Integration (CI)**: automated Cocotb regression triggered via GitHub Actions or Makefile.

---

## 8. References
- *RISC-V User-Level ISA Specification, Volume I (RV32I Base Instruction Set)*  
- *Cocotb Documentation v1.8+*  
- *RISC-V Green Card (RV32I)*  
