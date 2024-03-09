module fo4_tb;  

    initial begin
        $fsdbDumpfile("waveform.fsdb");
        $fsdbDumpvars();
    end

    logic dut_reset, dut_probe_in, dut_probe_out;
    
    fo4_top
    DUT
        (.reset_i(dut_reset)
        ,.probe_in_o(dut_probe_in)
        ,.probe_out_o(dut_probe_out)
        );

    time start_hi_lo, end_hi_lo, time_hi_lo; 
    time start_lo_hi, end_lo_hi, time_lo_hi; 

    initial begin
        dut_reset = 1'b1;
        #10000;
        dut_reset = 1'b0;
        #10000;

        @(posedge dut_probe_in);
        start_hi_lo = $time;
        @(negedge dut_probe_out);
        end_hi_lo = $time;
        time_hi_lo = end_hi_lo - start_hi_lo;

        @(negedge dut_probe_in);
        start_lo_hi = $time;
        @(posedge dut_probe_out);
        end_lo_hi = $time;
        time_lo_hi = end_lo_hi - start_lo_hi;

        $display("################################################################################");
        $display("# Fo4 Results");
        $display("# -----------");
        $display("#    Time Hi-Lo: %0tps", time_hi_lo);
        $display("#    Time Lo-Hi: %0tps", time_lo_hi);
        $display("#    Avg. Fo4: %0tps", (time_lo_hi+time_hi_lo)/2.0);
        $display("################################################################################");

        $finish();
    end

endmodule

