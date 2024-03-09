/**
 * BSG Chip -- Toplevel module. For this design, we are simply creating a
 *             wrapper for the clk_gen module which is to be implemented by the
 *             students.
 */
module clk_gen_top
    ( input  wire       reset_i
    , input  wire [3:0] select_i
    , output wire       clk_o
    );

    clk_gen 
    CG 
        ( .reset_i(reset_i), .select_i(select_i), .clk_o(clk_o) );

endmodule

