# Traffic Light Controller Testbench (tb2.v)

## Clock & Tick Setup
- **Clock (clk)**
  - Period = *10 ns* (always #5 clk = ~clk;)
  - Frequency = *100 MHz*

- **Tick (tick)**
  - Divider counts 21 clock cycles before asserting tick.
  - Effective tick frequency:
    
    TICK_HZ = 100 MHz / 21 ≈ 4.76 MHz
    
  - This choice was made to make the simulation *faster and easier to visualize* compared to a real-time 1 Hz tick.

---

## Traffic Light Timing
The controller follows a *5 / 2 / 5 / 2 tick sequence*:

| Phase        | Duration (ticks) |
|--------------|------------------|
| NS Green     | 5 |
| NS Yellow    | 2 |
| EW Green     | 5 |
| EW Yellow    | 2 |

This cycle repeats continuously.

---

## Verification
- The testbench was run with *GTKWave* using the generated wave2.vcd.
- Observed results:
  - After reset, *NS Green* stayed active for 5 ticks.
  - Transitioned to *NS Yellow* for 2 ticks.
  - Then to *EW Green* for 5 ticks.
  - Finally *EW Yellow* for 2 ticks, completing the cycle.
- The full cycle repeated correctly → confirming the expected *5/2/5/2 durations*.

---



## Simulation Commands
```bash
iverilog -o iverilog -o traf_ligh tb2.v traffic_light.v
vvp traf_ligh
gtkwave wave2.vcd

