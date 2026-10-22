create_clock -name clk -period 10.0 [get_ports clk]

set_input_delay 1.0 -clock clk [get_ports {reset req_A req_B req_C wake}]
set_input_transition 0.1 [get_ports {reset req_A req_B req_C wake}]

set_output_delay 1.0 -clock clk [get_ports {idle_A idle_B idle_C}]
set_load 0.005 [get_ports {idle_A idle_B idle_C}]
