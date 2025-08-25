# Vending Machine Controller (Mealy FSM)

##  Overview 
The machine accepts coins of *5* and *10*, represented by a 2-bit input:

- coin = 2'b01 → 5  
- coin = 2'b10 → 10  
- coin = 2'b00 → no coin  
- coin = 2'b11 → ignore  
 The FSM determines when to *dispense* the product and if to return *5 change*.

---

## Why Mealy?
The design is implemented as a *Mealy machine* instead of a Moore machine because:

- In a Mealy FSM, *outputs depend on both the state and the current input*, allowing faster response.  
- This is ideal for vending machines since the product can be dispensed *immediately when the last coin is inserted*, without waiting for an extra clock cycle.  
- A Moore FSM would require waiting until the next state transition before dispensing, adding unnecessary delay.  

Thus, Mealy FSM provides *efficient, real-time response* in coin detection and product dispensing.

---

##  State Encoding
- S0 → 0 inserted  
- S1 → 5 inserted  
- S2 → 10 inserted  
- S3 → 15 inserted  

---

## State Transitions
- From *S0*:  
  - +5 → S1  
  - +10 → S2  

- From *S1*:  
  - +5 → S2  
  - +10 → S3  

- From *S2*:  
  - +5 → S3  
  - +10 → Dispense immediately, reset to S0  

- From *S3*:  
  - +5 → Dispense immediately, reset to S0  
  - +10 → Dispense + return ₹5 change, reset to S0  

---

##  Output Logic
- *Dispense*:
  - When total ≥ 20 (achieved either by exact 20 or by overpayment).  
- *Change (chg5)*:
  - When an extra ₹10 is inserted at S3 (i.e., 25 total).  

---

## Simulation Commands
```bash
iverilog -o  iverilog -o vending vending_mealy.v tb3.v
vvp vending
gtkwave wave3.vcd

