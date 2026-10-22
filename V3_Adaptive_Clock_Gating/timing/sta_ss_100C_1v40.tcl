read_liberty /home/vsduser/Desktop/BabySoC_Simulation/src/skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__ss_100C_1v40.lib
read_verilog synthesized_clock_gating_v3_mapped.v
link_design adaptive_clock_gating_v3
read_sdc clock_gating_v3.sdc

puts "\n===== CORNER: ss_100C_1v40 ====="
report_checks -path_delay max
report_worst_slack -max
report_tns
