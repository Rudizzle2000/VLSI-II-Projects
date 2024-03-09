module clk_gen_16_1_inv_mux
    ( input wire [15:0] mux_in 
    , input wire [3:0] sel  
    , output wire mux_out 
    );

    wire [3:0] mux_connect;

    // 4 to 1 MUX Instantiations ----------------------------------------------------------------------------------

    // -------------------------------------------------
    clk_gen_4_1_inv_mux
    mux_1_outer
        ( .mux_in(mux_in[3:0])
        , .sel(sel[1:0])
        , .mux_out(mux_connect[0])
        );

    // -------------------------------------------------
    clk_gen_4_1_inv_mux
    mux_2_outer
        ( .mux_in(mux_in[7:4])
        , .sel(sel[1:0])
        , .mux_out(mux_connect[1])
        );

    // -------------------------------------------------
    clk_gen_4_1_inv_mux
    mux_3_outer
        ( .mux_in(mux_in[11:8])
        , .sel(sel[1:0])
        , .mux_out(mux_connect[2])
        );

    // -------------------------------------------------
    clk_gen_4_1_inv_mux
    mux_4_outer
        ( .mux_in(mux_in[15:12])
        , .sel(sel[1:0])
        , .mux_out(mux_connect[3])
        );

    // -------------------------------------------------
    clk_gen_4_1_inv_mux
    mux_5_final
        ( .mux_in(mux_connect)
        , .sel(sel[3:2])
        , .mux_out(mux_out)
        );

endmodule