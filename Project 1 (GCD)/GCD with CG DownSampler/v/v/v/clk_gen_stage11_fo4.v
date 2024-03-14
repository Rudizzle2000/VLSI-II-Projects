module clk_gen_stage11_fo4
    ( input wire loop_in
    , output wire loop_out
    );

    wire [23:0] inv_connect;

    assign inv_connect[0] = loop_in;
    assign loop_out = inv_connect[23];

    // Inverter Instantiations ----------------------------------------------------------------------------------
    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_23 
        ( .Y(inv_connect[23])
        , .A(inv_connect[22])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_22 
        ( .Y(inv_connect[22])
        , .A(inv_connect[21])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_21 
        ( .Y(inv_connect[21])
        , .A(inv_connect[20])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_20 
        ( .Y(inv_connect[20])
        , .A(inv_connect[19])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_19 
        ( .Y(inv_connect[19])
        , .A(inv_connect[18])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_18 
        ( .Y(inv_connect[18])
        , .A(inv_connect[17])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_17 
        ( .Y(inv_connect[17])
        , .A(inv_connect[16])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_16
        ( .Y(inv_connect[16])
        , .A(inv_connect[15])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_15 
        ( .Y(inv_connect[15])
        , .A(inv_connect[14])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_14 
        ( .Y(inv_connect[14])
        , .A(inv_connect[13])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_13 
        ( .Y(inv_connect[13])
        , .A(inv_connect[12])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_12 
        ( .Y(inv_connect[12])
        , .A(inv_connect[11])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_11 
        ( .Y(inv_connect[11])
        , .A(inv_connect[10])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_10
        ( .Y(inv_connect[10])
        , .A(inv_connect[9])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_9 
        ( .Y(inv_connect[9])
        , .A(inv_connect[8])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_8  
        ( .Y(inv_connect[8])
        , .A(inv_connect[7])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_7  
        ( .Y(inv_connect[7])
        , .A(inv_connect[6])
        );

    // -------------------------------------------------
    clk_gen_my_inverter 
    inv_6  
        ( .Y(inv_connect[6])
        , .A(inv_connect[5])
        );

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