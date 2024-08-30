// pow2_tb.v
//
// This file contains the top-level testbench for testing the GCD (Greatest Common Divisor) design.

module gcd_tb;

  /* Dump Test Waveform To VPD File */
  // This block initializes the waveform dumping to a file named "waveform.fsdb" 
  // for viewing simulation results later.
  initial begin
    $fsdbDumpfile("waveform.fsdb");
    $fsdbDumpvars();
  end

  /* Non-synth clock generator */
  logic clk;
  // This instantiates a non-synthesizable clock generator module.
  // The clock period is set to 3550 time units (e.g., ps, ns).
  bsg_nonsynth_clock_gen #(3550) clk_gen_1 (clk);

  /* Non-synth reset generator */
  logic reset;
  // This instantiates a non-synthesizable reset generator module.
  // It generates a reset signal based on the clock, with a low and high duration of 5 cycles each.
  bsg_nonsynth_reset_gen #(.num_clocks_p(1), .reset_cycles_lo_p(5), .reset_cycles_hi_p(5))
    reset_gen
      (.clk_i        ( clk )       // Input clock
      ,.async_reset_o( reset )     // Output asynchronous reset signal
      );

  // Logic signals for DUT (Device Under Test) and trace replay
  logic dut_v_lo, dut_v_r;                  // Valid signal from DUT (output) and registered valid signal
  logic [63:0] dut_data_lo, dut_data_r;     // Data output from DUT and registered data signal
  logic dut_ready_lo, dut_ready_r;          // Ready signal from DUT (output) and registered ready signal

  logic tr_v_lo;                            // Valid signal from trace replay (output)
  logic [63:0] tr_data_lo;                  // Data output from trace replay
  logic tr_ready_lo, tr_ready_r;            // Ready signal from trace replay (output)

  logic [63:0] rom_addr_li;                 // ROM address signal
  logic [67:0] rom_data_lo;                 // ROM data output signal

  logic tr_yumi_li, dut_yumi_li;            // Yumi signals for handshaking between trace replay and DUT

  // Instantiate the trace replay module
  // This module simulates the input stimulus by replaying a pre-recorded trace from a ROM.
  bsg_fsb_node_trace_replay #(.ring_width_p(64)
                             ,.rom_addr_width_p(64) )
    trace_replay
      ( .clk_i ( ~clk )                     // Run on the negative edge of the clock
      , .reset_i( reset )                   // Reset signal
      , .en_i( 1'b1 )                       // Enable signal

      , .v_i    ( dut_v_r )                 // Valid signal from DUT (registered)
      , .data_i ( dut_data_r )              // Data signal from DUT (registered)
      , .ready_o( tr_ready_lo )             // Ready signal from trace replay (output)

      , .v_o   ( tr_v_lo )                  // Valid signal from trace replay (output)
      , .data_o( tr_data_lo )               // Data signal from trace replay (output)
      , .yumi_i( tr_yumi_li )               // Yumi signal for trace replay

      , .rom_addr_o( rom_addr_li )          // ROM address output signal
      , .rom_data_i( rom_data_lo )          // ROM data input signal

      , .done_o()                           // Trace replay done signal (unused)
      , .error_o()                          // Trace replay error signal (unused)
      );

  // This always block is executed on every negative edge of the clock.
  // It registers the DUT ready and valid signals and updates the yumi signal 
  // based on the registered ready signal and the valid signal from trace replay.
  always_ff @(negedge clk) begin
    dut_ready_r <= dut_ready_lo;            // Register the DUT ready signal
    tr_yumi_li  <= dut_ready_r & tr_v_lo;   // Generate the yumi signal for trace replay
    dut_v_r     <= dut_v_lo;                // Register the DUT valid signal
    dut_data_r  <= dut_data_lo;             // Register the DUT data output
  end

  // Instantiate the trace ROM
  // This module contains the trace data that will be used for input stimulus.
  trace_rom #(.width_p(68), .addr_width_p(64))
    ROM
      (.addr_i( rom_addr_li )               // ROM address input
      ,.data_o( rom_data_lo )               // ROM data output
      );

  // Instantiate the GCD Device Under Test (DUT)
  gcd DUT
    (.clk_i  ( clk )                        // Clock input
    ,.reset_i( reset )                      // Reset input

    ,.data_in  ( tr_data_lo )               // Input data from trace replay
    ,.v_i    ( tr_v_lo )                    // Valid signal from trace replay
    ,.ready_o( dut_ready_lo )               // Ready signal output from DUT
    
    ,.data_out( dut_data_lo )               // Data output from DUT
    ,.v_o   ( dut_v_lo )                    // Valid signal output from DUT
    ,.yumi_i( dut_yumi_li )                 // Yumi signal for DUT
    );

  // This always block is executed on every negative edge of the clock.
  // It generates the yumi signal for the DUT based on the ready signal 
  // from trace replay and the valid signal from DUT.
  always_ff @(negedge clk) begin
    dut_yumi_li <= tr_ready_lo & dut_v_lo;  // Generate the yumi signal for DUT
  end

endmodule
