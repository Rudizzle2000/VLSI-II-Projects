/**
 * BSG Chip -- Toplevel module. For this design, we are simply creating a
 *             wrapper for the fo4 module which is to be implemented by the
 *             students.
 */

// Name: Rudy Garcia
// Class: EE477 (VLSI II)
// Assignment: LAB0 - Task 1 - Ring Oscillator
// Date: 01/15/24

// INPUT: Reset signal to control the state of the ring oscillator.
// OUTPUT: The output value for probe_in.
//       : The output value for probe_out.

module fo4_top
    ( input  wire reset_i
    , output wire probe_in_o
    , output wire probe_out_o
    );



    // Assignment that Determines how many x1 inverter stages there are in the main loop.
    /*reg [31:0] STAGES;
    assign STAGES = 7;

    // Assignment that Determines where in the loop I probe in.
    reg [31:0] PROBE_IN;
    assign PROBE_IN = 0;

    // Assignment that Determines where in the loop I probe out.
    reg [31:0] PROBE_OUT;
    assign PROBE_OUT = 6;*/

    // Module that connects the x1 main ring oscillator loop, with the 2-input OR gate module.
    // INPUT: Reset signal to control the state of the ring oscillator.
    // OUTPUT: The output value for probe_in.
    //       : The output value for probe_out.

    // PARAMETER: STAGES - Determines how many x1 inverter stages there are in the main loop.
    //            PROBE_IN - Determines where in the loop I probe in.
    //            PROBE_OUT - Determines where in the loop I probe out.
    fo4 
    FO4 
        ( .reset_i(reset_i)
        , .probe_in_o(probe_in_o)
        , .probe_out_o(probe_out_o)
        );

endmodule

