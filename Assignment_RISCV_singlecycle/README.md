# RISC-V Single-Cycle Processor (RV32I Subset)

This project implements a **single-cycle RISC-V processor** (RV32I subset) in **SystemVerilog**, following the design from *Digital Design and Computer Architecture* (David & Sarah Harris).  
It executes a small RISC-V program loaded from memory and verifies correctness via a testbench.

---

## 🧩 Features

- Implements the **RV32I base instruction set** subset:
  - Arithmetic: `add`, `sub`, `and`, `or`, `slt`
  - Immediate ALU: `addi`, `andi`, `ori`, `slti`
  - Memory: `lw`, `sw`
  - Branch: `beq`
  - Jump: `jal`
- Extended ALU operations (custom RVX10 group):
  - `ANDN`, `ORN`, `XNORN`, `MIN`, `MAX`, `MINU`, `MAXU`, `ROL`, `ROR`, `ABS`
- Little-endian memory organization
- 32 × 32-bit register file (`x0` hardwired to 0)
- Separate **instruction** and **data memories**
- Self-checking **testbench** that reports success/failure

---

## 🧠 Architecture Overview

The design consists of:

- `controller.sv` — Main and ALU control logic
- `datapath.sv` — Registers, ALU, and data routing
- `imem.sv` / `dmem.sv` — Instruction and data memory
- `riscvsingle.sv` — Top-level integration
- `testbench.sv` — Test and verification harness

Each instruction executes in one clock cycle, with no pipelining or hazard handling.

---

## ⚙️ Simulation Setup

### Prerequisites
- **Icarus Verilog** or **ModelSim** / **Vivado Simulator**
- A test program file `riscvtest.txt` in hexadecimal format, loaded into instruction memory via `$readmemh`.

### Run Simulation (Icarus Verilog)
```bash
iverilog -o riscv.out riscvsingle.sv
vvp riscv.out
