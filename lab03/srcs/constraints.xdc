create_clock -period 10 -name axis_clk -waveform {0.000 5.000} [get_ports ACLK]
set_input_delay 2 [all_inputs]
set_output_delay 2 [all_outputs]
