// pow2_tb.v
//
// This file contains the toplevel testbench for testing
// this design. 
//

module gcd_tb;

  /* Dump Test Waveform To VPD File */
  initial begin
    $fsdbDumpfile("waveform.fsdb");
    $fsdbDumpvars();
  end

  /* Non-synth clock generator */
  logic clk;
  bsg_nonsynth_clock_gen #(3550) clk_gen_1 (clk);

  /* Non-synth reset generator */
  logic reset;
  bsg_nonsynth_reset_gen #(.num_clocks_p(1),.reset_cycles_lo_p(5),. reset_cycles_hi_p(5))
    reset_gen
      (.clk_i        ( clk )
      ,.async_reset_o( reset )
      );

  logic dut_v_lo, dut_v_r;
  logic [63:0] dut_data_lo, dut_data_r; 
  logic dut_ready_lo, dut_ready_r;

  logic tr_v_lo;
  logic [63:0] tr_data_lo;
  logic tr_ready_lo, tr_ready_r;

  logic [63:0] rom_addr_li;
  logic [67:0] rom_data_lo;

  logic tr_yumi_li, dut_yumi_li;

  bsg_fsb_node_trace_replay #(.ring_width_p(64)
                             ,.rom_addr_width_p(64) )
    trace_replay
      ( .clk_i ( ~clk ) // Trace Replay should run on negative clock edge!
      , .reset_i( reset )
      , .en_i( 1'b1 )

      , .v_i    ( dut_v_r )
      , .data_i ( dut_data_r )
      , .ready_o( tr_ready_lo )

      , .v_o   ( tr_v_lo )
      , .data_o( tr_data_lo )
      , .yumi_i( tr_yumi_li )

      , .rom_addr_o( rom_addr_li )
      , .rom_data_i( rom_data_lo )

      , .done_o()
      , .error_o()
      );

  always_ff @(negedge clk) begin
    dut_ready_r <= dut_ready_lo;
    tr_yumi_li  <= dut_ready_r & tr_v_lo;
    dut_v_r     <= dut_v_lo;
    dut_data_r  <= dut_data_lo;
  end

  trace_rom #(.width_p(68),.addr_width_p(64))
    ROM
      (.addr_i( rom_addr_li )
      ,.data_o( rom_data_lo )
      );

  gcd DUT
    (.clk_i  ( clk )
    ,.reset_i( reset )

    ,.data_in  ( tr_data_lo )
    ,.v_i    ( tr_v_lo )
    ,.ready_o( dut_ready_lo )
    
    ,.data_out( dut_data_lo )
    ,.v_o   ( dut_v_lo )
    ,.yumi_i( dut_yumi_li )
    );

  always_ff @(negedge clk) begin
    dut_yumi_li <= tr_ready_lo & dut_v_lo;
  end

endmodule