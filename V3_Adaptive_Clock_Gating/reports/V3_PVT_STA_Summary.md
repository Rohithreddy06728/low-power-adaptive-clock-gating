# V3 Adaptive Clock-Gating Controller — Preliminary STA Report

## 1. Design Summary
- Design: Adaptive Clock-Gating Controller
- Technology library: SkyWater SKY130 HD
- Clock period constraint: 10 ns
- Analysis type: Pre-layout static timing analysis
- Netlist: synthesized_clock_gating_v3_mapped.v
- Constraints: clock_gating_v3.sdc

## 2. Functional Verification
- Testbench: tb_adaptive_clock_gating_v3.v
- Result: All five test checks passed
- Integrated clock-gating cells: 3
- Functional cell model: sky130_fd_sc_hd__dlclkp_1

## 3. Synthesis Summary
- Technology-mapped cell count: 57
- Integrated clock-gating cells: 3
- Reported mapped area: 574.3008 library area units
- Yosys structural check: 0 problems reported

Note: The area value is reported by the synthesis tool using the library's
area attributes. Do not assume a physical area unit unless verified.

## 4. Overall Timing Results

| Corner | Conditions | Worst Slack (ns) | TNS (ns) |
|---|---|---:|---:|
| TT | 25 C, 1.80 V | +8.56 | 0.00 |
| SS | 100 C, 1.40 V | +7.15 | 0.00 |
| FF | -40 C, 1.95 V | +8.74 | 0.00 |

## 5. ICG Gate Setup Checks

| Corner | ICG A Slack (ns) | ICG B Slack (ns) | ICG C Slack (ns) |
|---|---:|---:|---:|
| TT | +9.51 | +9.51 | +9.51 |
| SS | +8.48 | +8.48 | +8.48 |
| FF | +9.70 | +9.70 | +9.70 |

All nine reported ICG gate setup checks were marked MET by OpenSTA.

## 6. Interpretation
All three selected library-corner runs reported positive worst slack and
zero total negative slack under the current timing constraints. The SS
run had the lowest reported overall worst slack (+7.15 ns), and its ICG
gate setup checks had the lowest slack (+8.48 ns).

These results support preliminary timing feasibility for the analyzed
netlist and constraints. They are not complete physical-design or
silicon sign-off results.

## 7. Limitations
- Pre-layout analysis; routed parasitics are not included.
- The current design exports gated clocks; downstream generated-clock
  timing and receiving logic are not fully represented by this module-only
  analysis.
- Only the listed three library conditions were analyzed.
- No quantitative power-saving claim has been established by these STA
  results.
- Final sign-off requires appropriate constraints, clock propagation,
  physical parasitics, and the applicable approved PVT corners.

## 8. Generated Evidence
- synthesis_v3.log
- sta_tt_025C_1v80.log
- sta_ss_100C_1v40.log
- sta_ff_n40C_1v95.log
- icg_tt_025C_1v80.log
- icg_ss_100C_1v40.log
- icg_ff_n40C_1v95.log
