
module gcd_clk_gen_ds 
    ( input reset_i
    , input clk_reset_i
    , input ds_reset_i
    , input [7:0] select_i

    , input [63:0] data_i
    , input v_i
    , output ready_o
    , output clk_o

    , output logic [63:0] data_o
    , output logic v_o
    , input yumi_i
    );

    clk_gen_ds 
    CGDS ( .clk_reset_i(clk_reset_i)  
         , .ds_reset_i(ds_reset_i)      
         , .select_i(select_i)  
         , .clk_o(clk_o)  
         , .ds_enable()             // Ignore this. This is just here to see the output on the waveform.
        );


    gcd
    GCD ( .clk_i(clk_o)    
        , .reset_i(reset_i)     
        , .data_in(data_i)  
        , .v_i(v_i)      
        , .ready_o(ready_o)  
        , .data_out(data_o)
        , .v_o(v_o)     
        , .yumi_i(yumi_i)   
        );

endmodule