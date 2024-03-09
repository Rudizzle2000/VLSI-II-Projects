module clk_gen_my_inverter 
    ( output wire Y 
    , input wire A
    );

    // Inverter Instantiation ----------------------------------------------------------------------------------
    // -------------------------------------------------
    sky130_fd_sc_hd__clkinv_1
    inv 
        ( .Y(Y)
        , .A(A)
        );

endmodule