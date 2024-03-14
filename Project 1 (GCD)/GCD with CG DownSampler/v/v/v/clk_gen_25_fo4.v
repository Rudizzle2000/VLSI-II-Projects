
// Name: Rudy Garcia
// Class: EE477 (VLSI II)
// Assignment: LAB0 - Task 2 - Tunable Clock Generator
// Date: 01/18/24

// Disctription: Module that provides a ring oscillator with a "fan-out-of-4 inverter" (FO4) of 25 fo4. One FO4 has 
//               a delay of 313ps. Thus, this module has a delay of 25 x 313ps = 7,825ps or 7.825ns delay.
// INPUT: Input to the x1 inverter for a single stage in the main loop.
// OUTPUT: Output of the x1 inverter for a signle stage in the main loop.

module clk_gen_25_fo4
    ( input wire loop_in
    , output wire loop_out
    );

    // Array to hold the output values of each x1 inverter within the main loop
    wire [25:0] x1_outs;

    // NOTE: These assignments allow the loop to be fully closed
    // Assignment that stores the input of this module/main loop in the x1 inverter array
    assign x1_outs[0] = loop_in;

    // Assignment that outputs the last x1 inverter value in the array 
    assign loop_out = x1_outs[25];

    // X1 Iverter instantiations ----------------------------------------------------------------------------------

    // Disctription: Module that provides a single stage of the main x1 inverter for the ring oscillator as well as
    //               the dangling inverters x1 and x4.
    // INPUT: Input to the x1 inverter for a single stage in the main loop.
    // OUTPUT: Output of the x1 inverter for a signle stage in the main loop.
    // -------------------------------------------------
    fo4_1stage
    stage_1
    ( .inv_1_in(x1_outs[0])
    , .inv_1_out(x1_outs[1])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_2
    ( .inv_1_in(x1_outs[1])
    , .inv_1_out(x1_outs[2])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_3
    ( .inv_1_in(x1_outs[2])
    , .inv_1_out(x1_outs[3])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_4
    ( .inv_1_in(x1_outs[3])
    , .inv_1_out(x1_outs[4])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_5
    ( .inv_1_in(x1_outs[4])
    , .inv_1_out(x1_outs[5])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_6
    ( .inv_1_in(x1_outs[5])
    , .inv_1_out(x1_outs[6])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_7
    ( .inv_1_in(x1_outs[6])
    , .inv_1_out(x1_outs[7])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_8
    ( .inv_1_in(x1_outs[7])
    , .inv_1_out(x1_outs[8])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_9
    ( .inv_1_in(x1_outs[8])
    , .inv_1_out(x1_outs[9])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_10
    ( .inv_1_in(x1_outs[9])
    , .inv_1_out(x1_outs[10])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_11
    ( .inv_1_in(x1_outs[10])
    , .inv_1_out(x1_outs[11])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_12
    ( .inv_1_in(x1_outs[11])
    , .inv_1_out(x1_outs[12])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_13
    ( .inv_1_in(x1_outs[12])
    , .inv_1_out(x1_outs[13])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_14
    ( .inv_1_in(x1_outs[13])
    , .inv_1_out(x1_outs[14])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_15
    ( .inv_1_in(x1_outs[14])
    , .inv_1_out(x1_outs[15])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_16
    ( .inv_1_in(x1_outs[15])
    , .inv_1_out(x1_outs[16])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_17
    ( .inv_1_in(x1_outs[16])
    , .inv_1_out(x1_outs[17])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_18
    ( .inv_1_in(x1_outs[17])
    , .inv_1_out(x1_outs[18])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_19
    ( .inv_1_in(x1_outs[18])
    , .inv_1_out(x1_outs[19])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_20
    ( .inv_1_in(x1_outs[19])
    , .inv_1_out(x1_outs[20])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_21
    ( .inv_1_in(x1_outs[20])
    , .inv_1_out(x1_outs[21])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_22
    ( .inv_1_in(x1_outs[21])
    , .inv_1_out(x1_outs[22])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_23
    ( .inv_1_in(x1_outs[22])
    , .inv_1_out(x1_outs[23])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_24
    ( .inv_1_in(x1_outs[23])
    , .inv_1_out(x1_outs[24])
    );

    // -------------------------------------------------
    fo4_1stage
    stage_25
    ( .inv_1_in(x1_outs[24])
    , .inv_1_out(x1_outs[25])
    );

endmodule 