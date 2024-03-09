module clk_gen_4_1_inv_mux
    ( input wire [3:0] mux_in
    , input wire [1:0] sel
    , output wire mux_out
    );

    wire [1:0] mux_connect;

    // 2 to 1 MUX Instantiations ----------------------------------------------------------------------------------
    // -------------------------------------------------
    sky130_fd_sc_hd__mux2i_1
    mux_1_outer 
        ( .Y(mux_connect[0])
        , .A0(mux_in[0])
        , .A1(mux_in[1])
        , .S(sel[0])
        );

    // -------------------------------------------------
    sky130_fd_sc_hd__mux2i_1
    mux_2_outer
        ( .Y(mux_connect[1])
        , .A0(mux_in[2])
        , .A1(mux_in[3])
        , .S(sel[0])
        );

    // -------------------------------------------------
    sky130_fd_sc_hd__mux2i_1
    mux_3_final
        ( .Y(mux_out)
        , .A0(mux_connect[0])
        , .A1(mux_connect[1])
        , .S(sel[1])
        );

endmodule