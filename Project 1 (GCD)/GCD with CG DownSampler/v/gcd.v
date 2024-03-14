

module gcd
    ( input               clk_i    // Clock signal
    , input               reset_i  // Reset signal

    , input        [63:0] data_in  // Data in
    , input               v_i      // Valid input data confirmation signal
    , output              ready_o  // Data ready to be sent signal

    , output logic [63:0] data_out
    , output logic        v_o      // Our calulated value is valid signal
    , input               yumi_i   // Valid and Ready
    );


    // Control path signals 
    // -------------------------------------------------------------------------------------------------------
    typedef enum logic [1:0] {eWAIT, eBUSY, eDONE} state_e;
    state_e  state_n, state_r; // state_n = next state, state_r = present state

    assign ready_o = state_r == eWAIT; // if the present state is in the wait state, then we are ready to recieve data
    assign     v_o = state_r == eDONE; // if the presnt state is in the done state, then then we are ready to send the data we worked on
    // -------------------------------------------------------------------------------------------------------


    // Data path signals
    // -------------------------------------------------------------------------------------------------------
    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] temp;
    logic Done;

    assign data_out = {32'b0, A}; 
    // -------------------------------------------------------------------------------------------------------


    // Control logic (FSM) 
    // -------------------------------------------------------------------------------------------------------
    always_comb begin
        case(state_r)
            eWAIT: 
                if (ready_o & v_i) begin
                    state_n = eBUSY;
                end
                else begin
                    state_n = eWAIT;
                end

            eBUSY:
                if (Done == 1'b0) begin
                    state_n = eBUSY;
                end
                else begin
                    state_n = eDONE;
                end

            eDONE:
                if (v_o & yumi_i) begin
                    state_n = eWAIT;
                end
                else begin
                    state_n = eDONE;
                end
        endcase
    end 
    // -------------------------------------------------------------------------------------------------------


    // Sequential logic for reset and next/present state flow
    // -------------------------------------------------------------------------------------------------------
    always_ff @(posedge clk_i) begin
        if (reset_i)
            state_r <= eWAIT;
        else
            state_r <= state_n;
    end
    // -------------------------------------------------------------------------------------------------------


    // Data path logic
    // -------------------------------------------------------------------------------------------------------
    always_ff @(posedge clk_i) begin
        if (state_r == eWAIT) begin
            Done <= 1'b0;
            A <= data_in[63:32];
            B <= data_in[31:0];
        end

        else if (state_r == eBUSY) begin
            if (A < B) begin
                A <= B;
                B <= A;
            end
            else if (B != 32'b0) begin
                A <= A - B;
            end
            else begin
                Done <= 1'b1;
            end
        end

        else begin
            Done <= 1'b1;
        end
    end
    // -------------------------------------------------------------------------------------------------------

endmodule
