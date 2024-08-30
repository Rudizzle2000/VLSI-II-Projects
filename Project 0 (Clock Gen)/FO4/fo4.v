

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

    // Wire to connect the last output of the x1 inverter in the ring oscillator to the 
    // B input pin of the 2-input OR gate.
    wire x1_inverter_stages_output_to_Bpin_orgate;

    // Wire to connect the output of the 2-input OR gate (X) to the input of the first x1 
    // inverter within the ring oscillator.
    wire orgate_output_X_to_input_x1_inverter_stages;
    
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

