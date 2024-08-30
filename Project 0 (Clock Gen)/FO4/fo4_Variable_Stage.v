

// Disctription: Module that provides multiple stages of the main x1 inverter for the ring oscillator loop.
// INPUT: Input to the first x1 inverter in the main loop.
// OUTPUT: Output of the last x1 inverter in the main loop.
//       : The output value for probe_in.
//       : The output value for probe_out.

// PARAMETER: STAGES - Determines how many x1 inverter stages there are in the main loop.
//            PROBE_IN - Determines where in the loop I probe in.
//            PROBE_OUT - determines where in the loop I probe out.

module fo4_Variable_Stage #(parameter STAGES = 7, PROBE_IN = 4, PROBE_OUT = 5)
    ( input wire loop_in
    , output wire loop_out
    , output wire probe_in
    , output wire probe_out
    );

    // Array to hold the output values of each x1 inverter within the main loop
    wire [STAGES:0] x1_outs;

    // Assignment to obtain the output value for one of the x1 inverter stages
    assign probe_in = x1_outs[PROBE_IN];

    // Assignment to obtain the output value for one of the x1 inverter stages
    assign probe_out = x1_outs[PROBE_OUT];

    // NOTE: These assignments allow the loop to be fully closed
    // Assignment that stores the input of this module/main loop in the x1 inverter array
    assign x1_outs[0] = loop_in;

    // Assignment that outputs the last x1 inverter value in the array 
    assign loop_out = x1_outs[STAGES];

    // 7 Intervter stage instantiations ------------------------------------------------------------------
    
    fo4_1stage
    stage_1
    ( .inv_1_in(x1_outs[0])
    , .inv_1_out(x1_outs[1])
    );

    fo4_1stage
    stage_2
    ( .inv_1_in(x1_outs[1])
    , .inv_1_out(x1_outs[2])
    );

    fo4_1stage
    stage_3
    ( .inv_1_in(x1_outs[2])
    , .inv_1_out(x1_outs[3])
    );

    fo4_1stage
    stage_4
    ( .inv_1_in(x1_outs[3])
    , .inv_1_out(x1_outs[4])
    );

    fo4_1stage
    stage_5
    ( .inv_1_in(x1_outs[4])
    , .inv_1_out(x1_outs[5])
    );

    fo4_1stage
    stage_6
    ( .inv_1_in(x1_outs[5])
    , .inv_1_out(x1_outs[6])
    );

    fo4_1stage
    stage_7
    ( .inv_1_in(x1_outs[6])
    , .inv_1_out(x1_outs[7])
    );

endmodule