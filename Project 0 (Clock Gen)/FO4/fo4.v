//  FO4 Module -- Students should implement the FO4 circuit that they see in
//  the Module 0 handout. Note that we already have a 2-input OR gate
//  instantiated in this design. This both serves as an example of how a gate
//  is instantiated as well as implements a reset which allows us to put the
//  ring oscillator into a known state for digital simulations.
//
//  First, you must figure out what logic gates are available to us in the
//  standard cell library. The best place to figure this out is the liberty
//  file which can be found at:
//
//      <SKY130_ROOT>/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
//
//  Open this file above to see the gates available in this cell library. This
//  will be helpful to figure out the names of the gates as well as the name of
//  the pins for the gates. Using this information you can instantiate the
//  cells you need for the circuit.
//
//  NOTE: This file is 100K lines, be sure to use the search function of your
//  text editor. Search for "cell " to find the each gate available in this
//  cell library. Under each cell definition, search for "pin " to find the
//  pins of the gate (you can ignore pg_pins, we do not need to work with
//  supply nets within this verilog file). Inside the pin definition will be
//  the "direction " to determine if it is an input or output of the gate.
//  Output pins will also have a "function " which is the boolean logic
//  expression for the gate.
//

// Name: Rudy Garcia
// Class: EE477 (VLSI II)
// Assignment: LAB0 - Task 1 - Ring Oscillator
// Date: 01/15/24

// Disctription: Module that connects the x1 main ring oscillator loop, with the 2-input OR gate module.
// INPUT: Reset signal to control the state of the ring oscillator.
// OUTPUT: The output value for probe_in.
//       : The output value for probe_out.

// PARAMETER: STAGES - Determines how many x1 inverter stages there are in the main loop.
//            PROBE_IN - Determines where in the loop I probe in.
//            PROBE_OUT - determines where in the loop I probe out.

module fo4
    ( input  wire reset_i       // reset input
    , output wire probe_in_o    // first output probe
    , output wire probe_out_o   // second output probe
    );

    // TODO: Implement the FO4 ring below! Make sure that:
    //    1. The ring ends at the B pin of the reset OR gate below.
    //    2. The ring begins with the X pin of the reset OR gate below.
    //    3. Connect the probe_in_o pin to the input of the inverter you want
    //       to measure the propgation delay through. (NOTE: you should choose
    //       an inverter several stages away from the reset gate, so the fo4
    //       will not be influenced by it.)
    //    4. Connect the probe_out_o pin to the output of the inverter you want
    //       to measure the propgation delay through.


    // Wire to connect the last output of the x1 inverter in the ring oscillator to the 
    // B input pin of the 2-input OR gate.
    wire x1_inverter_stages_output_to_Bpin_orgate;

    // Wire to connect the output of the 2-input OR gate (X) to the input of the first x1 
    // inverter within the ring oscillator.
    wire orgate_output_X_to_input_x1_inverter_stages;

    // Reset Gate (DO NOT REMOVE OR RENAME)
    
    // Instagtiates a 2-input OR gate to control the state of the ring oscillator.
    // INPUT: A - reset pin
    //      : B - Takes the output of the last x1 inverter in the ring oscillator.
    // OUTPUT: X - Provides the input to the first x1 inverter in the ring oscillator.
    sky130_fd_sc_hd__or2_1
    reset
        ( .A(reset_i)
        , .B(x1_inverter_stages_output_to_Bpin_orgate)
        , .X(orgate_output_X_to_input_x1_inverter_stages)
        );

    // Module that provides multiple stages of the main x1 inverter for the ring oscillator loop.
    // INPUT: Input to the first x1 inverter in the main loop.
    // OUTPUT: Output of the last x1 inverter in the main loop.
    //       : The output value for probe_in.
    //       : The output value for probe_out.

    // PARAMETER: STAGES - Determines how many x1 inverter stages there are in the main loop.
    //            PROBE_IN - Determines where in the loop I probe in.
    //            PROBE_OUT - determines where in the loop I probe out.    
    fo4_Variable_Stage 
    #(7, 4, 5) fo4_var
        ( .loop_in(orgate_output_X_to_input_x1_inverter_stages)
        , .loop_out(x1_inverter_stages_output_to_Bpin_orgate)
        , .probe_in(probe_in_o)
        , .probe_out(probe_out_o)
        );

endmodule

