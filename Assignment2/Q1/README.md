# Sequence Detector 1101 (Mealy FSM, Overlap) 
- *FSM type*: Mealy  
- *Reset*: synchronous, active-high  
- **Output y**: 1-cycle pulse when the final 1 of 1101 arrives  

---



# Sequence Detector 1101 (Mealy FSM, Overlap)

## Tested stream (copy-paste)
- din(input given in testbench)=   110111011011011011011001101111101101
- y(expected)  =                   000100010010010010010000001000001001

## Detection indices
3, 7, 10, 13, 16, 19, 26, 32, 35

## Simulation Commands
```bash
iverilog -o seq_test tb.v seq_detect_mealy.v
vvp seq_test
gtkwave wave1.vcd

