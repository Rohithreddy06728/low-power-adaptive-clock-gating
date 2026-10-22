read_liberty /home/vsduser/Desktop/BabySoC_Simulation/src/skywater-pdk-libs-sky130_fd_sc_hd/timing/sky130_fd_sc_hd__ss_100C_1v40.lib
read_verilog synthesized_clock_gating_v3_mapped.v
link_design adaptive_clock_gating_v3
read_sdc clock_gating_v3.sdc

puts "\n===== ss_100C_1v40: ICG A ====="
report_checks -to [get_pins u_icg_A/GATE] -path_delay max

puts "\n===== ss_100C_1v40: ICG B ====="
report_checks -to [get_pins u_icg_B/GATE] -path_delay max

puts "\n===== ss_100C_1v40: ICG C ====="
report_checks -to [get_pins u_icg_C/GATE] -path_delay max
