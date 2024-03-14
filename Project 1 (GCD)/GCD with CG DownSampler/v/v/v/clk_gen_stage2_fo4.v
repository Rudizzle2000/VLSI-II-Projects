module clk_gen_stage2_fo4
    ( input wire loop_in
    , output wire loop_out
    );

    wire [5:0] inv_connect;

    assign inv_connect[0] = loop_in;
    assign loop_out = inv_connect[5];

    // Inverter Instantiations ----------------------------------------------------------------------------------
    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_5 
        ( .Y(inv_connect[5])
        , .A(inv_connect[4])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_4 
        ( .Y(inv_connect[4])
        , .A(inv_connect[3])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_3  
        ( .Y(inv_connect[3])
        , .A(inv_connect[2])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_2 
        ( .Y(inv_connect[2])
        , .A(inv_connect[1])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_1  
        ( .Y(inv_connect[1])
        , .A(inv_connect[0])
        );


endmodule