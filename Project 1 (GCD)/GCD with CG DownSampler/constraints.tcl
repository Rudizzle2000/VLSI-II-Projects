# constraints.tcl
#
# This file is where design timing constraints are defined for Genus and Innovus.
# Many constraints can be written directly into the Hammer config files. However, 
# you may manually define constraints here as well.
#

# TODO: add constraints here!

create_clock -name clk -period 4.2 [get_pins CGDS/CG/clk_o]                                                                                                                                         
set_clock_uncertainty 0.100 [get_clocks clk]                                                                                                                                                 
                                                                                                                                                                                             
# Always set the input/output delay as half periods for clock setup checks                                                                                                                   
set_input_delay  2.1 -max -clock [get_clocks clk] [all_inputs]                                                                                                                               
set_output_delay 2.1 -max -clock [get_clocks clk] [remove_from_collection [all_outputs] [get_ports clk_o]]                                                                                   
                                                                                                                                                                                             
# Always set the input/output delay as 0 for clock hold checks                                                                                                                               
set_input_delay  0.0 -min -clock [get_clocks clk] [all_inputs]                                                                                                                               
set_output_delay 0.0 -min -clock [get_clocks clk] [remove_from_collection [all_outputs] [get_ports clk_o]] 

#set_disable_timing -from B -to Y DS/CG/reset   

