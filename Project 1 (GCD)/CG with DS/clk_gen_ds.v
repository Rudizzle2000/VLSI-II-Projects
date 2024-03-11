/**
 * Clock Generator with Downsampler -- Toplevel module.
 */
module clk_gen_ds
  ( input clk_reset_i           // Used for the clock generator only!
  , input ds_reset_i            // Used for the downsampler only!
  , input [7:0] select_i        // Lower 4 bits should control clkgen, upper 4 bits should control downsampler
  , output logic clk_o          // Should connect directly to the clkgen if the select is < 16, otherwise should output the downsampler
  , output wire [3:0] ds_enable // Unused
  );

  //wire [3:0] ds_enable;
  wire CG_Out;
  wire DS_Out;

  // Tunable clock generator
  clk_gen
  CG ( .reset_i(clk_reset_i)
     , .select_i(select_i[3:0])
     , .clk_o(CG_Out)
     );

  // Downsampler module
  bsg_counter_clock_downsample#(.width_p(4) , .harden_p(0)) DS
    ( .clk_i(CG_Out)
    , .reset_i(ds_reset_i)
    , .val_i(4'b0000)
    , .clk_r_o(DS_Out)
    );

assign clk_o = (select_i[7:4]) ? DS_Out : CG_Out;

endmodule

