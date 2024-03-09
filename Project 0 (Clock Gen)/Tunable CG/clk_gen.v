// 
//  Clk Gen Module -- Students should implement their tunable clock generator
//  circuit here! The input and output port list has been created for you. Do
//  not modify the port list, this will break the rest of the lab :)
// 
//  First, you must figure out what logic gates are available to us in the
//  standard cell library. The best place to figure this out is the liberty
//  file which can be found at:
//
//      <SKY130_ROOT>/libs.ref/sky130_fd_sc_hd/lib/sky130_fd_sc_hd__ss_100C_1v60.lib
//
//  Open this file above to see the gates available in this cell library. This
//  will be helpful to figure out the names of the gates as well as the name of
//  the pins for the gates. Using this information you can instantiate the
//  cells you need for the circuit.
//
//  NOTE: This file is 100K lines, be sure to use the search function of your
//  text editor. Search for "cell " to find the each gate available in this
//  cell library. Under each cell definition, search for "pin " to find the
//  pins of the gate (you can ignore pg_pins, we do not need to work with
//  supply nets within this verilog file). Inside the pin definition will be
//  the "direction " to determine if it is an input or output of the gate.
//  Output pins will also have a "function " which is the boolean logic
//  expression for the gate. Timing information for each pin can also be found
//  within the pin definitions, please read the module - handout for more
//  information.
//
module clk_gen
    ( input  wire       reset_i
    , input  wire [3:0] select_i
    , output wire       clk_o
    );

    // TODO: Implement the clock generator below! Make sure that:
    //  1. The ring ends at the B pin of the reset NOR gate below.
    //  2. The ring begins with the X pin of the reset_bal NOR gate below.
    //  3. Use the 4-bit select_i to choose between your 16 clock speeds.
    //  4. The final clock should drive the clk_o port.

    wire reset_to_reset_bal_n;

    wire [15:0] inv_stages_to_mux;

    wire buff_to_inv_stages;

    wire nor_to_buff;

    wire buff_1_to_buff_2;

    // 2 to 1 NOR gate Instantiation
    // -------------------------------------------------
    sky130_fd_sc_hd__nor2_1
    reset
        (.A(reset_i)
        ,.B(clk_o)
        ,.Y(reset_to_reset_bal_n)
        );

    // 2 to 1 NOR gate Instantiation
    // -------------------------------------------------
    sky130_fd_sc_hd__nor2_1
    reset_bal
        (.A(reset_i)
        ,.B(reset_to_reset_bal_n)
        ,.Y(nor_to_buff)
        );

    // Clk buffer 1
    // -------------------------------------------------
    sky130_fd_sc_hd__clkbuf_1
    clk_buff_1
        ( .X(buff_1_to_buff_2)
        , .A(nor_to_buff)
        );

    // Clk buffer 4
    // -------------------------------------------------
    sky130_fd_sc_hd__clkbuf_4
    clk_buff_2
        ( .X(buff_to_inv_stages)
        , .A(buff_1_to_buff_2)
        );
    
    // Module to connect the output of the buffers to the input of all
    // 16 ring oscillator chains.
    // -------------------------------------------------
    clk_gen_all_stages
    all_stages
        ( .nor_to_inverter_stages(buff_to_inv_stages)
        , .inverter_stages_to_mux(inv_stages_to_mux)
        );    
    
    // 16 to 1 MUX
    // -------------------------------------------------
    clk_gen_16_1_inv_mux
    mux
        ( .mux_in(inv_stages_to_mux)
        , .sel(select_i)
        , .mux_out(clk_o)
        );

endmodule

