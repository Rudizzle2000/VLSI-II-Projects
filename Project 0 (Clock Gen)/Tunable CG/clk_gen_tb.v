// clk_gen_tb.v
//
// This file contains the toplevel testbench for testing
// this design: clk_gen_top
//

module clk_gen_tb;  

    /* Dump Test Waveform To VPD File */
    initial begin
        $fsdbDumpfile("waveform.fsdb");
        $fsdbDumpvars();
    end

    /* Device under test (DUT) */
    logic [3:0] dut_cfg;
    logic       dut_reset;
    logic       dut_clk;

    /* TODO - FIX ME TO MATCH YOUR DEVICE */
    clk_gen_top
    DUT
        (.reset_i(dut_reset)
        ,.select_i(dut_cfg)
        ,.clk_o(dut_clk)
        );

    /* Reports Clock Period and Changes */
    bsg_nonsynth_clk_watcher #(.tolerance_p(0)) clk_watcher (.clk_i(dut_clk));

    /* Sequential steps to test the DUT */
    initial begin

    // Start in reset
    dut_reset = 1'b1;

    for (integer i = 0; i < 2**$bits(dut_cfg); i++) begin
        dut_cfg = i;
        #5000
        $display("### START TESTING CONFIG %b", dut_cfg);
        dut_reset = 1'b0;
        for (integer j = 0; j < 25; j++) begin
            @(posedge dut_clk);
        end
        dut_reset = 1'b1;
        #5000
        $display("### FINISH TESTING CONFIG %b", dut_cfg);
    end

    $finish();

    end

endmodule
