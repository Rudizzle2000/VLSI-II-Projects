
// Testbench module for the fo4_top module
module fo4_tb; 

    // Initial block to set up waveform dumping for simulation debugging
    initial begin
        $fsdbDumpfile("waveform.fsdb");   // Specify the file to store waveform data
        $fsdbDumpvars();                  // Dump all variables into the waveform file
    end

    // Declare logic signals to interact with the Device Under Test (DUT)
    logic dut_reset, dut_probe_in, dut_probe_out;

    // Instantiate the DUT (fo4_top module) and connect its ports to testbench signals
    fo4_top
    DUT
        (.reset_i(dut_reset),       // Connect dut_reset signal to the DUT's reset input
        .probe_in_o(dut_probe_in),  // Connect dut_probe_in signal to the DUT's probe_in output
        .probe_out_o(dut_probe_out) // Connect dut_probe_out signal to the DUT's probe_out output
        );

    // Declare time variables to measure propagation delays
    time start_hi_lo, end_hi_lo, time_hi_lo;  // Variables for measuring high-to-low transition time
    time start_lo_hi, end_lo_hi, time_lo_hi;  // Variables for measuring low-to-high transition time

    // Initial block to define the test sequence and measure timing
    initial begin
        dut_reset = 1'b1;  // Set reset signal to high to initialize the DUT
        #10000;            // Wait for 10,000 time units
        dut_reset = 1'b0;  // Release the reset signal
        #10000;            // Wait for another 10,000 time units

        // Measure the time for a high-to-low transition
        @(posedge dut_probe_in);    // Wait for the rising edge of probe_in
        start_hi_lo = $time;        // Record the current simulation time
        @(negedge dut_probe_out);   // Wait for the falling edge of probe_out
        end_hi_lo = $time;          // Record the current simulation time
        time_hi_lo = end_hi_lo - start_hi_lo;  // Calculate the propagation delay for high-to-low transition

        // Measure the time for a low-to-high transition
        @(negedge dut_probe_in);    // Wait for the falling edge of probe_in
        start_lo_hi = $time;        // Record the current simulation time
        @(posedge dut_probe_out);   // Wait for the rising edge of probe_out
        end_lo_hi = $time;          // Record the current simulation time
        time_lo_hi = end_lo_hi - start_lo_hi;  // Calculate the propagation delay for low-to-high transition

        // Display the measured results
        $display("################################################################################");
        $display("# Fo4 Results");
        $display("# -----------");
        $display("#    Time Hi-Lo: %0tps", time_hi_lo);  // Display high-to-low transition time
        $display("#    Time Lo-Hi: %0tps", time_lo_hi);  // Display low-to-high transition time
        $display("#    Avg. Fo4: %0tps", (time_lo_hi+time_hi_lo)/2.0);  // Display average propagation delay (Fo4)
        $display("################################################################################");

        $finish();  // End the simulation
    end

endmodule


