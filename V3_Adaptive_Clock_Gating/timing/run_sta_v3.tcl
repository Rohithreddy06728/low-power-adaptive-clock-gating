read_liberty /home/vsduser/Desktop/BabySoC_Simulation/src/skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__tt_025C_1v80.lib

read_verilog synthesized_clock_gating_v3_mapped.v
link_design adaptive_clock_gating_v3
read_sdc clock_gating_v3.sdc

puts "\n===== V3 DATA-PATH TIMING ====="
report_checks -path_delay max

puts "\n===== V3 WORST SLACK ====="
report_worst_slack -max

puts "\n===== V3 TOTAL NEGATIVE SLACK ====="
report_tns
