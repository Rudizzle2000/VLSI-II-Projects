

// INPUT: Reset signal to control the state of the ring oscillator.
// OUTPUT: The output value for probe_in.
//       : The output value for probe_out.

module fo4_top
    ( input  wire reset_i
    , output wire probe_in_o
    , output wire probe_out_o
    );

    fo4 
    FO4 
        ( .reset_i(reset_i)
        , .probe_in_o(probe_in_o)
        , .probe_out_o(probe_out_o)
        );

endmodule

