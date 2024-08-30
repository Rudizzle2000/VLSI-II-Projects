

// Disctription: Module that provides a single stage of the main x1 inverter for the ring oscillator as well as
//               the dangling inverters x1 and x4.
// INPUT: Input to the x1 inverter for a single stage in the main loop.
// OUTPUT: Output of the x1 inverter for a signle stage in the main loop.

module fo4_1stage
    ( input wire inv_1_in
    , output wire inv_1_out
    );

    // Wires to connect the x1 inveters to their respective x4 inveter
    wire x1_dangle_1_to_x4_dangle_1;
    wire x1_dangle_2_to_x4_dangle_2;
    wire x1_dangle_3_to_x4_dangle_3;

    // X1 INVERTER INSTANTATIONS ------------------------------------------------------------------

    // Main x1 inverter instantiation within loop/ring oscillator
    sky130_fd_sc_hd__inv_1
    main_inverter_stage
        ( .Y(inv_1_out)
        , .A(inv_1_in)
        );

    // X1 inverter instatiation for dangle 1
    // INPUT: A - Output of the main inverter within the loop
    // OUTPUT: Y - Input to the x4 inveter for dangle 1
    sky130_fd_sc_hd__inv_1
    x1_dangle_1
        ( .Y(x1_dangle_1_to_x4_dangle_1)
        , .A(inv_1_out)
        );    

    // X1 inverter instatiation for dangle 2
    // INPUT: A - Output of the main inverter within the loop
    // OUTPUT: Y - Input to the x4 inveter for dangle 2
    sky130_fd_sc_hd__inv_1
    x1_dangle_2
        ( .Y(x1_dangle_2_to_x4_dangle_2)
        , .A(inv_1_out)
        ); 

    // X1 inverter instatiation for dangle 3
    // INPUT: A - Output of the main inverter within the loop
    // OUTPUT: Y - Input to the x4 inveter for dangle 3
    sky130_fd_sc_hd__inv_1
    x1_dangle_3
        ( .Y(x1_dangle_3_to_x4_dangle_3)
        , .A(inv_1_out)
        ); 

    // X4 INVERTER INSTANTATIONS ------------------------------------------------------------------

    // X4 inverter instatiation for dangle 1
    // INPUT: A - Output of x1 inverter for dangle 1
    // OUTPUT: Y - Output of the x4 inveter for dangle 1
    sky130_fd_sc_hd__inv_4
    x4_dangle_1
        ( .Y()
        , .A(x1_dangle_1_to_x4_dangle_1)
        );

    // X4 inverter instatiation for dangle 2
    // INPUT: A - Output of x1 inverter for dangle 2
    // OUTPUT: Y - Output of the x4 inveter for dangle 2
    sky130_fd_sc_hd__inv_4
    x4_dangle_2
        ( .Y()
        , .A(x1_dangle_2_to_x4_dangle_2)
        );

    // X4 inverter instatiation for dangle 3
    // INPUT: A - Output of x1 inverter for dangle 3
    // OUTPUT: Y - Output of the x4 inveter for dangle 3
    sky130_fd_sc_hd__inv_4
    x4_dangle_3
        ( .Y()
        , .A(x1_dangle_3_to_x4_dangle_3)
        );

endmodule