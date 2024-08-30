
module clk_gen
    ( input  wire       reset_i
    , input  wire [3:0] select_i
    , output wire       clk_o
    );



    wire reset_to_reset_bal_n;

    wire [15:0] inv_stages_to_mux;

    wire buff_to_inv_stages;

    wire nor_to_buff;

    wire buff_1_to_buff_2;

    // 2 to 1 NOR gate Instantiation
    // -------------------------------------------------
    sky130_fd_sc_hd__nor2_1
    reset
        (.A(reset_i)
        ,.B(clk_o)
        ,.Y(reset_to_reset_bal_n)
        );

    // 2 to 1 NOR gate Instantiation
    // -------------------------------------------------
    sky130_fd_sc_hd__nor2_1
    reset_bal
        (.A(reset_i)
        ,.B(reset_to_reset_bal_n)
        ,.Y(nor_to_buff)
        );

    // Clk buffer 1
    // -------------------------------------------------
    sky130_fd_sc_hd__clkbuf_1
    clk_buff_1
        ( .X(buff_1_to_buff_2)
        , .A(nor_to_buff)
        );

    // Clk buffer 4
    // -------------------------------------------------
    sky130_fd_sc_hd__clkbuf_4
    clk_buff_2
        ( .X(buff_to_inv_stages)
        , .A(buff_1_to_buff_2)
        );
    
    // Module to connect the output of the buffers to the input of all
    // 16 ring oscillator chains.
    // -------------------------------------------------
    clk_gen_all_stages
    all_stages
        ( .nor_to_inverter_stages(buff_to_inv_stages)
        , .inverter_stages_to_mux(inv_stages_to_mux)
        );    
    
    // 16 to 1 MUX
    // -------------------------------------------------
    clk_gen_16_1_inv_mux
    mux
        ( .mux_in(inv_stages_to_mux)
        , .sel(select_i)
        , .mux_out(clk_o)
        );

endmodule

