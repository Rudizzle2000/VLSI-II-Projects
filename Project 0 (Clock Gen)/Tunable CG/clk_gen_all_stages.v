module clk_gen_all_stages
    ( input wire nor_to_inverter_stages
    , output wire [15:0] inverter_stages_to_mux
    );


    // Inverter Instantiations ----------------------------------------------------------------------------------
    // -------------------------------------------------
    clk_gen_stage1_fo4
    stage_1_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[0])
        );

    // -------------------------------------------------
    clk_gen_stage2_fo4
    stage_2_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[1])
        );

    // -------------------------------------------------
    clk_gen_stage3_fo4
    stage_3_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[2])
        );

    // -------------------------------------------------
    clk_gen_stage4_fo4
    stage_4_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[3])
        );

    // -------------------------------------------------
    clk_gen_stage5_fo4
    stage_5_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[4])
        );

    // -------------------------------------------------
    clk_gen_stage6_fo4
    stage_6_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[5])
        );

    // -------------------------------------------------
    clk_gen_stage7_fo4
    stage_7_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[6])
        );

    // -------------------------------------------------
    clk_gen_stage8_fo4
    stage_8_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[7])
        );

    // -------------------------------------------------
    clk_gen_stage9_fo4
    stage_9_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[8])
        );

    // -------------------------------------------------
    clk_gen_stage10_fo4
    stage_10_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[9])
        );

    // -------------------------------------------------
    clk_gen_stage11_fo4
    stage_11_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[10])
        );

    // -------------------------------------------------
    clk_gen_stage12_fo4
    stage_12_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[11])
        );

    // -------------------------------------------------
    clk_gen_stage13_fo4
    stage_13_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[12])
        );

    // -------------------------------------------------
    clk_gen_stage14_fo4
    stage_14_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[13])
        );

    // -------------------------------------------------
    clk_gen_stage15_fo4
    stage_15_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[14])
        );

    // -------------------------------------------------
    clk_gen_stage16_fo4
    stage_16_inv
        ( .loop_in(nor_to_inverter_stages)
        , .loop_out(inverter_stages_to_mux[15])
        );

endmodule