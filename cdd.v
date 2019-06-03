/*
 *  cdd.v
 *
 *  Combinatorial digital device.
 */
module cdd(clock, reset, data, out0, out1, led);
    // ==========[ inputs ]==========
    input clock;
    input reset;
    input [3:0] data;

    // ==========[ outputs ]==========
    output reg [6:0] out0;
    output reg [6:0] out1;
	 output [2:0] led;

    // ==========[ regs ]==========
    reg  [3:0] key;
    reg [3:0] true_key;
    reg [2:0] state; // for save states
    reg [2:0] counter; // quantity of takts
	 
	 //wire [3:0] transfer_data;

    // ==========[ asssigns ]==========
	 //assign transfer_data <= data;
    //assign key      <= transfer_data;
    //assign true_key <= 4'd5;
    assign led = counter;
	 
    // ==========[ states ]==========
    parameter RESET = 0; // program start
    parameter SET   = 1; // set key
    parameter CHECK = 2; // check key
    parameter RUN   = 3; // start engine
    parameter ERROR = 4; // wrong key

    // ==========[ block transitions ]==========
    always@(posedge clock or negedge reset) begin
        if (!reset)
		  state <= RESET;
		  else begin
		  case (state)
            RESET: begin
				    state <= SET; // state: 1
            end

            SET: begin
                if (counter == 3'd3) 
                    state <= CHECK; // state: 2
            end

            CHECK: begin
                if (counter == 3'd4) begin
                    if (key == true_key) state <= RUN;
                    else state <= ERROR;
                end
            end
            RUN: begin
                if (counter == 3'd7)
                    state <= RESET;
            end

            ERROR: begin
                if (counter == 3'd6)
                    state <= RESET;
				end

        endcase
    end
	 end

    // TODO: Compile this block on Quartus II and show Neelova for fix.
    // ==========[ block states ]==========
    always@(posedge clock) begin
            case (state)
                RESET: begin
					     counter <= 3'd0;
            		  key <= 4'd0;
					     true_key <= 4'd5;
                    key <= 3'd0;
                end

                SET: begin
                    key <= data;
                    out1 <= 3'b001; // U
                    out0 <= 3'b010; // P
                    counter = counter + 1;
                end

                CHECK: begin
                    out1 <= 3'b011; // C
                    out0 <= 3'b100; // H
                    counter = counter + 1;
                end
                    
                RUN: begin
						  out1 <= 3'b000;
						  out0 <= 3'b101; // F
                    counter = counter + 1;
                end
                    
                ERROR: begin
                    out1 <= 3'b000;
						  out0 <= 3'b110; // A
                    counter = counter + 1;
                end
            endcase
         end
endmodule
